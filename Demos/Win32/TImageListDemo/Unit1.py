import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.MainMenu1 = MainMenu(self)
        self.ImageList1 = ImageList(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # 许多控件都有Images属性，注意MainMenu如顶层菜单设置了ImageIndex,
        # 需要设置OwnerDraw属性为True

