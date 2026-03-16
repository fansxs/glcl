import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.FontDialog1 = FontDialog(self)
        self.PrintDialog1 = PrintDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开打印对话框
        self.print_button = Button(self)
        self.print_button.Parent = self     # 设置父控件为窗体
        self.print_button.Caption = "Print"  # 设置按钮文本
        self.print_button.SetBounds(150, 80, 100, 30)  # 设置按钮的位置和大小

        # 为按钮设置点击事件处理程序
        self.print_button.OnClick = self.open_print_dialog

    def open_print_dialog(self, Sender):
        # 创建打印对话框
        print_dialog = PrintDialog(self)

        # 显示打印对话框并检查用户是否点击了“确定”
        if print_dialog.Execute():
            # 用户选择了打印机并点击“确定”，可以在这里执行打印操作
            # 例如，打印一条消息
            Application.PrintText("Print job started with selected settings.", 10, 10, self.FontDialog1.Font)

            # 这里可以添加更多的打印逻辑，例如：
            # 使用指定的打印机和设置来发送实际的文档进行打印

    def Button1Click(self, Sender):
        # Bitmap构造函数的两个参数，宽和高，可以写0，因为是从文件加载
        bitmap = Bitmap(0, 0)
        # 目前打印的图像格式只能是bmp
        bitmap.LoadFromFile('1.bmp')
        # 第4个参数 缩放比例 从1到100，1打印的图像最大，100打印的图像最小
        Application.PrintImage(bitmap, 50, 50, 1)