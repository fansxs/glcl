import os
from glcl import *

class Form1(Form):

    def __init__(self, owner):
        self.Button1 = Button(self)
        self.PaintBox1 = PaintBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        # 创建 TPaintBox 控件用于绘图
        self.paint_box = PaintBox(self)  # 创建 TPaintBox 实例
        self.paint_box.SetBounds(20, 20, 360, 200)  # 设置 TPaintBox 的位置和大小
        self.paint_box.Parent = self  # 将 TPaintBox 设置为窗体的子控件
        self.paint_box.OnPaint = self.on_paint  # 连接绘画事件到处理函数

    # 定义绘画事件处理函数
    def on_paint(self, Sender):
        canvas = self.paint_box.Canvas  # 获取 TPaintBox 的 Canvas 对象
        canvas.Brush.Color = clSkyBlue  # 设置画刷颜色为天蓝色
        # 注意FillRect传参不能直接写self.paint_box.ClientRect
        r = Rect(self.paint_box.ClientRect.Left, self.paint_box.ClientRect.Top,
            self.paint_box.ClientRect.Right, self.paint_box.ClientRect.Bottom)
        canvas.FillRect(r)  # 填充整个 TPaintBox 区域

        # 绘制一个红色矩形
        canvas.Brush.Color = clRed  # 设置画刷颜色为红色
        canvas.Rectangle(50, 50, 150, 150)  # 绘制一个矩形，坐标为 (50, 50) 到 (150, 150)

        # 绘制一个绿色矩形
        canvas.Brush.Color = clGreen  # 设置画刷颜色为绿色
        canvas.Rectangle(200, 50, 300, 150)  # 绘制另一个矩形，坐标为 (200, 50) 到 (300, 150)

    def Button1Click(self, Sender):
        canvas = self.PaintBox1.Canvas  # 获取 TPaintBox 的 Canvas 对象
        canvas.Brush.Color = clRed  # 设置画刷颜色为红色
        canvas.TextOut(10, 10, '文本输出')