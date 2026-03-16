import os
from glcl import *
from Unit2 import *

# 定义 Form1 类，继承自 Form 类。
class Form1(Form):

    # 构造函数，初始化窗体和控件。
    def __init__(self, owner):
        # 创建一个 Button 控件，并将其添加到当前窗体。
        self.Button1 = Button(self)
        # 创建一个 MainMenu 控件，并将其添加到当前窗体。
        self.MainMenu1 = MainMenu(self)
        # 加载窗体属性，从指定的文件路径加载设置。
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # 设置 MenuItem10 的点击事件处理函数。
        self.MenuItem10.OnClick = self.MenuItem10Click
        # 设置 Button1 的点击事件处理函数。
        self.Button1.OnClick = self.Button1Click

    # Button1 的点击事件处理函数，创建并显示 Form2 实例。
    def Button1Click(self, Sender):
        frm2 = Form2(self)
        frm2.Show()

    # MenuItem10 的点击事件处理函数，显示消息框。
    def MenuItem10Click(self, Sender):
        ShowMessage('控件方式创建菜单')
