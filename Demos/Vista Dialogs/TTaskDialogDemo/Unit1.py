import os
from glcl import *
import time

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.TaskDialog1 = TaskDialog(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建一个按钮用于打开任务对话框
        self.button = Button(self)
        self.button.Parent = self               # 设置父控件为当前窗体
        self.button.Caption = 'Show Task Dialog'  # 按钮标题
        self.button.Left = 70                   # 设置按钮的左侧距离
        self.button.Top = 50                    # 设置按钮的顶部距离
        self.button.OnClick = self.show_task_dialog  # 设置按钮点击事件处理程序

    # 任务对话框的处理事件
    def show_task_dialog(self, Sender):
        # 创建任务对话框实例
        task_dialog = TaskDialog(self)

        # 设置任务对话框的属性
        task_dialog.Title = 'Task Dialog Title'                  # 对话框标题
        task_dialog.Text = 'This is a sample task dialog.'     # 对话框内容

        # 添加按钮到任务对话框
        task_dialog.RadioButtons.Add().Caption = 'OK'     # 添加“OK”按钮
        task_dialog.RadioButtons.Add().Caption = 'Abort'  # 添加“Abort”按钮
        task_dialog.RadioButtons.Add().Caption = 'Cancel' # 添加“Cancel”按钮

        # 显示任务对话框并获取用户的选择
        result = task_dialog.Execute()
        for item in task_dialog.RadioButtons.Items:
            if task_dialog.RadioButton == item:
                self.Caption = item.Caption
                break

    def Button1Click(self, Sender):
        if self.TaskDialog1.Execute():
            for i in range(self.TaskDialog1.ProgressBar.Min, self.TaskDialog1.ProgressBar.Max+1):
                self.TaskDialog1.ProgressBar.Position = i
                time.sleep(0.005)
                Application.ProcessMessages()