import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Label1 = Label(self)
        self.Button1 = Button(self)
        self.DockTabSet1 = DockTabSet(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        self.DockTabSet1.OnClick = self.DockTabSet1Click

    def DockTabSet1Click(self, Sender):
        self.Label1.Caption = self.DockTabSet1.Tabs[self.DockTabSet1.TabIndex]

    def Button1Click(self, Sender):
        # 可以设置显示风格属性
        self.DockTabSet1.Style = tsIDETabs