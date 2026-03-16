import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Calendar1 = Calendar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Calendar1.OnDblClick = self.Calendar1DblClick

        # 创建一个TCalendar控件，用于选择日期
        self.calendar = Calendar(self)
        self.calendar.Parent = self             # 设置父控件为当前窗体
        self.calendar.Align = alTop             # 设置控件对齐方式为顶部
        self.calendar.OnChange = self.calendar_onchange # 设置改变事件

        # 创建一个标签用于显示所选日期
        self.label = Label(self)
        self.label.Parent = self                # 设置父控件为当前窗体
        self.label.Left = 10                    # 设置标签的左侧位置
        self.label.Top = 300                    # 设置顶部距离
        self.label.Top = self.calendar.Height + 10  # 设置标签的顶部位置，位于日历下方
        self.label.Caption = 'Selected Date: '   # 标签标题

    def calendar_onchange(self, Sender):
        self.label.Caption = self.calendar.CalendarDate

    def Calendar1DblClick(self, Sender):
        ShowMessage(self.Calendar1.CalendarDate)