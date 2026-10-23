# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
# -*- coding: utf-8 -*-
"""
    uMain.py                主窗体: 按钮事件、报表的预览/设计/打印/导出
    uDemoData.py            演示1~4 用的数据集(客户、订单主从、商品)
    uSampleData.py          6 个样例模板用的数据集(rmds1~rmds7)

【重要经验】Python 回调 OnGetValue 会干扰报表取数
    曾经给每个报表都挂了 Python 版 OnGetValue(为演示3 的 [ReportTitle] 等变量服务), 结果样例1、样例5
    的数据单元格全部变成空白; 样例预览不再挂这个回调后恢复正常. 原因推测是 RM 对每个值求值时都会回调它,
    而 var 参数的写回会破坏某些值. 所以现在只有真正需要变量的演示3 才挂它, 见 NewReport.
"""
import os
import re
import time

from glcl import *
import uDemoData
from uDemoData import keep, build_customer_ds, build_order_item_ds, build_product_ds
from uSampleData import (make_photo_file, build_inware_ds, build_outware_ds,
                         build_elder_fee_ds, build_elder_detail_ds, build_cash_ds,
                         build_accident_ds)

# 开关: 针对"样例模板"页的两项修补
ENABLE_TEMPLATE_PATCH = True   # 预览/打印样例前, 对 inware.rmf、elderdetail.rmf 做"等长替换"补丁
ENABLE_SCRIPT_PATCH = True     # 清空样例模板脚本里调用 GetValue/GetFieldValue 的过程(样例4、样例5)

# ===========================================================================
# 常量
# ===========================================================================
# 样例页 6 个模板的文件名, 顺序与界面上的样例1~样例6 对应
SAMPLE_FILES = ['inware.rmf', 'outware.rmf', 'accident.rmf',
                'cash.rmf', 'elderdetail.rmf', 'elderfeetable.rmf']

# 内置演示1~4 的模板文件名(需要用户在设计器里自己做并保存)
TEMPLATE_NAMES = {1: 'demo1_customer.rmf', 2: 'demo2_order_detail.rmf',
                  3: 'demo3_variables.rmf', 4: 'demo4_group.rmf'}

# 演示3 才使用报表变量 [ReportTitle] 等, 只有它需要挂 OnGetValue 回调
VARIABLE_DEMO = 3

# OnGetValue 里 [ReportTitle] 按演示编号返回的标题
REPORT_TITLES = {1: '客户清单', 2: '订单明细(主从)', 3: '客户清单(变量与过滤演示)', 4: '商品分组汇总'}

# 操作代码: 0 预览, 1 设计, 2 打印
ACT_PREVIEW, ACT_DESIGN, ACT_PRINT = 0, 1, 2

# --- 样例模板脚本修补(ENABLE_SCRIPT_PATCH) ----------------------------------
# 样例4(cash.rmf)、样例5(elderdetail.rmf)的脚本调用了 RM 内置函数 GetValue / GetFieldValue,
# 在测试环境里脚本编译器报 "Undeclared Identifier". PatchScript 用下面三个正则找出并清空这类过程.
_PROC_RE = re.compile(r'^procedure\s+(\w+)\s*(\([^)]*\))?\s*;(.*?)^end;', re.I | re.S | re.M)
_BAD_CALL_RE = re.compile(r'\b(GetFieldValue|GetValue)\s*\(', re.I)
_LOADFILE_RE = re.compile(r'(\w+)\s*\.\s*LoadFromFile\s*\(', re.I)

# --- 样例模板文件补丁(ENABLE_TEMPLATE_PATCH) ---------------------------------
# 在加载前对 .rmf 文件做"等长替换"生成临时副本(原模板不改动), 去掉模板里的数值运算表达式:
#   inware.rmf     Sum([cnt] * [price])  ->  Sum([sum])   (数据里 sum 字段本来就等于 cnt*price)
#   elderdetail.rmf IF([字段]=数字, ...) ->  读数据集里预先算好的文字字段 instate_name 等
# "等长": 新文本比旧文本短时, 在该备忘录文本末尾(\r\n 之前)补空格, 这样 .rmf 的二进制长度字段不受影响,
# 显示上也看不出来. 每项: (字节正则, 替换字节串, 期望命中次数); 命中次数不对就不打补丁.
FILE_PATCH_RULES = {
    'inware.rmf': [
        # \xe5\x85\x83 是"元"的 UTF-8 编码; 两个汇总备忘录(分组尾)各出现一次
        (rb'\[Sum\(\[rmds1\."cnt"\] \* \[rmds1\."price"\]\)\]\xe5\x85\x83(?=\r\n)',
         b'[Sum([rmds1."sum"])]\xe5\x85\x83', 2),
    ],
    'elderdetail.rmf': [
        (rb'\[IF\(\[rmds5\."instate"\]=0,[^\r\n]*\)\](?=\r\n)', b'[rmds5."instate_name"]', 1),
        (rb'\[IF\(\[rmds5\."gender"\]=0,[^\r\n]*\)\](?=\r\n)', b'[rmds5."gender_name"]', 1),
        (rb'\[IF\(\[rmds5\."marrige"\]=0,[^\r\n]*\)\](?=\r\n)', b'[rmds5."marrige_name"]', 1),
    ],
}

