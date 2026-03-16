import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Label1 = Label(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建一个 TLabel 实例
        self.label = Label(self)
        # 设置 TLabel 的属性
        self.label.Parent = self # 切记要写此句
        self.label.Caption = '代码方式创建TLabel'
        self.label.Left = 50   # 设置 TLabel 的左边距
        self.label.Top = 50    # 设置 TLabel 的上边距
        self.label.Width = 250 # 设置 TLabel 的宽度
        self.label.Height = 30 # 设置 TLabel 的高度
        self.label.Font.Size = 15  # 设置字体大小
        self.label.Font.Name = 'Arial'  # 设置字体名称
        self.label.Font.Color = clBlack # 设置字体颜色为黑色
