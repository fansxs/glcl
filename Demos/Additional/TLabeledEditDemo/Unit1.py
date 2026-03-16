import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.LabeledEdit1 = LabeledEdit(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TLabeledEdit 组件
        self.labeledEdit = LabeledEdit(self)
        self.labeledEdit.Parent = self  # 设置父组件为当前表单
        self.labeledEdit.Top = 20  # 设置位置
        self.labeledEdit.Left = 20  # 设置位置
        self.labeledEdit.Width = 250  # 设置编辑框宽度

        # 创建一个按钮用于显示输入的文本
        self.showButton = Button(self)
        self.showButton.Parent = self  # 设置父组件为当前表单
        self.showButton.Caption = 'Show Input'  # 设置按钮文本
        self.showButton.Top = 60  # 设置按钮位置
        self.showButton.Left = 20  # 设置按钮位置
        self.showButton.Width = 200  # 设置按钮宽度
        self.showButton.OnClick = self.show_input  # 绑定点击事件

    def show_input(self, Sender):
        # 按钮点击事件处理函数
        input_text = self.labeledEdit.Text  # 获取输入框中的文本
        ShowMessage(f'You entered: {input_text}')  # 显示输入的文本

    def Button1Click(self, Sender):
        ShowMessage(self.LabeledEdit1.Text)