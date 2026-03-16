import os
from glcl import *
import sys

class Form1(Form):

    def __init__(self, owner):
        self.pnlToolbar = Panel(self)
        self.grpDisplayMode = RadioGroup(self)
        self.grpPlacement = RadioGroup(self)
        self.pnlSettings = Panel(self)
        self.grpCloseStyle = RadioGroup(self)
        self.chkUseAnimation = CheckBox(self)
        self.SV = SplitView(self)
        self.catMenuItems = CategoryButtons(self)
        self.lstLog = ListBox(self)
        self.imlIcons = ImageList(self)
        self.imgMenu = Image(self)
        self.cbxVclStyles = ComboBox(self)
        self.grpAnimation = GroupBox(self)
        self.lblLog = Label(self)
        self.lblAnimationDelay = Label(self)
        self.lblAnimationStep = Label(self)
        self.trkAnimationDelay = TrackBar(self)
        self.trkAnimationStep = TrackBar(self)
        self.ActionList1 = ActionList(self)
        self.actHome = Action(self)
        self.actLayout = Action(self)
        self.actPower = Action(self)
        self.chkCloseOnMenuClick = CheckBox(self)
        self.lblTitle = Label(self)
        self.lblVclStyle = Label(self)
        self.SplitView1 = SplitView(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.SV.OnOpening = self.SVOpening
        self.SV.OnOpened = self.SVOpened
        self.SV.OnClosed = self.SVClosed
        self.actPower.OnExecute = self.actPowerExecute
        self.actLayout.OnExecute = self.actLayoutExecute
        self.actHome.OnExecute = self.actHomeExecute
        self.trkAnimationStep.OnChange = self.trkAnimationStepChange
        self.trkAnimationDelay.OnChange = self.trkAnimationDelayChange
        self.cbxVclStyles.OnChange = self.cbxVclStylesChange
        self.chkUseAnimation.OnClick = self.chkUseAnimationClick
        self.grpCloseStyle.OnClick = self.grpCloseStyleClick
        self.grpPlacement.OnClick = self.grpPlacementClick
        self.grpDisplayMode.OnClick = self.grpDisplayModeClick
        self.imgMenu.OnClick = self.imgMenuClick
        # 在窗体设计器的工程管理器右键弹出菜单->配置exe弹出的配置EXE文件窗口中，
        # 文件路径下方右键弹出菜单，点击Append将工程目录下的三个vsf皮肤文件添加保存
        # 这样部署为EXE后，皮肤文件会一起打包

        # 定义风格管理器对象
        self.sm = StyleManager(self)
        for i in range(0, 3):
            filename = os.path.join(os.path.split(sys.argv[0])[0], self.cbxVclStyles.Items[i] + '.vsf')
            # 加载工程目录下的风格文件
            self.sm.LoadFromFile(filename)

    # 左上角图片点击事件
    def imgMenuClick(self, Sender):
        # 如果SV是打开的则关闭
        if self.SV.Opened:
            self.SV.Close()
        else:   # 是关闭状态则打开
            self.SV.Open()

    # 显示模式点击事件
    def grpDisplayModeClick(self, Sender):
        # 如果当前选中的是Docked则设置SV的显示模式为svmDocked
        if self.grpDisplayMode.ItemIndex == 0:
            self.SV.DisplayMode = svmDocked
        else:   # 否则设置显示模式为svmOverlay
            self.SV.DisplayMode = svmOverlay

    # 放置位置点击事件
    def grpPlacementClick(self, Sender):
        # 如果当前选中的是左边则设置SV的放置位置为左边
        if self.grpPlacement.ItemIndex == 0:
            self.SV.Placement = svpLeft
        else:   # 否则设置SV的放置位置为右边
            self.SV.Placement = svpRight

    # 关闭风格点击事件
    def grpCloseStyleClick(self, Sender):
        # 如果当前选中的是收缩则设置SV的关闭风格为收缩
        if self.grpCloseStyle.ItemIndex == 0:
            self.SV.CloseStyle = svcCollapse
        else:   # 否则设置SV的关闭风格为袖珍
            self.SV.CloseStyle = svcCompact

    # 使用动画点击事件
    def chkUseAnimationClick(self, Sender):
        # 根据当前复选框是否选中设置SV的使用动画属性
        self.SV.UseAnimation = self.chkUseAnimation.Checked
        # 根据SV的使用动画属性来设置启用或禁用刻度条和标签
        self.lblAnimationDelay.Enabled = self.SV.UseAnimation
        self.trkAnimationDelay.Enabled = self.SV.UseAnimation
        self.lblAnimationStep.Enabled = self.SV.UseAnimation
        self.trkAnimationStep.Enabled = self.SV.UseAnimation

    # 复合框的改变事件
    def cbxVclStylesChange(self, Sender):
        # 设置风格
        self.sm.SetStyle(self.cbxVclStyles.Text)

    # 延时刻度条改变事件
    def trkAnimationDelayChange(self, Sender):
        # 根据延时刻度条的位置*5值设置SV的动画延时
        self.SV.AnimationDelay = self.trkAnimationDelay.Position * 5
        self.lblAnimationDelay.Caption = 'Animation Delay (' + str(self.SV.AnimationDelay) + ')'

    # 步进刻度条改变事件
    def trkAnimationStepChange(self, Sender):
        # 根据步进刻度条的位置*5值设置SV的动画步进
        self.SV.AnimationStep = self.trkAnimationStep.Position * 5
        self.lblAnimationStep.Caption = 'Animation Step (' + str(self.SV.AnimationStep) + ')'

    # Home的执行动作事件
    def actHomeExecute(self, Sender):
        self.Log(self.actHome.Caption + ' Clicked')
        if self.SV.Opened and self.chkCloseOnMenuClick.Checked:
            self.SV.Close()

    # Layout的执行动作事件
    def actLayoutExecute(self, Sender):
        self.Log(self.actLayout.Caption + ' Clicked')
        if self.SV.Opened and self.chkCloseOnMenuClick.Checked:
            self.SV.Close()

    # Power的执行动作事件
    def actPowerExecute(self, Sender):
        self.Log(self.actPower.Caption + ' Clicked')
        if self.SV.Opened and self.chkCloseOnMenuClick.Checked:
            self.SV.Close()

    # 打印日志函数
    def Log(self, Msg):
        Idx = self.lstLog.Items.Add(Msg)
        self.lstLog.TopIndex = Idx

    # SV的关闭事件
    def SVClosed(self, Sender):
        # 当TSplitView是关闭的，调整ButtonOptions和宽度
        self.catMenuItems.ButtonOptions.remove(boShowCaptions)
        if self.SV.CloseStyle == svcCompact:
            self.catMenuItems.Width = self.SV.CompactWidth

    # SV的打开事件
    def SVOpened(self, Sender):
        # 当未处在动画中，当TSplitView是打开时改变catMenuItems的大小
        self.catMenuItems.ButtonOptions.append(boShowCaptions)
        self.catMenuItems.Width = self.SV.OpenedWidth

    # SV的正在打开事件
    def SVOpening(self, Sender):
        # 当处于动画时，在开始打开时改变catMenuItems的大小
        self.catMenuItems.ButtonOptions.append(boShowCaptions)
        self.catMenuItems.Width = self.SV.OpenedWidth