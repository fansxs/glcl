import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Image1 = Image(self)
        self.OpenPictureDialog1 = OpenPictureDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮，点击后打开图片选择对话框
        self.button = Button(self)
        self.button.Parent = self   # 设置父控件为窗体
        self.button.Caption = 'Open Picture'    # 标题
        self.button.OnClick = self.open_picture_dialog  # 设置按钮点击事件
        self.button.SetBounds(50, 50, 150, 30)  # 设置按钮位置和大小

    def open_picture_dialog(self, Sender):
        # 创建一个图片选择对话框实例
        dialog = OpenPictureDialog(self)

        # 设置对话框的选项，例如文件过滤器
        dialog.Filter = 'Image Files|*.bmp;*.jpg;*.jpeg;*.png;*.gif'
        dialog.Title = 'Select an Image'  # 设置对话框标题

        # 显示对话框并检查用户是否点击了“确定”
        if dialog.Execute():
            # 获取选择的文件名
            file_name = dialog.FileName

            # 在这里可以使用选择的文件名，比如加载图片等
            ShowMessage(f'Selected file: {file_name}')
            # 例如，可以使用 TImage 控件来显示图片，但这里仅打印文件名

    def Button1Click(self, Sender):
        if self.OpenPictureDialog1.Execute():
            self.Image1.Picture.LoadFromFile(self.OpenPictureDialog1.FileName)