import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Memo1 = Memo(self)
        self.SearchBox1 = SearchBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.SearchBox1.OnInvokeSearch = self.SearchBox1InvokeSearch

        # 创建一个搜索框，类型为 TSearchBox
        self.search_box = SearchBox(self)
        self.search_box.Parent = self  # 将搜索框设置为窗体的子控件
        self.search_box.Left = 20  # 设置搜索框左边距
        self.search_box.Top = 20  # 设置搜索框上边距
        self.search_box.Width = 300  # 设置搜索框宽度

        # 创建一个按钮，类型为 TButton
        self.button = Button(self)
        self.button.Parent = self  # 将按钮设置为窗体的子控件
        self.button.Left = 20  # 设置按钮左边距
        self.button.Top = 70  # 设置按钮上边距
        self.button.Caption = '搜索'  # 设置按钮标题
        self.button.OnClick = self.on_search_click  # 绑定按钮点击事件

    # 按钮点击事件处理函数
    def on_search_click(self, Sender):
        # 获取搜索框中的文本
        search_text = self.search_box.Text
        # 在控制台输出用户输入的文本
        ShowMessage(f'用户输入的搜索文本: {search_text}')

    def SearchBox1InvokeSearch(self, Sender):
        if self.SearchBox1.Text in self.Memo1.Lines.Text:
            self.Caption = '64位Python'
        else:
            self.Caption = '32位Python'