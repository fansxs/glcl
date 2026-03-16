import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):  # 构造函数，接收一个参数 owner
        self.ListBox1 = ListBox(self)
        self.PopupMenu1 = PopupMenu(self)
        self.MainMenu1 = MainMenu(self)
        self.ActionList1 = ActionList(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        # 注意：动作是选中ActionList然后右键弹出菜单选择Action List Editor创建
        self.actClear.OnExecute = self.actClearExecute  # 绑定清空动作的执行方法
        self.actDelete.OnExecute = self.actDeleteExecute  # 绑定删除动作的执行方法
        self.actAdd.OnExecute = self.actAddExecute  # 绑定添加动作的执行方法

    def actAddExecute(self, Sender):  # 添加水果的执行方法
        newFruit = Application.InputBox('请输入水果名', '水果', '')  # 弹出输入框请求水果名
        self.ListBox1.Items.Add(newFruit)  # 将输入的水果名添加到列表框中

    def actDeleteExecute(self, Sender):  # 删除水果的执行方法
        selIndex = self.ListBox1.ItemIndex  # 获取选中的列表项索引
        if selIndex != -1:  # 如果有选中项
            self.ListBox1.Items.Delete(selIndex)  # 从列表中删除选中的项
        else:  # 如果没有选中项
            Application.MessageBox('当前未选中水果', '提示', MB_ICONINFORMATION)  # 显示提示信息

    def actClearExecute(self, Sender):  # 清空列表的执行方法
        self.ListBox1.Clear()  # 清空列表框中的所有项