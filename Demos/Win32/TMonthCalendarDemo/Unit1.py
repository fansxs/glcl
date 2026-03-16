import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.MonthCalendar1 = MonthCalendar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建 TMonthCalendar 控件用于选择日期
        self.monthCalendar = MonthCalendar(self)
        self.monthCalendar.SetBounds(50, 20, 200, 160)  # 设置控件的位置和大小
        self.monthCalendar.Parent = self  # 将控件设置为窗体的子控件

        # 创建按钮用于获取选定的日期
        self.btnShowDate = Button(self)
        self.btnShowDate.SetBounds(50, 200, 200, 30)  # 设置按钮的位置和大小
        self.btnShowDate.Caption = "显示选定的日期"  # 设置按钮文本
        self.btnShowDate.OnClick = self.show_date  # 绑定点击事件
        self.btnShowDate.Parent = self  # 将按钮设置为窗体的子控件

    # 显示选定的日期的方法
    def show_date(self, Sender):
        selected_date = self.monthCalendar.Date  # 获取选定的日期
        message = f"选定的日期: {selected_date}"  # 构建消息字符串
        ShowMessage(message)  # 显示消息框
