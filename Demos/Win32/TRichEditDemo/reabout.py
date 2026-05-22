import os
from glcl import *

class AboutBox(Form):

    def __init__(self, owner):
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "reabout.pydfm"))
