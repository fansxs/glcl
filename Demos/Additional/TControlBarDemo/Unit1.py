import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.CheckBox1 = CheckBox(self)
        self.Label1 = Label(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建控制条
        self.control_bar = ControlBar(self)
        self.control_bar.Parent = self  # 设置父控件
        self.control_bar.Align = alTop  # 顶部对齐
        self.control_bar.Height = 50  # 高度

        # 创建按钮 1
        self.btn1 = Button(self.control_bar)
        self.btn1.Parent = self.control_bar  # 设置父控件
        self.btn1.Caption = 'Button 1'  # 设置标题
        self.btn1.Left = 10
        self.btn1.Top = 10
        self.btn1.OnClick = self.btn1_click  # 绑定点击事件

        # 创建按钮 2
        self.btn2 = Button(self.control_bar)
        self.btn2.Parent = self.control_bar  # 设置父控件
        self.btn2.Caption = 'Button 2'  # 设置标题
        self.btn2.Left = 150
        self.btn2.Top = 10
        self.btn2.OnClick = self.btn2_click  # 绑定点击事件

    def btn1_click(self, Sender):
        ShowMessage('Button 1 clicked!')  # 显示消息框

    def btn2_click(self, Sender):
        ShowMessage('Button 2 clicked!')  # 显示消息框