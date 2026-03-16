import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ActionList1 = ActionList(self)
        self.Button1 = Button(self)
        self.Taskbar1 = Taskbar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Action3.OnExecute = self.Action3Execute
        self.Action2.OnExecute = self.Action2Execute
        self.Action1.OnExecute = self.Action1Execute
        self.Button1.OnClick = self.Button1Click
        # 设置Taskbar的OverlayIcon属性，会在任务栏主图标上添加一个指定的小图标

    def Button1Click(self, Sender):
        # 设置任务栏图标显示状态
        self.Taskbar1.ProgressMaxValue = 100
        self.Taskbar1.ProgressState = "Error"
        self.Taskbar1.ProgressValue = 70

    def Action1Execute(self, Sender):
        self.Caption = Application.MessageBox('内容', '标题', MB_OK)

    def Action2Execute(self, Sender):
        self.Caption = Application.SelectDirectory('选择目录', 'c:\\')

    def Action3Execute(self, Sender):
        self.Caption = Application.InputBox('输入姓名', '姓名', '张三')