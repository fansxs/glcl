import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个 TButton 控件
        self.button = Button(self)  # TButton 控件的拥有者是当前的表单 (self)
        self.button.Parent = self  # 将 TButton 控件的父窗口设置为当前表单
        self.button.Left = 100  # 设置 TButton 控件的左边距
        self.button.Top = 80  # 设置 TButton 控件的上边距
        self.button.Width = 100  # 设置 TButton 控件的宽度
        self.button.Height = 40  # 设置 TButton 控件的高度
        self.button.Caption = "Click Me"  # 设置 TButton 控件的显示文本
        self.button.OnClick = self.button_click  # 绑定按钮的点击事件到自定义方法

    # 定义按钮点击事件处理方法
    def button_click(self, Sender):
        # 弹出消息框显示 "Button Clicked!" 文本
        ShowMessage("Button Clicked!")


    def Button1Click(self, Sender):
        # 弹出消息框显示标题为 "title"，内容为 "content" 的文本
        Application.MessageBox('content', 'title', MB_OK)