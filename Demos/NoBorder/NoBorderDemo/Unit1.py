# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Button2 = Button(self)
        self.Button3 = Button(self)
        self.Panel1 = Panel(self)

        # 从文件加载窗体属性（位置、大小等）
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 绑定事件处理函数
        self.Panel1.OnDblClick = self.Panel1DblClick    # 面板双击事件
        self.Button1.OnClick = self.Button1Click        # 按钮1点击事件
        self.Button3.OnClick = self.Button3Click        # 按钮3点击事件
        self.Button2.OnClick = self.Button2Click        # 按钮2点击事件
        self.Panel1.OnMouseDown = self.Panel1MouseDown  # 面板鼠标按下事件

    def Panel1MouseDown(self, Sender, Button, Shift, X, Y):
        """处理面板鼠标按下事件 - 实现窗体拖动"""
        Application.ReleaseCapture()  # 释放鼠标捕获
        # 发送系统命令，实现窗体拖动（0xF012 对应拖动操作）
        self.Perform(WM_SYSCOMMAND, 0xF012, 0)

    def Button2Click(self, Sender):
        """按钮2点击事件 - 关闭窗体"""
        self.Close()

    def Button3Click(self, Sender):
        """按钮3点击事件 - 最小化窗体"""
        self.WindowState = wsMinimized  # 设置窗体状态为最小化

    def Button1Click(self, Sender):
        """按钮1点击事件 - 切换最大化/正常状态"""
        if self.WindowState == wsMaximized:
            # 如果当前是最大化状态，切换到正常状态
            self.Button1.Caption = 'Maximized'  # 更新按钮文本
            self.WindowState = wsNormal        # 设置为正常状态
        else:
            # 如果当前是正常状态，切换到最大化状态
            self.Button1.Caption = 'Normal'    # 更新按钮文本
            self.WindowState = wsMaximized     # 设置为最大化状态
            self.Height = Screen.WorkAreaHeight  # 设置高度为屏幕工作区高度

    def Panel1DblClick(self, Sender):
        """面板双击事件 - 模拟按钮1点击（切换最大化/正常状态）"""
        self.Button1.Click()  # 触发按钮1的点击事件