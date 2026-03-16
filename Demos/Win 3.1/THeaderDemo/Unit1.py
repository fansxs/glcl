import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Header1 = Header(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建一个 THeader 控件
        self.header = Header(self)
        self.header.Align = alTop  # 设置为顶部对齐
        self.header.Height = 50  # 设置高度
        self.header.Parent = self

        # 添加列到 THeader
        self.header.Sections.Add('列 1')
        self.header.Sections.Add('列 2')
        self.header.Sections.Add('列 3')