# ---------------------------------------------------------------------------
# 右侧帮助面板文字
# 键: 0 欢迎页, 1~4 内置演示, 5 预生成报表, 6 导出, 8 样例模板, 9 高级功能
# ---------------------------------------------------------------------------
HELP_TEXTS = {
    1: [
        '【演示1 客户清单 - 单表报表】',
        '数据集: rmCustomer',
        '字段: CustNo, CustName, City, Contact, Phone, Credit',
        '',
        '设计步骤:',
        '1. 点 [设计] 打开设计器',
        '2. 插入"报表标题"带, 放文本框写: 客户清单',
        '3. 插入"页眉"带, 放几个文本框做列标题',
        '4. 插入"主数据(MasterData)"带, 属性 DataSet 选 rmCustomer',
        '5. 在数据带内放文本框, 内容填 [rmCustomer."CustName"] 等字段',
        '   (也可以从设计器的数据字段列表拖入)',
        '6. 插入"页脚"带, 放页码系统变量',
        '7. 关闭设计器, 选择保存到 Templates 目录',
        '之后点 [预览] / [打印] 即可.',
    ],
    2: [
        '【演示2 订单主从明细】',
        '主数据集: rmOrder  (OrderNo, CustNo, OrderDate, Status, Total)',
        '明细数据集: rmOrderItem (OrderNo, LineNo, ProdName, Qty, Price, Amount)',
        '',
        '设计步骤:',
        '1. 插入"主数据"带, DataSet 选 rmOrder, 放订单号/日期/状态/合计',
        '2. 在主数据带下面插入"明细数据(DetailData)"带,',
        '   DataSet 选 rmOrderItem, 放商品/数量/单价/金额',
        '3. 主从关系已在 ClientDataSet 上通过 MasterSource/MasterFields',
        '   (OrderNo)建立好, 报表里不需要再设置连接.',
        '4. 保存模板后预览, 每个订单下面会跟着它自己的明细行.',
    ],
    3: [
        '【演示3 变量与过滤】',
        '数据集: rmCustomer, 先在左侧选好"过滤城市"再预览',
        '',
        '本例通过 OnGetValue 提供以下变量, 在文本框里直接写即可:',
        '  [ReportTitle]  报表标题',
        '  [Company]      公司名称',
        '  [PrintUser]    当前 Windows 用户名',
        '  [PrintTime]    打印时间',
        '  [FilterInfo]   过滤条件说明',
        '  [RecCount]     记录数',
        '启用 全局变量 [GlobalNote].',
        '',
        '设计: 标题带放 [ReportTitle] 和 [Company],',
        '页脚放 [PrintUser] [PrintTime] [RecCount],',
        '主数据带 DataSet 选 rmCustomer, 放客户字段.',
    ],
    4: [
        '【演示4 商品分组汇总】',
        '数据集: rmProduct (Category, ProdNo, ProdName, Price, Qty, Amount)',
        '数据已按 Category 排序.',
        '',
        '设计步骤:',
        '1. 插入"分组头(GroupHeader)"带, 分组条件填 [rmProduct."Category"]',
        '2. 在分组头放文本框显示 [rmProduct."Category"]',
        '3. 插入"主数据"带, DataSet 选 rmProduct, 放商品明细',
        '4. 插入"分组尾(GroupFooter)"带, 放汇总文本框统计 Amount',
        '   (网样例里的写法: [Sum([数据集."字段"],主数据带名])',
        '    也可以用"计算文本框"并设置汇总类型)',
        '5. 插入"报表总结"带放全部合计',
    ],
    5: [
        '【演示5 预生成报表 .rmp】',
        '把演示1的报表先 PrepareReport 生成结果页, 保存成 .rmp;',
        '之后无需数据集, 可以直接载入并预览, 适合归档/存档报表.',
        '',
        '先做好演示1的模板, 点 [生成保存], 再点 [载入预览].',
        '文件: Templates\\demo1_prepared.rmp',
    ],
    6: [
        '【演示6 导出】',
        '导出的是演示1的模板, 输出到 Templates 目录.',
    ],
    8: [
        '【样例模板】',
        '共 6 个真实使用中的 .rmf, 涵盖:',
        '  - 多级分组头/分组尾 + Sum 汇总 + IF/Copy 表达式',
        '  - 报表脚本(OnBeforePrint 隐藏行, 动态加载图片)',
        '  - 网格报表页(TRMGridReportPage)',
        '',
        '数据集名称 rmds1/2/4/5/6/7 由本程序生成同名同字段的',
        '模拟数据, 所以模板不需要修改即可显示.',
        '点 [设计] 可以在设计器里查看它们是怎么做的, 是很好的学习材料.',
        '',
        '勾选"用代码改写标题"后, 程序会在 LoadFromFile 之后用',
        "FindObject('Memo1').Memo.Text := ... 修改模板里的文本框.",
    ],
    9: [
        '【高级功能】',
        '打开任意 .rmf: 用来测试你自己的模板.',
        '  你的模板里数据集名字要与本程序数据集一致,',
        '  或者在设计器里把带区的 DataSet 改选为本程序的数据集.',
        '',
        '  内部使用 TRMCompositeReport, 把多个报表合并到一个预览.',
    ],
    0: [
        '【ReportMachine 多功能演示 v2】',
        '',
        '页1 内置演示: 4 个报表 + 预生成报表 + 导出',
        '页2 样例模板: 6 个真实 .rmf 直接加载',
        '页3 高级功能: 打开任意 rmf、多报表合并',
        '',
        '数据全部由内存 TClientDataSet 生成, 不需要数据库.',
        '',
        '使用流程(页1): 点 [设计] 做模板并保存, 再 [预览]/[打印].',
        '模板保存在程序同目录的 Templates 文件夹.',
    ],
}


