# -*- coding: utf-8 -*-
"""
Unit1.py 提醒：此工程会在后续版本升级过程修复组件Bug后再次更新

窗体上有两个 glcl 内置的表格组件:
    ParamGrid1  (P4DParamGrid)  参数表: 每行一个参数 [参数名称 | 值 | 说明]
    ListGrid1   (P4DListGrid)   列表表: 每行一条记录, 每列一个字段

两个表格的数据都保存在同一个 ini 文件 (TestParamGrid.ini) 里:
    [test]      ParamGrid1 的数据   (Ident = 'test')
    [userlist]  ListGrid1  的数据   (Ident = 'userlist')

窗体的布局保存在 Unit1.sfm(文本) / Unit1.pydfm(二进制) 里, 由 LoadProps() 读取;
事件处理函数在本文件里用代码绑定 (Delphi 里是在 dfm 里写 OnClick = xxx)。
"""
import os
from glcl import *

# 行的增删要用到 ListGridRowOps, 见下面 USE_SAFE_ROW_OPS 的说明
import ListGridRowOps

# ----------------------------------------------------------------------------
# 常量
# ----------------------------------------------------------------------------

# "增 / 删 / 改 / 查" 演示里使用的额外参数的标识 (对应 Delphi 的 cExtraParamIdent)
cExtraParamIdent = 'testExtra'

# ini 文件名。
INI_FILE_NAME = 'TestParamGrid.ini'

# ListGrid1 在 ini 里使用的节名 (即 ListGrid1.Ident)
LIST_IDENT = 'userlist'

# ListGrid1 的列定义: (列标识 ident, 表头文字, 数据类型, 初始列宽)
# 数据类型: 'String' / 'Integer' / 'Boolean'
# 之所以集中写成一张表: 建列(AddColumn)和后面"安全增删行"(ListGridRowOps)都要用到
# 列标识和类型, 写在一处可以保证两边始终一致。
LIST_COLUMNS = [
    ('UserName', '用户', 'String', 50),
    ('Age', '年龄', 'Integer', 50),
    ('Vip', 'VIP', 'Boolean', 50),
    ('Other', '其他数据', 'Integer', 50),   # 这一列是下拉框, 保存的是选中项的序号
]

# ----------------------------------------------------------------------------
# [重要] USE_SAFE_ROW_OPS: 是否用 Python 端的"安全行操作"代替 ListGrid1.AddRow()/DeleteRow()
# ----------------------------------------------------------------------------
# 现象: 当前 glcl 内置的 P4DListGrid.AddRow()/DeleteRow() 在 "增 -> 删 -> 再增" 时会报
#       Access violation (Read of address 0), 控制台提示 "AddRow" called with invalid arguments。
# 原因: 删除行时被删行的单元格属性对象被释放但指针没清, 再次增行时又被访问到
#       (详见 ListGridRowOps.py 的说明, 以及 delphi_patch/ 里的 Delphi 端修复)。
# 做法: 默认 True —— 增/删/清空行改走 ListGridRowOps (存盘 -> 改 ini -> LoadListGrid 整表重建),
#       完全不调用有问题的原生方法。
#       如果你已经按 delphi_patch/ 修复并重新编译了 glcl.pyd, 可以改成 False 直接用原生方法。
USE_SAFE_ROW_OPS = True


