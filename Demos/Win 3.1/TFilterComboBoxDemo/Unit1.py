import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.DriveComboBox1 = DriveComboBox(self)
        self.DirectoryListBox1 = DirectoryListBox(self)
        self.FileListBox1 = FileListBox(self)
        self.FilterComboBox1 = FilterComboBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # 可以设置FilterComboBox的FileList属性为FileListBox
        # Filter属性注意书写格式，每一组中间用'|'符号隔开，例如 文本文件 (*.txt)|*.txt

        # 创建一个 TFilterComboBox 控件
        self.filter_combo_box = FilterComboBox(self)
        self.filter_combo_box.Parent = self     # 设置父控件为窗体
        self.filter_combo_box.Align = alTop     # 将组合框置顶对齐

        # 添加一些示例过滤器到 TFilterComboBox
        self.filter_combo_box.Items.Add('所有文件 (*.*)')
        self.filter_combo_box.Items.Add('文本文件 (*.txt)')
        self.filter_combo_box.Items.Add('图像文件 (*.png; *.jpg; *.jpeg)')
        self.filter_combo_box.Items.Add('可执行文件 (*.exe)')

        # 创建一个按钮，用于显示所选过滤器
        self.show_filter_button = Button(self)
        self.show_filter_button.Parent = self   # 设置父控件为窗体
        self.show_filter_button.Width = 200     # 设置宽度
        self.show_filter_button.Caption = '显示所选过滤器'  # 设置按钮文本
        self.show_filter_button.Top = 50  # 设置按钮距离顶部的距离
        self.show_filter_button.Left = 10  # 设置按钮距离左侧的距离
        self.show_filter_button.OnClick = self.show_selected_filter  # 设置按钮点击事件处理

    # 按钮点击事件处理函数
    def show_selected_filter(self, Sender):
        selected_filter = self.filter_combo_box.Text  # 获取所选过滤器
        if selected_filter:
            ShowMessage(f'所选过滤器: {selected_filter}')  # 显示所选过滤器
        else:
            ShowMessage('没有选择过滤器')  # 如果没有选择过滤器，则显示提示