import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Memo1 = Memo(self)
        self.FontDialog1 = FontDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个标签用于显示所选字体
        self.font_label = Label(self)
        self.font_label.Parent = self   # 设置父控件为窗体
        self.font_label.Caption = "Sample Text"  # 标签上的标题
        self.font_label.SetBounds(150, 50, 200, 30)  # 设置标签的位置和大小

        # 创建一个按钮用于打开字体选择对话框
        self.font_button = Button(self)
        self.font_button.Parent = self  # 设置父控件为窗体
        self.font_button.Caption = "Choose Font"  # 按钮上的标题
        self.font_button.SetBounds(150, 100, 150, 30)  # 设置按钮的位置和大小

        # 为按钮设置点击事件处理程序
        self.font_button.OnClick = self.choose_font

    def choose_font(self, Sender):
        # 创建字体选择对话框
        font_dialog = FontDialog(self)

        # 显示对话框并检查用户是否点击了“确定”
        if font_dialog.Execute():
            # 获取用户选择的字体
            selected_font = font_dialog.Font

            # 将所选字体应用于标签
            self.font_label.Font.Assign(selected_font)

            # 显示所选字体的信息
            ShowMessage(f"Selected Font: {selected_font.Name}, Size: {selected_font.Size}, Style: {selected_font.Style}")

    def Button1Click(self, Sender):
        if self.FontDialog1.Execute():
            self.Memo1.Font.Assign(self.FontDialog1.Font)