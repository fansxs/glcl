import os
from glcl import *
import time

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Gauge1 = Gauge(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个TGauge实例，作为进度条
        self.gauge = Gauge(self)
        self.gauge.Parent = self        # 设置其父窗体为当前窗体
        self.gauge.Left = 50            # 设置进度条的左边位置
        self.gauge.Top = 50             # 设置进度条的顶边位置
        self.gauge.Width = 300          # 设置进度条的宽度
        self.gauge.Height = 30          # 设置进度条的高度
        self.gauge.MinValue = 0         # 进度条最小值
        self.gauge.MaxValue = 100       # 进度条最大值
        self.gauge.Progress = 0         # 进度初始值

        # 创建一个按钮，用于更新进度条
        self.button = Button(self)
        self.button.Parent = self        # 设置父控件为窗体
        self.button.Left = 150           # 设置按钮左边位置
        self.button.Top = 100            # 设置按钮顶边位置
        self.button.Caption = 'Start'    # 按钮标题
        self.button.OnClick = self.update_gauge  # 按钮点击事件

    # 按钮点击事件处理程序
    def update_gauge(self, Sender):
        # 模拟进度更新
        for i in range(self.gauge.MinValue, self.gauge.MaxValue + 1):
            self.gauge.Progress = i  # 更新进度条的值
            Application.ProcessMessages()  # 处理消息以避免界面卡死
            time.sleep(0.05)  # 模拟延迟，这里可以根据需要调整

    def Button1Click(self, Sender):
        for i in range(self.Gauge1.MinValue, self.Gauge1.MaxValue + 1):
            self.Gauge1.Progress = i  # 更新进度条的值
            Application.ProcessMessages()  # 处理消息以避免界面卡死
            time.sleep(0.05)  # 模拟延迟，这里可以根据需要调整