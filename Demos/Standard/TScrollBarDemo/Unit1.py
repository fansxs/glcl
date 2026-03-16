import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Label1 = Label(self)
        self.ScrollBar1 = ScrollBar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ScrollBar1.OnChange = self.ScrollBar1Change

        # 创建滚动条
        self.scroll_bar = ScrollBar(self)
        self.scroll_bar.Parent = self  # 设置滚动条的父控件为当前窗口
        self.scroll_bar.Min = 0  # 滚动条最小值
        self.scroll_bar.Max = 100  # 滚动条最大值
        self.scroll_bar.Position = 50  # 初始位置
        self.scroll_bar.Left = 40  # 左边距
        self.scroll_bar.Top = 80  # 上边距
        self.scroll_bar.Width = 400  # 宽度

        # 绑定滚动条的OnChange事件
        self.scroll_bar.OnChange = self.on_scroll_change

    def on_scroll_change(self, Sender):
        # 当滚动条值变化时更新标签内容
        self.Label1.Caption = f'Scroll Value: {self.scroll_bar.Position}'

    def ScrollBar1Change(self, Sender):
        self.Label1.Caption = self.ScrollBar1.Position