import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Animate1 = Animate(self)
        self.ShellResources1 = ShellResources(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        # TShellResources配合TAnimate控件使用

    def Button1Click(self, Sender):
        # 可以设置Animate显示何种系统操作动画
        self.Animate1.CommonAVI = aviEmptyRecycle
        # 需要设置Active属性为True
        self.Animate1.Active = True