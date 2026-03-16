import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button2 = Button(self)
        self.Button1 = Button(self)
        self.Label1 = Label(self)
        self.DirectoryOutline1 = DirectoryOutline(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button2.OnClick = self.Button2Click
        self.Button1.OnClick = self.Button1Click
        self.DirectoryOutline1.OnDblClick = self.DirectoryOutline1DblClick

        # 创建一个标签用于显示当前选择的目录
        self.label = Label(self)
        self.label.Parent = self                       # 设置父控件为当前窗体
        self.label.Left = 10                           # 设置标签的左侧位置
        self.label.Top = 10                            # 设置标签的顶部位置
        self.label.Caption = 'Selected Directory:'      # 标签标题

        # 创建一个TDirectoryOutline控件，用于显示目录结构
        self.directory_outline = DirectoryOutline(self)
        self.directory_outline.Parent = self            # 设置父控件为当前窗体
        self.directory_outline.Left = 50                # 设置左边距离
        self.directory_outline.Top = 50                 # 设置顶部距离
        self.directory_outline.Width = 200              # 设置宽度
        self.directory_outline.Height = 400             # 设置高度
        self.directory_outline.OnChange = self.on_change # 注册变化事件处理程序

        # 设置初始目录（可以根据需要修改）
        self.directory_outline.Directory = 'D:\\'           # 设置根目录为D盘

    # 处理目录变化事件
    def on_change(self, Sender):
        # 更新标签以显示当前选定的目录
        selected_directory = self.directory_outline.Directory
        self.label.Caption = f'Selected Directory: {selected_directory}'

    def DirectoryOutline1DblClick(self, Sender):
        self.Label1.Caption = self.DirectoryOutline1.Directory

    def Button1Click(self, Sender):
        # 全部折叠
        self.DirectoryOutline1.FullCollapse()

    def Button2Click(self, Sender):
        # 全部扩展
        self.DirectoryOutline1.FullExpand()