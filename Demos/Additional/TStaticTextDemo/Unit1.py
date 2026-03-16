import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.StaticText1.OnDblClick = self.StaticText1DblClick

        # 创建 TStaticText 对象
        self.static_text = StaticText(self)
        self.static_text.Parent = self  # 设置父控件
        # 设置静态文本的位置和大小
        self.static_text.Left = 50      # 距离左侧50个像素
        self.static_text.Top = 50       # 距离顶部50个像素
        self.static_text.Width = 300     # 宽度300个像素
        self.static_text.Height = 50      # 高度50个像素
        # 设置静态文本的内容
        self.static_text.Caption = "欢迎使用 TStaticText 控件！"

    def StaticText1DblClick(self, Sender):
        ShowMessage('OnDblClick')