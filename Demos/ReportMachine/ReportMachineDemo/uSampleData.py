# -*- coding: utf-8 -*-
"""样例模板用的模拟数据.

对应 Delphi 工程的 uSampleData.pas. Templates/Samples 里的 6 个 .rmf 是真实项目里做出来的报表模板,
它们按固定的数据集名称(rmds1/2/4/5/6/7)和字段名取数, 所以这里生成"同名同字段"的模拟数据,
模板不需要修改就能显示. 数据集的生成方式见 uDemoData.py 开头的说明.

数据集与模板的对应关系
    rmds1  入库明细      inware.rmf          (样例1)
    rmds2  出库明细      outware.rmf         (样例2)
    rmds7  护理事故记录  accident.rmf        (样例3)
    rmds6  现金流水      cash.rmf            (样例4)
    rmds5  人员详情      elderdetail.rmf     (样例5, 带照片)
    rmds4  费用表        elderfeetable.rmf   (样例6, 网格报表页)
(没有 rmds3: 只有未在样例页使用的 stock_d.rmf 会用到它, Delphi 原版同样没有提供.)

每个 build_xxx 函数开头都会重设随机种子, 并严格按 Delphi 版语句顺序调用 delphi_random,
所以生成的数据与 Delphi 版逐值一致.
"""
import os
import struct

from uDemoData import make_cds, set_rand_seed, delphi_random

# ---- 各数据集共用的取值表 ----
WHSE = ['一号仓', '二号仓']
CATS = ['办公用品', '电子产品', '日用百货']
MATS = [                                     # 物品名称, 按类别分组: MATS[类别][0..3]
    ['中性笔', '笔记本', '文件夹', '打印纸'],
    ['无线鼠标', '机械键盘', '移动硬盘', '耳机'],
    ['保温杯', '毛巾', '洗衣液', '收纳盒'],
]
SPECS = ['标准', '大号', '小号']
UNITS = ['个', '盒', '件']
PERSONS = ['张伟', '王芳', '李娜', '刘洋', '陈静', '杨帆', '赵磊', '孙悦']
DEPTS = ['行政部', '财务部', '销售部', '技术部']


def pick(arr, i):
    """循环取值, 等价于 Delphi 版的 Pick(A, I) = A[I mod 元素个数]"""
    return arr[i % len(arr)]


def dstr(m, d):
    """生成 '2026-月-日' 形式的日期字符串. 月份故意不补零, 因为样例模板里用
    Copy(日期,7,1)='-' 来判断月份是一位还是两位."""
    return '2026-%d-%d' % (m, d)


def _fields(defs):
    """把 'whse_id:S' 这样的简写转成 make_cds 需要的字段定义.
    :S 字符串(宽度 100), :F 浮点, :I 整数."""
    result = []
    for d in defs:
        name, kind = d.split(':')
        result.append((name, kind, 100 if kind == 'S' else 0))
    return result


def make_photo_file(path):
    """生成 90x120 的纯色占位照片(24 位 BMP). 文件已存在则不动. 返回是否成功.

    Templates/Samples 里已经带了 photo.bmp, 这个函数只在它被误删时兜底."""
    if os.path.isfile(path):
        return True
    try:
        os.makedirs(os.path.dirname(path), exist_ok=True)
        w, h = 90, 120
        stride = (w * 3 + 3) // 4 * 4                 # BMP 每行字节数要对齐到 4 的倍数
        pixel = bytes([0xE0, 0xC8, 0xA0])             # BGR 顺序, 即 Delphi 的 $00E0C8A0
        row = pixel * w + b'\x00' * (stride - w * 3)
        data = row * h
        header = (b'BM' + struct.pack('<IHHI', 54 + len(data), 0, 0, 54) +        # 文件头
                  struct.pack('<IiiHHIIiiII', 40, w, h, 1, 24, 0, len(data), 2835, 2835, 0, 0))  # 信息头
        with open(path, 'wb') as f:
            f.write(header + data)
        return True
    except Exception:
        return False


