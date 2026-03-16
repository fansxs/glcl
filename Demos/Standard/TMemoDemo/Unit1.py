import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Memo1 = Memo(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建一个 TMemo 控件
        self.memo = Memo(self)  # TMemo 控件的拥有者是当前的表单 (self)
        self.memo.Parent = self  # 将 TMemo 控件的父窗口设置为当前表单
        self.memo.Left = 20  # 设置 TMemo 控件的左边距
        self.memo.Top = 200  # 设置 TMemo 控件的上边距
        self.memo.Width = 360  # 设置 TMemo 控件的宽度
        self.memo.Height = 220  # 设置 TMemo 控件的高度
        self.memo.Text = "You can type multiple lines of text here..."  # 设置 TMemo 控件的初始文本
        self.memo.BorderStyle = bsNone  # 去掉边框风格
        self.memo.Lines.Add('add a line')  # 添加一行
        self.memo.WantReturns = False  # 按Enter不能回车，但是通过Ctrl+Enter可以回车
        self.memo.Color = clYellow  # 设置颜色为黄色
        self.memo.Font.Name = 'Consolas'  # 设置字体名为Consolas
