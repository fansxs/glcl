import os
from glcl import *
import webbrowser

class Form1(Form):

    def __init__(self, owner):
        self.LinkLabel1 = LinkLabel(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.LinkLabel1.OnLinkClick = self.LinkLabel1LinkClick
        self.LinkLabel1.Caption = '<a href="https://forum.glsite.com/">论坛</a>'

        # 创建链接标签控件
        self.link_label = LinkLabel(self)  # 创建 TLinkLabel 控件
        self.link_label.Parent = self  # 设置父控件
        self.link_label.Caption = '<a>Click here</a> to glsite.com!'  # 设置链接文本
        self.link_label.Left = 50  # 设置链接标签的左边距
        self.link_label.Top = 80  # 设置链接标签的顶部边距
        self.link_label.Font.Size = 12  # 设置字体大小
        self.link_label.Font.Color = clBlue  # 设置字体颜色为蓝色
        self.link_label.OnClick = self.link_label_click  # 绑定点击事件

    def link_label_click(self, Sender):
        # 点击链接标签时调用的事件处理程序
        webbrowser.open('http://www.glsite.com')

    def LinkLabel1LinkClick(self, Sender, Link, LinkType):
        webbrowser.open(Link)
        ShowMessage(Link)