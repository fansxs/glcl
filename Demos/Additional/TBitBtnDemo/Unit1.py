import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.BitBtn1 = BitBtn(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.BitBtn1.OnClick = self.BitBtn1Click

        # 创建一个TBitBtn按钮
        self.bit_btn = BitBtn(self)
        self.bit_btn.Parent = self  # 将按钮设置为窗体的子控件
        self.bit_btn.Left = 50  # 按钮距离左侧的距离
        self.bit_btn.Top = 50  # 按钮距离顶部的距离
        self.bit_btn.Width = 100  # 按钮宽度
        self.bit_btn.Height = 30  # 按钮高度
        self.bit_btn.Caption = "Click Me"  # 按钮显示的文本
        self.bit_btn.OnClick = self.on_bit_btn_click  # 绑定点击事件

    def on_bit_btn_click(self, Sender):
        # 点击按钮时执行的操作
        ShowMessage("Button Clicked!")  # 弹出消息框提示按钮被点击

    def BitBtn1Click(self, Sender):
        ShowMessage(self.Name)