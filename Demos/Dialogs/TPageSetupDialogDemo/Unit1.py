import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.PageSetupDialog1 = PageSetupDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开页面设置对话框
        self.page_setup_button = Button(self)
        self.page_setup_button.Parent = self    # 设置父控件为窗体
        self.page_setup_button.Caption = "Page Setup"  # 按钮标题
        self.page_setup_button.Left = 150  # 设置按钮左边位置
        self.page_setup_button.Top = 70  # 设置按钮顶边位置
        self.page_setup_button.Width = 150  # 设置按钮宽度
        self.page_setup_button.OnClick = self.show_page_setup_dialog  # 绑定点击事件

    def show_page_setup_dialog(self, Sender):
        # 创建页面设置对话框实例
        page_setup_dialog = PageSetupDialog(self)

        # 显示页面设置对话框
        if page_setup_dialog.Execute():
            # 如果用户按下“确定”，可以获取页面设置的相关信息
            ShowMessage("Page Setup Dialog executed successfully.")  # 显示弹出成功消息

    def Button1Click(self, Sender):
        if self.PageSetupDialog1.Execute():
            ShowMessage(str(self.PageSetupDialog1.MarginLeft))
            # 设置好参数后可以调用打印方法进行打印