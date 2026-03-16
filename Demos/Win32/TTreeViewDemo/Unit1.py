import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ImageList1 = ImageList(self)
        self.TreeView1 = TreeView(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建 TTreeView 控件用于显示树形结构
        self.treeView = TreeView(self)
        self.treeView.SetBounds(10, 10, 380, 250)  # 设置控件的位置和大小
        self.treeView.Parent = self  # 将控件设置为窗体的子控件

        # 添加根节点
        root_node = self.treeView.Items.Add(None, "根节点")  # 添加根节点
        # 添加子节点
        child_node1 = self.treeView.Items.AddChild(root_node, "子节点 1")  # 添加第一个子节点
        child_node2 = self.treeView.Items.AddChild(root_node, "子节点 2")  # 添加第二个子节点

        # 向第一个子节点添加孙子节点
        self.treeView.Items.AddChild(child_node1, "孙子节点 1.1")  # 添加孙子节点
        self.treeView.Items.AddChild(child_node1, "孙子节点 1.2")  # 添加另一个孙子节点

        # 创建按钮用于获取选中节点的信息
        self.btnShowSelected = Button(self)
        self.btnShowSelected.SetBounds(10, 270, 150, 30)  # 设置按钮的位置和大小
        self.btnShowSelected.Caption = "显示选中节点"  # 设置按钮文本
        self.btnShowSelected.OnClick = self.show_selected_node  # 绑定点击事件
        self.btnShowSelected.Parent = self  # 将按钮设置为窗体的子控件

    # 显示选中节点信息的方法
    def show_selected_node(self, Sender):
        selected_node = self.treeView.Selected  # 获取选中的节点
        if selected_node:  # 检查是否有选中节点
            message = f"选中节点: {selected_node.Text}"  # 构建消息字符串
        else:
            message = "没有选中任何节点"  # 如果没有选中节点则提示
        ShowMessage(message)  # 显示消息框