import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Edit1 = Edit(self)
        self.UpDown1 = UpDown(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建一个标签用于显示当前值
        self.label = Label(self)
        self.label.SetBounds(20, 50, 250, 30)  # 设置标签的位置和大小
        self.label.Caption = "当前值: 0"  # 初始化标签文本
        self.label.Parent = self  # 将标签设置为窗体的子控件

        # 创建一个 TEdit 控件用于显示和输入值
        self.edit = Edit(self)
        self.edit.SetBounds(20, 100, 100, 30)  # 设置编辑框的位置和大小
        self.edit.Text = "0"  # 初始化编辑框内容
        self.edit.Parent = self  # 将编辑框设置为窗体的子控件

        # 创建一个 TUpDown 控件用于增减值
        self.updown = UpDown(self)
        self.updown.SetBounds(130, 100, 30, 30)  # 设置 UpDown 控件的位置和大小
        self.updown.Parent = self  # 将 UpDown 控件设置为窗体的子控件
        self.updown.Min = 0  # 设置最小值
        self.updown.Max = 100  # 设置最大值
        self.updown.OnClick = self.update_value  # 绑定点击事件

        # 将 TUpDown 的关联编辑框设置为刚才创建的 TEdit
        self.updown.Associate = self.edit  # 关联控制

    # 更新值的方法
    def update_value(self, Sender, Button):
        # 更新标签显示当前值
        self.label.Caption = f"当前值: {self.edit.Text}"  # 显示当前编辑框中的值