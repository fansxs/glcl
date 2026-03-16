import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Memo1 = Memo(self)
        self.SaveTextFileDialog1 = SaveTextFileDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开保存文件对话框
        self.save_button = Button(self)
        self.save_button.Parent = self  # 设置父控件为窗体
        self.save_button.Caption = "Save Text File"  # 按钮上的文本
        self.save_button.SetBounds(150, 80, 150, 30)  # 设置按钮的位置和大小

        # 为按钮设置点击事件处理程序
        self.save_button.OnClick = self.save_file_dialog

    def save_file_dialog(self, Sender):
        # 创建保存文本文件对话框
        dialog = SaveTextFileDialog(self)

        # 设置对话框的标题
        dialog.Title = "Save Text File"

        # 设置默认的文件名
        dialog.FileName = "document.txt"

        # 设置过滤器，仅显示文本文件
        dialog.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"

        # 显示对话框并检查用户是否点击了“确定”
        if dialog.Execute():
            # 获取用户选择的文件名
            selected_file = dialog.FileName

            # 打开文件并写入示例内容
            with open(selected_file, 'w') as file:
                file.write("Hello, this is a sample text file!")  # 写入内容到文件

            # 显示所选文件名，以确认文件已保存
            ShowMessage(f"File saved: {selected_file}")

    def Button1Click(self, Sender):
        if self.SaveTextFileDialog1.Execute():
            self.Memo1.Lines.SaveToFile(self.SaveTextFileDialog1.FileName)