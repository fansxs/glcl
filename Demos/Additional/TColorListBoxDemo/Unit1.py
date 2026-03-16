import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.ColorListBox1 = ColorListBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个颜色列表框
        self.color_list_box = ColorListBox(self)
        self.color_list_box.Parent = self   # 指定父控件为当前表单
        self.color_list_box.Width = 150     # 设置宽度
        self.color_list_box.Height = 120    # 设置高度
        self.color_list_box.Left = 10       # 设置左边距
        self.color_list_box.Top = 10        # 设置顶边距

        # 创建一个按钮，用于显示选中的颜色
        self.ShowColorButton = Button(self)
        self.ShowColorButton.Parent = self  # 指定父控件为当前表单
        self.ShowColorButton.Caption = '显示选中的颜色'    # 设置标题属性
        self.ShowColorButton.Width = 200    # 设置宽度
        self.ShowColorButton.Top = 150      # 设置顶边距
        self.ShowColorButton.Left = 10      # 设置左边距
        self.ShowColorButton.OnClick = self.ShowColorButtonClick

    def ShowColorButtonClick(self, Sender):
        # 显示选中的颜色
        ShowMessage(Application.ColorToString(self.color_list_box.Selected))

    def Button1Click(self, Sender):
        ShowMessage(Application.ColorToString(self.ColorListBox1.Selected))