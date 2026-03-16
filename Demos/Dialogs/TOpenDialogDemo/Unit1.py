import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.OpenDialog1 = OpenDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮，用于打开文件对话框
        self.open_dialog_button = Button(self)
        self.open_dialog_button.Parent = self   # 设置父控件为窗体
        self.open_dialog_button.Caption = '打开文件'  # 设置按钮文本
        self.open_dialog_button.Top = 50  # 设置按钮距离顶部的距离
        self.open_dialog_button.Left = 150  # 设置按钮距离左侧的距离
        self.open_dialog_button.OnClick = self.open_file_dialog  # 设置按钮点击事件处理

    # 按钮点击事件处理函数
    def open_file_dialog(self, Sender):
        open_dialog = OpenDialog(self)  # 创建文件打开对话框实例
        open_dialog.Filter = '所有文件 (*.*)|*.*|文本文件 (*.txt)|*.txt|图像文件 (*.png; *.jpg; *.jpeg)|*.png;*.jpg;*.jpeg'  # 设置过滤器
        open_dialog.Title = '选择一个文件'  # 设置对话框标题

        # 显示对话框并检查用户是否点击了“确定”
        if open_dialog.Execute():  # 打开对话框并等待用户选择
            selected_file = open_dialog.FileName  # 获取所选文件的路径
            ShowMessage(f'您选择的文件: {selected_file}')  # 显示所选文件路径
        else:
            ShowMessage('未选择文件')  # 如果用户没有选择文件，则显示提示

    def Button1Click(self, Sender):
        if self.OpenDialog1.Execute():
            self.Caption = self.OpenDialog1.FileName