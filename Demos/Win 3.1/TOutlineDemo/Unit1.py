import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Outline1 = Outline(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Outline1.OnClick = self.Outline1Click
        self.Button1.OnClick = self.Button1Click

        # 创建 TOutline 控件用于显示层次结构
        self.outline = Outline(self)  # 创建 TOutline 实例
        self.outline.SetBounds(10, 10, 360, 240)  # 设置 TOutline 的位置和大小
        self.outline.Parent = self  # 将 TOutline 设置为窗体的子控件

        # 添加节点到 TOutline
        self.populate_outline()  # 调用方法填充 TOutline 数据

    # 填充 TOutline 的数据
    def populate_outline(self):
        # 清空数据
        self.outline.Clear()

        # 添加数据
        self.outline.Lines.Add("数据行")
        self.outline.Lines.Add("数据行")
        self.outline.Lines.Add("数据行")

    def Button1Click(self, Sender):
        self.Outline1.OutlineStyle = osText

    def Outline1Click(self, Sender):
        ShowMessage(self.Outline1.SelectedItem)