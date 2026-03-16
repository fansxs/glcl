import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Shape1 = Shape(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建一个 TShape 对象
        self.shape = Shape(self)
        # 设置形状的位置和大小
        self.shape.Left = 50      # 距离窗体左边的距离
        self.shape.Top = 50       # 距离窗体顶部的距离
        self.shape.Width = 100     # 形状的宽度
        self.shape.Height = 100    # 形状的高度
        self.shape.Brush.Color = clBlue  # 设置填充颜色为蓝色
        self.shape.Pen.Color = clBlack   # 设置边框颜色为黑色
        self.shape.Pen.Width = 2          # 设置边框宽度

        # 将形状添加到窗体中
        self.shape.Parent = self
