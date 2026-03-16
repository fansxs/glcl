import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.GridPanel1 = GridPanel(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 设置列宽百分比
        self.GridPanel1.ColumnCollection[0].Value = 25
        self.GridPanel1.ColumnCollection[1].Value = 30
        self.GridPanel1.ColumnCollection[2].Value = 45

        # 设置行宽百分比
        self.GridPanel1.RowCollection[0].Value = 25
        self.GridPanel1.RowCollection[1].Value = 25
        self.GridPanel1.RowCollection[2].Value = 25
        self.GridPanel1.RowCollection[3].Value = 25

        # 循环创建12个Button
        for i in range(12):
            btn = Button(self)
            btn.Name = "btn" + str(i)
            btn.Parent = self.GridPanel1    # 设置父控件为GridPanel1
            btn.Caption = "aaa" +str(i)
            btn.Align = alClient            # 对齐方式填充客户区域

        # 下面两行分别是列和行的合并，可以分别取消注释看下效果
        #self.GridPanel1.ControlCollection[0].ColumnSpan = 2
        #self.GridPanel1.ControlCollection[0].RowSpan = 2