# 窗体上全部按钮的名称. 它们共用同一个 OnClick 处理函数 BtnClick, 由按钮的 Tag 区分
BUTTON_NAMES = [
    'btnDemo1Design',
    'btnDemo1Preview',
    'btnDemo1Print',
    'btnDemo2Design',
    'btnDemo2Preview',
    'btnDemo2Print',
    'btnDemo3Design',
    'btnDemo3Preview',
    'btnDemo3Print',
    'btnDemo4Design',
    'btnDemo4Preview',
    'btnDemo4Print',
    'btnPrepSave',
    'btnPrepLoad',
    'btnExpHtml',
    'btnExpXls',
    'btnOpenDir',
    'btnSample1Preview',
    'btnSample1Design',
    'btnSample1Print',
    'btnSample2Preview',
    'btnSample2Design',
    'btnSample2Print',
    'btnSample3Preview',
    'btnSample3Design',
    'btnSample3Print',
    'btnSample4Preview',
    'btnSample4Design',
    'btnSample4Print',
    'btnSample5Preview',
    'btnSample5Design',
    'btnSample5Print',
    'btnSample6Preview',
    'btnSample6Design',
    'btnSample6Print',
    'btnOpenAny',
    'btnComposite',
]


def quoted_str(s):
    """等价于 Delphi 的 QuotedStr: 用单引号括起来, 内部的单引号写成两个. 用于拼 Filter 表达式."""
    return "'" + s.replace("'", "''") + "'"


