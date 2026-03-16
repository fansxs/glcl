import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ImageList1 = ImageList(self)
        self.ComboBoxEx1 = ComboBoxEx(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ComboBoxEx1.OnSelect = self.ComboBoxEx1Select

        # 创建 TComboBoxEx 控件
        self.comboBoxEx = ComboBoxEx(self)
        self.comboBoxEx.SetBounds(20, 50, 260, 30)  # 设置 TComboBoxEx 的位置和大小
        self.comboBoxEx.Parent = self  # 将 TComboBoxEx 设置为窗体的子控件

        # 添加选项到 TComboBoxEx
        self.populate_combo_box()  # 调用方法添加选项

        # 连接选择变化事件
        self.comboBoxEx.OnChange = self.on_combo_change  # 当选择变化时调用 on_combo_change 方法

    # 填充 TComboBoxEx 的选项
    def populate_combo_box(self):
        options = ["选项 1", "选项 2", "选项 3", "选项 4"]  # 定义选项列表
        for option in options:
            self.comboBoxEx.Items.Add(option)  # 将每个选项添加到 TComboBoxEx

        self.comboBoxEx.ItemIndex = 0  # 设置默认选择第一个选项

    # 处理选项变化事件
    def on_combo_change(self, sender):
        selected_option = self.comboBoxEx.Text  # 获取当前选中的文本
        ShowMessage(f"您选择了: {selected_option}")  # 弹出消息框显示选择的内容

    def ComboBoxEx1Select(self, Sender):
        ShowMessage(self.ComboBoxEx1.Items[self.ComboBoxEx1.ItemIndex])