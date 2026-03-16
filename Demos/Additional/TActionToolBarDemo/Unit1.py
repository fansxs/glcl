import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ActionToolBar1 = ActionToolBar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # ActionToolBar需要结合ActionManager使用，ActionManager等待添加
