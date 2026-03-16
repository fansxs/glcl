import os  # 导入os模块，用于处理文件和目录路径
from glcl import *  # 导入glcl模块，假设它包含GUI组件和功能
from Unit2 import *  # 导入Unit2模块，假设它定义了Form2类或其他所需功能

class Form1(Form):
    # Form1类继承自Form类，代表一个窗体或用户界面

    def __init__(self, owner):
        # 初始化Form1类的实例
        self.Button2 = Button(self)  # 创建一个Button2实例，作为Form1的子组件
        self.Button1 = Button(self)  # 创建一个Button1实例，作为Form1的子组件

        # 加载窗体属性，指定路径到Unit1.pydfm文件
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 将Button2的OnClick事件关联到Button2Click方法
        self.Button2.OnClick = self.Button2Click

        # 将Button1的OnClick事件关联到Button1Click方法
        self.Button1.OnClick = self.Button1Click

    def Button1Click(self, Sender):
        # Button1的点击事件处理方法
        frm2 = Form2(self)  # 创建Form2实例，父窗体为当前Form1
        frm2.Show()  # 显示Form2窗体

    def Button2Click(self, Sender):
        # Button2的点击事件处理方法
        myForm = Form(self)  # 创建一个新的Form实例，父窗体为当前Form1
        myForm.Parent = self  # 将新创建的窗体设置为Form1的子窗体
        myForm.Caption = '代码方式创建窗体'  # 设置窗体标题
        myForm.Height = 200  # 设置窗体高度为200
        myForm.Width = 300  # 设置窗体宽度为300
        myForm.Name = 'MyForm'  # 设置窗体名称为"MyForm"
        myForm.BorderStyle = bsDialog  # 设置窗体的边框样式为对话框样式
        myForm.ShowModal()  # 以模态方式显示窗体
        myForm.Free()  # 释放窗体资源
