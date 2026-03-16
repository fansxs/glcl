import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.JumpList1 = JumpList(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # 设置AutoRefresh属性为True，并设置TaskList属性
        # TaskList属性编辑器可以指定每一个TJumpListItem的Path和Icon
        # Path可以是一个可执行程序的路径
        # 右键任务栏图标，在弹出框中可以看到任务列表，是添加的TJumpListItem
        # 点击每个TJumpListItem会打开相应Path指向的可执行程序
