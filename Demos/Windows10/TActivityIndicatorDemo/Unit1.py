import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button2 = Button(self)
        self.Button1 = Button(self)
        self.ActivityIndicator1 = ActivityIndicator(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button2.OnClick = self.Button2Click
        self.Button1.OnClick = self.Button1Click
        # 可以设置ActivityIndicator的IndicatorType变换不同效果

        # 创建一个 TActivityIndicator 控件
        self.activity_indicator = ActivityIndicator(self)
        self.activity_indicator.Parent = self   # 设置父控件为窗体
        self.activity_indicator.Left = 10       # 设置左边距离
        self.activity_indicator.Top = 10        # 设置顶边距离

        # 启动活动指示器
        self.activity_indicator.Animate = True  # 设置启用动画

        # 添加一个按钮来停止活动指示器
        self.stop_button = Button(self)
        self.stop_button.Parent = self          # 设置父控件为窗体
        self.stop_button.Caption = '停止'       # 设置标题
        self.stop_button.SetBounds(10, 50, 100, 30)     # 设置位置和宽高

        # 为按钮点击事件绑定处理函数
        self.stop_button.OnClick = self.stop_activity_indicator

    # 定义停止活动指示器的函数
    def stop_activity_indicator(self, Sender):
        self.activity_indicator.Animate = False  # 停止活动指示器
        ShowMessage('活动指示器已停止')  # 显示消息框

    def Button1Click(self, Sender):
        self.ActivityIndicator1.Animate = True

    def Button2Click(self, Sender):
        self.ActivityIndicator1.Animate = False