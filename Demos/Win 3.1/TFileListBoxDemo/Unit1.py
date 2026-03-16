import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.FileListBox1 = FileListBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个 TFileListBox 控件
        self.file_list_box = FileListBox(self)
        self.file_list_box.Parent = self    # 设置父控件为窗体
        self.file_list_box.Left = 10        # 左边距离
        self.file_list_box.Top = 50         # 上边距离
        self.file_list_box.Width = 200      # 宽度
        self.file_list_box.Height = 300     # 高度
        self.file_list_box.Directory = '.'  # 设置初始目录为当前目录

        # 创建一个按钮，用于显示所选文件名
        self.show_file_button = Button(self)
        self.show_file_button.Parent = self # 设置父控件为窗体
        self.show_file_button.Caption = '显示所选文件'  # 设置按钮文本
        self.show_file_button.Top = 10  # 设置按钮距离顶部的距离
        self.show_file_button.Left = 10  # 设置按钮距离左侧的距离
        self.show_file_button.Width = 200   # 宽度
        self.show_file_button.OnClick = self.show_selected_file  # 设置按钮点击事件处理

    # 按钮点击事件处理函数
    def show_selected_file(self, Sender):
        selected_file = self.file_list_box.FileName  # 获取所选文件名
        if selected_file:
            ShowMessage(f'所选文件: {selected_file}')  # 显示所选文件名
        else:
            ShowMessage('没有选择文件')  # 如果没有选择文件，则显示提示

    def Button1Click(self, Sender):
        # 设置目录
        self.FileListBox1.Directory = Application.SelectDirectory('选择目录', 'C:\\')
        # 设置窗体获得焦点，若不调用此函数，在选择目录对话框关闭后，窗体会无焦点
        self.SetFocus()