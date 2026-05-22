# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os
from glcl import *

class Form53(Form):

    def __init__(self, owner):
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "main.pydfm"))
