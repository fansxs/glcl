import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.DateTimePicker1 = DateTimePicker(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TDateTimePicker 控件用于选择日期和时间
        self.dateTimePicker = DateTimePicker(self)
        self.dateTimePicker.SetBounds(50, 50, 200, 25)  # 设置控件的位置和大小
        self.dateTimePicker.Parent = self  # 将控件设置为窗体的子控件

        # 创建按钮用于获取选定的日期和时间
        self.btnShowDateTime = Button(self)
        self.btnShowDateTime.SetBounds(50, 100, 200, 30)  # 设置按钮的位置和大小
        self.btnShowDateTime.Caption = "显示选定的日期和时间"  # 设置按钮文本
        self.btnShowDateTime.OnClick = self.show_date_time  # 绑定点击事件
        self.btnShowDateTime.Parent = self  # 将按钮设置为窗体的子控件

    # 显示选定的日期和时间的方法
    def show_date_time(self, Sender):
        selected_date_time = self.dateTimePicker.DateTime  # 获取选定的日期和时间
        message = f"选定的日期和时间: {selected_date_time}"  # 构建消息字符串
        ShowMessage(message)  # 显示消息框

    def Button1Click(self, Sender):
        selected_date_time = self.DateTimePicker1.DateTime  # 获取选定的日期和时间
        message = f"选定的日期和时间: {selected_date_time}"  # 构建消息字符串
        ShowMessage(message)  # 显示消息框