
import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.NumberBox1 = NumberBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.NumberBox1.OnChangeValue = self.NumberBox1ChangeValue
        self.Button1.OnClick = self.Button1Click

        # 创建一个 TNumberBox 实例
        self.number_box = NumberBox(self)
        self.number_box.Parent = self   # 设置父控件为窗体
        self.number_box.SetBounds(50, 50, 200, 30)  # 设置位置和大小
        self.number_box.MinValue = 0  # 设置最小值
        self.number_box.MaxValue = 100  # 设置最大值
        self.number_box.Value = 50  # 设置默认值

        # 创建一个按钮，用于显示输入的数字
        self.button = Button(self)
        self.button.Parent = self   # 设置父控件为窗体
        self.button.Caption = 'Show Value'  # 设置按钮标题
        self.button.SetBounds(50, 100, 200, 30)  # 设置按钮位置和大小
        self.button.OnClick = self.show_value  # 绑定按钮点击事件

    def show_value(self, Sender):
        """显示当前输入的数字"""
        value = self.number_box.Value  # 获取当前输入的值
        Application.MessageBox(f'Current Value: {value}', 'Info', MB_OK)  # 弹出消息框显示值

    def Button1Click(self, Sender):
        self.Caption = str(self.NumberBox1.Value)

    def NumberBox1ChangeValue(self, Sender):
        self.Caption = str(self.NumberBox1.Value)