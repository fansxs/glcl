import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Label1 = Label(self)
        self.TrackBar1 = TrackBar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.TrackBar1.OnChange = self.TrackBar1Change

        # 创建 TTrackBar 控件
        self.track_bar = TrackBar(self)
        self.track_bar.SetBounds(10, 50, 360, 40)  # 设置 TrackBar 的位置和大小
        self.track_bar.Min = 0  # 设置最小值
        self.track_bar.Max = 100  # 设置最大值
        self.track_bar.Position = 50  # 设置初始位置
        self.track_bar.OnChange = self.on_track_bar_change  # 绑定改变事件
        self.track_bar.Parent = self  # 将 TrackBar 设置为窗体的子控件

        # 创建一个标签显示当前值
        self.label = Label(self)
        self.label.SetBounds(10, 10, 360, 30)  # 设置标签的位置和大小
        self.label.Caption = f"当前值: {self.track_bar.Position}"  # 初始化标签文本
        self.label.Parent = self  # 将标签设置为窗体的子控件

    # TrackBar 改变事件处理方法
    def on_track_bar_change(self, Sender):
        # 更新标签文本以显示当前 TrackBar 的值
        self.label.Caption = f"当前值: {self.track_bar.Position}"

    def TrackBar1Change(self, Sender):
        self.Label1.Caption = self.TrackBar1.Position