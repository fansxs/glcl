import os
from glcl import *
import time

class Form1(Form):

    def __init__(self, owner):
        self.Timer1 = Timer(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Timer1.OnTimer = self.Timer1Timer
        self.Timer1.Enabled = True

        # 创建 TLabel 控件用于显示当前时间
        self.label = Label(self)
        self.label.SetBounds(50, 50, 200, 30)  # 设置标签的位置和大小
        self.label.Parent = self  # 将标签设置为窗体的子控件
        self.label.Caption = "当前时间："  # 标签初始文本

        # 创建 TTimer 控件
        self.timer = Timer(self)
        self.timer.Interval = 1000  # 设置定时器的间隔为 1000 毫秒（1 秒）
        self.timer.OnTimer = self.on_timer  # 连接定时器事件到处理函数

        self.timer.Enabled = True  # 启动定时器

    # 定义定时器触发时执行的操作
    def on_timer(self, Sender):
        timestamp = time.time()
        current_time = time.ctime(timestamp)
        #current_time = time.localtime()
        self.label.Caption = current_time  # 更新标签文本显示当前时间

    def Timer1Timer(self, Sender):
        self.Caption = str(self.Tag)
        self.Tag += 1