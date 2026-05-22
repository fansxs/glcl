import os
from glcl import *
import random

class MainForm(Form):

    def __init__(self, owner):
        self.NiceGrid1 = NiceGrid(self)
        # 从pydfm文件加载窗体属性（窗体设计器生成的）
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "main.pydfm"))
        # 绑定表格单元格绘制事件
        self.NiceGrid1.OnDrawCell = self.NiceGrid1DrawCell

        # 初始化表格数据（20行5列的随机数）
        for x in range(0, 20):
            self.NiceGrid1.Cells[0, x] = str(random.randint(0, 100))
            self.NiceGrid1.Cells[1, x] = str(random.randint(0, 100))
            self.NiceGrid1.Cells[2, x] = str(random.randint(0, 100))
            self.NiceGrid1.Cells[3, x] = str(random.randint(0, 100))
            self.NiceGrid1.Cells[4, x] = str(random.randint(0, 100))

    # 表格单元格绘制事件处理
    def NiceGrid1DrawCell(self, Sender, ACanvas, X, Y, Rc, Handled):
        """
        参数:
            Sender: 事件发送者
            ACanvas: 画布对象，用于绘制单元格
            X: 列索引
            Y: 行索引
            Rc: 单元格矩形区域
            Handled: 是否已处理标志
        """
        # 获取当前单元格的整数值
        i = int(self.NiceGrid1.Cells[X, Y])
        # 如果是奇数，设置文字颜色为红色
        if i & 1 == 1:
            ACanvas.Font.Color = clRed
        # 如果能被10整除，设置单元格背景为黄色
        if ((i % 10) == 0):
            ACanvas.Brush.Color = clYellow