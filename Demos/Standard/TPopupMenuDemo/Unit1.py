import os
from glcl import *
from Unit2 import *

class Form1(Form):

    def __init__(self, owner):
        self.PopupMenu1 = PopupMenu(self)
        self.Button1 = Button(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click
        self.MenuItem5.OnClick = self.MenuItem5Click


    def MenuItem5Click(self, Sender):
        ShowMessage('文件子菜单')

    def Button1Click(self, Sender):
        frm2 = Form2(self)
        frm2.Show()