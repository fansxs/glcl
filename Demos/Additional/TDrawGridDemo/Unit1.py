import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 创建一个 TDrawGrid 组件
        self.grid = DrawGrid(self)
        self.grid.Parent = self
        self.grid.Align = alClient  # 设置 grid 组件填充整个表单

        # 配置 TDrawGrid
        self.grid.ColCount = 3  # 设置列数
        self.grid.RowCount = 5  # 设置行数
        for i in range(0, 3):
            self.grid.ColWidths[i] = 150  # 设置列宽
        for i in range(0, 5):
            self.grid.RowHeights[i] = 50  # 设置行高
        self.grid.OnDrawCell = self.draw_cell  # 绑定绘制单元格事件

        # 填充一些数据
        self.data = [
            ["Row 1, Col 1", "Row 1, Col 2", "Row 1, Col 3"],
            ["Row 2, Col 1", "Row 2, Col 2", "Row 2, Col 3"],
            ["Row 3, Col 1", "Row 3, Col 2", "Row 3, Col 3"],
            ["Row 4, Col 1", "Row 4, Col 2", "Row 4, Col 3"],
            ["Row 5, Col 1", "Row 5, Col 2", "Row 5, Col 3"],
        ]

    def draw_cell(self, Sender, aCol, aRow, aRect, State):
        """
        自定义绘制单元格
        :param Sender: 发起事件的对象
        :param aCol: 列索引
        :param aRow: 行索引
        :param Rect: 单元格的矩形区域
        :param State: 单元格状态（正常、选中等）
        """
        # 获取 Canvas 对象用于绘制
        canvas = Sender.Canvas

        # 设置背景颜色
        canvas.Brush.Color = clYellow  # 正常状态背景色
        canvas.Font.Color = clRed  # 正常状态字体颜色

        # 强制类型定义，让Python解释器知道类型
        rt = Rect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom)
        # 填充单元格背景
        canvas.FillRect(rt)

        # 绘制文本，居中显示
        text = self.data[aRow][aCol]  # 从数据中获取文本
        text_rect = rt
        canvas.TextRect( text_rect, text_rect.Left, text_rect.Top, text)  # 绘制文本