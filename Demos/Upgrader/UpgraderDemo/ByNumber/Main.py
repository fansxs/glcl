# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
'''
功能：用于通过Http更新软件

特性：
1、阻塞模式更新
2、具备比较完备的进度控制
3、与autoupgrader组件相比，相对更简单些，但autoupgrader必须要求具备GUI，而这个组件则不需要。
4、具有自动回滚功能。如停止下载或下载失败都会执行回滚操作。
5、可将文件方便地下载到指定目录而不必须都下载到同一目录中。

组件属性：
UpdateInfoURL：更新信息文件的URL地址
VersionPattern：版本控制模式
    vpByNumber:采用数字作为版本号，采用此模式，VersionAsNumber有效
    vpByDateTime:采用日期作为版本号，采用此模式，VersionAsDateTime有效

组件事务：
OnProgress：进度控制
OnFileBegin：文件下载前
OnFileEnd：文件下载后

更新信息文件格式：
[version]
Pattern=1  //VersionPattern (0表示采用vpByDateTime, 1表示采用vpByNumber)
Version=2  //版本号，如果Pattern为0，则这里采用数字，否则使用日期字符串，如:2007-08-03 12:00:00

//下面是文件列表，格式为：本地路径=下载地址
//.表示当前目录，..表示上级目录，跟DOS下的表示是一样的。
[files]
../test/NBServer.exe=http://192.168.1.2:19130/nbmanager/NBServer.exe
./test/blacklist.sys=http://192.168.1.2:19130/nbmanager/blacklist.sys
test/client.exe=http://192.168.1.2:19130/nbmanager/bak/client.exe
config.ini=http://192.168.1.2:19130/nbmanager/config.ini
zend/1.exe=http://192.168.1.2:19130/nbmanager/test/1.exe
zend/2.exe=http://192.168.1.2:19130/nbmanager/test/2.exe
zend/3.exe=http://192.168.1.2:19130/nbmanager/test/3.exe

配置文件中的本地路径可以使用目录变量，如
%Windows%\setup.exe=http://192.168.1.2:19130/setup.exe
即表示将http://192.168.1.2:19130/setup.exe下载到本地的Windows目录下，并改名为setup.exe

可用的目录变量如下：
%Windows%
%System%
%Temp%
%Desktop%
%Programs%
%Personal%
%Startup%
%Recent%
%SendTo%
%StartMenu%
%DesktopDirectory%
%NetHood%
%Fonts%
%Templates%
%Common_StartMenu%
%Common_Programs%
%Common_Startup%
%Common_DesktopDirectory%
%AppData%
%PrintHood%
%Common_Favorites%
%Internet_Cache%
%Cookies%
%History%

使用相关说明，请参看update.inf和Demo（压缩包中的update.inf只是范本，只有放到Http服务器上才会生效）
注：新程序的版本号一定要大于旧程序的版本才会更新
'''

import os
from glcl import *

class frmMain(Form):

    def __init__(self, owner):
        self.ProgressBar1 = ProgressBar(self)
        self.ProgressBar2 = ProgressBar(self)
        self.Memo1 = Memo(self)
        self.Label1 = Label(self)
        self.btnStart = Button(self)
        self.btnPause = Button(self)
        self.btnResume = Button(self)
        self.btnStop = Button(self)
        self.Upgrader1 = Upgrader(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Main.pydfm"))
        self.Upgrader1.OnFileEnd = self.Upgrader1FileEnd
        self.Upgrader1.OnProgress = self.Upgrader1Progress
        self.Upgrader1.OnFileBegin = self.Upgrader1FileBegin
        self.btnStop.OnClick = self.btnStopClick
        self.btnResume.OnClick = self.btnResumeClick
        self.btnPause.OnClick = self.btnPauseClick
        self.btnStart.OnClick = self.btnStartClick
        ''' 这个实例演示的是使用版本号的方式。如果你设置的版本号是一个
        比用户端版本还更小的数，是不会更新的。
        '''

    def btnStartClick(self, Sender):
        if self.Upgrader1.Check(None):      # 检查更新
            self.Upgrader1.Start(None)      # 开始更新
        else:                               # 当前是最新版
            self.Caption = '已经是最新的版本'

    def btnPauseClick(self, Sender):
        self.Upgrader1.Pause()              # 暂停更新

    def btnResumeClick(self, Sender):
        self.Upgrader1.Resume()             # 继续更新

    def btnStopClick(self, Sender):
        self.Upgrader1.Stop()               # 停止更新

    def Upgrader1FileBegin(self, url, localfile, Size):     # 更新开始事件
        self.Memo1.Lines.Add(url + '===>' + localfile)

    def GetTimeString(self, Time) -> str:                   # 计算时间的函数
        if Time >= 3600:
            return '%d小时%2d分钟%2d秒钟'.format((Time // 3600), ((Time % 3600) // 60), (Time % 60))
        else:
            if Time >= 60:
                return '%2d分钟%2d秒钟'.format((Tme // 60), (Time % 60))
            else:
                return str(Time) + '秒钟'

    def Upgrader1Progress(self, ProgressEx, ulStatusCode, szStatusText):        # 更新进度事件
        if ProgressEx.Single.TotalSize != 0:        # 一开始时未获取到单文件大小，需要排除这种情况
            self.Label1.Caption = str(ProgressEx.Single.FinishedSize)           # 下载完成的大小
            self.ProgressBar1.Position = round((ProgressEx.Single.FinishedSize / ProgressEx.Single.TotalSize) * 100)    # 计算单文件进度
        if ProgressEx.General.TotalSize != 0:       # 一开始时未获取到总文件大小，需要排除这种情
            self.ProgressBar2.Position = round((ProgressEx.General.FinishedSize / ProgressEx.General.TotalSize) * 100)  # 计算总文件进度
        self.Label1.Caption = '文件个数：' + str(ProgressEx.FileCount)                         # 文件个数

    def Upgrader1FileEnd(self, url, localfile, Size):
        self.Memo1.Lines.Add('传输完成:'  + localfile)
