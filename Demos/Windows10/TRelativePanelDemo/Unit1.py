import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Label2 = Label(self)
        self.RelativePanel1 = RelativePanel(self)
        self.PageControl1 = PageControl(self)
        self.TabSheet1 = TabSheet(self)
        self.TabSheet2 = TabSheet(self)
        self.TabSheet3 = TabSheet(self)
        self.Label1 = Label(self)
        self.Label3 = Label(self)
        self.Label4 = Label(self)
        self.Label5 = Label(self)
        self.Label6 = Label(self)
        self.Label7 = Label(self)
        self.Label8 = Label(self)
        self.Label9 = Label(self)
        self.Label10 = Label(self)
        self.Label11 = Label(self)
        self.Bevel1 = Bevel(self)
        self.cb1AlignLeftWithPanel = CheckBox(self)
        self.cb1AlignHorizontalCenterWithPanel = CheckBox(self)
        self.cb1AlignRightWithPanel = CheckBox(self)
        self.cb1AlignTopWithPanel = CheckBox(self)
        self.cb1AlignVerticalCenterWithPanel = CheckBox(self)
        self.cb1AlignBottomWithPanel = CheckBox(self)
        self.cbx1LeftOf = ComboBox(self)
        self.cbx1AlignLeftWith = ComboBox(self)
        self.cbx1AlignHorizontalCenterWith = ComboBox(self)
        self.cbx1AlignRightWith = ComboBox(self)
        self.cbx1RightOf = ComboBox(self)
        self.cbx1Above = ComboBox(self)
        self.cbx1AlignTopWith = ComboBox(self)
        self.cbx1AlignVerticalCenterWith = ComboBox(self)
        self.cbx1AlignBottomWith = ComboBox(self)
        self.cbx1Below = ComboBox(self)
        self.Label12 = Label(self)
        self.Label13 = Label(self)
        self.Label14 = Label(self)
        self.Label15 = Label(self)
        self.Label16 = Label(self)
        self.Label17 = Label(self)
        self.Label18 = Label(self)
        self.Label19 = Label(self)
        self.Label20 = Label(self)
        self.Label21 = Label(self)
        self.Bevel2 = Bevel(self)
        self.cb2AlignLeftWithPanel = CheckBox(self)
        self.cb2AlignHorizontalCenterWithPanel = CheckBox(self)
        self.cb2AlignRightWithPanel = CheckBox(self)
        self.cb2AlignTopWithPanel = CheckBox(self)
        self.cb2AlignVerticalCenterWithPanel = CheckBox(self)
        self.cb2AlignBottomWithPanel = CheckBox(self)
        self.cbx2LeftOf = ComboBox(self)
        self.cbx2AlignLeftWith = ComboBox(self)
        self.cbx2AlignHorizontalCenterWith = ComboBox(self)
        self.cbx2AlignRightWith = ComboBox(self)
        self.cbx2RightOf = ComboBox(self)
        self.cbx2Above = ComboBox(self)
        self.cbx2AlignTopWith = ComboBox(self)
        self.cbx2AlignVerticalCenterWith = ComboBox(self)
        self.cbx2AlignBottomWith = ComboBox(self)
        self.cbx2Below = ComboBox(self)
        self.Label22 = Label(self)
        self.Label23 = Label(self)
        self.Label24 = Label(self)
        self.Label25 = Label(self)
        self.Label26 = Label(self)
        self.Label27 = Label(self)
        self.Label28 = Label(self)
        self.Label29 = Label(self)
        self.Label30 = Label(self)
        self.Label31 = Label(self)
        self.Bevel3 = Bevel(self)
        self.cb3AlignLeftWithPanel = CheckBox(self)
        self.cb3AlignHorizontalCenterWithPanel = CheckBox(self)
        self.cb3AlignRightWithPanel = CheckBox(self)
        self.cb3AlignTopWithPanel = CheckBox(self)
        self.cb3AlignVerticalCenterWithPanel = CheckBox(self)
        self.cb3AlignBottomWithPanel = CheckBox(self)
        self.cbx3LeftOf = ComboBox(self)
        self.cbx3AlignLeftWith = ComboBox(self)
        self.cbx3AlignHorizontalCenterWith = ComboBox(self)
        self.cbx3AlignRightWith = ComboBox(self)
        self.cbx3RightOf = ComboBox(self)
        self.cbx3Above = ComboBox(self)
        self.cbx3AlignTopWith = ComboBox(self)
        self.cbx3AlignVerticalCenterWith = ComboBox(self)
        self.cbx3AlignBottomWith = ComboBox(self)
        self.cbx3Below = ComboBox(self)
        self.Edit1 = Edit(self)
        self.Button1 = Button(self)
        self.Shape1 = Shape(self)
        self.Label32 = Label(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # PageControl的标签页1上面相关控件设置事件
        self.cbx1LeftOf.OnChange = self.cbxLeftOfChange
        self.cbx1AlignHorizontalCenterWith.OnChange = self.cbxAlignHorizontalCenterWithChange
        self.cbx1AlignBottomWith.OnChange = self.cbxAlignBottomWithChange
        self.cbx1Above.OnChange = self.cbxAboveChange
        self.cb1AlignVerticalCenterWithPanel.OnClick = self.cbAlignVerticalCenterWithPanelClick
        self.cb1AlignTopWithPanel.OnClick = self.cbAlignTopWithPanelClick
        self.cb1AlignRightWithPanel.OnClick = self.cbAlignRightWithPanelClick
        self.cb1AlignLeftWithPanel.OnClick = self.cbAlignLeftWithPanelClick
        self.cb1AlignHorizontalCenterWithPanel.OnClick = self.cbAlignHorizontalCenterWithPanelClick
        self.cb1AlignBottomWithPanel.OnClick = self.cbAlignBottomWithPanelClick
        # PageControl的标签页2上面相关控件设置事件
        self.cbx2LeftOf.OnChange = self.cbxLeftOfChange
        self.cbx2AlignHorizontalCenterWith.OnChange = self.cbxAlignHorizontalCenterWithChange
        self.cbx2AlignBottomWith.OnChange = self.cbxAlignBottomWithChange
        self.cbx2Above.OnChange = self.cbxAboveChange
        self.cb2AlignVerticalCenterWithPanel.OnClick = self.cbAlignVerticalCenterWithPanelClick
        self.cb2AlignTopWithPanel.OnClick = self.cbAlignTopWithPanelClick
        self.cb2AlignRightWithPanel.OnClick = self.cbAlignRightWithPanelClick
        self.cb2AlignLeftWithPanel.OnClick = self.cbAlignLeftWithPanelClick
        self.cb2AlignHorizontalCenterWithPanel.OnClick = self.cbAlignHorizontalCenterWithPanelClick
        self.cb2AlignBottomWithPanel.OnClick = self.cbAlignBottomWithPanelClick
        # PageControl的标签页3上面相关控件设置事件
        self.cbx3LeftOf.OnChange = self.cbxLeftOfChange
        self.cbx3AlignHorizontalCenterWith.OnChange = self.cbxAlignHorizontalCenterWithChange
        self.cbx3AlignBottomWith.OnChange = self.cbxAlignBottomWithChange
        self.cbx3Above.OnChange = self.cbxAboveChange
        self.cb3AlignVerticalCenterWithPanel.OnClick = self.cbAlignVerticalCenterWithPanelClick
        self.cb3AlignTopWithPanel.OnClick = self.cbAlignTopWithPanelClick
        self.cb3AlignRightWithPanel.OnClick = self.cbAlignRightWithPanelClick
        self.cb3AlignLeftWithPanel.OnClick = self.cbAlignLeftWithPanelClick
        self.cb3AlignHorizontalCenterWithPanel.OnClick = self.cbAlignHorizontalCenterWithPanelClick
        self.cb3AlignBottomWithPanel.OnClick = self.cbAlignBottomWithPanelClick

    # 选择控件的函数，根据当前标签页的页名返回要操作的控件对象
    def SelectedControl(self, aComboBox):
        if aComboBox.Items[aComboBox.ItemIndex] == 'Edit1':
            return self.Edit1
        elif aComboBox.Items[aComboBox.ItemIndex] == 'Button1':
            return self.Button1
        elif aComboBox.Items[aComboBox.ItemIndex] == 'Shape1':
            return self.Shape1

    # 每个要被操作的控件对象的Tag值是不一样的，根据Tag的值确定某个控件调整它的位置属性
    def cbAlignBottomWithPanelClick(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].AlignBottomWithPanel = Sender.Checked

    def cbAlignHorizontalCenterWithPanelClick(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].AlignHorizontalCenterWithPanel = Sender.Checked

    def cbAlignLeftWithPanelClick(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].AlignLeftWithPanel = Sender.Checked

    def cbAlignRightWithPanelClick(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].AlignRightWithPanel = Sender.Checked

    def cbAlignTopWithPanelClick(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].AlignTopWithPanel = Sender.Checked

    def cbAlignVerticalCenterWithPanelClick(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].AlignVerticalCenterWithPanel = Sender.Checked

    def cbxAboveChange(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].Above = self.SelectedControl(Sender)

    def cbxAlignBottomWithChange(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].AlignBottomWith = self.SelectedControl(Sender)

    def cbxAlignHorizontalCenterWithChange(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].AlignHorizontalCenterWith = self.SelectedControl(Sender)

    def cbxLeftOfChange(self, Sender):
        self.RelativePanel1.ControlCollection[Sender.Tag].LeftOf = self.SelectedControl(Sender)