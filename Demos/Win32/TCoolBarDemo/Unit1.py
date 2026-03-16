import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ImageList1 = ImageList(self)
        self.ToolBar1 = ToolBar(self)
        self.CoolBar1 = CoolBar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # 使用Bands属性添加CoolBand，CoolBar其上还可以放置ToolBar