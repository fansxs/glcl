import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ImageList1 = ImageList(self)
        self.ToolBar1 = ToolBar(self)
        self.PageScroller1 = PageScroller(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # 在PageScroller上面放置一个ToolBar控件，并可以设置AutoScroll为True
        self.PageScroller1.AutoScroll = True
