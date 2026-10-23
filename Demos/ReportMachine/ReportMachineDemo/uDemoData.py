# -*- coding: utf-8 -*-
"""演示数据: 全部在内存中生成, 不需要数据库.

对应 Delphi 工程的 uDemoData.pas, 提供演示1~4 使用的三组数据:
    客户表            build_customer_ds        演示1(单表)、演示3(变量与过滤)
    订单主表+明细表   build_order_item_ds      演示2(主从明细)
    商品表            build_product_ds         演示4(分组汇总)
同时提供样例数据模块 uSampleData.py 共用的底层工具:
    delphi_random / set_rand_seed   与 Delphi 完全一致的随机数
    make_cds                        由字段定义+行数据生成并打开一个 ClientDataSet
    keep / data_dir                 引用保活、临时目录

与 Delphi 版的差异(都是由 glcl 的能力决定的, 数据内容等价):
  * glcl 里没有 ftString 这类字段类型常量, 而且 FieldDefs.Add 被封装成了无参数的 TCollection.Add(),
    没法按 Delphi 的方式 "FieldDefs.Add + CreateDataSet + Append/Post" 建表. 所以改用 glcl 官方示例
    (Demos/DataAccess/DBGridAndDataDemo)里的办法: 先生成 MIDAS 的 DATAPACKET XML 文件,
    再通过 ClientDataSet.FileName + Active=True 载入, 得到的就是一个普通的 TClientDataSet.
  * 生成的 XML 是纯 ASCII(中文写成 &#NNNN; 数字引用), 这样不管 ClientDataSet 按 UTF-8 还是按系统代码页
    读取文件都不会乱码(早期版本直接写 UTF-8, 在测试环境里出现过中文乱码).
  * Delphi 的 RandSeed / Random 是一个固定的线性同余算法, 这里原样实现了一份, 所以只要种子相同,
    生成的演示数据与 Delphi 版逐值一致.
"""
import os
import atexit
import shutil
import tempfile

from glcl import ClientDataSet, DataSource

# ---------------------------------------------------------------------------
# Delphi 兼容的随机数 (System.Random / RandSeed)
# ---------------------------------------------------------------------------
_rand_seed = 0   # 与 Delphi 的全局变量 RandSeed 对应; 各 build_xxx 函数开头会自己设定种子


def set_rand_seed(value):
    """等价于 Delphi 的 RandSeed := value"""
    global _rand_seed
    _rand_seed = value & 0xFFFFFFFF


def delphi_random(rng):
    """等价于 Delphi 的 Random(rng), 返回 0..rng-1 的整数.

    Delphi 的整数版 Random 是:  RandSeed := RandSeed * $08088405 + 1;  结果 := (RandSeed * rng) shr 32
    (全部按 32 位无符号运算). 调用顺序也必须与 Delphi 版一致, 否则后面的数据都会错位.
    """
    global _rand_seed
    _rand_seed = (_rand_seed * 0x08088405 + 1) & 0xFFFFFFFF
    return (_rand_seed * rng) >> 32


# ---------------------------------------------------------------------------
# 内存数据集: 生成 DATAPACKET XML -> ClientDataSet
# ---------------------------------------------------------------------------
# 字段类型字符 -> MIDAS XML 的 fieldtype.  'S' 字符串, 'F' 浮点, 'I' 整数, 'D' 日期时间
_XML_TYPES = {'S': 'string', 'F': 'r8', 'I': 'i4', 'D': 'dateTime'}

_data_dir = None   # 临时目录, 第一次用到时才创建
_keep = []         # 保存 Python 端对 Delphi 组件的引用, 避免被提前回收


def _get_data_dir():
    """返回(必要时创建)放 XML 数据文件和样例模板补丁副本的临时目录, 程序退出时自动删除."""
    global _data_dir
    if _data_dir is None:
        _data_dir = tempfile.mkdtemp(prefix='RMSample_')
        atexit.register(shutil.rmtree, _data_dir, True)
    return _data_dir


def data_dir():
    """对外的临时目录入口(uMain 用它存放修补后的模板副本)."""
    return _get_data_dir()


def keep(obj):
    """保存对象引用并原样返回. 窗体拥有这些组件, 但 Python 端的包装对象也要有人持有, 防止被回收."""
    _keep.append(obj)
    return obj


