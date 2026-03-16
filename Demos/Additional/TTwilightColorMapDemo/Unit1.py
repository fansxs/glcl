import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.TwilightColorMap1 = TwilightColorMap(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # 结合TActionToolBar使用，等待完善
