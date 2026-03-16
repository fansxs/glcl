import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.RadioGroup1 = RadioGroup(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TRadioGroup 控件
        self.radio_group = RadioGroup(self)
        self.radio_group.Parent = self  # 设置单选框组的父控件为当前窗口
        self.radio_group.Caption = 'Choose an Option'  # 设置单选框组标题
        self.radio_group.Items.Add('Option 1')  # 添加选项1
        self.radio_group.Items.Add('Option 2')  # 添加选项2
        self.radio_group.Items.Add('Option 3')  # 添加选项3
        self.radio_group.Left = 20  # 设置单选框组左边距
        self.radio_group.Top = 30  # 设置单选框组上边距
        self.radio_group.Width = 250  # 设置单选框组宽度

        # 创建一个 TButton 控件
        self.button = Button(self)
        self.button.Parent = self  # 设置按钮的父控件为当前窗口
        self.button.Caption = 'Submit'  # 设置按钮标题
        self.button.Left = 20  # 设置按钮左边距
        self.button.Top = 200  # 设置按钮上边距
        self.button.OnClick = self.on_button_click  # 绑定按钮点击事件

    def on_button_click(self, Sender):
        # 处理按钮点击事件
        selected_option = self.radio_group.ItemIndex  # 获取选中的选项索引
        if selected_option != -1:  # 检查是否有选项被选中
            ShowMessage(f'Selected: {self.radio_group.Items[selected_option]}')  # 显示选中的选项
        else:
            ShowMessage('No option selected')  # 显示未选择任何选项的消息

    def Button1Click(self, Sender):
        # 处理按钮点击事件
        selected_option = self.RadioGroup1.ItemIndex  # 获取选中的选项索引
        if selected_option != -1:  # 检查是否有选项被选中
            ShowMessage(f'确认购买: {self.RadioGroup1.Items[selected_option]}')  # 显示选中的选项
        else:
            ShowMessage('请先选择水果')  # 显示未选择任何选项的消息