def _xml_attr(text):
    """转成 XML 属性值. 所有非 ASCII 字符写成 &#NNNN; 数字引用, 使整个 XML 文件是纯 ASCII."""
    out = []
    for ch in str(text):
        o = ord(ch)
        if ch == '&':
            out.append('&amp;')
        elif ch == '<':
            out.append('&lt;')
        elif ch == '>':
            out.append('&gt;')
        elif ch == '"':
            out.append('&quot;')
        elif o < 32 or o > 126:
            out.append('&#%d;' % o)
        else:
            out.append(ch)
    return ''.join(out)


def _fmt_value(ftype, value):
    """把一个 Python 值格式化成对应字段类型的 XML 文本."""
    if ftype == 'F':
        return '%.10g' % float(value)          # 3200.0 -> '3200', 避免出现科学计数法
    if ftype == 'I':
        return '%d' % int(value)
    if ftype == 'D':                           # 传入 (年, 月, 日), 写成 MIDAS 的 dateTime 格式
        return '%04d%02d%02dT00:00:00000' % value
    return _xml_attr(value)


def make_cds(owner, tag, fields, rows):
    """创建并打开一个内存 ClientDataSet.

    owner   组件的拥有者(主窗体)
    tag     数据集标识, 同时用作临时 XML 文件名
    fields  [(字段名, 类型字符, 字符串宽度), ...]  宽度只对 'S' 有效
    rows    [{字段名: 值, ...}, ...]  行里缺省的字段即 NULL
    """
    # 字符串字段的宽度不能小于实际内容(例如照片路径可能很长), 否则载入会失败或被截断
    widths = {}
    for name, ftype, size in fields:
        if ftype == 'S':
            longest = max([len(str(r[name])) for r in rows if name in r] or [0])
            widths[name] = max(size, longest)

    # 拼出 MIDAS XML: 先是字段元数据, 再是每一行数据. RowState="4" 表示该行是未修改的原始数据
    out = ['<?xml version="1.0" standalone="yes"?>',
           '<DATAPACKET Version="2.0">',
           '<METADATA>', '<FIELDS>']
    for name, ftype, size in fields:
        if ftype == 'S':
            out.append('<FIELD attrname="%s" fieldtype="string" WIDTH="%d"/>'
                       % (name, widths[name]))
        else:
            out.append('<FIELD attrname="%s" fieldtype="%s"/>' % (name, _XML_TYPES[ftype]))
    out += ['</FIELDS>', '<PARAMS/>', '</METADATA>', '<ROWDATA>']
    for r in rows:
        attrs = ''.join(' %s="%s"' % (name, _fmt_value(ftype, r[name]))
                        for name, ftype, size in fields if name in r)
        out.append('<ROW RowState="4"%s/>' % attrs)
    out += ['</ROWDATA>', '</DATAPACKET>']

    path = os.path.join(_get_data_dir(), tag + '.xml')
    with open(path, 'w', encoding='ascii', newline='\n') as f:
        f.write('\n'.join(out))

    # 载入: FileName 指向 XML 文件, Active=True 触发读取
    ds = keep(ClientDataSet(owner))
    ds.FileName = path
    ds.Active = True
    return ds


# ---------------------------------------------------------------------------
# 客户表: CustNo, CustName, City, Contact, Phone, Credit   (20 行)
# ---------------------------------------------------------------------------
def build_customer_ds(owner):
    cities = ['北京', '上海', '广州', '深圳']
    suffix = ['华达贸易', '恒信电子', '远景科技', '宏图实业', '鑫源物流']
    contacts = ['张伟', '王芳', '李娜', '刘洋', '陈静', '杨帆']

    set_rand_seed(20260929)   # 固定种子, 每次启动数据一致
    rows = []
    for i in range(20):
        # 注意随机数的调用顺序: 先电话, 再信用额度(与 Delphi 版的语句顺序一致)
        phone = '1380%07d' % delphi_random(10000000)
        credit = (delphi_random(50) + 10) * 1000
        rows.append({
            'CustNo': 1000 + i,
            'CustName': cities[i % 4] + suffix[i % 5] + '有限公司',
            'City': cities[i % 4],
            'Contact': contacts[i % 6],
            'Phone': phone,
            'Credit': credit,
        })
    ds = make_cds(owner, 'cdsCustomer', [
        ('CustNo', 'I', 0), ('CustName', 'S', 40), ('City', 'S', 20),
        ('Contact', 'S', 20), ('Phone', 'S', 20), ('Credit', 'F', 0)], rows)
    ds.IndexFieldNames = 'CustNo'   # 按客户号排序
    ds.First()
    return ds


