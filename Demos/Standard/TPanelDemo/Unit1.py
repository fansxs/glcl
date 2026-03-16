import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Panel1 = Panel(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TPanel 控件
        self.panel = Panel(self)  # 创建面板并设置其拥有者为当前窗口
        self.panel.Parent = self  # 设置面板的父控件
        self.panel.Caption = 'This is a TPanel'  # 设置面板标题
        self.panel.Align = alTop  # 设置面板对齐方式为顶部
        self.panel.Height = 100  # 设置面板高度
        self.panel.Color = clBtnFace  # 设置面板背景颜色

        # 创建一个 TButton 控件
        self.button = Button(self.panel)  # 创建按钮并设置其拥有者为当前窗口
        self.button.Parent = self.panel  # 设置按钮的父控件
        self.button.Caption = 'Show Message'  # 设置按钮标题
        self.button.Width = 150
        self.button.Left = 20  # 设置按钮左边距
        self.button.Top = 20  # 设置按钮上边距
        self.button.OnClick = self.on_button_click  # 绑定按钮点击事件

    def on_button_click(self, Sender):
        # 处理按钮点击事件
        ShowMessage('Hello from TPanel!')  # 在面板上显示消息

    def Button1Click(self, Sender):
        ShowMessage(self.Panel1.Caption)