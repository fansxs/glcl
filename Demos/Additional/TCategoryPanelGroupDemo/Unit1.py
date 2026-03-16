import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button4 = Button(self)
        self.Button3 = Button(self)
        self.Button2 = Button(self)
        self.Button1 = Button(self)
        self.CategoryPanelGroup1 = CategoryPanelGroup(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button4.OnClick = self.Button4Click
        self.Button3.OnClick = self.Button3Click
        self.Button2.OnClick = self.Button2Click
        self.Button1.OnClick = self.Button1Click


    def Button1Click(self, Sender):
        # 折叠所有面板
        self.CategoryPanelGroup1.CollapseAll()

    def Button2Click(self, Sender):
        # 展开所有面板
        self.CategoryPanelGroup1.ExpandAll()

    def Button3Click(self, Sender):
        # 不显示 第二个面板
        self.CategoryPanelGroup1.Controls[1].Visible = False

    def Button4Click(self, Sender):
        # 显示 第二个面板
        self.CategoryPanelGroup1.Controls[1].Visible = True