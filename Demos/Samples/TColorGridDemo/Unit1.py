import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ColorGrid1 = ColorGrid(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ColorGrid1.OnChange = self.ColorGrid1Change

        # 创建一个TColorGrid实例，作为颜色选择网格
        self.color_grid = ColorGrid(self)
        self.color_grid.Parent = self          # 设置其父控件为当前窗体
        self.color_grid.Left = 50              # 设置颜色网格的位置
        self.color_grid.Top = 50               # 设置颜色网格的位置
        self.color_grid.Width = 300             # 设置颜色网格的宽度
        self.color_grid.Height = 200            # 设置颜色网格的高度
        self.color_grid.OnClick = self.color_selected  # 绑定点击事件

        # 显示已选择的颜色标签
        self.selected_color_label = Label(self)
        self.selected_color_label.Parent = self  # 设置其父控件为当前窗体
        self.selected_color_label.Left = 150     # 标签左边位置
        self.selected_color_label.Top = 260       # 标签顶边位置
        self.selected_color_label.Caption = 'Selected Color: None'  # 初始文本

    # 颜色选择处理程序
    def color_selected(self, Sender):
        # 获取当前选中的颜色索引
        index = self.color_grid.ForegroundIndex
        self.Caption = str(index)
        # 将选中的颜色值转为字符串形式并设置给标签的标题
        self.selected_color_label.Caption = Application.ColorToString(self.color_grid.ForegroundColor)

    def ColorGrid1Change(self, Sender):
        ShowMessage(Application.ColorToString(self.ColorGrid1.ForegroundColor))