class frmMain(Form):
    """主窗体. 界面控件由 uMain.pydfm 描述, 报表对象在代码里动态创建."""

    def __init__(self, owner):
        # ---- 控件声明 ----
        self.memLog = Memo(self)
        self.memHelp = Memo(self)
        self.pnlClient = Panel(self)
        self.pcMain = PageControl(self)
        self.tsBuiltin = TabSheet(self)
        self.lblDemo1 = Label(self)
        self.lblDemo2 = Label(self)
        self.lblDemo3 = Label(self)
        self.lblCity = Label(self)
        self.lblDemo4 = Label(self)
        self.lblDemo5 = Label(self)
        self.lblDemo6 = Label(self)
        self.lblTplDir = Label(self)
        self.btnDemo1Design = Button(self)
        self.btnDemo1Preview = Button(self)
        self.btnDemo1Print = Button(self)
        self.btnDemo2Design = Button(self)
        self.btnDemo2Preview = Button(self)
        self.btnDemo2Print = Button(self)
        self.btnDemo3Design = Button(self)
        self.btnDemo3Preview = Button(self)
        self.btnDemo3Print = Button(self)
        self.cbCity = ComboBox(self)
        self.btnDemo4Design = Button(self)
        self.btnDemo4Preview = Button(self)
        self.btnDemo4Print = Button(self)
        self.btnPrepSave = Button(self)
        self.btnPrepLoad = Button(self)
        self.btnExpHtml = Button(self)
        self.btnExpXls = Button(self)
        self.btnOpenDir = Button(self)
        self.tsSamples = TabSheet(self)
        self.lblSample1 = Label(self)
        self.lblSample2 = Label(self)
        self.lblSample3 = Label(self)
        self.lblSample4 = Label(self)
        self.lblSample5 = Label(self)
        self.lblSample6 = Label(self)
        self.btnSample1Preview = Button(self)
        self.btnSample1Design = Button(self)
        self.btnSample1Print = Button(self)
        self.btnSample2Preview = Button(self)
        self.btnSample2Design = Button(self)
        self.btnSample2Print = Button(self)
        self.btnSample3Preview = Button(self)
        self.btnSample3Design = Button(self)
        self.btnSample3Print = Button(self)
        self.btnSample4Preview = Button(self)
        self.btnSample4Design = Button(self)
        self.btnSample4Print = Button(self)
        self.btnSample5Preview = Button(self)
        self.btnSample5Design = Button(self)
        self.btnSample5Print = Button(self)
        self.btnSample6Preview = Button(self)
        self.btnSample6Design = Button(self)
        self.btnSample6Print = Button(self)
        self.chkTitle = CheckBox(self)
        self.edtTitle = Edit(self)
        self.tsAdvanced = TabSheet(self)
        self.lblOpenAny = Label(self)
        self.lblComposite = Label(self)
        self.lblDatasets = Label(self)
        self.btnOpenAny = Button(self)
        self.btnComposite = Button(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "uMain.pydfm"))

        # ---- 事件绑定 ----
        # sfm 里按钮没有 OnClick, 在这里统一绑定到 BtnClick
        for name in BUTTON_NAMES:
            getattr(self, name).OnClick = self.BtnClick

        # ---- 成员变量 ----
        self.FReport = None          # 当前的 RMReport. 每次操作都重新创建, 见 NewReport
        self.FDesigner = None        # 报表设计器组件
        self.FCust = None            # 客户数据集(演示1/3 用, 演示3 会按城市过滤)
        self.FOrder = None           # 订单主表
        self.FItem = None            # 订单明细表(与主表联动)
        self.FProd = None            # 商品数据集(演示4 分组汇总)
        self.FCurIdx = 0             # 当前演示编号, OnGetValue 里据此返回不同的标题
        self.FPhoto = ''             # 样例5 用的占位照片路径
        self.FHtmlExp = None         # HTML 导出器
        self.FXlsExp = None          # Excel 导出器
        self.FTplDir = ''            # 模板目录(带结尾反斜杠)
        self.FSampleDir = ''         # 样例模板目录
        self.FormCreate()

    # ------------------------------------------------------------------
    # 窗体创建
    # ------------------------------------------------------------------
    def FormCreate(self):
        """初始化: 确定模板目录、创建设计器、生成演示数据、显示欢迎帮助."""
        # 模板目录放在脚本所在目录下. Delphi 用 exe 所在目录, 但 Python 里 Application.ExeName
        # 是 python.exe, 所以改用 __file__.
        base = os.path.dirname(os.path.abspath(__file__))
        self.FTplDir = os.path.join(base, 'Templates') + os.sep
        self.FSampleDir = os.path.join(self.FTplDir, 'Samples') + os.sep
        os.makedirs(self.FSampleDir, exist_ok=True)

        # 设计器组件: 报表的 DesignReport 需要它; TemplateDir 决定"打开/保存"对话框的默认目录
        self.FDesigner = RMDesigner(self)
        self.FDesigner.TemplateDir = self.FTplDir

        self.BuildData()
        self.ShowHelp(0)
        self.Log('启动完成. 模板目录: ' + self.FTplDir)

    def BuildData(self):
        """生成全部演示数据, 并为每个数据集包一层 RM 数据集(RMDBDataSet)供报表引用."""
        # 演示1~4 用的数据集
        self.FCust = build_customer_ds(self)
        self.FOrder, self.FItem = build_order_item_ds(self)
        self.FProd = build_product_ds(self)
        # RM 数据集的 Name 就是设计器和模板里看到的名字, 如 [rmCustomer."CustName"]
        self.MakeRmDS('rmCustomer', self.FCust)
        self.MakeRmDS('rmOrder', self.FOrder)
        self.MakeRmDS('rmOrderItem', self.FItem)
        self.MakeRmDS('rmProduct', self.FProd)

        # 样例模板固定使用 rmds1 ~ rmds7 这几个名字(没有 rmds3), 字段名也要与模板一致
        photo = self.FSampleDir + 'photo.bmp'
        make_photo_file(photo)          # 照片文件不存在时生成一个占位图
        self.FPhoto = photo
        self.MakeRmDS('rmds1', build_inware_ds(self))
        self.MakeRmDS('rmds2', build_outware_ds(self))
        self.MakeRmDS('rmds4', build_elder_fee_ds(self))
        self.MakeRmDS('rmds5', build_elder_detail_ds(self, photo))
        self.MakeRmDS('rmds6', build_cash_ds(self))
        self.MakeRmDS('rmds7', build_accident_ds(self))

        # 导出器: 报表 PrepareReport 之后用 ExportTo 导出为 HTML / Excel
        self.FHtmlExp = RMHTMExport(self)
        self.FXlsExp = RMXLSExport(self)

    def MakeRmDS(self, name, ds):
        """创建一个 RM 数据集并关联到 ClientDataSet. 返回值用 keep() 保存引用, 防止 Python 端过早回收."""
        result = keep(RMDBDataSet(self))
        result.Name = name
        result.DataSet = ds
        return result

    def Log(self, s):
        """向左下角的日志框追加一行, 带时间戳."""
        self.memLog.Lines.Add(time.strftime('%H:%M:%S  ') + s)

    def ShowHelp(self, idx):
        """在右侧帮助框里显示第 idx 号帮助; 没有对应内容时显示欢迎页."""
        self.memHelp.Lines.Clear()
        for line in HELP_TEXTS.get(idx, HELP_TEXTS[0]):
            self.memHelp.Lines.Add(line)

    # ------------------------------------------------------------------
    # 报表核心逻辑
    # ------------------------------------------------------------------
    def TemplateFile(self, idx):
        """演示 idx 的模板文件完整路径."""
        return self.FTplDir + TEMPLATE_NAMES[idx]

    def ApplyFilter(self, idx):
        """按演示编号设置客户数据集的过滤条件: 只有演示3 并且选了具体城市时才过滤."""
        self.FCust.Filtered = False
        self.FCust.Filter = ''
        if idx == VARIABLE_DEMO and self.cbCity.ItemIndex > 0:   # 第 0 项是"全部城市"
            self.FCust.Filter = 'City = ' + quoted_str(self.cbCity.Text)
            self.FCust.Filtered = True
        self.FCust.First()

    def NewReport(self, idx, handler=None):
        """释放旧报表并新建一个 RMReport, 避免上一次的模板内容残留.

        handler: 是否挂接 OnGetValue 回调. 默认只有演示3(要用 [ReportTitle] 等变量)才挂.
                 不需要变量的报表一律不要挂: 这个 Python 回调曾导致样例1、样例5 的数据全部变成空白
        """
        if handler is None:
            handler = (idx == VARIABLE_DEMO)
        self.FCurIdx = idx
        if self.FReport is not None:
            try:
                self.FReport.Free()
            except Exception:
                pass
            self.FReport = None
        self.FReport = RMReport(self)
        if handler:
            self.FReport.OnGetValue = self.ReportGetValue
        self.ApplyFilter(idx)

    def RunFile(self, afile, idx, act, retitle, sample=False):
        """加载模板文件 afile, 然后按 act 执行预览 / 设计 / 打印.

        idx     演示编号(决定过滤条件和变量标题); 样例和"打开任意模板"传 0
        act     ACT_PREVIEW / ACT_DESIGN / ACT_PRINT
        retitle 是否在加载后用代码改写模板里 Memo1 的文本(样例页的"用代码改写标题"复选框)
        sample  是否是样例页的模板. 样例模板需要做下面的两项修补
        """
        # 修补只用于样例的预览/打印. 设计模式必须打开原模板, 否则用户保存时会把修补后的内容写回样例文件.
        fix = sample and act != ACT_DESIGN

        self.NewReport(idx)

        load_file = afile
        if fix and ENABLE_TEMPLATE_PATCH:
            load_file = self.PatchedTemplate(afile)      # 没有补丁规则/打补丁失败时返回原文件
        if os.path.isfile(afile):
            self.FReport.LoadFromFile(load_file)
        if fix and ENABLE_SCRIPT_PATCH:
            self.FixPictures(self.PatchScript(self.FReport))

        # 演示"加载模板后用代码修改其中的对象": 找到名为 Memo1 的文本框, 改写它的内容
        title = self.edtTitle.Text
        if retitle and act != ACT_DESIGN and title != '':
            v = self.FReport.FindObject('Memo1')
            if v is not None:
                self.SetMemoText(v, title)
                self.Log('已用代码改写 Memo1 文本')
            else:
                self.Log('模板中没有名为 Memo1 的对象, 未改写')

        name = os.path.basename(afile)
        if act == ACT_PREVIEW:
            self.Log('预览: ' + name)
            self.FReport.ShowReport()
        elif act == ACT_DESIGN:
            self.Log('打开设计器: ' + name)
            self.FReport.DesignReport()
            # 设计器关闭后询问是否把改动保存回模板文件
            if self.Confirm('是否将当前设计保存到:\n' + afile + ' ?'):
                self.FReport.SaveToFile(afile)
                self.Log('模板已保存: ' + name)
        elif act == ACT_PRINT:
            self.Log('打印: ' + name)
            self.FReport.PrintReport()

    # ------------------------------------------------------------------
    # 样例模板的修补(详见文件开头的两个开关)
    # ------------------------------------------------------------------
    def PatchedTemplate(self, afile):
        """按 FILE_PATCH_RULES 对模板文件做等长替换, 把结果写成临时副本并返回副本路径.

        没有对应规则、规则命中次数与预期不符(例如模板被用户改过)、或出现异常时, 返回原文件路径,
        即"按原样加载". 原模板文件从不被修改.
        """
        name = os.path.basename(afile)
        rules = FILE_PATCH_RULES.get(name.lower())
        if not rules or not os.path.isfile(afile):
            return afile
        try:
            with open(afile, 'rb') as f:
                data = f.read()
            total = 0
            for pattern, new, expected in rules:
                def repl(m, new=new):
                    old = m.group(0)
                    if len(new) > len(old):
                        raise ValueError('替换文本比原文长, 无法等长替换')
                    return new + b' ' * (len(old) - len(new))   # 末尾补空格保持总长度不变
                data, n = re.subn(pattern, repl, data)
                if n != expected:
                    self.Log('模板补丁未命中(%s: %d/%d), 按原样加载' % (name, n, expected))
                    return afile
                total += n
            out = os.path.join(uDemoData.data_dir(), name)   # 临时目录, 程序退出时自动清理
            with open(out, 'wb') as f:
                f.write(data)
            self.Log('已生成模板补丁副本: %s (等长替换 %d 处)' % (name, total))
            return out
        except Exception as e:
            self.Log('模板补丁失败, 按原样加载: %s' % e)
            return afile

    def PatchScript(self, report):
        """清空模板脚本里调用 GetValue / GetFieldValue 的过程, 避免 RM 弹出 "Undeclared Identifier".

        只替换整个过程体为空过程(过程名和参数保持不变, 模板里绑定的事件仍然能找到它).
        返回这些过程里出现过 "对象名.LoadFromFile(" 的对象名列表, 交给 FixPictures 用代码补上.
        """
        pictures = []
        changed = []
        try:
            src = report.Script.Text
        except Exception as e:
            self.Log('读取模板脚本失败: %s' % e)
            return pictures

        def repl(m):
            body = m.group(3)
            if not _BAD_CALL_RE.search(body):
                return m.group(0)                     # 不含问题调用的过程原样保留
            changed.append(m.group(1))
            pictures.extend(_LOADFILE_RE.findall(body))
            return 'procedure %s%s;\r\nbegin\r\nend;' % (m.group(1), m.group(2) or '')

        new_src = _PROC_RE.sub(repl, src)
        if changed:
            try:
                report.Script.Text = new_src
            except Exception:                         # 个别环境下 Text 不可写: 退回逐行写入
                report.Script.Clear()
                for line in new_src.split('\r\n'):
                    report.Script.Add(line)
            self.Log('已清空模板脚本中的过程: ' + ', '.join(changed))
        return pictures

    def FixPictures(self, names):
        """给图片对象直接赋图, 代替被清空的脚本.

        样例5 的脚本原本在每行打印前取 rmds5."fphoto" 的路径再 LoadFromFile; 由于所有行用的是同一张
        照片, 直接给 Picture1 载入这张图即可, 效果相同.
        """
        for nm in names:
            v = self.FReport.FindObject(nm)
            if v is None:
                self.Log('模板中没有名为 %s 的图片对象' % nm)
                continue
            try:
                v.Picture.LoadFromFile(self.FPhoto)
                self.Log('已为 %s 载入图片 %s' % (nm, os.path.basename(self.FPhoto)))
            except Exception as e:
                self.Log('为 %s 载入图片失败: %s' % (nm, e))

    @staticmethod
    def SetMemoText(view, text):
        """等价于 Delphi 的 V.Memo.Text := text. Text 不可写时退回 Clear + Add."""
        try:
            view.Memo.Text = text
        except Exception:
            view.Memo.Clear()
            view.Memo.Add(text)

    def Confirm(self, text):
        """是/否确认框, 点"是"返回 True. """
        return Application.MessageBox(text, '确认', MB_YESNO | MB_ICONQUESTION) == IDYES

    # ------------------------------------------------------------------
    # 各按钮对应的动作
    # ------------------------------------------------------------------
    def DoTpl(self, idx, act):
        """内置演示 idx 的设计 / 预览 / 打印. 预览和打印时若模板还没做, 提示并可直接进设计器新建."""
        fn = self.TemplateFile(idx)
        if act != ACT_DESIGN and not os.path.isfile(fn):
            if self.Confirm('模板文件不存在:\n' + fn + '\n\n是否现在打开设计器新建?'):
                self.RunFile(fn, idx, ACT_DESIGN, False)
            return
        self.RunFile(fn, idx, act, False)

    def DoSample(self, i, act):
        """样例页第 i 个模板(从 0 开始)的预览 / 设计 / 打印. 样例模板需要修补, 所以 sample=True."""
        fn = self.FSampleDir + SAMPLE_FILES[i]
        self.RunFile(fn, 0, act, self.chkTitle.Checked, True)

    def DoOpenAny(self):
        """打开任意 .rmf 文件, 询问是预览还是设计."""
        dlg = OpenDialog(self)
        try:
            dlg.Filter = 'ReportMachine 模板 (*.rmf)|*.rmf|所有文件 (*.*)|*.*'
            dlg.InitialDir = self.FTplDir
            if not dlg.Execute():
                return
            fn = dlg.FileName
        finally:
            dlg.Free()
        # 三选一: Yes 预览 / No 设计 / Cancel 取消
        r = Application.MessageBox(
            '对 ' + os.path.basename(fn) + ' 执行什么操作?\n\n[Yes] 预览     [No] 设计     [Cancel] 取消',
            '确认', MB_YESNOCANCEL | MB_ICONQUESTION)
        if r == IDYES:
            self.RunFile(fn, 0, ACT_PREVIEW, False)
        elif r == IDNO:
            self.RunFile(fn, 0, ACT_DESIGN, False)

    def DoComposite(self):
        """多报表合并预览: 把演示1 和演示2 的模板放进 RMCompositeReport 一起预览."""
        t1, t2 = self.TemplateFile(1), self.TemplateFile(2)
        if not (os.path.isfile(t1) and os.path.isfile(t2)):
            ShowMessage('请先完成演示1和演示2的模板设计.')
            return
        self.ApplyFilter(0)
        r1 = RMReport(self)
        r2 = RMReport(self)
        c = RMCompositeReport(self)
        try:
            r1.LoadFromFile(t1)
            r2.LoadFromFile(t2)
            try:
                c.Reports.Clear()
                c.Reports.Add(r1)
                c.Reports.Add(r2)
                use_composite = True
            except Exception as e:
                # glcl 对 TList.Add 的封装不一定可用. 不可用时退而求其次: 用 AppendFromFile
                # 把第二个模板追加到第一个报表里, 同样能在一个预览窗口里看到两份报表.
                use_composite = False
                self.Log('Reports.Add 不可用(%s), 改用 AppendFromFile 合并' % e)
            self.Log('多报表合并预览: 演示1 + 演示2')
            if use_composite:
                c.ShowReport()
            else:
                r1.AppendFromFile(t2)
                r1.ShowReport()
        finally:
            # 先组合报表, 再两个子报表
            for obj in (c, r2, r1):
                try:
                    obj.Free()
                except Exception:
                    pass

    def DoSavePrepared(self):
        """演示5(上): 生成演示1 的报表结果页并保存成 .rmp, 之后无需数据集即可载入预览."""
        fn = self.TemplateFile(1)
        if not os.path.isfile(fn):
            ShowMessage('请先完成演示1的模板设计.')
            return
        self.NewReport(1)
        self.FReport.LoadFromFile(fn)
        t = time.perf_counter()
        self.FReport.PrepareReport()                       # 只生成结果页, 不显示
        t = int((time.perf_counter() - t) * 1000)
        self.FReport.SavePreparedReport(self.FTplDir + 'demo1_prepared.rmp')
        self.Log('已生成并保存 demo1_prepared.rmp, 生成耗时 %d ms' % t)

    def DoLoadPrepared(self):
        """演示5(下): 载入 .rmp 并预览(不需要模板, 也不需要数据集)."""
        fn = self.FTplDir + 'demo1_prepared.rmp'
        if not os.path.isfile(fn):
            ShowMessage('还没有 .rmp 文件, 请先点 [生成保存].')
            return
        self.NewReport(1)
        self.FReport.LoadPreparedReport(fn)
        self.Log('载入预生成报表: demo1_prepared.rmp')
        self.FReport.ShowPreparedReport()

    def DoExport(self, kind):
        """演示6: 把演示1 的报表导出. kind=0 导出 HTML, 其它导出 Excel. 输出到模板目录."""
        fn = self.TemplateFile(1)
        if not os.path.isfile(fn):
            ShowMessage('请先完成演示1的模板设计.')
            return
        self.NewReport(1)
        self.FReport.LoadFromFile(fn)
        self.FReport.PrepareReport()                       # 导出前必须先生成结果页
        if kind == 0:
            self.FReport.ExportTo(self.FHtmlExp, self.FTplDir + 'demo1.html')
            self.Log('已导出 demo1.html')
        else:
            self.FReport.ExportTo(self.FXlsExp, self.FTplDir + 'demo1.xls')
            self.Log('已导出 demo1.xls')

    # ------------------------------------------------------------------
    # 按钮事件: 所有按钮共用, 用 Tag 区分
    #   10~42   内置演示   十位 = 演示编号(1~4), 个位: 0 设计, 1 预览, 2 打印
    #   50/51   预生成报表 保存 / 载入预览
    #   60/61   导出 HTML / Excel
    #   70      打开模板目录
    #   100~152 样例模板   (Tag-100)//10 = 样例序号(0~5), 个位: 0 预览, 1 设计, 2 打印
    #   210     打开任意 rmf      220  多报表合并
    # ------------------------------------------------------------------
    def BtnClick(self, Sender):
        tag = Sender.Tag
        try:
            if tag >= 200:
                self.ShowHelp(9)
                if tag == 210:
                    self.DoOpenAny()
                elif tag == 220:
                    self.DoComposite()
            elif tag >= 100:
                self.ShowHelp(8)
                self.DoSample((tag - 100) // 10, (tag - 100) % 10)
            else:
                idx = tag // 10
                act = tag % 10
                self.ShowHelp(idx)
                if 1 <= idx <= 4:
                    # 注意: 内置演示里 Tag 个位的含义是 0 设计 / 1 预览 / 2 打印
                    if act == 0:
                        self.DoTpl(idx, ACT_DESIGN)
                    elif act == 1:
                        self.DoTpl(idx, ACT_PREVIEW)
                    elif act == 2:
                        self.DoTpl(idx, ACT_PRINT)
                elif idx == 5:
                    if act == 0:
                        self.DoSavePrepared()
                    else:
                        self.DoLoadPrepared()
                elif idx == 6:
                    self.DoExport(act)
                elif idx == 7:
                    # 在资源管理器中打开模板目录
                    Application.ShellExecute(0, 'open', self.FTplDir, None, None, SW_SHOWNORMAL)
        except Exception as e:
            # 任何异常都写进日志并弹框, 不让程序崩溃
            self.Log('错误 ' + type(e).__name__ + ': ' + str(e))
            Application.MessageBox('运行出错:\n' + type(e).__name__ + '\n' + str(e),
                                   '错误', MB_OK | MB_ICONERROR)

    # ------------------------------------------------------------------
    # OnGetValue: 演示3 的报表变量
    #
    # 报表里写 [ReportTitle] / [Company] 等未定义的变量时, RM 会回调这里取值.
    # ParValue 对应 Delphi 的 "var ParValue: Variant", 在 Python 里是一个容器对象, 要通过 .Value 回写.
    # 只有演示3 才挂这个回调, 原因见文件开头的说明和 NewReport.
    # ------------------------------------------------------------------
    def ReportGetValue(self, ParName, ParValue):
        name = ParName.lower()                            # 变量名不区分大小写
        if name == 'reporttitle':
            ParValue.Value = REPORT_TITLES.get(self.FCurIdx, 'ReportMachine 演示')
        elif name == 'company':
            ParValue.Value = '演示科技有限公司'
        elif name == 'printuser':
            ParValue.Value = os.environ.get('USERNAME', '')   # 当前 Windows 用户名
        elif name == 'printtime':
            ParValue.Value = time.strftime('%Y-%m-%d %H:%M:%S')
        elif name == 'filterinfo':
            if self.FCust.Filtered:
                ParValue.Value = '城市 = ' + self.cbCity.Text
            else:
                ParValue.Value = '全部城市'
        elif name == 'reccount':
            ParValue.Value = self.FCust.RecordCount
        elif name == 'globalnote':
            # Delphi 版把它放在全局变量 RMVariables 里; glcl 没有导出 RMVariables, 改在这里提供
            ParValue.Value = '来自 RMVariables 的全局变量'
