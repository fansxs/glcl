import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.FlowPanel1 = FlowPanel(self)
        self.ScrollBox1 = ScrollBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 循环添加10个Button
        for i in range(10):
            btn = Button(self)
            btn.Name = "Flobtn" + str(i)
            # 需要将控件的父控件设置为FlowPanel
            btn.Parent = self.FlowPanel1
            btn.Caption = "aaaa" + str(i)