# ---------------------------------------------------------------------------
# rmds1: 入库明细 (inware.rmf)   36 行, 按 仓库 + 日期 排序
# 注意 sum 字段 = cnt * price: 模板里的汇总原本写成 Sum(cnt*price), 补丁后改为 Sum(sum), 结果相同.
# ---------------------------------------------------------------------------
def build_inware_ds(owner):
    defs = ['whse_id:S', 'inware_date:S', 'mat_name:S', 'cat_id:S', 'buyer:S', 'spec:S',
            'unit:S', 'cnt:F', 'sum:F', 'check_id:S', 'price:F']
    set_rand_seed(777)
    rows = []
    for i in range(36):
        c = i % 3                                     # 类别下标
        cnt = 1 + delphi_random(50)
        price = 5 + delphi_random(200)
        rows.append({                                 # 字典里各项的求值顺序就是随机数的调用顺序
            'whse_id': pick(WHSE, i // 2),
            'inware_date': dstr(1 + delphi_random(4), 1 + delphi_random(28)),
            'mat_name': MATS[c][delphi_random(4)],
            'cat_id': CATS[c],
            'buyer': pick(PERSONS, i),
            'spec': pick(SPECS, i),
            'unit': pick(UNITS, i),
            'cnt': cnt,
            'sum': cnt * price,
            'check_id': pick(PERSONS, i + 3),
            'price': price,
        })
    ds = make_cds(owner, 'cdsInware', _fields(defs), rows)
    ds.IndexFieldNames = 'whse_id;inware_date'       # 模板按仓库、月份两级分组, 数据必须先排好序
    ds.First()
    return ds


# ---------------------------------------------------------------------------
# rmds2: 出库明细 (outware.rmf)   36 行, 按 仓库 + 日期 排序
# ---------------------------------------------------------------------------
def build_outware_ds(owner):
    defs = ['whse_id:S', 'out_date:S', 'cat_id:S', 'mat_name:S', 'receiptor:S', 'spec:S',
            'unit:S', 'cnt:F', 'dept:S', 'audit_name:S', 'input_date:S']
    set_rand_seed(888)
    rows = []
    for i in range(36):
        c = i % 3
        rows.append({
            'whse_id': pick(WHSE, i // 2),
            'out_date': dstr(1 + delphi_random(4), 1 + delphi_random(28)),
            'cat_id': CATS[c],
            'mat_name': MATS[c][delphi_random(4)],
            'receiptor': pick(PERSONS, i),
            'spec': pick(SPECS, i),
            'unit': pick(UNITS, i),
            'cnt': 1 + delphi_random(30),
            'dept': pick(DEPTS, i),
            'audit_name': pick(PERSONS, i + 5),
            'input_date': dstr(1 + delphi_random(4), 1 + delphi_random(28)),
        })
    ds = make_cds(owner, 'cdsOutware', _fields(defs), rows)
    ds.IndexFieldNames = 'whse_id;out_date'
    ds.First()
    return ds


# ---------------------------------------------------------------------------
# rmds7: 护理事故记录 (accident.rmf)   20 行, 按录入日期排序
# ---------------------------------------------------------------------------
def build_accident_ds(owner):
    health = ['跌倒', '发烧', '擦伤', '头晕']
    memo = ['已处理, 观察24小时', '已联系家属并送医', '已上药包扎', '休息后好转']
    defs = ['input_date:S', 'elder_name:S', 'con_code:S', 'duty_man:S', 'tend_date:S',
            'healthmemoname:S', 'tend_memo:S']
    set_rand_seed(999)
    rows = []
    for i in range(20):
        rows.append({
            'input_date': dstr(1 + i % 4, 1 + delphi_random(28)),
            'elder_name': pick(PERSONS, i),
            'con_code': 'C%04d' % (1000 + i),
            'duty_man': pick(PERSONS, i + 2),
            'tend_date': dstr(1 + i % 4, 1 + delphi_random(28)),
            'healthmemoname': pick(health, i),
            'tend_memo': pick(memo, i + 1),
        })
    ds = make_cds(owner, 'cdsAccident', _fields(defs), rows)
    ds.IndexFieldNames = 'input_date'
    ds.First()
    return ds


# ---------------------------------------------------------------------------
# rmds6: 现金/银行流水 (cash.rmf)   20 行, 按 id 排序
#
# Delphi 原版数据里还有一个 id=21 的余额汇总行, 由模板脚本 GetValue('rmds6."id"')=21 把它隐藏.
# 测试环境里这段脚本无法编译(见 uMain.PatchScript), 程序会把它清空, 所以这里干脆不生成该行.
# 显示效果与原来相同: 被隐藏的行本来就不显示, 且它的借贷字段为空, 不影响合计.
# ---------------------------------------------------------------------------
def build_cash_ds(owner):
    proj = ['办公费', '差旅费', '材料费', '水电费']
    pays = ['现金', '银行转账', '支票']
    defs = ['id:I', 'c_blance:F', 'b_blance:F', 'in_date:S', 'name:S', 'project:S', 'pay:S',
            'remark:S', 'c_debit:F', 'c_credit:F', 'b_debit:F', 'b_credit:F']
    set_rand_seed(555)
    rows = []
    for i in range(1, 21):
        rows.append({                                 # c_blance / b_blance(余额)留空, 即 NULL
            'id': i,
            'in_date': dstr(1 + i % 4, 1 + delphi_random(28)),
            'name': pick(PERSONS, i),
            'project': pick(proj, i),
            'pay': pick(pays, i),
            'remark': '演示数据%d' % i,
            'c_debit': float(delphi_random(3000)),
            'c_credit': float(delphi_random(2000)),
            'b_debit': float(delphi_random(5000)),
            'b_credit': float(delphi_random(4000)),
        })
    ds = make_cds(owner, 'cdsCash', _fields(defs), rows)
    ds.IndexFieldNames = 'id'
    ds.First()
    return ds


# ---------------------------------------------------------------------------
# rmds5: 人员详情 (elderdetail.rmf)   15 行, 按 instate(入住状态) 排序, 模板按它分组
#
# fphoto 是照片文件路径, 模板里的图片对象用它显示照片(见 uMain.FixPictures).
# 末尾三个 *_name 字段是 Delphi 版没有的: 模板里原来用 IF([instate]=0,'试住老人信息',...) 这样的
# 数值比较表达式把代码翻译成文字, 程序加载前会把这些表达式替换成直接读下面预先算好的文字字段
# (见 uMain.FILE_PATCH_RULES). 文字内容与模板里的 IF 逻辑逐项一致.
# ---------------------------------------------------------------------------
def build_elder_detail_ds(owner, photo):
    nation = ['汉族', '回族', '满族']
    place = ['北京', '上海', '广东', '四川']
    fee = ['自费', '医保', '公费']
    level = ['一级', '二级', '三级']
    defs = ['fphoto:S', 'instate:I', 'oldername:S', 'gender:I', 'birth_date:S', 'nation:S',
            'nativeplace:S', 'telephone:S', 'medicare:S', 'fee_type:S', 'marrige:I',
            'month_fee:F', 'care_people:S', 'care_level:S',
            'instate_name:S', 'gender_name:S', 'marrige_name:S']
    instate_names = ['试住老人信息', '入住老人信息', '退住老人信息', '转院老人信息']   # instate 0~3, 其它为"死亡"
    marrige_names = ['离婚', '已婚', '离异']                                           # marrige 0~2, 其它为"喪偶"
    set_rand_seed(444)
    rows = []
    for i in range(15):
        rows.append({
            'fphoto': photo,
            'instate': i % 5,
            'oldername': pick(PERSONS, i),
            'gender': i % 2,                          # 0 男, 1 女
            'birth_date': '%d-%d-%d' % (1935 + delphi_random(15), 1 + delphi_random(12),
                                        1 + delphi_random(28)),
            'nation': pick(nation, i),
            'nativeplace': pick(place, i),
            'telephone': '1390%07d' % delphi_random(10000000),
            'medicare': pick(fee, i + 1),
            'fee_type': pick(fee, i),
            'marrige': i % 4,                         # 必须是整数, 模板里按数字 0..3 判断
            'month_fee': float(2000 + delphi_random(30) * 100),
            'care_people': pick(PERSONS, i + 4),
            'care_level': pick(level, i),
            'instate_name': instate_names[i % 5] if i % 5 < 4 else '死亡',
            'gender_name': '男' if i % 2 == 0 else '女',
            'marrige_name': marrige_names[i % 4] if i % 4 < 3 else '喪偶',
        })
    ds = make_cds(owner, 'cdsElderDetail', _fields(defs), rows)
    ds.IndexFieldNames = 'instate'
    ds.First()
    return ds


# ---------------------------------------------------------------------------
# rmds4: 费用表 (elderfeetable.rmf, 网格报表页)   15 行
# 每人 5 个费用项目 (record0..4 / fee0..4), allfee 是合计.
# ---------------------------------------------------------------------------
def build_elder_fee_ds(owner):
    rec = ['床位费', '护理费', '餐费', '医疗费', '其他']
    defs = ['elder_name:S', 'con_code:S', 'record0:S', 'fee0:F', 'mindate0:S', 'maxdate0:S',
            'record1:S', 'fee1:F', 'record2:S', 'fee2:F', 'record3:S', 'fee3:F',
            'record4:S', 'fee4:F', 'allfee:F']
    set_rand_seed(333)
    rows = []
    for i in range(15):
        r = {
            'elder_name': pick(PERSONS, i),
            'con_code': 'C%04d' % (1000 + i),
            'mindate0': dstr(1, 1 + delphi_random(10)),
            'maxdate0': dstr(4, 15 + delphi_random(10)),
        }
        total = 0.0
        for k in range(5):
            r['record%d' % k] = rec[k]
            r['fee%d' % k] = float(100 + delphi_random(90) * 10)
            total += r['fee%d' % k]
        r['allfee'] = total
        rows.append(r)
    ds = make_cds(owner, 'cdsElderFee', _fields(defs), rows)
    ds.First()                                        # 该数据集没有排序要求
    return ds
