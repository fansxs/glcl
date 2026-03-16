import os
from glcl import *
# 需要导入datetime包
from datetime import datetime

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.TimePicker1 = TimePicker(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        self.TimePicker1.OnChange = self.TimePicker1Change

        # 创建 TTimePicker 组件
        self.time_picker = TimePicker(self)
        self.time_picker.Parent = self      # 设置父控件为窗体
        self.time_picker.Left = 10          # 设置左边距离
        self.time_picker.Top = 10           # 设置顶部距离

        # 创建一个按钮，用于获取选择的时间
        self.show_time_button = Button(self)
        self.show_time_button.Parent = self # 设置父控件为窗体
        self.show_time_button.Left = 10     # 设置左边距离
        self.show_time_button.Top = 60      # 设置顶部距离
        self.show_time_button.Width = 200   # 设置宽度
        self.show_time_button.Caption = "显示选择的时间"  # 按钮标题
        self.show_time_button.OnClick = self.show_selected_time  # 绑定点击事件

        # 创建一个标签，用于显示时间
        self.selected_time_label = Label(self)
        self.selected_time_label.Parent = self  # 设置父控件为窗体
        self.selected_time_label.Left = 10      # 设置左边距离
        self.selected_time_label.Top = 100      # 设置顶部距离
        self.selected_time_label.Caption = "选择的时间将在这里显示"  # 设置化标签标题

    # 显示选择的时间的事件处理函数
    def show_selected_time(self, Sender):
        selected_time = self.time_picker.Time  # 获取选中的时间
        self.selected_time_label.Caption = f"选择的时间: {selected_time}"  # 更新标签显示所选时间

    def TimePicker1Change(self, Sender):
        self.Caption = self.TimePicker1.Time

    def Button1Click(self, Sender):
        # 设置TimePicker1的当前时间
        self.TimePicker1.Time = datetime.now()