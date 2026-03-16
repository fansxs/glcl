import os
from glcl import *
from datetime import datetime

class Form1(Form):

    def __init__(self, owner):
        self.CalendarView1 = CalendarView(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.CalendarView1.OnChange = self.CalendarView1Change

        # 创建 TCalendarView 组件
        self.calendar_view = CalendarView(self)
        self.calendar_view.Parent = self    # 设置父控件为窗体
        self.calendar_view.Left = 10        # 设置左边距离
        self.calendar_view.Top = 50         # 设置顶边距离

        # 创建一个按钮，用于获取选择的日期
        self.show_date_button = Button(self)
        self.show_date_button.Parent = self # 设置父控件为窗体
        self.show_date_button.Caption = "显示选择的日期"   # 设置标题
        self.show_date_button.Left = 10     # 设置左边距离
        self.show_date_button.Top = 500     # 设置顶边距离
        self.show_date_button.Width = 150   # 设置宽度
        self.show_date_button.OnClick = self.show_selected_date  # 绑定点击事件

        # 创建一个标签，用于显示日期
        self.selected_date_label = Label(self)
        self.selected_date_label.Parent = self    # 设置父控件为窗体
        self.selected_date_label.Left = 10        # 设置左边距离
        self.selected_date_label.Top = 10         # 设置顶边距离
        self.selected_date_label.Caption = "选择的日期将在这里显示"    # 设置标题

    # 显示选择的日期的事件处理函数
    def show_selected_date(self, Sender):
        try:
            selected_date = self.calendar_view.Date  # 获取选中的日期
            self.selected_date_label.Caption = f"选择的日期: {selected_date}"  # 更新显示
        except:
            ShowMessage('未选中日期')

    def CalendarView1Change(self, Sender):
        try:
            selected_date = self.CalendarView1.Date  # 获取选中的日期
            self.Caption = f"选择的日期: {selected_date}"  # 更新显示
        except:
            ShowMessage('未选中日期')