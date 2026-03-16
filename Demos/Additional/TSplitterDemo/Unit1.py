import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.Splitter1 = Splitter(self)
        self.Memo1 = Memo(self)
        self.Panel1 = Panel(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

    def Button1Click(self, Sender):
        self.Memo1.Lines.Add('splitter')