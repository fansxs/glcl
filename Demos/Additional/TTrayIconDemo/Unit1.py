import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.PopupMenu1 = PopupMenu(self)
        self.TrayIcon1 = TrayIcon(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        self.TrayIcon1.OnClick = self.TrayIcon1Click
        self.MenuItem3.OnClick = self.MenuItem3Click
        self.MenuItem2.OnClick = self.MenuItem2Click
        self.MenuItem1.OnClick = self.MenuItem1Click
        self.OnCloseQuery = self.FormCloseQuery

    # 在窗口的关闭查询事件当中询问是否最小化
    def FormCloseQuery(self, Sender, CanClose):
        if Application.MessageBox('确认关闭吗？点击是将退出，点击否将最小化到右下角', '确认', MB_YESNO) != IDYES:
            Application.MainFormOnTaskbar = False
            self.Hide()
            raise ValueError("点击右下角图标将再次显示")

    def MenuItem1Click(self, Sender):
        # 在任务栏显示图标
        Application.MainFormOnTaskbar = True
        # 显示窗体
        self.Show()

    def MenuItem2Click(self, Sender):
        # 在任务栏隐藏图标
        #Application.MainFormOnTaskbar = False
        # 隐藏窗体
        self.Hide()

    def MenuItem3Click(self, Sender):
        self.Close()

    def TrayIcon1Click(self, Sender):
        Application.MainFormOnTaskbar = True
        self.Show()

    def Button1Click(self, Sender):
        self.TrayIcon1.BalloonFlags = bfInfo
        self.TrayIcon1.BalloonHint = '这是提示内容'
        self.TrayIcon1.BalloonTitle = '这是提示标题'
        self.TrayIcon1.BalloonTimeout = 5000        # 气泡时间
        # Windows 7 可能无法发挥作用
        self.TrayIcon1.ShowBalloonHint()            # 显示气泡提示