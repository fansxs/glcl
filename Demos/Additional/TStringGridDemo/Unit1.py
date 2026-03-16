import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.StringGrid1 = StringGrid(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TStringGrid 控件
        self.string_grid = StringGrid(self)
        self.string_grid.Parent = self  # 设置父控件
        self.string_grid.Left = 20  # 设置控件的左侧位置
        self.string_grid.Top = 20  # 设置控件的顶部位置
        self.string_grid.Width = 360  # 设置控件宽度
        self.string_grid.Height = 200  # 设置控件高度

        # 设置 TStringGrid 的行列数
        self.string_grid.RowCount = 5  # 行数
        self.string_grid.ColCount = 3  # 列数

        # 设置列标题
        self.string_grid.SetCell(0, 0, "姓名")  # 第一列标题
        self.string_grid.SetCell(1, 0, "年龄")  # 第二列标题
        self.string_grid.SetCell(2, 0, "城市")  # 第三列标题

        # 添加一些示例数据
        self.string_grid.SetCell(0, 1, "Alice")  # 第一行第一列
        self.string_grid.SetCell(1, 1, "30")     # 第一行第二列
        self.string_grid.SetCell(2, 1, "北京")   # 第一行第三列

        self.string_grid.SetCell(0, 2, "Bob")    # 第二行第一列
        self.string_grid.SetCell(1, 2, "25")     # 第二行第二列
        self.string_grid.SetCell(2, 2, "上海")   # 第二行第三列

        # 创建按钮用于显示所选单元格的值
        self.show_button = Button(self)
        self.show_button.Parent = self  # 设置父控件
        self.show_button.Caption = "显示选中单元格"  # 设置按钮文本
        self.show_button.Left = 20  # 设置按钮的左侧位置
        self.show_button.Top = 230  # 设置按钮的顶部位置
        self.show_button.Width = 150  # 设置按钮的宽度
        self.show_button.OnClick = self.on_show_button_click  # 设置点击事件处理函数

    def on_show_button_click(self, Sender):
        # 获取选中的单元格的值
        row = self.string_grid.Row  # 获取当前选中的行
        col = self.string_grid.Col  # 获取当前选中的列
        cell_value = self.string_grid.GetCell(col, row)  # 获取单元格的值

        # 弹出消息框显示选中单元格的值
        ShowMessage(f"选中单元格的值: {cell_value}")  # 弹出消息框

    def Button1Click(self, Sender):
        # 设置 TStringGrid 的行列数
        self.StringGrid1.RowCount = 5  # 行数
        self.StringGrid1.ColCount = 3  # 列数

        # 设置列标题
        self.StringGrid1.SetCell(0, 0, "姓名")  # 第一列标题
        self.StringGrid1.SetCell(1, 0, "年龄")  # 第二列标题
        self.StringGrid1.SetCell(2, 0, "城市")  # 第三列标题

        # 添加一些示例数据
        self.StringGrid1.SetCell(0, 1, "Alice")  # 第一行第一列
        self.StringGrid1.SetCell(1, 1, "30")     # 第一行第二列
        self.StringGrid1.SetCell(2, 1, "北京")   # 第一行第三列

        self.StringGrid1.SetCell(0, 2, "Bob")    # 第二行第一列
        self.StringGrid1.SetCell(1, 2, "25")     # 第二行第二列
        self.StringGrid1.SetCell(2, 2, "上海")   # 第二行第三列

        # 获取选中的单元格的值
        row = self.StringGrid1.Row  # 获取当前选中的行
        col = self.StringGrid1.Col  # 获取当前选中的列
        cell_value = self.StringGrid1.GetCell(col, row)  # 获取单元格的值

        # 弹出消息框显示选中单元格的值
        ShowMessage(f"选中单元格的值: {cell_value}")  # 弹出消息框