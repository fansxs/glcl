import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.SaveDialog1 = SaveDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮，用于打开保存对话框
        self.SaveButton = Button(self)
        self.SaveButton.Parent = self   # 设置父控件为窗体
        self.SaveButton.Caption = '保存文件'  # 按钮标题
        self.SaveButton.Left = 150  # 左边距离
        self.SaveButton.Top = 80  # 上边距离
        self.SaveButton.OnClick = self.SaveButtonClick  # 绑定点击事件

    def SaveButtonClick(self, Sender):
        # 创建保存对话框实例
        save_dialog = SaveDialog(self)

        # 设置对话框的一些属性
        save_dialog.Filter = 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*'  # 文件类型过滤器
        save_dialog.DefaultExt = 'txt'  # 默认扩展名

        # 显示对话框并检查用户是否点击“保存”
        if save_dialog.Execute():
            # 获取用户选择的文件名
            file_name = save_dialog.FileName
            # 这里可以添加文件保存的逻辑，例如写入数据到文件
            with open(file_name, 'w') as f:
                f.write('这是一个示例文件内容。')  # 写入示例内容
            ShowMessage(f'文件已保存: {file_name}')  # 提示用户文件已保存

    def Button1Click(self, Sender):
        if self.SaveDialog1.Execute():
            self.Caption = self.SaveDialog1.FileName