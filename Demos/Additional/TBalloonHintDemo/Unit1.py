import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.ComboBox1 = ComboBox(self)
        self.Label1 = Label(self)
        self.BalloonHint1 = BalloonHint(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))



