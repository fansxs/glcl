import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ToolBar1 = ToolBar(self)
        self.ImageList1 = ImageList(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ToolButton3.OnClick = self.ToolButton3Click
        self.ToolButton1.OnClick = self.ToolButton1Click

        # 创建 TToolBar 控件用于放置工具按钮
        self.toolBar = ToolBar(self)
        self.toolBar.SetBounds(0, 0, 400, 30)  # 设置工具栏的位置和大小
        self.toolBar.Parent = self  # 将控件设置为窗体的子控件
        self.toolBar.Images = self.ImageList1 # 设置关联的Images

        # 添加工具按钮到工具栏
        self.add_tool_buttons()

        # 创建状态栏用于显示状态信息
        self.statusBar = StatusBar(self)
        self.statusBar.SetBounds(0, 250, 400, 30)  # 设置状态栏位置和大小
        self.statusBar.Parent = self  # 将状态栏设置为窗体的子控件

    # 添加工具按钮的方法
    def add_tool_buttons(self):
        # 创建并设置一个新的工具按钮
        self.btnHello = ToolButton(self.toolBar)
        self.btnHello.ImageIndex = 0 # 图像下标
        self.btnHello.ShowHint = True # 设置显示提示
        self.btnHello.Hint = '显示文本' # 提示信息
        self.btnHello.OnClick = self.on_hello_click  # 绑定点击事件
        self.btnHello.Parent = self.toolBar  # 将按钮设置为工具栏的子控件

        # 创建并设置另一个工具按钮
        self.btnExit = ToolButton(self.toolBar)
        self.btnExit.ImageIndex = 1 # 图像下标
        self.btnExit.ShowHint = True # 设置显示提示
        self.btnExit.Hint = '退出' # 提示信息
        self.btnExit.OnClick = self.on_exit_click  # 绑定点击事件
        self.btnExit.Parent = self.toolBar  # 将按钮设置为工具栏的子控件

    # 处理“你好”按钮点击事件的方法
    def on_hello_click(self, Sender):
        self.statusBar.SimplePanel = True
        self.statusBar.SimpleText = "你好，欢迎使用 TToolBar 示例!"  # 更新状态栏文本

    # 处理“退出”按钮点击事件的方法
    def on_exit_click(self, Sender):
        Application.Terminate()  # 结束应用程序

    def ToolButton1Click(self, Sender):
        ShowMessage('ToolButton1Click')

    def ToolButton3Click(self, Sender):
        ShowMessage('ToolButton3Click')