import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.MediaPlayer1 = MediaPlayer(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TMediaPlayer 控件用于播放音频
        self.media_player = MediaPlayer(self)  # 创建 TMediaPlayer 实例
        self.media_player.SetBounds(10, 10, 380, 50)  # 设置 TMediaPlayer 的位置和大小
        self.media_player.Parent = self  # 将 TMediaPlayer 设置为窗体的子控件

        # 创建播放按钮
        self.play_button = Button(self)  # 创建 TButton 实例
        self.play_button.Caption = "播放"  # 设置按钮的显示文本
        self.play_button.SetBounds(10, 70, 80, 30)  # 设置按钮的位置和大小
        self.play_button.OnClick = self.play_media  # 连接按钮点击事件到处理函数
        self.play_button.Parent = self  # 将按钮设置为窗体的子控件

        # 创建停止按钮
        self.stop_button = Button(self)  # 创建另一个 TButton 实例
        self.stop_button.Caption = "停止"  # 设置按钮的显示文本
        self.stop_button.SetBounds(100, 70, 80, 30)  # 设置按钮的位置和大小
        self.stop_button.OnClick = self.stop_media  # 连接按钮点击事件到处理函数
        self.stop_button.Parent = self  # 将按钮设置为窗体的子控件

        # 设置媒体文件路径（请根据实际路径修改）
        self.media_player.FileName = "错位时空 - 艾辰.mp3"  # 设置要播放的音频文件路径

    # 定义播放媒体的处理函数
    def play_media(self, Sender):
        self.media_player.Open()  # 打开媒体文件
        self.media_player.Play()  # 开始播放音频

    # 定义停止媒体的处理函数
    def stop_media(self, Sender):
        self.media_player.Stop()  # 停止播放音频

    def Button1Click(self, Sender):
        # 设置媒体文件路径（请根据实际路径修改）
        self.MediaPlayer1.FileName = "错位时空 - 艾辰.mp3"  # 设置要播放的音频文件路径
        self.MediaPlayer1.Open()  # 打开媒体文件
        self.MediaPlayer1.Play()  # 开始播放音频