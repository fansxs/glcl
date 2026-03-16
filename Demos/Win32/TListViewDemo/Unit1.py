import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ListView1 = ListView(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建 TListView 控件用于显示列表
        self.listView = ListView(self)
        self.listView.SetBounds(10, 10, 360, 220)  # 设置控件的位置和大小
        self.listView.Parent = self  # 将控件设置为窗体的子控件

        # 添加示例项到列表
        self.add_item("项目 1", "这是第一个项目的描述")
        self.add_item("项目 2", "这是第二个项目的描述")
        self.add_item("项目 3", "这是第三个项目的描述")

        # 创建按钮用于获取选中项的信息
        self.btnShowSelected = Button(self)
        self.btnShowSelected.SetBounds(10, 240, 150, 30)  # 设置按钮的位置和大小
        self.btnShowSelected.Caption = "显示选中项"  # 设置按钮文本
        self.btnShowSelected.OnClick = self.show_selected_item  # 绑定点击事件
        self.btnShowSelected.Parent = self  # 将按钮设置为窗体的子控件

    # 添加项目的方法
    def add_item(self, name, description):
        item = self.listView.Items.Add()  # 添加新项
        item.Caption = name  # 设置项的标题
        item.SubItems.Add(description)  # 添加子项（描述）

    # 显示选中项信息的方法
    def show_selected_item(self, Sender):
        selected_item = self.listView.Selected  # 获取选中的项
        if selected_item:  # 检查是否有选中项
            message = f"选中项: {selected_item.Caption}\n描述: {selected_item.SubItems[0]}"  # 构建消息字符串
        else:
            message = "没有选中任何项"  # 如果没有选中项则提示
        ShowMessage(message)  # 显示消息框