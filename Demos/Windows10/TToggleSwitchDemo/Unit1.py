import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ActivityIndicator1 = ActivityIndicator(self)
        self.ToggleSwitch1 = ToggleSwitch(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ToggleSwitch1.OnClick = self.ToggleSwitch1Click

        # 创建 TToggleSwitch 控件
        self.toggle_switch = ToggleSwitch(self)
        self.toggle_switch.Parent = self    # 设置父控件为窗体
        self.toggle_switch.SetBounds(100, 50, 100, 40)  # 设置控件位置和大小
        self.toggle_switch.OnClick = self.toggle_switch_click  # 设置点击事件处理

        # 创建标签，用于显示状态
        self.status_label = Label(self)
        self.status_label.Parent = self    # 设置父控件为窗体
        self.status_label.SetBounds(100, 100, 200, 40)  # 设置标签位置和大小
        self.status_label.Caption = '当前状态: 关闭'  # 设置标题

    def toggle_switch_click(self, Sender):
        # 切换开关的点击事件处理函数
        if self.toggle_switch.State == tssOn:
            self.status_label.Caption = '当前状态: 开启'  # 更新状态标签
        else:
            self.status_label.Caption = '当前状态: 关闭'  # 更新状态标签

    def ToggleSwitch1Click(self, Sender):
        if self.ToggleSwitch1.State == tssOn:
            self.ActivityIndicator1.Animate = True
        else:
            self.ActivityIndicator1.Animate = False