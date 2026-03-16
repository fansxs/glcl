import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.StatusBar1 = StatusBar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TStatusBar 控件用于显示状态信息
        self.statusBar = StatusBar(self)
        self.statusBar.SetBounds(0, 150, 400, 30)  # 设置控件的位置和大小
        self.statusBar.Parent = self  # 将控件设置为窗体的子控件

        # 初始化状态栏的面板
        self.init_status_panels()

        # 创建按钮用于更新状态栏文本
        self.btnUpdateStatus = Button(self)
        self.btnUpdateStatus.SetBounds(10, 50, 150, 30)  # 设置按钮的位置和大小
        self.btnUpdateStatus.Caption = "更新状态"  # 设置按钮文本
        self.btnUpdateStatus.OnClick = self.update_status  # 绑定点击事件
        self.btnUpdateStatus.Parent = self  # 将按钮设置为窗体的子控件

    # 初始化状态栏面板的方法
    def init_status_panels(self):
        # 添加多个面板到状态栏
        self.statusBar.Panels.Add()  # 添加第一个面板
        self.statusBar.Panels[0].Text = "面板 1"  # 设置面板文本
        self.statusBar.Panels.Add()  # 添加第二个面板
        self.statusBar.Panels[1].Text = "面板 2"  # 设置第二个面板文本
        self.statusBar.Panels.Add()  # 添加第三个面板
        self.statusBar.Panels[2].Text = "面板 3"  # 设置第三个面板文本

        # 设置面板的宽度（可选）
        self.statusBar.Panels[0].Width = 120
        self.statusBar.Panels[1].Width = 120
        self.statusBar.Panels[2].Width = 120

    # 更新状态栏文本的方法
    def update_status(self, Sender):
        # 更新状态栏面板的文本
        self.statusBar.Panels[0].Text = "更新: 面板 1"
        self.statusBar.Panels[1].Text = "更新: 面板 2"
        self.statusBar.Panels[2].Text = "更新: 面板 3"

    def Button1Click(self, Sender):
        #简单文本显示，需要将SimplePanel设置为True
        self.StatusBar1.SimplePanel = True
        self.StatusBar1.SimpleText = '这是一条状态提示'