import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.TabbedNotebook1 = TabbedNotebook(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.TabbedNotebook1.OnClick = self.TabbedNotebook1Click

        # 创建 TTabbedNotebook 控件，注意它和TNotebook一样，客户区是共享的，更推荐使用TPageControl
        self.notebook = TabbedNotebook(self)
        self.notebook.Parent = self

        # 设置 TTabbedNotebook 的大小和位置
        self.notebook.SetBounds(10, 10, 360, 240)

        # 添加标签页
        self.add_tabs()

    def add_tabs(self):
        # 第一个标签页
        self.notebook.Pages.Add("Tab 1")
        label1 = Label(self.notebook)
        label1.Parent = self.notebook
        label1.Caption = "Content of Tab 1"
        label1.SetBounds(20, 20, 200, 30)

        # 第二个标签页
        self.notebook.Pages.Add("Tab 2")
        label2 = Label(self.notebook)
        label2.Parent = self.notebook
        label2.Caption = "Content of Tab 2"
        label2.SetBounds(20, 20, 200, 30)

        # 第三个标签页
        self.notebook.Pages.Add("Tab 3")
        label3 = Label(self.notebook)
        label3.Parent = self.notebook
        label3.Caption = "Content of Tab 3"
        label3.SetBounds(20, 20, 200, 30)

    def TabbedNotebook1Click(self, Sender):
        self.Caption = self.TabbedNotebook1.PageIndex