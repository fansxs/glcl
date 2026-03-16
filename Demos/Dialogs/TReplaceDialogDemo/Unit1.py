import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.ReplaceDialog1 = ReplaceDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开替换对话框
        self.replace_button = Button(self)
        self.replace_button.Parent = self   # 设置父控件为窗体
        self.replace_button.Caption = "Replace"     # 设置标题
        self.replace_button.Left = 150  # 设置按钮左边位置
        self.replace_button.Top = 100  # 设置按钮顶边位置
        self.replace_button.OnClick = self.show_replace_dialog  # 绑定点击事件

    def show_replace_dialog(self, Sender):
        # 创建替换对话框实例
        replace_dialog = ReplaceDialog(self)
        replace_dialog.FindText = 'aaa'
        replace_dialog.ReplaceText = 'bbb'

        # 显示替换对话框并检查用户是否按下“确定”
        if replace_dialog.Execute():
            # 获取用户输入的查找和替换文本
            search_text = replace_dialog.FindText
            replace_text = replace_dialog.ReplaceText
            ShowMessage(f"Searching for: {search_text}")  # 显示查找内容
            ShowMessage(f"Replacing with: {replace_text}")  # 显示替换内容

            # 这里可以添加实际的替换逻辑，例如在文本框中查找并替换内容

    def Button1Click(self, Sender):
        if self.ReplaceDialog1.Execute():
            ShowMessage(self.ReplaceDialog1.FindText)
            ShowMessage(self.ReplaceDialog1.ReplaceText)