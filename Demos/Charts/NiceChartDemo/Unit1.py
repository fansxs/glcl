import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button3 = Button(self)
        self.CheckBox1 = CheckBox(self)
        self.CheckBox2 = CheckBox(self)
        self.CheckBox3 = CheckBox(self)
        self.CheckBox4 = CheckBox(self)
        self.Label1 = Label(self)
        self.Button1 = Button(self)
        self.Button2 = Button(self)
        # 从pydfm文件加载窗体属性（窗体设计器生成的）
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button3.OnClick = self.Button3Click
        # 绑定控件事件处理方法
        self.Button2.OnClick = self.Button2Click
        self.OnClose = self.FormClose
        self.Button1.OnClick = self.Button1Click
        self.CheckBox4.OnClick = self.CheckBox4Click
        self.CheckBox3.OnClick = self.CheckBox3Click
        self.CheckBox2.OnClick = self.CheckBox2Click
        self.CheckBox1.OnClick = self.CheckBox1Click
        # 动态创建NiceChart，也可以通过窗体设计器放置NiceChart控件并设置属性和事件
        self.Chart = NiceChart(self)
        self.Chart.Parent = self
        self.Chart.Left = 8  # 设置左边距
        self.Chart.Top = 40  # 设置上边距
        self.Chart.Width = self.ClientWidth - 16  # 设置宽度（根据窗体宽度调整）
        self.Chart.Height = self.ClientHeight - 70  # 设置高度（根据窗体高度调整）
        self.Chart.Anchors = ['akLeft', 'akTop', 'akRight', 'akBottom']  # 设置锚点，使图表随窗体大小调整
        self.Chart.Title = 'Look at me!\rI''m a NiceChart!'  # 设置图表标题
        self.Chart.AxisXOnePerValue = True  # X轴每个值显示一个刻度
        self.Chart.ShowXGrid = False  # 不显示X轴网格线
        self.Chart.GridColor = clSilver  # 设置网格线颜色
        self.Chart.TickLength = 6  # 设置刻度线长度
        self.Chart.AxisYScale = 1000  # 设置Y轴比例
        self.Chart.OnMouseMove = self.ChartMouseMove  # 绑定鼠标移动事件

        # 开始批量更新图表（提高性能）
        self.Chart.BeginUpdate()

        # 添加第一个数据系列（柱状图）
        Series = self.Chart.AddSeries(skBar) # skLine=>线条, skSmooth=>平滑曲线, skBar=>柱状
        Series.Caption = 'Revenue'  # 设置系列名称
        # 添加数据点（X值，Y值，标签）
        Series.AddXY(   0,        0, '')
        Series.AddXY(2000,  4904620, '')
        Series.AddXY(2001, 15086420, '')
        Series.AddXY(2002, 14696560, '')
        Series.AddXY(2003, 14263160, '')
        Series.AddXY(2004, 13711080, '')
        Series.AddXY(2005, 13018880, '')
        Series.AddXY(2006, 11901080, '')
        Series.AddXY(2007, 10592340, '')
        Series.AddXY(2008,  9750620, '')
        Series.AddXY(2009,  9007960, '')
        Series.AddXY(2010,  7980940, '')
        Series.AddXY(2011,  6164060, '')
        Series.AddXY(2012,  4182760, '')
        Series.AddXY(2013,  3026420, '')
        Series.AddXY(2014,  1907200, '')

        # 添加第二个数据系列（柱状图）
        Series = self.Chart.AddSeries(skBar)
        Series.Caption = 'Cash Flow'
        Series.AddXY(   0,     -9435276, '')
        Series.AddXY(2000, -12884809.79, '')
        Series.AddXY(2001,   11849628.6, '')
        Series.AddXY(2002,   8676685.24, '')
        Series.AddXY(2003,   3856984.44, '')
        Series.AddXY(2004,   3811447.44, '')
        Series.AddXY(2005,     686684.1, '')
        Series.AddXY(2006,    377060.42, '')
        Series.AddXY(2007,    831488.06, '')
        Series.AddXY(2008,   1517731.99, '')
        Series.AddXY(2009,   1431460.27, '')
        Series.AddXY(2010,   1158463.54, '')
        Series.AddXY(2011,    737914.59, '')
        Series.AddXY(2012,    386103.52, '')
        Series.AddXY(2013,    249675.86, '')
        Series.AddXY(2014,       119973, '')

        # 添加第三个数据系列（平滑曲线）
        Series = self.Chart.AddSeries(skSmooth)
        Series.Caption = 'Cum. Cash Flow'
        Series.AddXY(   0,     -9435276, '')
        Series.AddXY(2000, -22320085.79, '')
        Series.AddXY(2001, -10470457.19, '')
        Series.AddXY(2002,  -1793771.95, '')
        Series.AddXY(2003,   2063212.49, '')
        Series.AddXY(2004,   5874659.93, '')
        Series.AddXY(2005,   6561344.03, '')
        Series.AddXY(2006,   6938404.46, '')
        Series.AddXY(2007,   7769892.52, '')
        Series.AddXY(2008,   9287624.51, '')
        Series.AddXY(2009,  10719084.78, '')
        Series.AddXY(2010,  11877548.32, '')
        Series.AddXY(2011,  12615462.91, '')
        Series.AddXY(2012,  13001566.43, '')
        Series.AddXY(2013,  13251242.29, '')
        Series.AddXY(2014,  13371215.29, '')
        Series.LineWidth = 3    # 设置线宽
        self.Chart.EndUpdate()

        self.Label1.Caption = '123'

    # 图表鼠标移动事件处理
    def ChartMouseMove(self, Sender, Shift, X, Y):
        # 将鼠标坐标转换为图表坐标
        strXY = self.Chart.ClientToChart(X, Y) # 返回值是图表坐标，以竖线分割
        if strXY != '':
            # 解析坐标值并格式化显示
            ax, ay = strXY.split('|')   # 分割坐标值
            self.Label1.Caption = 'Mouse position: {:.2f}'.format(float(ax)) + '; ' + '{:.2f}'.format(float(ay) / 1000)
        else:
            # 鼠标在图表外时显示提示
            self.Label1.Caption = 'Out of Chart'

    # 复选框1点击事件（控制坐标轴线宽）
    def CheckBox1Click(self, Sender):
        if self.Checkbox1.Checked:
            self.Chart.AxisLineWidth = 3
        else:
            self.Chart.AxisLineWidth = 1

    # 复选框2点击事件（控制X轴网格显示）
    def CheckBox2Click(self, Sender):
        self.Chart.ShowXGrid = self.Checkbox2.Checked

    # 复选框3点击事件（控制Y轴网格显示）
    def CheckBox3Click(self, Sender):
        self.Chart.ShowYGrid = self.Checkbox3.Checked

    # 复选框4点击事件（控制X轴线显示）
    def CheckBox4Click(self, Sender):
        self.Chart.ShowXAxisLine = self.Checkbox4.Checked

    # 按钮1点击事件（切换单色/彩色模式）
    def Button1Click(self, Sender):
        self.Chart.Monochrome = not self.Chart.Monochrome
        if self.Chart.Monochrome:
            self.Button1.Caption = 'Color'
        else:
            self.Button1.Caption = 'Monochrome'

    # 窗体关闭事件（释放图表资源）
    def FormClose(self, Sender, Action):
        self.Chart.Free()

    # 按钮2点击事件（保存图表为EMF文件）
    def Button2Click(self, Sender):
        fn = 'test.emf'
        m = self.Chart.CreateMetafile()
        try:
            m.Enhanced = True
            m.SaveToFile(fn)
        finally:
            m.Free()
        ShowMessage('Saved to "' + fn + '".')

    def Button3Click(self, Sender):
        fb = 'test.bmp'
        b = self.Chart.CreateBitmap(self.Chart.Width, self.Chart.Height)
        try:
            b.SaveToFile(fb)
        finally:
            b.Free()
        ShowMessage('Saved to "' + fb + '".')