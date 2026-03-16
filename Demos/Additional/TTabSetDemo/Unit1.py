import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Notebook1 = Notebook(self)
        self.Button1 = Button(self)
        self.TabSet1 = TabSet(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        self.TabSet1.OnClick = self.TabSet1Click

    def TabSet1Click(self, Sender):
        # TabSet通常和Notebook搭配一起使用，Notebook为了向后兼容提供的，
        # 它是属于比较古老的控件，如今应该用PageControl
        self.Notebook1.PageIndex = self.TabSet1.TabIndex

    def Button1Click(self, Sender):
        # 设置显示风格
        self.TabSet1.Style = tsModernTabs