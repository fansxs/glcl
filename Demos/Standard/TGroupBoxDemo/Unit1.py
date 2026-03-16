import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Edit1 = Edit(self)
        self.Label1 = Label(self)
        self.GroupBox1 = GroupBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TGroupBox 控件
        self.group_box = GroupBox(self)
        self.group_box.Parent = self  # 设置分组框的父控件为当前窗口
        self.group_box.Caption = 'Settings'  # 设置分组框标题
        self.group_box.Left = 20  # 设置分组框左边距
        self.group_box.Top = 30  # 设置分组框上边距

        # 创建一个 TCheckBox 控件
        self.check_box = CheckBox(self.group_box)  # 将复选框放入分组框内
        self.check_box.Parent = self.group_box  # 设置复选框的父控件为分组框
        self.check_box.Caption = 'Enable Feature'  # 设置复选框标题
        self.check_box.Left = 20  # 设置复选框左边距
        self.check_box.Top = 30  # 设置复选框上边距

        # 创建一个 TButton 控件
        self.button = Button(self.group_box)  # 将按钮放入分组框内
        self.button.Parent = self.group_box  # 设置按钮的父控件为分组框
        self.button.Caption = 'Submit'  # 设置按钮标题
        self.button.Left = 20  # 设置按钮左边距
        self.button.Top = 60  # 设置按钮上边距
        self.button.OnClick = self.on_button_click  # 绑定按钮点击事件

    def on_button_click(self, Sender):
        # 处理按钮点击事件
        if self.check_box.Checked:
            ShowMessage('Feature Enabled')  # 显示消息框
        else:
            ShowMessage('Feature Disabled')  # 显示消息框

    def Button1Click(self, Sender):
        self.Label1.Caption = 'TGroupBox'
        self.Edit1.Text = 'Hello World'