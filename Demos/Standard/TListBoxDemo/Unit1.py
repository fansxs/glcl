import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ListBox1 = ListBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ListBox1.OnClick = self.ListBox1Click

        # 创建一个 TListBox 控件
        self.list_box = ListBox(self)
        self.list_box.Parent = self  # 设置父控件为当前窗口
        self.list_box.Left = 300
        self.list_box.Top = 10

        # 向列表框中添加一些项
        self.list_box.Items.Add('项 1')
        self.list_box.Items.Add('项 2')
        self.list_box.Items.Add('项 3')

        # 处理列表框的选中项改变事件
        self.list_box.OnClick = self.list_box_click

    # 列表框点击事件处理函数
    def list_box_click(self, Sender):
        # 获取当前选中的项
        selected_item = self.list_box.Items[self.list_box.ItemIndex]
        # 弹出消息框显示选中的项
        ShowMessage(f'选中的项: {selected_item}')


    def ListBox1Click(self, Sender):
        text = self.ListBox1.Items[self.ListBox1.ItemIndex]
        ShowMessage(text)