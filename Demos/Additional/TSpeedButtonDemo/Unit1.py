import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.SpeedButton1 = SpeedButton(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.SpeedButton1.OnClick = self.SpeedButton1Click

        # 创建一个TSpeedButton按钮
        self.speed_button = SpeedButton(self)
        self.speed_button.Parent = self  # 将按钮设置为窗体的子控件
        self.speed_button.Left = 50  # 按钮距离左侧的距离
        self.speed_button.Top = 50  # 按钮距离顶部的距离
        self.speed_button.Width = 100  # 按钮宽度
        self.speed_button.Height = 30  # 按钮高度
        self.speed_button.Caption = 'test'  # 按钮标题
        self.speed_button.OnClick = self.on_speed_button_click  # 绑定点击事件

    def on_speed_button_click(self, Sender):
        # 点击按钮时执行的操作
        ShowMessage("Speed Button Clicked!")  # 弹出消息框提示按钮被点击

    def SpeedButton1Click(self, Sender):
        ShowMessage(self.SpeedButton1.Name)