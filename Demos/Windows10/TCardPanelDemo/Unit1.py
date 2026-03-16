import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.pnlToolbar = Panel(self)
        self.CardPanel1 = CardPanel(self)
        self.ActionList1 = ActionList(self)
        self.actNextCard = Action(self)
        self.actPreviousCard = Action(self)
        self.chkLoop = CheckBox(self)
        self.Button1 = Button(self)
        self.Button2 = Button(self)
        self.lblGestureInfo = Label(self)
        self.Image1 = Image(self)
        self.Image2 = Image(self)
        self.Image3 = Image(self)
        self.Image4 = Image(self)
        self.Image5 = Image(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.chkLoop.OnClick = self.chkLoopClick
        self.actPreviousCard.OnExecute = self.actPreviousCardExecute
        self.actNextCard.OnExecute = self.actNextCardExecute
        self.CardPanel1.ActiveCardIndex = 0

    # 下一张卡片的执行事件
    def actNextCardExecute(self, Sender):
        self.CardPanel1.NextCard()

    # 上一张卡片的执行事件
    def actPreviousCardExecute(self, Sender):
        self.CardPanel1.PreviousCard()

    # 循环复选框的点击事件
    def chkLoopClick(self, Sender):
        # 根据复选框的勾选状态设置卡片面板是否循环
        self.CardPanel1.Loop = self.chkLoop.Checked