class Form1(Form):
    """主窗体"""

    def __init__(self, owner):
        self.Label1 = Label(self)              # 标题 "P4D CRUD Demo"
        self.Label2 = Label(self)              # 副标题 "增删改查全部通过方法调用完成"
        self.Label3 = Label(self)              # ParamGrid1 上方的说明
        self.Label4 = Label(self)              # ListGrid1 上方的说明

        self.ParamGrid1 = P4DParamGrid(self)   # 参数表 (glcl 内置组件)
        self.ListGrid1 = P4DListGrid(self)     # 列表表 (glcl 内置组件)

        self.btnParamAdd = Button(self)        # 参数表: 增
        self.btnParamDelete = Button(self)     # 参数表: 删
        self.btnParamModify = Button(self)     # 参数表: 改
        self.btnParamQuery = Button(self)      # 参数表: 查
        self.btnRowAdd = Button(self)          # 列表表: 增
        self.btnRowDelete = Button(self)       # 列表表: 删
        self.btnRowModify = Button(self)       # 列表表: 改
        self.btnRowQuery = Button(self)        # 列表表: 查
        self.Button1 = Button(self)            # "取值" (演示读取 / 修改单元格外观)
        self.Button3 = Button(self)            # "saveparams" (保存两个表格)

        self.Memo1 = Memo(self)                # 日志输出框

        # ------------------------------------------------------------------
        # 第 2 步: 从 Unit1.pydfm 读取窗体布局
        # ------------------------------------------------------------------
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # ------------------------------------------------------------------
        # 第 3 步: 绑定按钮事件 (对应 dfm 里的 OnClick = xxx)
        # ------------------------------------------------------------------
        self.btnParamAdd.OnClick = self.btnParamAddClick
        self.btnParamDelete.OnClick = self.btnParamDeleteClick
        self.btnParamModify.OnClick = self.btnParamModifyClick
        self.btnParamQuery.OnClick = self.btnParamQueryClick
        self.btnRowAdd.OnClick = self.btnRowAddClick
        self.btnRowDelete.OnClick = self.btnRowDeleteClick
        self.btnRowModify.OnClick = self.btnRowModifyClick
        self.btnRowQuery.OnClick = self.btnRowQueryClick
        self.Button1.OnClick = self.Button1Click
        self.Button3.OnClick = self.Button3Click

        # ------------------------------------------------------------------
        # 第 4 步: 相当于 Delphi 的 FormCreate (Python 里没有 OnCreate, 在构造函数末尾直接调用)
        # ------------------------------------------------------------------
        self.FormCreate(self)

    # ======================================================================
    # FormCreate: 定义参数 / 列, 并把 ini 里的数据装载进两个表格
    # ======================================================================
    def FormCreate(self, Sender):
        self.Memo1.Lines.Clear()

        # 把表格内部的提示消息 ("选择格子" / "左键点击" ...) 显示到 Memo, 见 HookMsg
        self.HookMsg(self.ParamGrid1)
        self.HookMsg(self.ListGrid1)

        # ini 文件完整路径, 两个表格共用这一个文件
        self.IniPath = os.path.join(os.path.dirname(os.path.abspath(__file__)), INI_FILE_NAME)

        # ---------------------------------------------------------------
        # ParamGrid1: 键值参数表
        # ---------------------------------------------------------------
        self.ParamGrid1.IniFileName = self.IniPath   # 数据保存在哪个 ini 文件
        self.ParamGrid1.Ident = 'test'               # 使用 ini 里的 [test] 这一节

        # AddParam(参数标识, 显示名称, 说明, 数据类型, 默认值)
        # 数据类型: String / Integer / Boolean / Date / Time / DateTime
        # 默认值一律用文本传入, 按数据类型解析; ini 里没有这个参数时就用默认值。
        self.ParamGrid1.AddParam('test01', '开关', '布尔测试', 'Boolean', '1')            # 显示为复选框
        self.ParamGrid1.AddParam('test02', '日期', '日期测试', 'Date', '1982-01-20')
        self.ParamGrid1.AddParam('test03', '日期时间', '日期时间测试', 'DateTime', '1982-03-20 08:00:01')
        self.ParamGrid1.AddParam('test04', '时间', '时间测试', 'Time', '08:00:01')

        self.ParamGrid1.AddParam('test05', '参数05', '整数测试', 'Integer', '10')
        self.ParamGrid1.SetParamAlignment('test05', 'Center')   # 对齐: Left / Right / Center
        self.ParamGrid1.SetParamTextColor('test05', clGreen)    # 文字颜色 (Delphi 版的 ccGreen)

        # 下拉框参数: 保存的是选中项的序号 (Integer), 默认值 '0' 表示默认选第 0 项
        self.ParamGrid1.AddParam('test06', '选择', '下拉选择', 'Integer', '0')
        self.ParamGrid1.SetParamAsCombo('test06')
        self.ParamGrid1.AddParamComboItem('test06', '0--关闭')
        self.ParamGrid1.AddParamComboItem('test06', '1--打开')

        # 所有参数定义完之后, 一次性装载 (从 ini 读值, 生成表格行)
        self.ParamGrid1.LoadParamGrid()

        # ---------------------------------------------------------------
        # ListGrid1: 行列数据表
        # ---------------------------------------------------------------
        self.ListGrid1.IniFileName = self.IniPath    # 与参数表共用同一个 ini 文件
        self.ListGrid1.Ident = LIST_IDENT            # 使用 ini 里的 [userlist] 这一节

        # AddColumn(列标识, 表头文字, 数据类型, 初始列宽)
        # 数据类型: String / Integer / Boolean (Boolean 显示为复选框)
        for ident, caption, kind, width in LIST_COLUMNS:
            self.ListGrid1.AddColumn(ident, caption, kind, width)

        # 'Other' 列设置成下拉框, 候选项如下 (保存的是选中项的序号)
        self.ListGrid1.SetColumnAsCombo('Other')
        self.ListGrid1.AddColumnComboItem('Other', '001')
        self.ListGrid1.AddColumnComboItem('Other', '002')
        self.ListGrid1.AddColumnComboItem('Other', '003')

        # 所有列定义完之后, 一次性装载 (行数、各行的值、列宽都来自 ini)
        self.ListGrid1.LoadListGrid()

    # ======================================================================
    # "取值" 按钮: 演示读取下拉框的值, 以及运行时修改单元格的文字颜色 / 对齐
    # ======================================================================
    def Button1Click(self, Sender):
        # 读取参数表下拉框 test06 当前选中项的序号
        i = self.ParamGrid1.GetParamInt('test06')
        self.DispMsg('choice test06:' + str(i))

        # 把 test02 那个参数的值单元格改成红色字:
        #   先改颜色属性, 再 Invalidate 通知表格重绘这个格子
        self.ParamGrid1.SetParamCellTextColor('test02', clRed)
        self.ParamGrid1.InvalidateParamCell('test02')

        # 列表表: 第 0 行的 Age 单元格改成红色 + 居中显示
        self.ListGrid1.SetCellTextColor('Age', 0, clRed)
        self.ListGrid1.SetCellAlignment('Age', 0, 'Center')
        self.ListGrid1.InvalidateDataCell('Age', 0)

        # 读取第 2 行的 Age (行号 0 基; 要求列表里至少有 3 行, 否则会越界报错)
        i = self.ListGrid1.GetCellInt('Age', 2)
        self.DispMsg('row 2 Age:' + str(i))

    # ======================================================================
    # "saveparams" 按钮: 把两个表格里当前的内容写回 ini
    # ======================================================================
    def Button3Click(self, Sender):
        self.ParamGrid1.SaveParamGrid()
        self.ListGrid1.SaveListGrid()
        self.DispMsg('All params saved!')

    # ======================================================================
    # ParamGrid1: 增 / 删 / 改 / 查
    # ======================================================================
    def btnParamAddClick(self, Sender):
        """增: 增加一个参数 testExtra (已存在则跳过)"""
        if self.ParamGrid1.ParamExists(cExtraParamIdent):
            self.DispMsg('[Param 增] ' + cExtraParamIdent + ' already exists, skipped.')
            return

        # 先定义参数, 再重新装载一次表格, 新参数才会显示出来
        self.ParamGrid1.AddParam(cExtraParamIdent, '额外参数', '增删改查演示用', 'String', 'hello')
        self.ParamGrid1.LoadParamGrid()
        self.DispMsg('[Param 增] added ' + cExtraParamIdent + ' = ' +
                     self.ParamGrid1.GetParamString(cExtraParamIdent))

    def btnParamDeleteClick(self, Sender):
        """删: 删除参数 testExtra (参数定义 + ini 里的值 + 表格里的行)"""
        if not self.ParamGrid1.ParamExists(cExtraParamIdent):
            self.DispMsg('[Param 删] ' + cExtraParamIdent + ' does not exist, add it first.')
            return

        self.ParamGrid1.DeleteParam(cExtraParamIdent)
        self.DispMsg('[Param 删] deleted ' + cExtraParamIdent)

    def btnParamModifyClick(self, Sender):
        """改: 把整数参数 test05 加 1"""
        NewValue = self.ParamGrid1.GetParamInt('test05') + 1
        self.ParamGrid1.SetParamInt('test05', NewValue)
        self.DispMsg('[Param 改] test05 -> ' + str(NewValue))

    def btnParamQueryClick(self, Sender):
        """查: 读取并显示 test05 的值"""
        self.DispMsg('[Param 查] test05 = ' + str(self.ParamGrid1.GetParamInt('test05')))

    # ======================================================================
    # ListGrid1: 增 / 删 / 改 / 查      (行号一律是 0 基的"数据行号", 不含表头)
    # ======================================================================
    def btnRowAddClick(self, Sender):
        """增: 在末尾加一行, 并给新行填上初始值"""
        NewRow = self.AddListRow()      # 返回新行的 0 基行号
        self.ListGrid1.SetCellString('UserName', NewRow, 'NewUser' + str(NewRow))
        self.ListGrid1.SetCellInt('Age', NewRow, 18)
        self.ListGrid1.SetCellBool('Vip', NewRow, False)
        self.DispMsg('[Row 增] added row ' + str(NewRow) + ' UserName=' +
                     self.ListGrid1.GetCellString('UserName', NewRow))

    def btnRowDeleteClick(self, Sender):
        """删: 删除最后一行"""
        if self.ListGrid1.GetRowCount() <= 0:
            self.DispMsg('[Row 删] no rows to delete.')
            return

        LastRow = self.ListGrid1.GetRowCount() - 1
        self.DispMsg('[Row 删] deleting row ' + str(LastRow) + ' UserName=' +
                     self.ListGrid1.GetCellString('UserName', LastRow))
        self.DeleteListRow(LastRow)

    def btnRowModifyClick(self, Sender):
        """改: 把第 0 行的 Age 加 1"""
        if self.ListGrid1.GetRowCount() <= 0:
            self.DispMsg('[Row 改] no rows to modify.')
            return

        NewAge = self.ListGrid1.GetCellInt('Age', 0) + 1
        self.ListGrid1.SetCellInt('Age', 0, NewAge)
        self.DispMsg('[Row 改] row 0 Age -> ' + str(NewAge))

    def btnRowQueryClick(self, Sender):
        """查: 显示第 0 行的内容"""
        if self.ListGrid1.GetRowCount() <= 0:
            self.DispMsg('[Row 查] no rows.')
            return

        self.DispMsg('[Row 查] row 0: UserName=' + self.ListGrid1.GetCellString('UserName', 0) +
                     ' Age=' + str(self.ListGrid1.GetCellInt('Age', 0)) +
                     ' Vip=' + str(self.ListGrid1.GetCellBool('Vip', 0)))

    # ======================================================================
    # 列表表 增 / 删 / 清空 行 —— 统一入口 (见上面 USE_SAFE_ROW_OPS 的说明)
    # ======================================================================
    def AddListRow(self):
        """在列表末尾增加一行, 返回新行的 0 基行号"""
        if USE_SAFE_ROW_OPS:
            return ListGridRowOps.add_row(self.ListGrid1, self.IniPath, LIST_IDENT,
                                          self._ListColumnKinds())
        return self.ListGrid1.AddRow()

    def DeleteListRow(self, ARow):
        """删除 0 基行号为 ARow 的行"""
        if USE_SAFE_ROW_OPS:
            ListGridRowOps.delete_row(self.ListGrid1, self.IniPath, LIST_IDENT,
                                      self._ListColumnKinds(), ARow)
        else:
            self.ListGrid1.DeleteRow(ARow)

    def ClearListRows(self):
        """清空列表 (保留一个默认值行)。 本演示里没有按钮用到它, 留作需要时调用"""
        if USE_SAFE_ROW_OPS:
            ListGridRowOps.clear_rows(self.ListGrid1, self.IniPath, LIST_IDENT,
                                      self._ListColumnKinds())
        else:
            self.ListGrid1.ClearRows()

    @staticmethod
    def _ListColumnKinds():
        """从 LIST_COLUMNS 取出 ListGridRowOps 需要的 [(列标识, 数据类型), ...]"""
        return [(ident, kind) for ident, _caption, kind, _width in LIST_COLUMNS]

    # ======================================================================
    # 日志输出
    # ======================================================================
    def DispMsg(self, AMsg):
        """往 Memo 末尾追加一行日志"""
        self.Memo1.Lines.Add(AMsg)

    def OnDispMsgTing(self, AMsg):
        """表格内部消息的回调 (Delphi 版里赋给 Grid.OnMsg), 直接显示到 Memo"""
        self.DispMsg(AMsg)

    # ----------------------------------------------------------------------
    # 原 Delphi 版:  Grid.OnMsg := self.OnDispMsgTing
    # 当前 glcl 的 P4DParamGrid / P4DListGrid 没有暴露 OnMsg 属性, 所以这里:
    #   1) 先尝试直接给 OnMsg 赋值 (以后 glcl 暴露了就自动生效);
    #   2) 不支持时, 用标准的 OnSelectCell / OnMouseUp 事件输出同样的提示
    #      ('选择格子' / '左键点击'); "参数已保存"一类表格内部消息在这种方式下得不到。
    # 任何一步不可用都只是跳过, 不会抛异常。
    # ----------------------------------------------------------------------
    def HookMsg(self, Grid):
        try:
            Grid.OnMsg = self.OnDispMsgTing
            return
        except AttributeError:
            pass
        try:
            Grid.OnSelectCell = self.GridSelectCell
        except AttributeError:
            pass
        try:
            Grid.OnMouseUp = self.GridMouseUp
        except AttributeError:
            pass

    def GridSelectCell(self, Sender, ACol, ARow, CanSelect):
        """用户选中了某个单元格"""
        self.DispMsg('选择格子')

    def GridMouseUp(self, Sender, Button, Shift, X, Y):
        """鼠标在表格上抬起; 只关心左键"""
        if Button == 'mbLeft' or Button == 0:
            self.DispMsg('左键点击')
