import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.FileOpenDialog1 = FileOpenDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开文件对话框
        self.button = Button(self)
        self.button.Parent = self                 # 设置父控件为当前窗体
        self.button.Caption = 'Open File'         # 按钮标题
        self.button.Left = 150                    # 设置按钮的左侧距离
        self.button.Top = 50                       # 设置按钮的顶部距离
        self.button.OnClick = self.open_file_dialog  # 注册按钮点击事件处理程序

        # 创建一个标签用于显示所选文件的路径
        self.label = Label(self)
        self.label.Parent = self                  # 设置父控件为当前窗体
        self.label.Left = 10                      # 设置标签的左侧位置
        self.label.Top = self.button.Top + 30     # 设置标签的顶部位置，位于按钮下方
        self.label.Caption = 'Selected File: '    # 标签标题

    # 打开文件对话框的处理函数
    def open_file_dialog(self, Sender):
        # 创建文件打开对话框实例
        dialog = FileOpenDialog(self)
        dialog.Title = 'Select a File'           # 对话框标题

        # 显示对话框并检查用户是否选择了文件
        if dialog.Execute():
            selected_file = dialog.FileName       # 获取所选文件的路径
            self.label.Caption = f'Selected File: {selected_file}'  # 更新标签标题

    def Button1Click(self, Sender):
        # 如果是选择文件夹，需要指定Options属性中的fdoPickFolders为True
        if self.FileOpenDialog1.Execute():
            self.Caption = self.FileOpenDialog1.FileName