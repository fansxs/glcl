import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.TabSet1 = TabSet(self)
        self.Notebook1 = Notebook(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Notebook1.OnPageChanged = self.Notebook1PageChanged
        self.TabSet1.OnClick = self.TabSet1Click

    def TabSet1Click(self, Sender):
         # 此控件需要代码手动控制控件的显示使用，更推荐使用TPageControl
        self.Notebook1.PageIndex = self.TabSet1.TabIndex
        self.Caption = str(self.Notebook1.PageIndex)

    def Notebook1PageChanged(self, Sender):
        print('changed')