import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.SpinEdit1 = SpinEdit(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.SpinEdit1.OnChange = self.SpinEdit1Change

        # 创建一个TSpinEdit控件，用于输入和调整数值
        self.spin_edit = SpinEdit(self)
        self.spin_edit.Parent = self             # 设置父控件为当前窗体
        self.spin_edit.Left = 50                 # 设置控件的左侧位置
        self.spin_edit.Top = 50                  # 设置控件的顶部位置
        self.spin_edit.Width = 200                # 设置控件的宽度
        self.spin_edit.MinValue = 0              # 设置最小值为0
        self.spin_edit.MaxValue = 100            # 设置最大值为100
        self.spin_edit.Value = 0                  # 设置初始值为0

        # 创建一个标签用于显示说明
        self.label = Label(self)
        self.label.Parent = self                 # 设置父控件为当前窗体
        self.label.Left = 50                     # 设置标签的左侧位置
        self.label.Top = 20                      # 设置标签的顶部位置
        self.label.Caption = 'Adjust the value:' # 标签标题

    def SpinEdit1Change(self, Sender):
        self.Caption = str(self.SpinEdit1.Text)