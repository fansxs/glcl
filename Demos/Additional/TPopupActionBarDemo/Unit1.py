import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.PopupActionBar1 = PopupActionBar(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.MenuItem5.OnClick = self.MenuItem5Click

    def MenuItem5Click(self, Sender):
        ShowMessage('MenuItem5Click')