# ---------------------------------------------------------------------------
# 订单主表: OrderNo, CustNo, OrderDate, Status, Total             (12 行)
# 订单明细表(从表): OrderNo, LineNo, ProdName, Qty, Price, Amount  (每单 2~5 行)
# 从表通过 OrderNo 与主表联动: 主表翻到哪个订单, 从表就只显示该订单的明细行.
#
# Delphi 版里主表的 Total 是在建明细表时回写的, 所以这里把主/从表放在一个函数里一起建.
# 返回 (主表, 从表)
# ---------------------------------------------------------------------------
def build_order_item_ds(owner):
    statuses = ['已完成', '待发货', '已取消']
    prods = ['无线鼠标', '机械键盘', '移动硬盘', '显示器', '耳机', '打印纸', '保温杯', '收纳盒']

    orders = []
    for i in range(12):
        orders.append({
            'OrderNo': 2026001 + i,
            'CustNo': 1000 + (i * 3) % 20,                       # 引用客户表里的客户号
            'OrderDate': (2026, 1 + i % 9, 1 + (i * 5) % 27),
            'Status': statuses[i % 3],
            'Total': 0.0,                                        # 稍后由明细金额汇总得到
        })

    items = []
    # 随机序列紧接着客户表之后继续使用(不重新设种子), 与 Delphi 版一致
    for order in orders:
        total = 0.0
        n = 2 + delphi_random(4)                                 # 每单 2~5 行明细
        for j in range(1, n + 1):
            prodname = prods[delphi_random(8)]
            qty = delphi_random(20) + 1
            price = float(delphi_random(190) + 10)
            amount = qty * price
            total += amount
            items.append({'OrderNo': order['OrderNo'], 'LineNo': j, 'ProdName': prodname,
                          'Qty': qty, 'Price': price, 'Amount': amount})
        order['Total'] = total

    cds_order = make_cds(owner, 'cdsOrder', [
        ('OrderNo', 'I', 0), ('CustNo', 'I', 0), ('OrderDate', 'D', 0),
        ('Status', 'S', 10), ('Total', 'F', 0)], orders)
    cds_order.IndexFieldNames = 'OrderNo'
    cds_order.First()

    cds_item = make_cds(owner, 'cdsOrderItem', [
        ('OrderNo', 'I', 0), ('LineNo', 'I', 0), ('ProdName', 'S', 30),
        ('Qty', 'I', 0), ('Price', 'F', 0), ('Amount', 'F', 0)], items)

    # 建立主从联动. 要点: 从表的索引必须以联动字段(OrderNo)开头, MasterSource 指向主表的 DataSource,
    # MasterFields 指定用主表的哪个字段去匹配从表的同名索引字段.
    src = keep(DataSource(owner))
    src.DataSet = cds_order
    cds_item.IndexFieldNames = 'OrderNo;LineNo'
    cds_item.MasterSource = src
    cds_item.MasterFields = 'OrderNo'
    cds_item.First()
    return cds_order, cds_item


# ---------------------------------------------------------------------------
# 商品表(分组演示): Category, ProdNo, ProdName, Price, Qty, Amount   (3 类 x 6 个 = 18 行)
# 数据按 Category 排序, 分组报表要求数据已按分组字段排好序.
# ---------------------------------------------------------------------------
def build_product_ds(owner):
    cats = ['办公用品', '电子产品', '日用百货']
    prods = [
        ['中性笔', '笔记本', '文件夹', '订书机', '打印纸', '便利贴'],
        ['无线鼠标', '机械键盘', '移动硬盘', '显示器', '耳机', '充电器'],
        ['保温杯', '毛巾', '洗衣液', '纸巾', '雨伞', '收纳盒'],
    ]
    rows = []
    for c in range(3):
        for p in range(6):
            price = float(delphi_random(300) + 5)
            qty = delphi_random(100) + 1
            rows.append({'Category': cats[c], 'ProdNo': (c + 1) * 100 + p + 1,
                         'ProdName': prods[c][p], 'Price': price, 'Qty': qty,
                         'Amount': price * qty})
    ds = make_cds(owner, 'cdsProduct', [
        ('Category', 'S', 20), ('ProdNo', 'I', 0), ('ProdName', 'S', 30),
        ('Price', 'F', 0), ('Qty', 'I', 0), ('Amount', 'F', 0)], rows)
    ds.IndexFieldNames = 'Category;ProdNo'
    ds.First()
    return ds
