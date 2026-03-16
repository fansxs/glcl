import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ImageList1 = ImageList(self)
        self.ButtonGroup1 = ButtonGroup(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ButtonGroup1.OnMouseUp = self.ButtonGroup1MouseUp

    # 鼠标抬起事件
    def ButtonGroup1MouseUp(self, Sender, Button, Shift, X, Y):
        # 根据X, Y的获取按钮的Index
        index = self.ButtonGroup1.IndexOfButtonAt(X, Y)
        # 调用函数执行按钮的Hint属性指定的程序
        Application.WinExec(self.ButtonGroup1.Items[index].Hint, SW_SHOWNORMAL)