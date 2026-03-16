import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.HotKey1 = HotKey(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建标签用于显示热键的文本
        self.label = Label(self)
        self.label.SetBounds(20, 50, 250, 30)  # 设置标签的位置和大小
        self.label.Caption = "按下热键..."  # 初始化标签文本
        self.label.Parent = self  # 将标签设置为窗体的子控件

        # 创建 THotKey 控件用于设置热键
        self.hotkey = HotKey(self)
        self.hotkey.SetBounds(20, 100, 100, 30)  # 设置 HotKey 控件的位置和大小
        self.hotkey.Parent = self  # 将 HotKey 控件设置为窗体的子控件
        self.hotkey.OnChange = self.hotkey_changed  # 绑定热键变化事件

    # 热键变化时的处理方法
    def hotkey_changed(self, Sender):
        self.Caption = 'hot key changed'