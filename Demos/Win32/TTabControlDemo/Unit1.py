import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Label3 = Label(self)
        self.Label2 = Label(self)
        self.Label1 = Label(self)
        self.TabControl1 = TabControl(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.TabControl1.OnChange = self.TabControl1Change

    # TabControl因为客户区是公用的，所以需要编写代码去控制组件的可见，更建议使用PageControl
    def TabControl1Change(self, Sender):
        # TabIndex属性是当前标签页下标
        if self.TabControl1.TabIndex == 0:
            self.Label1.Visible = True
            self.Label2.Visible = False
            self.Label3.Visible = False
        elif self.TabControl1.TabIndex == 1:
            self.Label1.Visible = False
            self.Label2.Visible = True
            self.Label3.Visible = False
        elif self.TabControl1.TabIndex == 2:
            self.Label1.Visible = False
            self.Label2.Visible = False
            self.Label3.Visible = True