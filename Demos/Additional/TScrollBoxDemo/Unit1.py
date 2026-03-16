import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Image1 = Image(self)
        self.ScrollBox1 = ScrollBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.OnMouseWheel = self.FormMouseWheel

        # 创建 TScrollBox 对象
        self.scroll_box = ScrollBox(self)
        self.scroll_box.Parent = self
        # 设置 TScrollBox 的位置和大小
        self.scroll_box.Left = 10      # 距离窗体左边10个单位
        self.scroll_box.Top = 10       # 距离窗体顶部10个单位
        self.scroll_box.Width = 360     # 宽度为360个单位
        self.scroll_box.Height = 240    # 高度为240个单位

        # 向 ScrollBox 添加多个 Label 组件
        for i in range(20):
            label = Label(self.scroll_box)  # 在 ScrollBox 中创建新的 Label
            label.Caption = f"标签 {i + 1}"  # 设置标签内容
            label.Left = 10                  # 标签距离 ScrollBox 左边10个单位
            label.Top = 30 * i               # 标签垂直排列，每个标签之间间隔30个单位
            label.Parent = self.scroll_box    # 将标签添加到 ScrollBox 中

    def FormMouseWheel(self, Sender, Shift, WheelDelta, MousePos, Handled):
        if WheelDelta < 0:    # 滚轮向下滑动WheelDelta是小于零
            # 将纵向滑块加20
            self.ScrollBox1.VertScrollBar.Position += 20
        else:
            # 将纵向滑块减20
            self.ScrollBox1.VertScrollBar.Position -= 20