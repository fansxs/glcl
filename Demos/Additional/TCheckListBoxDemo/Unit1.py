import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.CheckListBox1 = CheckListBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        self.CheckListBox1.OnClickCheck = self.CheckListBox1ClickCheck

        # 创建 TCheckListBox 组件
        self.check_list_box = CheckListBox(self)
        self.check_list_box.Parent = self  # 设置父控件为当前窗体
        self.check_list_box.Left = 30  # 设置左边距30
        self.check_list_box.Top = 30  # 设置顶边距30

        # 向 TCheckListBox 添加项目
        self.check_list_box.Items.Add("选项 1")
        self.check_list_box.Items.Add("选项 2")
        self.check_list_box.Items.Add("选项 3")
        self.check_list_box.Items.Add("选项 4")

        # 创建一个按钮用于显示选中项
        self.button = Button(self)
        self.button.Parent = self  # 设置父控件为当前窗体
        self.button.Width = 150  # 设置宽度为150
        self.button.Left = 30  # 设置左边距30
        self.button.Top = 200  # 设置顶边距200
        self.button.Caption = "显示选中的项"
        self.button.OnClick = self.show_selected_items  # 绑定按钮点击事件

    def show_selected_items(self, Sender):
        # 获取选中的项
        selected_items = [self.check_list_box.Items[i] for i in range(self.check_list_box.Count) if self.check_list_box.Checked[i]]

        # 使用消息框显示选中的项
        if selected_items:
            ShowMessage("选中的项:\n" + "\n".join(selected_items))
        else:
            ShowMessage("没有选中的项")

    def CheckListBox1ClickCheck(self, Sender):
        ShowMessage(self.CheckListBox1.ItemIndex)

    def Button1Click(self, Sender):
        # 获取选中的项
        selected_items = [self.CheckListBox1.Items[i] for i in range(self.CheckListBox1.Count) if self.CheckListBox1.Checked[i]]

        # 使用消息框显示选中的项
        if selected_items:
            ShowMessage("选中的项:\n" + "\n".join(selected_items))
        else:
            ShowMessage("没有选中的项")