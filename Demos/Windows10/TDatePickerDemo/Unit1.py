import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.DatePicker1 = DatePicker(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.DatePicker1.OnChange = self.DatePicker1Change

        # 创建 TDatePicker 组件
        self.date_picker = DatePicker(self)
        self.date_picker.Parent = self  # 设置父控件为窗体
        self.date_picker.Left = 10      # 设置左边距离
        self.date_picker.Top = 10       # 设置顶部距离

        # 创建一个按钮，用于获取选择的日期
        self.show_date_button = Button(self)
        self.show_date_button.Parent = self  # 设置父控件为窗体
        self.show_date_button.Top = 60       # 设置顶部距离
        self.show_date_button.Left = 10      # 设置左边距离
        self.show_date_button.Width = 200    # 设置宽度
        self.show_date_button.Caption = "显示选择的日期"  # 按钮文本
        self.show_date_button.OnClick = self.show_selected_date  # 绑定点击事件

        # 创建一个标签，用于显示日期
        self.selected_date_label = Label(self)
        self.selected_date_label.Parent = self  # 设置父控件为窗体
        self.selected_date_label.Left = 10      # 设置左边距离
        self.selected_date_label.Top = 100      # 设置顶部距离
        self.selected_date_label.Caption = '选择的日期将在这里显示' # 初始化标签文本

    # 显示选择的日期的事件处理函数
    def show_selected_date(self, Sender):
        selected_date = self.date_picker.Date # 获取选中的日期
        self.selected_date_label.Caption = f"选择的日期: {selected_date}"  # 更新标签显示所选日期

    def DatePicker1Change(self, Sender):
        self.Caption = self.DatePicker1.Date