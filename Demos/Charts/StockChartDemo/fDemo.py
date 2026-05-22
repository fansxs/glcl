# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os  # 导入操作系统模块，用于文件路径操作
from glcl import *  # 导入glcl框架的所有组件

class frmDemo(Form):  # 定义主窗体类，继承自Form
    '''TStockChart Demo - Stock chart viewer application'''  # 类说明：股票图表查看器应用程序

    def __init__(self, owner):  # 构造函数，初始化窗体
        self.splitter = Splitter(self)  # 分隔条控件
        self.pnlTop = Panel(self)  # 顶部面板
        self.lblStock = Label(self)  # 股票代码标签
        self.lblStatus = Label(self)  # 状态信息标签
        self.edtStock = Edit(self)  # 股票代码输入框
        self.btnLoad = Button(self)  # "加载"按钮
        self.btnZoomIn = Button(self)  # "放大"按钮
        self.btnZoomOut = Button(self)  # "缩小"按钮
        self.btnFirst = Button(self)  # "跳转到第一条"按钮
        self.btnLeft = Button(self)  # "向左滚动"按钮
        self.btnRight = Button(self)  # "向右滚动"按钮
        self.btnLast = Button(self)  # "跳转到最后一条"按钮
        self.pnlLeft = Panel(self)  # 左侧面板
        self.grpDisplay = GroupBox(self)  # "显示选项"分组框
        self.chkMA = CheckBox(self)  # "显示均线"复选框
        self.chkVMA = CheckBox(self)  # "显示成交量均线"复选框
        self.chkDate = CheckBox(self)  # "显示日期刻度"复选框
        self.chkDot = CheckBox(self)  # "显示虚线"复选框
        self.chkHL = CheckBox(self)  # "显示高低价标签"复选框
        self.chkRSI = CheckBox(self)  # "显示RSI面板"复选框
        self.grpMA = GroupBox(self)  # "均线周期设置"分组框
        self.lblMA0 = Label(self)  # 均线0的标签
        self.lblMA1 = Label(self)  # 均线1的标签
        self.lblMA2 = Label(self)  # 均线2的标签
        self.lblMA3 = Label(self)  # 均线3的标签
        self.lblMA4 = Label(self)  # 均线4的标签
        self.lblMA5 = Label(self)  # 均线5的标签
        self.seMA0 = SpinEdit(self)  # 均线0的数值调节控件
        self.seMA1 = SpinEdit(self)  # 均线1的数值调节控件
        self.seMA2 = SpinEdit(self)  # 均线2的数值调节控件
        self.seMA3 = SpinEdit(self)  # 均线3的数值调节控件
        self.seMA4 = SpinEdit(self)  # 均线4的数值调节控件
        self.seMA5 = SpinEdit(self)  # 均线5的数值调节控件
        self.grpRSI = GroupBox(self)  # "RSI周期设置"分组框
        self.lblRSI0 = Label(self)  # RSI0的标签
        self.lblRSI1 = Label(self)  # RSI1的标签
        self.seRSI0 = SpinEdit(self)  # RSI0的数值调节控件
        self.seRSI1 = SpinEdit(self)  # RSI1的数值调节控件
        self.grpColor = GroupBox(self)  # "颜色设置"分组框
        self.btnBgColor = Button(self)  # "背景颜色"按钮
        self.btnUpColor = Button(self)  # "上涨颜色"按钮
        self.btnDnColor = Button(self)  # "下跌颜色"按钮
        self.btnEvColor = Button(self)  # "平盘颜色"按钮
        self.grpLayout = GroupBox(self)  # "布局设置"分组框
        self.lblKRatio = Label(self)  # K线比例标签
        self.lblVRatio = Label(self)  # 成交量比例标签
        self.trkKRatio = TrackBar(self)  # K线比例滑块
        self.trkVRatio = TrackBar(self)  # 成交量比例滑块
        self.grpInfo = GroupBox(self)  # "信息显示"分组框
        self.mmoInfo = Memo(self)  # 信息显示文本框
        self.pnlRight = Panel(self)  # 右侧面板
        self.grpList = GroupBox(self)  # "股票列表"分组框
        self.lstStocks = ListBox(self)  # 股票列表控件
        self.Chart = StockChart(self)  # 核心的股票图表控件
        self.ColorDlg = ColorDialog(self)  # 颜色选择对话框

        # 从.pydfm文件中加载窗体属性（位置、大小、字体等）
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "fDemo.pydfm"))
        # ！！！！！！！！！！！！！！！！！！注意！！！！！！！！！！！！！！！！！！！！！
        # 如果需要打包为EXE，需要在配置exe中附带打包DATA目录
        # ！！！！！！！！！！！！！！！！！！注意！！！！！！！！！！！！！！！！！！！！！

        # 设置事件处理程序 - 首先绑定图表相关的事件
        self.Chart.OnDataIndexChange = self.ChartDataIndexChange  # 绑定数据索引变化事件
        self.Chart.OnStockLoaded = self.ChartStockLoaded  # 绑定股票加载完成事件
        self.Chart.OnStockNotFound = self.ChartStockNotFound  # 绑定股票未找到事件

        # 绑定工具栏按钮事件
        self.btnLoad.OnClick = self.btnLoadClick  # 绑定"加载"按钮点击事件
        self.btnZoomIn.OnClick = self.btnZoomInClick  # 绑定"放大"按钮点击事件
        self.btnZoomOut.OnClick = self.btnZoomOutClick  # 绑定"缩小"按钮点击事件
        self.btnFirst.OnClick = self.btnFirstClick  # 绑定"跳转到第一条"按钮点击事件
        self.btnLast.OnClick = self.btnLastClick  # 绑定"跳转到最后一条"按钮点击事件
        self.btnLeft.OnClick = self.btnLeftClick  # 绑定"向左滚动"按钮点击事件
        self.btnRight.OnClick = self.btnRightClick  # 绑定"向右滚动"按钮点击事件

        # 绑定显示选项复选框事件
        self.chkMA.OnClick = self.chkMAClick  # 绑定"显示均线"复选框点击事件
        self.chkVMA.OnClick = self.chkVMAClick  # 绑定"显示成交量均线"复选框点击事件
        self.chkDate.OnClick = self.chkDateClick  # 绑定"显示日期刻度"复选框点击事件
        self.chkDot.OnClick = self.chkDotClick  # 绑定"显示虚线"复选框点击事件
        self.chkHL.OnClick = self.chkHLClick  # 绑定"显示高低价标签"复选框点击事件
        self.chkRSI.OnClick = self.chkRSIClick  # 绑定"显示RSI面板"复选框点击事件

        # 绑定均线周期数值调节控件事件（使用Tag属性区分不同的控件）
        self.seMA0.Tag = 0  # 设置seMA0的标识为0
        self.seMA1.Tag = 1  # 设置seMA1的标识为1
        self.seMA2.Tag = 2  # 设置seMA2的标识为2
        self.seMA3.Tag = 3  # 设置seMA3的标识为3
        self.seMA4.Tag = 4  # 设置seMA4的标识为4
        self.seMA5.Tag = 5  # 设置seMA5的标识为5
        self.seMA0.OnChange = self.seMAChange  # 绑定seMA0数值变化事件
        self.seMA1.OnChange = self.seMAChange  # 绑定seMA1数值变化事件
        self.seMA2.OnChange = self.seMAChange  # 绑定seMA2数值变化事件
        self.seMA3.OnChange = self.seMAChange  # 绑定seMA3数值变化事件
        self.seMA4.OnChange = self.seMAChange  # 绑定seMA4数值变化事件
        self.seMA5.OnChange = self.seMAChange  # 绑定seMA5数值变化事件

        # 绑定RSI周期数值调节控件事件
        self.seRSI0.Tag = 0  # 设置seRSI0的标识为0
        self.seRSI1.Tag = 1  # 设置seRSI1的标识为1
        self.seRSI0.OnChange = self.seRSIChange  # 绑定seRSI0数值变化事件
        self.seRSI1.OnChange = self.seRSIChange  # 绑定seRSI1数值变化事件

        # 绑定颜色选择按钮事件（使用Tag属性区分不同的按钮）
        self.btnBgColor.Tag = 0  # 设置"背景颜色"按钮标识为0
        self.btnUpColor.Tag = 1  # 设置"上涨颜色"按钮标识为1
        self.btnDnColor.Tag = 2  # 设置"下跌颜色"按钮标识为2
        self.btnEvColor.Tag = 3  # 设置"平盘颜色"按钮标识为3
        self.btnBgColor.OnClick = self.btnColorClick  # 绑定"背景颜色"按钮点击事件
        self.btnUpColor.OnClick = self.btnColorClick  # 绑定"上涨颜色"按钮点击事件
        self.btnDnColor.OnClick = self.btnColorClick  # 绑定"下跌颜色"按钮点击事件
        self.btnEvColor.OnClick = self.btnColorClick  # 绑定"平盘颜色"按钮点击事件

        # 绑定布局滑块事件
        self.trkKRatio.OnChange = self.trkKRatioChange  # 绑定K线比例滑块变化事件
        self.trkVRatio.OnChange = self.trkVRatioChange  # 绑定成交量比例滑块变化事件

        # 绑定股票列表选择事件
        self.lstStocks.OnClick = self.lstStocksClick  # 绑定股票列表点击事件

        # 同步控件状态与图表默认值
        self.SyncControls()  # 将图表的当前属性值同步到所有UI控件上

        # 扫描DATA文件夹获取股票列表
        self.ScanStockList()  # 扫描数据目录，将可用的股票文件添加到列表

        # 如果存在股票，则加载默认股票
        if self.lstStocks.Count > 0:  # 判断股票列表是否不为空
            self.lstStocks.ItemIndex = 0  # 选中列表中的第一项
            self.edtStock.Text = self.lstStocks.Items[0]  # 将股票代码填入输入框
            self.Chart.LoadStock(self.edtStock.Text)  # 加载默认股票数据

    # ---------------------------------------------------------------------------
    # SyncControls  -  将图表属性值同步到UI控件
    # ---------------------------------------------------------------------------
    def SyncControls(self):
        """将图表的当前显示设置同步到对应的控件上"""
        self.chkMA.Checked = self.Chart.ShowMA  # 同步"显示均线"复选框状态
        self.chkVMA.Checked = self.Chart.ShowVolumeMA  # 同步"显示成交量均线"复选框状态
        self.chkDate.Checked = self.Chart.ShowDateScale  # 同步"显示日期刻度"复选框状态
        self.chkDot.Checked = self.Chart.ShowDotLine  # 同步"显示虚线"复选框状态
        self.chkHL.Checked = self.Chart.ShowHighLowLabel  # 同步"显示高低价标签"复选框状态
        self.chkRSI.Checked = self.Chart.ShowRSI  # 同步"显示RSI面板"复选框状态

        self.seMA0.Value = int(self.Chart.GetMACycle(0))  # 同步均线0的周期值
        self.seMA1.Value = int(self.Chart.GetMACycle(1))  # 同步均线1的周期值
        self.seMA2.Value = int(self.Chart.GetMACycle(2))  # 同步均线2的周期值
        self.seMA3.Value = int(self.Chart.GetMACycle(3))  # 同步均线3的周期值
        self.seMA4.Value = int(self.Chart.GetMACycle(4))  # 同步均线4的周期值
        self.seMA5.Value = int(self.Chart.GetMACycle(5))  # 同步均线5的周期值

        self.seRSI0.Value = int(self.Chart.GetRSICycle(0))  # 同步RSI0的周期值
        self.seRSI1.Value = int(self.Chart.GetRSICycle(1))  # 同步RSI1的周期值

        self.trkKRatio.Position = int(float(self.Chart.KLineRatio) * 100)  # 同步K线比例滑块位置（转换为百分比）
        self.trkVRatio.Position = int(float(self.Chart.VolumeRatio) * 100)  # 同步成交量比例滑块位置（转换为百分比）

    # ---------------------------------------------------------------------------
    # ScanStockList  -  从 .\DATA\日K线\*.DAT 填充股票列表
    # ---------------------------------------------------------------------------
    def ScanStockList(self):
        """扫描数据文件目录，将所有.DAT文件添加到股票列表中"""
        self.lstStocks.Clear()  # 清空股票列表
        DataDir = self.Chart.DataPath  # 获取图表控件当前设置的数据路径

        import sys
        if not os.path.isdir(DataDir):  # 如果数据目录不存在
            # 尝试根据可执行文件所在位置定位数据目录
            exe_dir = os.path.dirname(os.path.abspath(__file__))
            DataDir = os.path.join(exe_dir, 'DATA', '日K线') + os.sep  # 拼接为"DATA/日K线/"路径
            self.Chart.DataPath = DataDir  # 更新图表控件的数据路径

        if os.path.isdir(DataDir):  # 如果数据目录存在
            for fname in os.listdir(DataDir):  # 遍历目录下的所有文件
                if fname.upper().endswith('.DAT'):  # 只处理扩展名为.DAT的文件（不区分大小写）
                    name = os.path.splitext(fname)[0]  # 去除扩展名，只保留文件名
                    self.lstStocks.Items.Add(name)  # 将股票名称添加到列表框中

        if self.lstStocks.Count == 0:  # 如果没有找到任何股票数据文件
            self.lstStocks.Items.Add('(no *.DAT found in ' + str(DataDir) + ')')  # 显示提示信息

    # ---------------------------------------------------------------------------
    # 工具栏按钮事件处理方法
    # ---------------------------------------------------------------------------
    def btnLoadClick(self, Sender):
        """加载按钮点击事件 - 根据输入框中的股票代码加载股票数据"""
        stock = self.edtStock.Text.strip()  # 获取输入框中的股票代码并去除前后空格
        if stock != '':  # 如果股票代码不为空
            self.Chart.LoadStock(stock)  # 调用图表控件的LoadStock方法加载数据

    def btnZoomInClick(self, Sender):
        """放大按钮点击事件 - 放大图表显示"""
        self.Chart.ZoomIn()  # 调用图表的放大方法

    def btnZoomOutClick(self, Sender):
        """缩小按钮点击事件 - 缩小图表显示"""
        self.Chart.ZoomOut()  # 调用图表的缩小方法

    def btnFirstClick(self, Sender):
        """跳转到第一条按钮点击事件 - 滚动到数据的第一条"""
        self.Chart.ScrollToFirst()  # 调用图表的滚动到第一条方法

    def btnLastClick(self, Sender):
        """跳转到最后一条按钮点击事件 - 滚动到数据的最后一条"""
        self.Chart.ScrollToLast()  # 调用图表的滚动到最后一条方法

    def btnLeftClick(self, Sender):
        """向左滚动按钮点击事件 - 向左滚动一屏"""
        self.Chart.ScrollLeft(1)  # 调用图表的向左滚动方法

    def btnRightClick(self, Sender):
        """向右滚动按钮点击事件 - 向右滚动一屏"""
        self.Chart.ScrollRight(1)  # 调用图表的向右滚动方法

    # ---------------------------------------------------------------------------
    # 显示选项复选框事件处理方法
    # ---------------------------------------------------------------------------
    def chkMAClick(self, Sender):
        """显示均线复选框点击事件 - 切换均线显示"""
        self.Chart.ShowMA = self.chkMA.Checked  # 将复选框状态设置给图表的ShowMA属性

    def chkVMAClick(self, Sender):
        """显示成交量均线复选框点击事件 - 切换成交量均线显示"""
        self.Chart.ShowVolumeMA = self.chkVMA.Checked  # 将复选框状态设置给图表的ShowVolumeMA属性

    def chkDateClick(self, Sender):
        """显示日期刻度复选框点击事件 - 切换日期刻度显示"""
        self.Chart.ShowDateScale = self.chkDate.Checked  # 将复选框状态设置给图表的ShowDateScale属性

    def chkDotClick(self, Sender):
        """显示虚线复选框点击事件 - 切换虚线显示"""
        self.Chart.ShowDotLine = self.chkDot.Checked  # 将复选框状态设置给图表的ShowDotLine属性

    def chkHLClick(self, Sender):
        """显示高低价标签复选框点击事件 - 切换高低价标签显示"""
        self.Chart.ShowHighLowLabel = self.chkHL.Checked  # 将复选框状态设置给图表的ShowHighLowLabel属性

    def chkRSIClick(self, Sender):
        """显示RSI面板复选框点击事件 - 切换RSI面板显示"""
        self.Chart.ShowRSI = self.chkRSI.Checked  # 将复选框状态设置给图表的ShowRSI属性

    # ---------------------------------------------------------------------------
    # 均线周期数值调节控件事件处理方法
    # ---------------------------------------------------------------------------
    def seMAChange(self, Sender):
        """均线周期数值变化事件 - 根据用户调整更新对应均线的周期值"""
        SE = Sender  # 获取触发事件的SpinEdit控件对象
        self.Chart.SetMACycle(SE.Tag, int(SE.Value))  # 根据Tag标识和当前值设置对应均线的周期

    # ---------------------------------------------------------------------------
    # RSI周期数值调节控件事件处理方法
    # ---------------------------------------------------------------------------
    def seRSIChange(self, Sender):
        """RSI周期数值变化事件 - 根据用户调整更新对应RSI的周期值"""
        SE = Sender  # 获取触发事件的SpinEdit控件对象
        self.Chart.SetRSICycle(SE.Tag, int(SE.Value))  # 根据Tag标识和当前值设置对应RSI的周期

    # ---------------------------------------------------------------------------
    # 颜色选择按钮事件处理方法
    # ---------------------------------------------------------------------------
    def btnColorClick(self, Sender):
        """颜色按钮点击事件 - 打开颜色选择对话框，设置图表的对应颜色"""
        Btn = Sender  # 获取触发事件的按钮对象
        tag = Btn.Tag  # 获取按钮的Tag标识
        if tag == 0:  # 如果Tag为0，表示背景颜色按钮
            self.ColorDlg.Color = self.Chart.BackColor  # 将对话框初始颜色设置为当前背景色
        elif tag == 1:  # 如果Tag为1，表示上涨颜色按钮
            self.ColorDlg.Color = self.Chart.UpColor  # 将对话框初始颜色设置为当前上涨色
        elif tag == 2:  # 如果Tag为2，表示下跌颜色按钮
            self.ColorDlg.Color = self.Chart.DownColor  # 将对话框初始颜色设置为当前下跌色
        elif tag == 3:  # 如果Tag为3，表示平盘颜色按钮
            self.ColorDlg.Color = self.Chart.EvenColor  # 将对话框初始颜色设置为当前平盘色

        if self.ColorDlg.Execute():  # 显示颜色选择对话框，如果用户点击了"确定"
            if tag == 0:  # 背景颜色按钮
                self.Chart.BackColor = self.ColorDlg.Color  # 设置图表的背景颜色
            elif tag == 1:  # 上涨颜色按钮
                self.Chart.UpColor = self.ColorDlg.Color  # 设置图表的上涨颜色
            elif tag == 2:  # 下跌颜色按钮
                self.Chart.DownColor = self.ColorDlg.Color  # 设置图表的下跌颜色
            elif tag == 3:  # 平盘颜色按钮
                self.Chart.EvenColor = self.ColorDlg.Color  # 设置图表的平盘颜色

    # ---------------------------------------------------------------------------
    # 布局滑块事件处理方法
    # ---------------------------------------------------------------------------
    def trkKRatioChange(self, Sender):
        """K线比例滑块变化事件 - 调整K线图在图表中的显示比例"""
        self.Chart.KLineRatio = float(self.trkKRatio.Position) / 100.0  # 将滑块位置值（0-100）转换为比例（0.0-1.0）
        self.lblKRatio.Caption = 'K-Line: %d%%' % self.trkKRatio.Position  # 更新显示K线比例的标签文本

    def trkVRatioChange(self, Sender):
        """成交量比例滑块变化事件 - 调整成交量图在图表中的显示比例"""
        self.Chart.VolumeRatio = float(self.trkVRatio.Position) / 100.0  # 将滑块位置值（0-100）转换为比例（0.0-1.0）
        self.lblVRatio.Caption = 'Volume: %d%%' % self.trkVRatio.Position  # 更新显示成交量比例的标签文本

    # ---------------------------------------------------------------------------
    # 股票列表事件处理方法
    # ---------------------------------------------------------------------------
    def lstStocksClick(self, Sender):
        """股票列表点击事件 - 选中股票后加载其数据到图表"""
        idx = self.lstStocks.ItemIndex  # 获取当前选中项的索引
        if idx >= 0:  # 如果选中了有效项
            Name = self.lstStocks.Items[idx]  # 获取选中的股票名称
            if Name != '' and Name[0] != '(':  # 排除提示信息（以括号开头的文本）
                self.edtStock.Text = Name  # 将股票名称填入输入框
                self.Chart.LoadStock(Name)  # 加载该股票的数据

    # ---------------------------------------------------------------------------
    # 图表事件处理方法
    # ---------------------------------------------------------------------------
    def ChartDataIndexChange(self, Sender, ADataIndex, AData):
        """图表数据索引变化事件 - 当前选中的K线数据发生变化时更新信息面板"""
        self.UpdateInfoPanel(ADataIndex, AData)  # 调用信息面板更新方法

    def ChartStockLoaded(self, Sender, AStockName, ADataCount):
        """股票加载完成事件 - 更新状态栏显示加载成功信息"""
        self.lblStatus.Caption = 'Loaded: %s  (%s bars)' % (AStockName, str(ADataCount))  # 显示股票名称和数据条数
        self.lblStatus.Font.Color = clLime  # 将状态文字颜色设置为亮绿色（表示成功）

    def ChartStockNotFound(self, Sender, AStockName):
        """股票未找到事件 - 更新状态栏显示错误信息"""
        self.lblStatus.Caption = 'NOT FOUND: ' + str(AStockName)  # 显示未找到的股票名称
        self.lblStatus.Font.Color = clRed  # 将状态文字颜色设置为红色（表示错误）
        self.mmoInfo.Lines.Clear()  # 清空信息面板
        self.mmoInfo.Lines.Add('Data file not found for: ' + str(AStockName))  # 添加未找到数据文件的提示
        self.mmoInfo.Lines.Add('Expected path: ' + str(self.Chart.DataPath) + str(AStockName) + '.DAT')  # 显示期望的数据文件路径

    # ---------------------------------------------------------------------------
    # UpdateInfoPanel  -  显示当前K线的OHLCV数据（开盘、最高、最低、收盘、成交量）
    # ---------------------------------------------------------------------------
    def UpdateInfoPanel(self, ADataIndex, AData):
        """更新信息面板 - 显示当前选中的K线数据（索引、日期、开盘价、最高价、最低价、收盘价、成交量）"""
        self.mmoInfo.Lines.BeginUpdate()  # 开始批量更新，提高性能并避免闪烁
        try:
            self.mmoInfo.Lines.Clear()  # 清空信息文本框
            self.mmoInfo.Lines.Add('Index : ' + str(ADataIndex))  # 显示当前数据索引
            if AData is not None and hasattr(AData, 'Date') and AData.Date != 0:  # 如果数据有效且日期不为0
                self.mmoInfo.Lines.Add('Date  : ' + str(AData.Date))  # 显示日期
                self.mmoInfo.Lines.Add('Open  : ' + str(AData.OP))  # 显示开盘价
                self.mmoInfo.Lines.Add('High  : ' + str(AData.HP))  # 显示最高价
                self.mmoInfo.Lines.Add('Low   : ' + str(AData.LP))  # 显示最低价
                self.mmoInfo.Lines.Add('Close : ' + str(AData.CP))  # 显示收盘价
                self.mmoInfo.Lines.Add('Volume: ' + str(AData.VOL))  # 显示成交量
                self.mmoInfo.Lines.Add('')  # 添加空行分隔
                self.mmoInfo.Lines.Add('Total bars: ' + str(self.Chart.GetDataCount()))  # 显示总数据条数
            else:  # 如果没有有效数据
                self.mmoInfo.Lines.Add('(no record)')  # 显示"无记录"提示
        finally:
            self.mmoInfo.Lines.EndUpdate()  # 确保无论是否发生异常都结束批量更新
