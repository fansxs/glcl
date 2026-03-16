import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.FontDialog1 = FontDialog(self)
        self.Button1 = Button(self)
        self.PrinterSetupDialog1 = PrinterSetupDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开打印机设置对话框
        self.setup_button = Button(self)
        self.setup_button.Parent = self     # 设置父控件为窗体
        self.setup_button.Caption = "Printer Setup"  # 设置按钮文本
        self.setup_button.SetBounds(150, 80, 150, 30)  # 设置按钮的位置和大小

        # 为按钮设置点击事件处理程序
        self.setup_button.OnClick = self.open_printer_setup_dialog

    def open_printer_setup_dialog(self, Sender):
        # 创建打印机设置对话框
        printer_setup_dialog = PrinterSetupDialog(self)

        # 显示打印机设置对话框并检查用户是否点击了“确定”
        if printer_setup_dialog.Execute():
            # 用户选择了设置并点击“确定”，可以在这里执行相关逻辑
            Application.PrintText("Printer setup completed with selected settings.", 30, 30, self.FontDialog1.Font)
            # 在弹出的打印机设置对话框中可以设置属性，根据打印的纸张观察效果
            # 这里可以添加更多的逻辑，例如获取打印机信息或设定参数

    def Button1Click(self, Sender):
        if self.PrinterSetupDialog1.Execute():
            Application.PrintText("Printer setup completed with selected settings.", 30, 30, self.FontDialog1.Font)