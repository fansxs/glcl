import os
from glcl import *

class MainForm(Form):

    def __init__(self, owner):
        self.Panel1 = Panel(self)
        self.Splitter1 = Splitter(self)
        self.NiceGrid1 = NiceGrid(self)
        self.NiceGridSync1 = NiceGridSync(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "main.pydfm"))
