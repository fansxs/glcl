import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Label2 = Label(self)
        self.Bevel1 = Bevel(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建 TBevel 对象
        self.bevel = Bevel(self)
        self.bevel.Parent = self  # 设置 TBevel 的父控件
        # 设置 TBevel 的位置和大小
        self.bevel.Left = 50      # 距离窗体左边50个单位
        self.bevel.Top = 50       # 距离窗体顶部50个单位
        self.bevel.Width = 300    # 宽度为300个单位
        self.bevel.Height = 100    # 高度为100个单位

        # 添加文本说明
        self.label = Label(self)
        self.label.Parent = self  # 设置 TLabel 的父控件
        self.label.Left = 60
        self.label.Top = 80
        self.label.Caption = "这是一个 TBevel 示例"  # 设置标签内容

