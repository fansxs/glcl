import os
from glcl import *

class Form2(Form):

    def __init__(self, owner):
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit2.pydfm"))

        # 创建一个 TPopupMenu 对象
        self.PopupMenu2 = PopupMenu(self)

        # 创建菜单项
        self.MenuItem1 = MenuItem(self.PopupMenu2)
        self.MenuItem1.Caption = "Option 1"
        self.MenuItem1.OnClick = self.OnMenuItem1Click

        self.MenuItem2 = MenuItem(self.PopupMenu2)
        self.MenuItem2.Caption = "Option 2"

        self.MenuItem3 = MenuItem(self.PopupMenu2)
        self.MenuItem3.Caption = "Option 3"
        self.MenuItem3.OnClick = self.OnMenuItem3Click

        # 将菜单项添加到 TPopupMenu 中
        self.PopupMenu2.Items.Add(self.MenuItem1)
        self.PopupMenu2.Items.Add(self.MenuItem2)

        # 将二级子菜单MenuItem3添加到MenuItem2
        self.MenuItem2.Add(self.MenuItem3)

        # 将 PopupMenu2 赋值给窗体的 PopupMenu 属性
        self.PopupMenu = self.PopupMenu2

    def OnMenuItem1Click(self, Sender):
        # 处理第一个菜单项点击事件
        ShowMessage("Option 1 clicked")

    def OnMenuItem3Click(self, Sender):
        # 处理第二个菜单项点击事件
        ShowMessage("Option 3 clicked")