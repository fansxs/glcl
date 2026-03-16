import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.FileListBox1 = FileListBox(self)
        self.DirectoryListBox1 = DirectoryListBox(self)
        self.DriveComboBox1 = DriveComboBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # DriveComboBox可以设置DirList、DirectoryListBox设置FileList以实现三个控件联动

        # 创建一个 TDriveComboBox 控件
        self.drive_combo_box = DriveComboBox(self)
        self.drive_combo_box.Parent = self  # 设置父控件为窗体
        self.drive_combo_box.Align = alTop  # 将组合框置顶对齐

        # 创建一个按钮，用于显示所选驱动器
        self.show_drive_button = Button(self)
        self.show_drive_button.Parent = self    # 设置父控件为窗体
        self.show_drive_button.Caption = '显示所选驱动器'  # 设置按钮文本
        self.show_drive_button.Top = 50  # 设置按钮距离顶部的距离
        self.show_drive_button.Left = 10  # 设置按钮距离左侧的距离
        self.show_drive_button.Width = 200  # 设置宽度
        self.show_drive_button.OnClick = self.show_selected_drive  # 设置按钮点击事件处理

    # 按钮点击事件处理函数
    def show_selected_drive(self, Sender):
        selected_drive = self.drive_combo_box.Drive  # 获取所选驱动器
        if selected_drive:
            ShowMessage(f'所选驱动器: {selected_drive}')  # 显示所选驱动器
        else:
            ShowMessage('没有选择驱动器')  # 如果没有选择驱动器，则显示提示