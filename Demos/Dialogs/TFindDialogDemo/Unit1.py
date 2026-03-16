import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.FindDialog1 = FindDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开查找对话框
        self.find_button = Button(self)
        self.find_button.Parent = self  # 设置父控件为窗体
        self.find_button.Caption = "Find"   # 设置标题
        self.find_button.Left = 150  # 设置按钮左边位置
        self.find_button.Top = 100  # 设置按钮顶边位置
        self.find_button.OnClick = self.show_find_dialog  # 绑定点击事件

    def show_find_dialog(self, Sender):
        # 创建查找对话框实例
        find_dialog = FindDialog(self)
        # 设置要查找的文本
        find_dialog.FindText = 'aaa'

        # 显示查找对话框并检查用户是否按下“确定”
        if find_dialog.Execute():
            search_text = find_dialog.FindText  # 获取用户输入的查找内容
            ShowMessage(f"Searching for: {search_text}")  # 显示查找内容

            # 这里可以添加实际的查找逻辑，例如在文本框中查找内容

    def Button1Click(self, Sender):
        if self.FindDialog1.Execute():
            ShowMessage(self.FindDialog1.FindText)