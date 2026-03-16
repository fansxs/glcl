import os
from glcl import *

class Form2(Form):

    def __init__(self, owner):
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit2.pydfm"))

        self.Caption = 'Main Form with TMainMenu'

        # 创建主菜单
        self.MainMenu = MainMenu(self)

        # 创建文件菜单项
        file_menu = MenuItem(self.MainMenu)
        file_menu.Caption = 'File'
        self.MainMenu.Items.Add(file_menu)

        # 创建打开菜单项
        open_item = MenuItem(self.MainMenu)
        open_item.Caption = 'Open'
        open_item.OnClick = self.open_file
        file_menu.Add(open_item)

        # 创建退出菜单项
        exit_item = MenuItem(self.MainMenu)
        exit_item.Caption = 'Exit'
        exit_item.OnClick = self.exit_app
        file_menu.Add(exit_item)

        # 打开文件的事件处理函数
    def open_file(self, Sender):
        ShowMessage('Open menu item clicked')
        ShowMessage('代码方式创建菜单')

    # 退出应用的事件处理函数
    def exit_app(self, Sender):
        Application.Terminate()
