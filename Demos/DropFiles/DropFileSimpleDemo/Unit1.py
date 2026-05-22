import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Memo1 = Memo(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.PJFormDropFiles1.OnDropFiles = self.PJFormDropFiles1DropFiles

    def PJFormDropFiles1DropFiles(self, Sender):
        for i in range(0, self.PJFormDropFiles1.Count):
            self.Memo1.Lines.Add(self.PJFormDropFiles1.Files[i])