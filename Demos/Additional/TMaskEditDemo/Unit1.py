import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.MaskEdit1 = MaskEdit(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TMaskEdit 控件
        self.mask_edit = MaskEdit(self)
        self.mask_edit.Parent = self  # 设置父控件
        self.mask_edit.Left = 50  # 设置控件的左侧位置
        self.mask_edit.Top = 50  # 设置控件的顶部位置
        self.mask_edit.EditMask = "!999-9999;1;_ "  # 设置输入掩码
        self.mask_edit.Width = 100  # 设置控件宽度

        # 创建按钮用于显示输入的值
        self.show_button = Button(self)
        self.show_button.Parent = self  # 设置父控件
        self.show_button.Caption = "显示输入"  # 设置按钮文本
        self.show_button.Left = 50  # 设置按钮的左侧位置
        self.show_button.Top = 100  # 设置按钮的顶部位置
        self.show_button.OnClick = self.on_show_button_click  # 设置点击事件处理函数

    def on_show_button_click(self, Sender):
        # 点击按钮时执行的操作
        user_input = self.mask_edit.Text  # 获取输入的文本
        ShowMessage(f"您输入的是: {user_input}")  # 弹出消息框显示输入内容

    def Button1Click(self, Sender):
        # 点击按钮时执行的操作
        user_input = self.MaskEdit1.Text  # 获取输入的文本
        ShowMessage(f"您输入的是: {user_input}")  # 弹出消息框显示输入内容