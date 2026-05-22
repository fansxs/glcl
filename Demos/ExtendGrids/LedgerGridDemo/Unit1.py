# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.LedgerGrid1 = LedgerGrid(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.LedgerGrid1.OnSelectCell = self.LedgerGrid1SelectCell
        self.LedgerGrid1.OnGetEditText = self.LedgerGrid1GetEditText
        # 此控件使用比较简单，一般用于会计、记账

    def LedgerGrid1GetEditText(self, Sender, ACol, ARow, Value):
        print(Value)

    def LedgerGrid1SelectCell(self, Sender, ACol, ARow, CanSelect):
        print(CanSelect)