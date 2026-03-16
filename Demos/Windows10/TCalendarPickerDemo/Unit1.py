import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.CalendarPicker1 = CalendarPicker(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.CalendarPicker1.OnChange = self.CalendarPicker1Change

    def CalendarPicker1Change(self, Sender):
        self.Caption = self.CalendarPicker1.Date