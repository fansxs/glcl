import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Edit1 = Edit(self) # 通过拖放控件方式生成的代码，此处只是声明变量和类型，控件实例在Unit1.pydfm中
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 在LoadProps方法后面创建控件，该控件实例并未在Unit1.pydfm中定义
        # 创建一个 Edit 控件
        self.edit = Edit(self)  # TEdit 控件的拥有者是当前的表单 (self)
        self.edit.Parent = self  # 将控件的父窗口设置为当前表单
        self.edit.Left = 20  # 设置控件左边距
        self.edit.Top = 100  # 设置控件上边距
        self.edit.Width = 250  # 设置控件宽度
        self.edit.Height = 20  # 设置控件高度
        self.edit.Text = "123456789"  # 设置控件的初始文本
        self.edit.Color = clBlack  # 设置颜色为黑色
        self.edit.Font.Color = clGreen  # 设置字体颜色为绿色
        self.edit.MaxLength = 15  # 设置最大长度为15
        self.edit.NumbersOnly = True  # 设置仅接受数字
        self.edit.PasswordChar = '*'  # 设置密码字符，字符为#0时显示字符
        self.edit.ReadOnly = False  # 设置只读


