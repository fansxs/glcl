import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.FileListBox1 = FileListBox(self)
        self.DirectoryListBox1 = DirectoryListBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        self.DirectoryListBox1.OnChange = self.DirectoryListBox1Change

        # 创建一个 TDirectoryListBox 控件
        self.directory_list_box = DirectoryListBox(self)
        self.directory_list_box.Parent = self   # 设置父控件为窗体
        self.directory_list_box.Left = 10       # 设置左边距离
        self.directory_list_box.Top = 50        # 设置顶部距离
        self.directory_list_box.Height = 300    # 设置高度
        self.directory_list_box.Directory = 'C:\\'  # 设置初始目录为C盘根目录

        # 创建一个按钮，用于显示所选目录
        self.show_directory_button = Button(self)
        self.show_directory_button.Parent = self    # 设置父控件为窗体
        self.show_directory_button.Caption = '显示所选目录'  # 设置按钮文本
        self.show_directory_button.Top = 10  # 设置按钮距离顶部的距离
        self.show_directory_button.Left = 10  # 设置按钮距离左侧的距离
        self.show_directory_button.Width = 200  # 设置宽度
        self.show_directory_button.OnClick = self.show_selected_directory  # 设置按钮点击事件处理

    # 按钮点击事件处理函数
    def show_selected_directory(self, Sender):
        selected_directory = self.directory_list_box.Directory  # 获取所选目录
        if selected_directory:
            ShowMessage(f'所选目录: {selected_directory}')  # 显示所选目录
        else:
            ShowMessage('没有选择目录')  # 如果没有选择目录，则显示提示

    def DirectoryListBox1Change(self, Sender):
        self.FileListBox1.Directory = self.DirectoryListBox1.Directory

    def Button1Click(self, Sender):
        self.FileListBox1.Mask = '*.py'