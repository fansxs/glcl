import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.RadioButton2 = RadioButton(self)
        self.RadioButton1 = RadioButton(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        #self.RadioButton2.OnClick = self.RadioButton2Click
        #self.RadioButton1.OnClick = self.RadioButton1Click
        # 也可以手动指定RadioButton1和RadioButton2的OnClick事件
        self.RadioButton2.OnClick = self.radio_button_click
        self.RadioButton1.OnClick = self.radio_button_click

        # 设置窗口的标题
        self.Caption = "TRadioButton 示例"

        # 创建一个单选按钮组
        self.radio_button1 = RadioButton(self)
        self.radio_button2 = RadioButton(self)
        self.radio_button3 = RadioButton(self)

        # 设置第一个单选按钮的位置和大小
        self.radio_button1.Left = 50
        self.radio_button1.Top = 100
        self.radio_button1.Width = 200
        self.radio_button1.Height = 30
        self.radio_button1.Parent = self
        self.radio_button1.Caption = "选项 1"
        self.radio_button1.OnClick = self.radio_button_click

        # 设置第二个单选按钮的位置和大小
        self.radio_button2.Left = 50
        self.radio_button2.Top = 150
        self.radio_button2.Width = 200
        self.radio_button2.Height = 30
        self.radio_button2.Parent = self
        self.radio_button2.Caption = "选项 2"
        self.radio_button2.OnClick = self.radio_button_click

        # 设置第三个单选按钮的位置和大小
        self.radio_button3.Left = 50
        self.radio_button3.Top = 200
        self.radio_button3.Width = 200
        self.radio_button3.Height = 30
        self.radio_button3.Parent = self
        self.radio_button3.Caption = "选项 3"
        self.radio_button3.OnClick = self.radio_button_click

    # 事件处理程序方法
    def radio_button_click(self, Sender):
        if Sender == self.radio_button1:
            ShowMessage("选择了选项 1")
        elif Sender == self.radio_button2:
            ShowMessage("选择了选项 2")
        elif Sender == self.radio_button3:
            ShowMessage("选择了选项 3")
        elif Sender == self.RadioButton1:
            ShowMessage('手动指定的Apple')
        elif Sender == self.RadioButton2:
            ShowMessage('手动指定的Orange')

    def RadioButton1Click(self, Sender):
        ShowMessage('自动生成的Apple')

    def RadioButton2Click(self, Sender):
        ShowMessage('自动生成的Orange')