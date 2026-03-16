import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button2 = Button(self)
        self.ComboBox5 = ComboBox(self)
        self.ComboBox4 = ComboBox(self)
        self.ComboBox3 = ComboBox(self)
        self.ComboBox2 = ComboBox(self)
        self.CheckBox5 = CheckBox(self)
        self.CheckBox4 = CheckBox(self)
        self.CheckBox3 = CheckBox(self)
        self.CheckBox2 = CheckBox(self)
        self.GroupBox1 = GroupBox(self)
        self.ComboBox1 = ComboBox(self)
        self.RadioButton1 = RadioButton(self)
        self.CheckBox1 = CheckBox(self)
        self.Button1 = Button(self)
        self.Edit1 = Edit(self)
        self.Label1 = Label(self)
        self.Panel1 = Panel(self)
        self.PageControl1 = PageControl(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button2.OnClick = self.Button2Click


    def Button2Click(self, Sender):
        self.PageControl1.TabIndex = 1