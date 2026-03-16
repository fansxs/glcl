import os
from glcl import *

class Form2(Form):

    def __init__(self, owner):
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit2.pydfm"))
