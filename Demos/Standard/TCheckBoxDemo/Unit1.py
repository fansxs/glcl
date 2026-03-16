import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.CheckBox1 = CheckBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.CheckBox1.OnClick = self.CheckBox1Click

        # 创建一个 TCheckBox 组件
        self.check_box = CheckBox(self)
        self.check_box.Parent = self
        # 设置 TCheckBox 的位置和大小
        self.check_box.Left = 50
        self.check_box.Top = 100
        self.check_box.Width = 200
        self.check_box.Height = 30
        # 设置 TCheckBox 的文本
        self.check_box.Caption = "这是一个复选框"
        # 设置默认选中
        self.check_box.Checked = True
        # 创建一个事件处理程序，当复选框的状态改变时调用
        self.check_box.OnClick = self.check_box_click

    # 事件处理程序方法
    def check_box_click(self, Sender):
        if self.check_box.Checked:
            ShowMessage("复选框已选中")
        else:
            ShowMessage("复选框未选中")


    def CheckBox1Click(self, Sender):
        if self.CheckBox1.Checked:
            ShowMessage("复选框已选中")
        else:
            ShowMessage("复选框未选中")