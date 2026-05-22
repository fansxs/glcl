# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button2 = Button(self)
        self.Button1 = Button(self)
        self.Memo2 = Memo(self)
        self.Memo1 = Memo(self)
        self.AiDeepSeekChat1 = AiDeepSeekChat(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.AiDeepSeekChat1.OnReceiveDataEnd = self.AiDeepSeekChat1ReceiveDataEnd
        self.AiDeepSeekChat1.OnReceiveData = self.AiDeepSeekChat1ReceiveData
        self.Button2.OnClick = self.Button2Click
        self.Button1.OnClick = self.Button1Click
        # 也可以直接在对象检查器设置属性
        self.AiDeepSeekChat1.ApiKey = '此处替换为你在DeepSeek API开放平台创建的API Key'

    # 第一种调用方式
    def Button1Click(self, Sender):
        # self.AiDeepSeekChat1.Asynchronous = True  # 也可以指定为异步的
        self.Memo1.Text = self.AiDeepSeekChat1.AddMessageAndRun(self.Memo2.Text, 'user', [])

    # 第二种调用方式
    def Button2Click(self, Sender):
        self.AiDeepSeekChat1.Asynchronous = True    # 必须指定异步输出，也可以直接设置对象检查器中的属性
        msg = self.AiDeepSeekChat1.AddMessage(self.Memo2.Text, 'user')
        self.AiDeepSeekChat1.Run(msg, None)

    # 第二种调用方式，设置事件
    def AiDeepSeekChat1ReceiveData(self, Sender, aMsg, aResponse, aRole, aText):
        try:
            self.Memo1.Lines.BeginUpdate()
            self.Memo1.Text += aText    # Memo文本内容每次加上接收的文本
            self.Memo1.Perform(EM_LINESCROLL, 0, self.Memo1.Lines.Count-1)  # 让Memo文本滚动到最底部一行
        finally:
            self.Memo1.Lines.EndUpdate()
            pass

    # 第二种调用方式，设置事件
    def AiDeepSeekChat1ReceiveDataEnd(self, Sender, aMsg, aResponse, aRole, aText):
        self.Memo1.Lines.Add('')    # 接收数据结束后换行