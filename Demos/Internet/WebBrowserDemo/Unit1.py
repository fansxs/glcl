import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        # WebBrowser目前还不能通过窗体设计器创建，需要通过代码的方式创建实例
        self.WebBrowser1 = WebBrowser(self)
        # 指定此属性，如果目标计算机的Edge引擎可用将优先使用Edge引擎，前提是必须附带
        # 打包工程目录下的的WebView2Loader.dll文件，目标计算机也必须有安装WebView2，
        # 可在微软官方下载。
        self.WebBrowser1.SelectedEngine = EdgeIfAvailable
        self.WebBrowser1.ParentWindow = self.Handle     # 父窗口句柄，必须指定这个属性
        self.WebBrowser1.Width = 1500   # 设置宽度
        self.WebBrowser1.Height = 800   # 设置高度
        self.WebBrowser1.Left = 10      # 设置左边距离
        self.WebBrowser1.Top = 10       # 设置顶部距离
        self.WebBrowser1.Silent = True  # 安静模式
        self.WebBrowser1.Show()

    def Button1Click(self, Sender):
        # 访问网页，此网页可检测当前是IE内核还是Chromium内核
        self.WebBrowser1.Navigate('https://www.ip138.com')
        # 部署为exe后，如果附带打包了WebView2Loader.dll并且目标计算机有安装WebView2
        # 那么方位该网页无弹窗提示，否则会弹窗提示“请升级使用Chrome内核浏览器”