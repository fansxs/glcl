import os
from glcl import *
import time

class Form1(Form):

    def __init__(self, owner):
        self.Label1 = Label(self)
        self.Button1 = Button(self)
        self.ProgressBar1 = ProgressBar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TProgressBar 控件
        self.progress_bar = ProgressBar(self)
        self.progress_bar.SetBounds(20, 50, 360, 30)  # 设置 ProgressBar 的位置和大小
        self.progress_bar.Min = 0  # 设置最小值
        self.progress_bar.Max = 100  # 设置最大值
        self.progress_bar.Position = 0  # 设置初始位置
        self.progress_bar.Parent = self  # 将 ProgressBar 设置为窗体的子控件

        # 创建一个按钮用于开始进度
        self.start_button = Button(self)
        self.start_button.SetBounds(20, 100, 100, 30)  # 设置按钮的位置和大小
        self.start_button.Caption = "开始"  # 设置按钮文本
        self.start_button.OnClick = self.start_progress  # 绑定点击事件
        self.start_button.Parent = self  # 将按钮设置为窗体的子控件

        # 创建一个标签显示当前进度
        self.label = Label(self)
        self.label.SetBounds(150, 100, 230, 30)  # 设置标签的位置和大小
        self.label.Caption = "进度: 0%"  # 初始化标签文本
        self.label.Parent = self  # 将标签设置为窗体的子控件

    # 开始进度的方法
    def start_progress(self, sender):
        # 在进度条上进行逐步增加进度
        for i in range(self.progress_bar.Min, self.progress_bar.Max + 1):
            self.progress_bar.Position = i  # 设置当前进度
            self.label.Caption = f"进度: {i}%"  # 更新标签显示进度
            Application.ProcessMessages()  # 处理消息以更新界面
            time.sleep(0.05)  # 模拟延迟，增加进度的时间间隔

    def Button1Click(self, Sender):
        # 在进度条上进行逐步增加进度
        for i in range(self.ProgressBar1.Min, self.ProgressBar1.Max + 1):
            self.ProgressBar1.Position = i  # 设置当前进度
            self.Label1.Caption = f"进度: {i}%"  # 更新标签显示进度
            Application.ProcessMessages()  # 处理消息以更新界面
            time.sleep(0.05)  # 模拟延迟，增加进度的时间间隔