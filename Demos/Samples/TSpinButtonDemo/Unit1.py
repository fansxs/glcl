import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Edit1 = Edit(self)
        self.SpinButton1 = SpinButton(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.SpinButton1.OnUpClick = self.SpinButton1UpClick
        self.SpinButton1.OnDownClick = self.SpinButton1DownClick

        # 创建一个TEdit控件，用于显示当前数值
        self.value_edit = Edit(self)
        self.value_edit.Parent = self   # 设置父控件为窗体
        self.value_edit.Left = 50       # 设置左边距离
        self.value_edit.Top = 50        # 设置顶部距离
        self.value_edit.Width = 200     # 设置宽度
        self.value_edit.Text = '0'      # 设置文本

        # 创建一个TSpinButton控件
        self.spin_button = SpinButton(self)
        self.spin_button.Parent = self  # 设置父控件为窗体
        self.spin_button.Left = 250     # 设置左边距离
        self.spin_button.Top = 50       # 设置顶部距离
        self.spin_button.Height = 35   # 设置高度

        # 绑定点击事件
        self.spin_button.OnUpClick = self.spin_up_click
        self.spin_button.OnDownClick = self.spin_down_click

    # 增加值的方法
    def spin_up_click(self, Sender):
        self.update_value(1)

    # 减少值的方法
    def spin_down_click(self, Sender):
        self.update_value(-1)

    # 更新文本框中的值
    def update_value(self, delta):
        try:
            current_value = int(self.value_edit.Text)
            current_value += delta
            self.value_edit.Text = str(current_value)
        except ValueError:
            pass

    def SpinButton1DownClick(self, Sender):
        current_value = int(self.Edit1.Text)
        current_value -= 1
        self.Edit1.Text = str(current_value)

    def SpinButton1UpClick(self, Sender):
        current_value = int(self.Edit1.Text)
        current_value += 1
        self.Edit1.Text = str(current_value)