import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button2 = Button(self)
        self.OllamaChat = AiOllamaChat(self)
        self.Button1 = Button(self)
        self.MemoPrompt = Memo(self)
        self.MemoChat = Memo(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button2.OnClick = self.Button2Click
        self.Button1.OnClick = self.Button1Click
        self.OllamaChat.OnReceiveDataEnd = self.OllamaChatReceiveDataEnd
        self.OllamaChat.OnReceiveData = self.OllamaChatReceiveData
        '''
        使用方法：
        1.网页搜索Ollama运行千问大模型，下载Ollama客户端安装并用命令下载合适的千问大模型
        2.退出右下角Ollama客户端，并在控制台(不要用PowerShell)中运行命令set OLLAMA_HOST=0.0.0.0:11434
        3.上述命令是允许全网段访问，然后再运行命令ollama serve启动服务
        4.Ollama服务开启成功后，点击窗体设计器上的AiOllamaChat控件，属性设置Model为当前模型名
        5.如Ollama运行在本机，则Url属性无需修改，如运行在局域网或远程服务器，则ip需修改
        '''

    def UpdateMemo(self, Text):
        try:
            self.MemoChat.Lines.Text += Text
            self.MemoChat.Perform(EM_LINESCROLL, 0, self.MemoChat.Lines.Count-1)
        finally:
            pass

    # 第一种方式，接收数据结束事件
    def OllamaChatReceiveDataEnd(self, Sender, aMsg, aResponse, aRole, aText):
        self.MemoChat.Lines.Add('') # 换行

    # 第一种方式，接收数据事件
    def OllamaChatReceiveData(self, Sender, aMsg, aResponse, aRole, aText):
        try:
            self.MemoChat.Lines.BeginUpdate()   # 用于防止界面闪烁和提高性能
            self.MemoChat.Text += aText
            self.MemoChat.Perform(EM_LINESCROLL, 0, self.MemoChat.Lines.Count-1)  # 让Memo文本滚动到最底部一行
        finally:
            self.MemoChat.Lines.EndUpdate() # 用于防止界面闪烁和提高性能

    # 第一种方式
    def Button1Click(self, Sender):
          self.UpdateMemo('你 : ' + self.MemoPrompt.Text + '\r\n')
          Msg = self.OllamaChat.NewMessage(self.MemoPrompt.Text, 'user')
          Res = self.OllamaChat.Run(Msg, None)

          self.UpdateMemo('AI : ' + Res)
          self.MemoPrompt.Lines.Clear()

    # 第二种方式
    def Button2Click(self, Sender):
        #self.OllamaChat.Asynchronous = False  # 可以是异步也可以是同步
        self.MemoChat.Text = self.OllamaChat.AddMessageAndRun(self.MemoPrompt.Text, 'user', [])