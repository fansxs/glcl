import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.HeaderControl1 = HeaderControl(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 THeaderControl 控件用于显示标题
        self.headerControl = HeaderControl(self)
        self.headerControl.SetBounds(10, 10, 360, 30)  # 设置控件的位置和大小
        self.headerControl.Parent = self  # 将控件设置为窗体的子控件

        # 初始化列
        self.init_columns()

        # 创建按钮用于添加新列
        self.btnAddColumn = Button(self)
        self.btnAddColumn.SetBounds(10, 50, 150, 30)  # 设置按钮的位置和大小
        self.btnAddColumn.Caption = "添加列"  # 设置按钮文本
        self.btnAddColumn.OnClick = self.add_column  # 绑定点击事件
        self.btnAddColumn.Parent = self  # 将按钮设置为窗体的子控件

    # 初始化列的方法
    def init_columns(self):
        # 创建并添加第一个标题
        header_item1 = self.headerControl.Sections.Add()  # 添加新列
        header_item1.Text = "列 1"  # 设置列的标题
        header_item1.Width = 100  # 设置列的宽度

        # 创建并添加第二个标题
        header_item2 = self.headerControl.Sections.Add()  # 添加新列
        header_item2.Text = "列 2"  # 设置列的标题
        header_item2.Width = 100  # 设置列的宽度

        # 创建并添加第三个标题
        header_item3 = self.headerControl.Sections.Add()  # 添加新列
        header_item3.Text = "列 3"  # 设置列的标题
        header_item3.Width = 100  # 设置列的宽度

    # 添加新列的方法
    def add_column(self, Sender):
        # 获取当前列数量
        column_count = self.headerControl.Sections.Count
        # 创建新列
        new_column = self.headerControl.Sections.Add()
        new_column.Text = f"列 {column_count + 1}"  # 设置

    def Button1Click(self, Sender):
        # 获取当前列数量
        column_count = self.HeaderControl1.Sections.Count
        # 创建新列
        new_column = self.HeaderControl1.Sections.Add()
        new_column.Text = f"列 {column_count + 1}"  # 设置