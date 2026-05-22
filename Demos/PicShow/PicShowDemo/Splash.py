# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os
from glcl import *
import sys
import random
import time

class SplashForm(Form):

    def __init__(self, owner):
        self.PicShow = PicShow(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Splash.pydfm"))
        self.PicShow.OnProgress = self.PicShowProgress

    def CreateBackground(self):
        '''首先我们将窗体位置设置在桌面中心。
        我们将窗体的Position属性设置为poDesigned，因为我们需要在显示窗体之前获取其位置。'''
        self.Left = (Screen.Width - self.Width) // 2
        self.Top = (Screen.Height - self.Height) // 2
        # 我们创建一个位图对象来存储窗体后面的屏幕内容。
        Background = Bitmap(0, 0)
        try:
            Background.Width = self.Width
            Background.Height = self.Height
            # 我们获取屏幕的设备上下文，并将窗体后面的屏幕内容复制到创建的位图中。
            DC = Application.GetDC(0)
            try:
                Application.BitBlt(Background.Canvas.Handle, 0, 0, self.Width, self.Height, DC, self.Left, self.Top, SRCCOPY)
            finally:
                Application.ReleaseDC(0, DC)
            # 我们将PicShow的Background属性设置为捕获的屏幕图像。
            # 通过这个技巧，窗体看起来是透明的。
            self.PicShow.BgPicture.Bitmap = Background
        finally:
            # 我们不再需要位图对象，因此释放它。
            Background.Free()

    @classmethod
    def Execute(self):
        Result = SplashForm(None)
        if len(sys.argv) == 1:
            # 使PicShow显示为透明的技巧
            Result.CreateBackground()
            # 显示启动窗体。
            Result.Show()
            # 为防止闪烁，立即更新窗体。
            Result.Update()
            # 随机选择一个过渡效果。
            Result.PicShow.Style = random.randint(1, 176)
            # 开始图像过渡。
            # 对于启动窗体，不要将PicShow设置为线程模式。当Threaded为True时，
            # 过渡将在主窗体激活后开始。
            Result.PicShow.Execute()
            # 在继续应用程序其余部分之前等待片刻。
            # 请注意我们没有使用线程模式，否则下面这行代码没有效果。
            time.sleep(0.5)
        return Result

    def PicShowProgress(self, Sender):
        if (self.PicShow.Progress == 100) and not self.PicShow.Reverse:
            # 我们随机选择另一个过渡效果，
            self.PicShow.Style = random.randint(1, 176)
            # 并将过渡继续到其初始状态。
            self.PicShow.Reverse = True
            # 在隐藏图像之前等待两秒钟
            time.sleep(2)