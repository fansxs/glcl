import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ColorBox1 = ColorBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ColorBox1.OnChange = self.ColorBox1Change

        # 创建一个 TColorBox 控件
        self.color_box = ColorBox(self)
        # 设置 TColorBox 的位置和大小
        self.color_box.Left = 50    # 设置 TColorBox 的左边距
        self.color_box.Top = 50    # 设置 TColorBox 的顶边距
        self.color_box.Width = 200    # 设置 TColorBox 的宽度
        # 设置 TColorBox 改变事件，可以和self.ColorBox1是同一个事件
        self.color_box.OnChange = self.ColorBox1Change

        # 将 TColorBox 添加到窗体中
        self.InsertControl(self.color_box)

        # 创建一个标签来显示所选颜色的文本
        self.label = Label(self)
        self.label.Left = 50
        self.label.Top = 100
        self.label.Caption = 'Selected Color: None'
        # 将 TLabel 添加到窗体中，此方法内部指定了Parent属性，还做了其他操作
        self.InsertControl(self.label)

    def ColorBox1Change(self, Sender):
        # 通过Sender进行区分是哪一个控件
        if Sender == self.ColorBox1:
            self.label.Caption = 'Selected Color: ' + Application.ColorToString(self.ColorBox1.Selected)
        else:
            self.label.Caption = 'Selected Color: ' + Application.ColorToString(self.color_box.Selected)