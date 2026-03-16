import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.ValueListEditor1 = ValueListEditor(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TValueListEditor 组件
        self.valueListEditor = ValueListEditor(self)
        self.valueListEditor.Parent = self  # 设置父组件为当前表单
        self.valueListEditor.Left = 10
        self.valueListEditor.Top = 50

        # 添加列名到 TValueListEditor
        self.valueListEditor.Strings.Add('Key1=Value1')  # 添加键值对
        self.valueListEditor.Strings.Add('Key2=Value2')  # 添加另一个键值对

    def Button1Click(self, Sender):
        ShowMessage(self.valueListEditor.Strings.Text)  # 显示所有键值对
        for i in range(1, self.ValueListEditor1.RowCount):  # 从1开始遍历每一行
              # 显示每行键值对的值
            ShowMessage(self.ValueListEditor1.Values[self.ValueListEditor1.Keys[i]])
