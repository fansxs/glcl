import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Memo1 = Memo(self)
        self.OpenTextFileDialog1 = OpenTextFileDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮，用于打开文件对话框
        self.open_button = Button(self)
        self.open_button.Parent = self  # 设置父控件为窗体
        self.open_button.Caption = "Open Text File" # 设置标题
        self.open_button.SetBounds(350, 80, 150, 30) # 设置位置和宽高

        # 为按钮设置点击事件
        self.open_button.OnClick = self.open_file_dialog

    def open_file_dialog(self, Sender):
        # 创建文本文件打开对话框
        dialog = OpenTextFileDialog(self)

        # 设置对话框的标题
        dialog.Title = "Select a Text File"

        # 设置过滤器，仅显示文本文件
        dialog.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"

        # 显示对话框并检查用户是否点击了“确定”
        if dialog.Execute():
            # 获取选中的文件名
            selected_file = dialog.FileName
            # 显示选中的文件名
            ShowMessage(f"Selected file: {selected_file}")

            # 这里可以添加代码读取文件内容或做其他操作

    def Button1Click(self, Sender):
        if self.OpenTextFileDialog1.Execute():
            self.Memo1.Lines.LoadFromFile(self.OpenTextFileDialog1.FileName)