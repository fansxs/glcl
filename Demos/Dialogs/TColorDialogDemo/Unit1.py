import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Memo1 = Memo(self)
        self.ColorDialog1 = ColorDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个编辑框用于显示所选颜色
        self.color_edit = Edit(self)
        self.color_edit.Parent = self  # 设置父控件为窗体
        self.color_edit.Text = "Sample Text"  # 文本内容
        self.color_edit.SetBounds(150, 50, 200, 30)  # 设置编辑框的位置和大小

        # 创建一个按钮用于打开颜色选择对话框
        self.color_button = Button(self)
        self.color_button.Parent = self  # 设置父控件为窗体
        self.color_button.Caption = "Choose Color"  # 按钮上的标题
        self.color_button.SetBounds(150, 100, 150, 30)  # 设置按钮的位置和大小

        # 为按钮设置点击事件处理程序
        self.color_button.OnClick = self.choose_color

    def choose_color(self, Sender):
        # 创建颜色选择对话框
        color_dialog = ColorDialog(self)

        # 显示对话框并检查用户是否点击了“确定”
        if color_dialog.Execute():
            # 获取用户选择的颜色
            selected_color = color_dialog.Color

            # 将所选颜色应用于标签的背景色
            self.color_edit.Color = selected_color

            # 显示所选颜色的信息
            ShowMessage(f"Selected Color: {selected_color}")

    def Button1Click(self, Sender):
        if self.ColorDialog1.Execute():
            self.Memo1.Color = self.ColorDialog1.Color