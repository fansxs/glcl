import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Memo1 = Memo(self)
        self.Button1 = Button(self)
        self.FileSaveDialog1 = FileSaveDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开保存文件对话框
        self.button = Button(self)
        self.button.Parent = self                 # 设置父控件为当前窗体
        self.button.Caption = 'Save File'         # 按钮标题
        self.button.Left = 150                    # 设置按钮的左侧位置
        self.button.Top = 50                       # 设置按钮的顶部位置
        self.button.OnClick = self.save_file_dialog  # 设置按钮点击事件处理程序

        # 创建一个标签用于显示所选文件的路径
        self.label = Label(self)
        self.label.Parent = self                  # 设置父控件为当前窗体
        self.label.Left = 10                      # 设置标签的左侧位置
        self.label.Top = self.button.Top + 30     # 设置标签的顶部位置，位于按钮下方
        self.label.Caption = 'Saved File: '       # 标签标题

    # 打开文件保存对话框的处理函数
    def save_file_dialog(self, Sender):
        # 创建文件保存对话框实例
        dialog = FileSaveDialog(self)
        dialog.Title = 'Save a File'              # 对话框标题

        # 显示对话框并检查用户是否指定了文件名
        if dialog.Execute():
            saved_file = dialog.FileName            # 获取所选保存文件的路径
            self.label.Caption = f'Saved File: {saved_file}'  # 更新标签内容

    def Button1Click(self, Sender):
        if self.FileSaveDialog1.Execute():
            self.Memo1.Lines.SaveToFile(self.FileSaveDialog1.FileName)