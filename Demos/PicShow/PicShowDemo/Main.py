# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os
from glcl import *
import random
import sys

class MainForm(Form):

    def __init__(self, owner):
        self.PicShow = PicShow(self)
        self.Timer = Timer(self)
        self.StatusBar = StatusBar(self)
        self.PageControl = PageControl(self)
        self.TabSheet1 = TabSheet(self)
        self.TabSheet2 = TabSheet(self)
        self.TabSheet3 = TabSheet(self)
        self.lblStyle = Label(self)
        self.cbStyle = ComboBox(self)
        self.rgStyleControl = RadioGroup(self)
        self.gbProgressControl = GroupBox(self)
        self.rbProgressAuto = RadioButton(self)
        self.rbProgressManual = RadioButton(self)
        self.lblStyleNo = Label(self)
        self.tbProgress = TrackBar(self)
        self.lblProgressStep = Label(self)
        self.lblProgressDelay = Label(self)
        self.edtProgressStep = Edit(self)
        self.udProgressStep = UpDown(self)
        self.edtProgressDelay = Edit(self)
        self.udProgressDelay = UpDown(self)
        self.ckExactTiming = CheckBox(self)
        self.ckThreaded = CheckBox(self)
        self.ckOverDraw = CheckBox(self)
        self.lblDisplayInterval = Label(self)
        self.tbDisplayInterval = TrackBar(self)
        self.gbBackground = GroupBox(self)
        self.lblBackgroundMode = Label(self)
        self.cbBackgroundMode = ComboBox(self)
        self.btnChangeBackground = Button(self)
        self.gbImagePlacement = GroupBox(self)
        self.ckCenter = CheckBox(self)
        self.ckProportional = CheckBox(self)
        self.ckStretch = CheckBox(self)
        self.OpenPictureDialog = OpenPictureDialog(self)
        self.lblDisplayIntervalValue = Label(self)
        self.gbFrame = GroupBox(self)
        self.lblFrameWidth = Label(self)
        self.edtFrameWidth = Edit(self)
        self.udFrameWidth = UpDown(self)
        self.btnChangeFrameColor = Button(self)
        self.ColorDialog = ColorDialog(self)
        self.btnChangePath = Button(self)
        self.Bevel1 = Bevel(self)

        # 从文件加载窗体属性
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Main.pydfm"))

        # 设置事件处理程序
        self.udProgressDelay.OnClick = self.udProgressDelayClick
        self.udProgressStep.OnClick = self.udProgressStepClick
        self.OnCloseQuery = self.FormCloseQuery
        self.tbDisplayInterval.OnChange = self.tbDisplayIntervalChange
        self.ckOverDraw.OnClick = self.ckOverDrawClick
        self.btnChangePath.OnClick = self.btnChangePathClick
        self.btnChangeFrameColor.OnClick = self.btnChangeFrameColorClick
        self.edtFrameWidth.OnChange = self.edtFrameWidthChange
        self.btnChangeBackground.OnClick = self.btnChangeBackgroundClick
        self.cbBackgroundMode.OnChange = self.cbBackgroundModeChange
        self.ckProportional.OnClick = self.ckProportionalClick
        self.ckStretch.OnClick = self.ckStretchClick
        self.ckCenter.OnClick = self.ckCenterClick
        self.PicShow.OnStop = self.PicShowStop
        self.PicShow.OnStart = self.PicShowStart
        self.PicShow.OnProgress = self.PicShowProgress
        self.PicShow.OnDblClick = self.PicShowDblClick
        self.Timer.OnTimer = self.TimerTimer
        self.tbProgress.OnChange = self.tbProgressChange
        self.rbProgressManual.OnClick = self.rbProgressManualClick
        self.ckThreaded.OnClick = self.ckThreadedClick
        self.ckExactTiming.OnClick = self.ckExactTimingClick
        self.rbProgressAuto.OnClick = self.rbProgressAutoClick
        self.cbStyle.OnChange = self.cbStyleChange
        self.OnKeyDown = self.FormKeyDown
        self.OnDestroy = self.FormDestroy

        # 背景模式数组
        self.BackgroundMode = [bmNone, bmTiled, bmStretched, bmCentered]
        # 创建字符串列表用于存储图像文件列表
        self.Pictures = []
        self.PicturesPath = ''
        self.ShowingImage = ''
        self.LoadedImage = ''

        # 根据PicShow的属性更新控件
        self.PicShow.GetStyleNames(self.cbStyle.Items)
        self.cbStyle.ItemIndex = self.PicShow.Style - 1
        self.rbProgressAuto.Checked = not self.PicShow.Manual
        self.rbProgressManual.Checked = self.PicShow.Manual
        self.udProgressStep.Position = self.PicShow.Step
        self.udProgressDelay.Position = self.PicShow.Delay
        self.ckExactTiming.Checked = self.PicShow.ExactTiming
        self.ckThreaded.Checked = self.PicShow.Threaded
        self.tbProgress.Position = self.PicShow.Progress
        self.ckOverDraw.Checked = self.PicShow.OverDraw
        self.ckCenter.Checked = self.PicShow.Center
        self.ckStretch.Checked = self.PicShow.Stretch
        self.ckProportional.Checked = self.PicShow.Proportional
        self.cbBackgroundMode.ItemIndex = self.BackgroundMode.index(self.PicShow.BgMode)
        self.udFrameWidth.Position = self.PicShow.FrameWidth
        self.tbDisplayInterval.Position = self.Timer.Interval

        self.tbProgress.Min = 0
        self.tbProgress.Max =100
        self.tbProgress.Frequency = (100 - 0) // 10

        # 创建图像列表
        self.CreateImageList(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Photos"))
        # 检查照片切换定时器的状态
        self.CheckTimer()

    # 创建在路径中找到的图像文件名列表
    def CreateImageList(self, Path):
        SNoImage = '指定文件夹不包含任何支持的图像文件。'
        if Path != self.PicturesPath:
            FileList = FileListBox(self)
            try:
                FileList.Visible = False
                FileList.Parent = self
                FileList.Directory = Path
                if FileList.Items.Count > 0:
                    for item in FileList.Items:
                        self.Pictures.append(item)
                    self.PicturesPath = Path
                    if (len(Path) > 0) and (self.PicturesPath[len(Path)-1] == '\\'):
                        self.PicturesPath = self.PicturesPath[:len(Path)] + self.PicturesPath[len(Path) + 1:]
                    self.StatusBar.Panels[2].Text = str(len(self.Pictures)) + ' 张图像'
                    self.StatusBar.Panels[3].Text = '文件夹: ' + Path
                    self.LoadNextImage()
                else:
                    Application.MessageDlg(Path + '\r\n' + SNoImage, mtWarning, mbCancel, 0)
            finally:
                FileList.Free()

    # 根据控件状态切换定时器
    def CheckTimer(self):
        self.Timer.Enabled = not self.PicShow.Busy and self.rbProgressAuto.Checked and (len(self.Pictures) > 0)

    def FormDestroy(self, Sender):
        pass

    def FormKeyDown(self, Sender, Key, Shift):
        if (Key == VK_ESCAPE) and (self.PicShow.Align == alNone):
            self.SetFullScreen(False)

    # 激活或取消全屏模式
    def SetFullScreen(self, Active):
        if Active and (self.PicShow.Align == 'alClient'):
            self.PicShow.SetFocus()
            self.PicShow.Align = alNone
            self.PicShow.BgMode = bmNone
            self.PicShow.FrameWidth = 0
            self.PicShow.ShowHint = False
            Application.SetParent(self.PicShow.Handle, 0)
            self.PicShow.SetBounds(0, 0, Screen.Width, Screen.Height)
            Application.SetWindowPos(self.PicShow.Handle, HWND_TOPMOST, 0, 0, Screen.Width, Screen.Height, SWP_SHOWWINDOW)
            Application.ShowCursor(False)
        elif not Active and (self.PicShow.Align == 'alNone'):
            Application.SetParent(self.PicShow.Handle, self.Handle)
            self.PicShow.Align = 'alClient'
            self.PicShow.BgMode = self.cbBackgroundMode.ItemIndex
            self.PicShow.FrameWidth = self.udFrameWidth.Position
            self.PicShow.ShowHint = True
            Application.ShowCursor(True)

    # 从列表中随机选择一张图像并加载到PicShow中
    def LoadNextImage(self):
        self.LoadedImage = ''
        if len(self.Pictures) > 0:
            while True:
                Index = random.randint(0, len(self.Pictures) - 1)
                if len(self.Pictures) <= 1 or self.ShowingImage != self.Pictures[Index]:
                    break
            self.LoadedImage = self.Pictures[Index]
            self.PicShow.Picture.LoadFromFile(self.PicturesPath + '\\' + self.LoadedImage)
        self.StatusBar.Panels[1].Text = '下一张: ' + self.LoadedImage

    def cbStyleChange(self, Sender):
        if self.PicShow.Style != self.cbStyle.ItemIndex + 1:
            self.PicShow.Style = self.cbStyle.ItemIndex + 1
            self.lblStyleNo.Caption = '[ #{} ]'.format(self.PicShow.Style)
            self.lblStyleNo.Update()
            self.cbStyle.Hint = self.PicShow.StyleName

    def rbProgressAutoClick(self, Sender):
        self.PicShow.Manual = False
        self.lblProgressStep.Enabled = not self.PicShow.Manual
        self.edtProgressStep.Enabled = not self.PicShow.Manual
        self.udProgressStep.Enabled = not self.PicShow.Manual
        self.lblProgressDelay.Enabled = not self.PicShow.Manual
        self.edtProgressDelay.Enabled = not self.PicShow.Manual
        self.udProgressDelay.Enabled = not self.PicShow.Manual
        self.ckExactTiming.Enabled = not self.PicShow.Manual
        self.ckThreaded.Enabled = not self.PicShow.Manual
        self.tbProgress.Enabled = self.PicShow.Manual
        self.CheckTimer()

    def ckExactTimingClick(self, Sender):
        self.PicShow.ExactTiming = self.ckExactTiming.Checked

    def ckThreadedClick(self, Sender):
        self.PicShow.Threaded = self.ckThreaded.Checked

    def rbProgressManualClick(self, Sender):
        self.PicShow.Manual = True
        self.lblProgressStep.Enabled = not self.PicShow.Manual
        self.edtProgressStep.Enabled = not self.PicShow.Manual
        self.udProgressStep.Enabled = not self.PicShow.Manual
        self.lblProgressDelay.Enabled = not self.PicShow.Manual
        self.edtProgressDelay.Enabled = not self.PicShow.Manual
        self.udProgressDelay.Enabled = not self.PicShow.Manual
        self.ckExactTiming.Enabled = not self.PicShow.Manual
        self.ckThreaded.Enabled = not self.PicShow.Manual
        self.tbProgress.Enabled = self.PicShow.Manual
        self.tbProgress.PageSize = self.PicShow.Step
        self.tbProgress.Position = self.PicShow.Progress
        self.CheckTimer()
        # 当PicShow处于手动模式时，我们必须首先调用Execute方法。
        # 然后，我们可以更改Progress属性。如果PicShow已经忙，
        # 调用Execute方法不是必需的。
        if not (self.PicShow.Busy or self.PicShow.Empty):
            self.Update()
            self.PicShow.Execute()

    def tbProgressChange(self, Sender):
        if self.PicShow.Manual:
            self.PicShow.Progress = self.tbProgress.Position

    def TimerTimer(self, Sender):
        self.ShowNextImage()

    # 开始当前加载图像的过渡效果
    def ShowNextImage(self):
        self.Timer.Enabled = False
        # 如果列表中没有图片，退出
        if len(self.Pictures) == 0:
            return
        # 如果PicShow正在播放，停止它
        if self.PicShow.Busy:
            self.PicShow.Stop()
        # 根据用户选择设置过渡样式
        if self.rgStyleControl.ItemIndex == 0:
            self.cbStyle.ItemIndex = (self.cbStyle.ItemIndex + 1) % self.cbStyle.Items.Count
        elif self.rgStyleControl.ItemIndex == 1:
            self.cbStyle.ItemIndex = random.randint(0, self.cbStyle.Items.Count-1)
        self.cbStyleChange(None)
        # 更新图像名称状态
        self.ShowingImage = self.LoadedImage
        self.StatusBar.Panels[0].Text = '正在显示: ' + self.ShowingImage
        # 开始过渡效果
        self.PicShow.Execute()

    def PicShowDblClick(self, Sender):
        self.SetFullScreen(self.PicShow.Align != alNone)

    def PicShowProgress(self, Sender):
        self.tbProgress.Position = self.PicShow.Progress

    def PicShowStart(self, Sender, Picture, Screen):
        self.CheckTimer()
        # 当PicShow开始过渡时，我们可以将下一张图像加载到控件中。
        # 这是可能的，因为PicShow将图像转换为位图并在其过程中使用此副本。
        self.LoadNextImage()

    def PicShowStop(self, Sender):
        self.CheckTimer()

    def ckCenterClick(self, Sender):
        self.PicShow.Center = self.ckCenter.Checked

    def ckStretchClick(self, Sender):
        self.PicShow.Stretch = self.ckStretch.Checked

    def ckProportionalClick(self, Sender):
        self.PicShow.Proportional = self.ckProportional.Checked

    def cbBackgroundModeChange(self, Sender):
        self.PicShow.BgMode = self.cbBackgroundMode.ItemIndex

    def btnChangeBackgroundClick(self, Sender):
        if self.OpenPictureDialog.Execute():
            self.PicShow.BgPicture.LoadFromFile(self.OpenPictureDialog.FileName)

    def edtFrameWidthChange(self, Sender):
        self.PicShow.FrameWidth = self.udFrameWidth.Position

    def btnChangeFrameColorClick(self, Sender):
        self.ColorDialog.Color = self.PicShow.FrameColor
        if self.ColorDialog.Execute():
            self.PicShow.FrameColor = self.ColorDialog.Color

    def btnChangePathClick(self, Sender):
        self.Path = self.PicturesPath
        if Application.SelectDirectory('选择幻灯片显示图像文件夹:', ''):
            self.CreateImageList(self.Path)

    def ckOverDrawClick(self, Sender):
        self.PicShow.OverDraw = self.ckOverDraw.Checked

    def tbDisplayIntervalChange(self, Sender):
        self.Timer.Interval = self.tbDisplayInterval.Position
        self.lblDisplayIntervalValue.Caption = '[ {:.1f} 秒 ]'.format(self.Timer.Interval / 1000)

    def FormCloseQuery(self, Sender, CanClose):
        if self.Pictures != None:
            self.Pictures = None

    def udProgressStepClick(self, Sender, Button):
        self.PicShow.Step = self.udProgressStep.Position

    def udProgressDelayClick(self, Sender, Button):
        self.PicShow.Delay = self.udProgressDelay.Position