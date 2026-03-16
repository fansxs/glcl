import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Image1 = Image(self)
        self.Button1 = Button(self)
        self.SavePictureDialog1 = SavePictureDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮，点击后打开图片保存对话框
        self.button = Button(self)
        self.button.Parent = self   # 设置父控件为窗体
        self.button.Caption = 'Save Picture'    # 设置标题
        self.button.OnClick = self.save_picture_dialog  # 设置按钮点击事件
        self.button.SetBounds(50, 50, 150, 30)  # 设置按钮位置和大小

    def save_picture_dialog(self, Sender):
        """处理按钮点击事件，打开图片保存对话框"""
        # 创建一个图片保存对话框实例
        dialog = SavePictureDialog(self)

        # 设置对话框的选项，例如文件过滤器
        dialog.Filter = 'BMP Files|*.bmp|JPG File|*.jpg|PNG File|*.png'
        dialog.Title = 'Save an Image'  # 设置对话框标题
        dialog.DefaultExt = '.bmp'  # 设置默认文件名后缀

        # 显示对话框并检查用户是否点击了“确定”
        if dialog.Execute():
            # 获取输入的文件名
            file_name = dialog.FileName

            # 在这里可以将图像保存到选择的文件名
            ShowMessage(f'Saving file as: {file_name}')
            # 例如，可以在这里添加保存图像的代码

    def Button1Click(self, Sender):
        if self.SavePictureDialog1.Execute():
            self.Image1.Picture.Bitmap.SaveToFile(self.SavePictureDialog1.FileName)