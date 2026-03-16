import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Animate1 = Animate(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TAnimate 控件用于显示动画
        self.animate = Animate(self)
        self.animate.SetBounds(50, 50, 300, 200)  # 设置动画控件的位置和大小
        self.animate.Parent = self  # 将动画控件设置为窗体的子控件
        self.animate.FileName = "cool.avi"  # 设置要播放的 AVI 文件
        self.animate.Visible = True  # 确保动画控件可见

        # 创建按钮用于开始和停止动画
        self.btnStart = Button(self)
        self.btnStart.SetBounds(50, 260, 100, 30)  # 设置按钮的位置和大小
        self.btnStart.Caption = "开始动画"  # 设置按钮文本
        self.btnStart.OnClick = self.start_animation  # 绑定点击事件
        self.btnStart.Parent = self  # 将按钮设置为窗体的子控件

        self.btnStop = Button(self)
        self.btnStop.SetBounds(160, 260, 100, 30)  # 设置按钮的位置和大小
        self.btnStop.Caption = "停止动画"  # 设置按钮文本
        self.btnStop.OnClick = self.stop_animation  # 绑定点击事件
        self.btnStop.Parent = self  # 将按钮设置为窗体的子控件

    # 开始动画的方法
    def start_animation(self, sender):
        self.animate.Active = True  # 设置动画为活动状态，开始播放

    # 停止动画的方法
    def stop_animation(self, sender):
        self.animate.Active = False  # 设置动画为非活动状态，停止播放

    def Button1Click(self, Sender):
        self.Animate1.Active = True