import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ImageList1 = ImageList(self)
        self.CategoryButtons1 = CategoryButtons(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.CategoryButtons1.OnMouseUp = self.CategoryButtons1MouseUp

    # 鼠标抬起事件
    def CategoryButtons1MouseUp(self, Sender, Button, Shift, X, Y):
        # 需要判断弹起时X，Y位置的按钮是否为空
        if self.CategoryButtons1.GetButtonAt(X, Y, None):
            # 如不为空则调用函数执行按钮的Hint属性指定位置的程序
            Application.WinExec(self.CategoryButtons1.GetButtonAt(X, Y, None).Hint, SW_SHOWNORMAL)
