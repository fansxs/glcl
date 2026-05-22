import os
from glcl import *
import random

class MainForm(Form):

    def __init__(self, owner):
        self.NiceGrid1 = NiceGrid(self)
        self.CheckBox1 = CheckBox(self)
        self.CheckBox2 = CheckBox(self)
        self.CheckBox3 = CheckBox(self)
        self.CheckBox4 = CheckBox(self)
        self.CheckBox5 = CheckBox(self)
        self.Label1 = Label(self)
        self.Label2 = Label(self)
        self.Button1 = Button(self)
        self.Button2 = Button(self)
        self.Button3 = Button(self)
        self.Button4 = Button(self)
        self.CheckBox6 = CheckBox(self)
        # 从pydfm文件加载窗体属性（窗体设计器生成的）
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "main.pydfm"))
        # 绑定控件事件处理方法
        self.Button4.OnClick = self.Button4Click
        self.Button1.OnClick = self.Button1Click
        self.Button3.OnClick = self.Button3Click
        self.Button2.OnClick = self.Button2Click
        self.CheckBox6.OnClick = self.CheckBox6Click
        self.CheckBox4.OnClick = self.CheckBox4Click
        self.CheckBox5.OnClick = self.CheckBox5Click
        self.CheckBox3.OnClick = self.CheckBox3Click
        self.CheckBox2.OnClick = self.CheckBox2Click
        self.CheckBox1.OnClick = self.CheckBox1Click
        self.NiceGrid1.OnDrawHeader = self.NiceGrid1DrawHeader # 表头绘制事件

        # 开始批量更新表格（提高性能）
        self.NiceGrid1.BeginUpdate()
        # 初始化表格数据（10行示例数据）
        for x in range(0, 10):
            self.NiceGrid1[0, x] = 'Sample Text'    # 第1列：示例文本
            self.NiceGrid1[1, x] = 'Centered Text'  # 第2列：居中文本
            self.NiceGrid1[2, x] = 'Left Alignment' # 第3列：左对齐文本
            self.NiceGrid1[3, x] = '{:,}'.format(random.randint(0, 19999999))   # 第4列：格式化随机数
            self.NiceGrid1[4, x] = str(random.randint(0, 1999)) # 第5列：随机数
        # 结束批量更新
        self.NiceGrid1.EndUpdate()
        # 初始化复选框2状态
        self.CheckBox2Click(None)

    def NiceGrid1DrawHeader(self, Sender, ACanvas, Rc, Str, Handled):
        if (Str == 'One'):
            ACanvas.Font.Color = clRed

    # 复选框1点击事件（控制表格平面样式）
    def CheckBox1Click(self, Sender):
        self.NiceGrid1.Flat = self.CheckBox1.Checked

    # 复选框2点击事件（控制表格标题样式）
    def CheckBox2Click(self, Sender):
        if self.CheckBox2.Checked:
            #self.NiceGrid1.GridColor = clBtnShadow
            self.NiceGrid1.HeaderColor = clBtnFace
            self.NiceGrid1.HeaderDarkColor = clBtnShadow
            self.NiceGrid1.HeaderLightColor = clBtnHighlight
            self.NiceGrid1.HeaderFont.Color = clBlack
            self.NiceGrid1.GutterFont.Color = clBlack
        else:
            #self.NiceGrid1.GridColor = clGray
            self.NiceGrid1.HeaderColor = 0x00DF0000 # 深红色
            self.NiceGrid1.HeaderDarkColor = clBlack    # 黑色
            self.NiceGrid1.HeaderLightColor = 0x00FF8000    # 橙色
            self.NiceGrid1.HeaderFont.Color = clWhite   # 白色
            self.NiceGrid1.GutterFont.Color = clWhite   # 白色

    # 复选框3点击事件（控制表格自动适应宽度）
    def CheckBox3Click(self, Sender):
        self.NiceGrid1.FitToWidth = self.CheckBox3.Checked

    # 复选框5点击事件（控制网格线显示）
    def CheckBox5Click(self, Sender):
        self.NiceGrid1.ShowGrid = self.CheckBox5.Checked

    # 复选框4点击事件（控制自动列宽）
    def CheckBox4Click(self, Sender):
        self.NiceGrid1.AutoColWidth = self.CheckBox4.Checked

    # 复选框6点击事件（控制页脚显示）
    def CheckBox6Click(self, Sender):
        self.NiceGrid1.ShowFooter = not self.NiceGrid1.ShowFooter

    # 按钮2点击事件（在当前行插入新行）
    def Button2Click(self, Sender):
        self.NiceGrid1.InsertRow(self.NiceGrid1.Row)

    # 按钮3点击事件（删除当前行）
    def Button3Click(self, Sender):
        self.NiceGrid1.DeleteRow(self.NiceGrid1.Row)

    # 按钮1点击事件（切换第3列可见性）
    def Button1Click(self, Sender):
        self.NiceGrid1.Columns[2].Visible = not self.NiceGrid1.Columns[2].Visible

    # 按钮4点击事件（切换第3列只读状态）
    def Button4Click(self, Sender):
        self.NiceGrid1.Columns[2].ReadOnly = not self.NiceGrid1.Columns[2].ReadOnly