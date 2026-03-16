import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ImageList1 = ImageList(self)
        self.Button1 = Button(self)
        self.ButtonedEdit1 = ButtonedEdit(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TButtonedEdit 组件
        self.buttonedEdit = ButtonedEdit(self)
        self.buttonedEdit.Parent = self  # 设置父控件为当前表单
        self.buttonedEdit.Top = 20  # 设置位置
        self.buttonedEdit.Left = 20  # 设置位置
        self.buttonedEdit.Width = 250  # 设置编辑框宽度
        self.buttonedEdit.Images = self.ImageList1  # 设置关联的图片列表组件
        self.buttonedEdit.LeftButton.ImageIndex = 0  # 设置图片索引下标
        self.buttonedEdit.LeftButton.Visible = True  # 设置可见
        self.buttonedEdit.RightButton.ImageIndex = 1
        self.buttonedEdit.RightButton.Visible = True

        # 创建一个按钮用于显示输入的文本
        self.showButton = Button(self)
        self.showButton.Parent = self  # 设置父控件为当前表单
        self.showButton.Caption = 'Show Input'  # 设置按钮文本
        self.showButton.Top = 60  # 设置按钮位置
        self.showButton.Left = 20  # 设置按钮位置
        self.showButton.Width = 200  # 设置按钮宽度
        self.showButton.OnClick = self.show_input  # 绑定点击事件

    def show_input(self, Sender):
        # 按钮点击事件处理函数
        input_text = self.buttonedEdit.Text  # 获取输入框中的文本
        ShowMessage(f'You entered: {input_text}')  # 显示输入的文本

    def Button1Click(self, Sender):
        ShowMessage(self.ButtonedEdit1.Text)