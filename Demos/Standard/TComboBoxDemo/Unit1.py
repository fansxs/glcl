import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ComboBox1 = ComboBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ComboBox1.OnChange = self.ComboBox1Change

        # 创建一个 TComboBox 组件
        combo_box = ComboBox(self)
        combo_box.Parent = self  # 设置父组件为窗体
        combo_box.Left = 30  # 设置 combo_box 的左边距
        combo_box.Top = 100  # 设置 combo_box 的上边距
        combo_box.Width = 150  # 设置 combo_box 的宽度
        combo_box.OnSelect = self.combo_boxSelect  # 设置 combo_box 的OnSelect事件

        # 添加选项到 TComboBox 中
        combo_box.Items.Add("Option 1")  # 添加第一个选项
        combo_box.Items.Add("Option 2")  # 添加第二个选项
        combo_box.Items.Add("Option 3")  # 添加第三个选项

    def combo_boxSelect(self, Sender):
        ShowMessage('select')

    def ComboBox1Change(self, Sender):
        ShowMessage('change')