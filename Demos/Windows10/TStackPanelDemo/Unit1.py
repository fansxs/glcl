import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Panel1 = Panel(self)
        self.grpOrientation = RadioGroup(self)
        self.Panel2 = Panel(self)
        self.grpControlPositioning = RadioGroup(self)
        self.trkSpacing = TrackBar(self)
        self.lblSpacing = Label(self)
        self.grpPositioning = RadioGroup(self)
        self.lstControls = ListBox(self)
        self.lblPadding = Label(self)
        self.trkPadding = TrackBar(self)
        self.lblControlOverride = Label(self)
        self.StackPanel1 = StackPanel(self)
        self.Label1 = Label(self)
        self.Edit1 = Edit(self)
        self.Button1 = Button(self)
        self.Memo1 = Memo(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.grpPositioning.OnClick = self.grpPositioningClick
        self.grpControlPositioning.OnClick = self.grpControlPositioningClick
        self.grpOrientation.OnClick = self.grpOrientationClick
        self.lstControls.OnClick = self.lstControlsClick
        self.trkPadding.OnChange = self.trkPaddingChange
        self.trkSpacing.OnChange = self.trkSpacingChange

        # 设置默认宽高
        self.DefaultLabel1Width   =  self.Label1.Width
        self.DefaultEdit1Width    =  self.Edit1.Width
        self.DefaultButton1Width  =  self.Button1.Width
        self.DefaultMemo1Width    =  self.Memo1.Width
        self.DefaultLabel1Height  =  self.Label1.Height
        self.DefaultEdit1Height   =  self.Edit1.Height
        self.DefaultButton1Height =  self.Button1.Height
        self.DefaultMemo1Height   =  self.Memo1.Height

        # 设置初始选中
        self.lstControls.ItemIndex = 0
        # 定义方向和位置列表
        self.orientation = [spoVertical, spoHorizontal]
        self.hp = [sphpDefault, sphpLeft, sphpCenter, sphpRight, sphpFill]
        self.vp = [spvpDefault, spvpTop, spvpCenter, spvpBottom, spvpFill]

    # 刻度条间距改变事件
    def trkSpacingChange(self, Sender):
        # 根据刻度条设置间距
        self.StackPanel1.Spacing = self.trkSpacing.Position

    # 刻度条边距改变事件
    def trkPaddingChange(self, Sender):
        # 设置左上右下边距
        P = self.trkPadding.Position
        self.StackPanel1.Padding.SetBounds(P, P, P, P)

    # 列表框点击事件
    def lstControlsClick(self, Sender):
        # 判断当前选中的方向
        if self.StackPanel1.Orientation == spoVertical:
            # 设置单选组合框选中项
            self.grpControlPositioning.ItemIndex = self.hp.index(self.StackPanel1.ControlCollection[self.lstControls.ItemIndex].HorizontalPositioning)
        else:
            self.grpControlPositioning.ItemIndex = self.vp.index(self.StackPanel1.ControlCollection[self.lstControls.ItemIndex].VerticalPositioning)

    # 方向单选组点击事件
    def grpOrientationClick(self, Sender):
        # 设置方向
        self.StackPanel1.Orientation = self.orientation[self.grpOrientation.ItemIndex]
        # 如果是纵向
        if self.StackPanel1.Orientation == spoVertical:
            # 设置相关属性
            self.grpPositioning.Caption = 'Horizontal Positioning'
            self.grpPositioning.Items.Clear()
            self.grpPositioning.Items.Add('sphpLeft')
            self.grpPositioning.Items.Add('sphpCenter')
            self.grpPositioning.Items.Add('sphpRight')
            self.grpPositioning.Items.Add('sphpFill')
            self.grpPositioning.ItemIndex = self.hp.index(self.StackPanel1.HorizontalPositioning) - 1

            self.grpControlPositioning.Items.Clear()
            self.grpControlPositioning.Items.Add('sphpDefault')
            self.grpControlPositioning.Items.Add('sphpLeft')
            self.grpControlPositioning.Items.Add('sphpCenter')
            self.grpControlPositioning.Items.Add('sphpRight')
            self.grpControlPositioning.Items.Add('sphpFill')
            self.grpControlPositioning.ItemIndex = -1
        else:   # 横向
            # 设置相关属性
            self.grpPositioning.Caption = 'Vertical Positioning'
            self.grpPositioning.Items.Clear()
            self.grpPositioning.Items.Add('spvpTop')
            self.grpPositioning.Items.Add('spvpCenter')
            self.grpPositioning.Items.Add('spvpBottom')
            self.grpPositioning.Items.Add('spvpFill')
            self.grpPositioning.ItemIndex = self.vp.index(self.StackPanel1.VerticalPositioning) - 1

            self.grpControlPositioning.Items.Clear()
            self.grpControlPositioning.Items.Add('spvpDefault')
            self.grpControlPositioning.Items.Add('spvpTop')
            self.grpControlPositioning.Items.Add('spvpCenter')
            self.grpControlPositioning.Items.Add('spvpBottom')
            self.grpControlPositioning.Items.Add('spvpFill')
            self.grpControlPositioning.ItemIndex = -1

    # 重置控件属性函数
    def ResetControl(self):
        # 获取并设置控件默认的宽高
        self.Label1.Width  = self.DefaultLabel1Width
        self.Label1.Height = self.DefaultLabel1Height
        self.Edit1.Width   = self.DefaultEdit1Width
        self.Edit1.Height  = self.DefaultEdit1Height
        self.Button1.Width = self.DefaultButton1Width
        self.Button1.Height= self.DefaultButton1Height
        self.Memo1.Width   = self.DefaultMemo1Width
        self.Memo1.Height  = self.DefaultMemo1Height

    # 控件位置单选组点击事件
    def grpControlPositioningClick(self, Sender):
        self.StackPanel1.DisableAlign()
        try:
            self.ResetControl() # Revert width / height of all controls.
            if self.StackPanel1.Orientation == spoVertical:
                self.StackPanel1.ControlCollection[self.lstControls.ItemIndex].HorizontalPositioning = self.hp[self.grpControlPositioning.ItemIndex]
            else:
                self.StackPanel1.ControlCollection[self.lstControls.ItemIndex].VerticalPositioning = self.vp[self.grpControlPositioning.ItemIndex]
        finally:
            self.StackPanel1.EnableAlign() # restart align with new parameter.

    # 位置单选组点击事件
    def grpPositioningClick(self, Sender):
        # 取消对齐
        self.StackPanel1.DisableAlign()
        try:
            # 重置控件宽高
            self.ResetControl()
            # 在位置单选组中没有sphpDefault/spvpDefault。下标+1跳过sphpDefault/spvpDefault
            if self.StackPanel1.Orientation == spoVertical:
                self.StackPanel1.HorizontalPositioning = self.hp[self.grpPositioning.ItemIndex + 1]
            else:
                self.StackPanel1.VerticalPositioning = self.vp[self.grpPositioning.ItemIndex + 1]
        finally:
            # 启用对齐
            self.StackPanel1.EnableAlign()
