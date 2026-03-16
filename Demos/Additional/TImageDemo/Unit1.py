import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Image2 = Image(self)
        self.Image1 = Image(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

         # 创建一个 TImage 组件
        self.image = Image(self)
        self.image.Parent = self  # 设置 TImage 父控件
        self.image.Width = 300  # 设置 TImage 宽度
        self.image.Height = 200  # 设置 TImage 高度
        self.image.Left = 10  # 设置 TImage 左边距
        self.image.Top = 10  # 设置 TImage 顶边距
        #self.image.Align = alClient  # 设置 TImage 填充整个窗体
        self.image.Stretch = True  # 设置图像拉伸以适应控件大小

        # 加载图像文件
        if os.path.exists('c:\\188888.jpg'):  # 替换为你自己的图像文件路径
            self.image.Picture.LoadFromFile("c:\\188888.jpg")  # 从文件加载图像

        # gif动态图加载显示
        self.Image2.Picture.LoadFromFile(os.path.join(os.path.dirname(os.path.abspath(__file__)), '1.gif'))
        self.Image2.Picture.Graphic.Animate = True
        self.Image2.Picture.Graphic.AnimationSpeed = 500