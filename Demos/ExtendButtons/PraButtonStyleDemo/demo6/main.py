# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
# 导入操作系统模块，用于文件和路径操作
import os
# 从glcl库导入所有组件（这是一个GUI框架）
from glcl import *
# 导入时间模块，用于添加延时效果
import time

class Form13(Form):
    """
    主窗体类，继承自Form基类
    实现了一个图片轮播预览的演示界面
    通过按钮点击来循环显示ImageList中的不同图片
    """

    def __init__(self, owner):
        """
        构造函数，初始化窗体及其所有控件

        参数:
            owner: 窗体的所有者（父窗体）
        """
        # 图像列表控件，用于存储多张图片资源
        # 这些图片已经被预先加载到ImageList中
        self.ImageList1 = ImageList(self)

        # 普通按钮控件，用于触发图片轮播
        self.Button1 = Button(self)

        # 自定义按钮样式控件，用于显示当前选中的图片
        # 这个按钮将作为图片显示区域，通过设置ImageIndexPicture属性来改变显示的图片
        self.PraButtonStyle1 = PraButtonStyle(self)

        # 加载窗体的布局文件（.pydfm格式）
        # 使用__file__获取当前脚本的路径，构建完整的布局文件路径
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "main.pydfm"))

        # 绑定按钮点击事件处理函数
        self.Button1.OnClick = self.Button1Click

    def Button1Click(self, Sender):
        """
        按钮点击事件处理函数
        当点击按钮时，循环遍历ImageList中的所有图片
        并在自定义按钮上依次显示每张图片，实现轮播预览效果

        参数:
            Sender: 触发事件的控件对象（这里是Button1）
        """
        # 遍历ImageList中的所有图片（从索引0到Count-1）
        for i in range(0, self.ImageList1.Count):
            # 设置自定义按钮的图片索引为当前循环的索引值
            # ImageIndexPicture属性决定了按钮上显示ImageList中的哪张图片
            self.PraButtonStyle1.ImageIndexPicture = i

            # 处理所有挂起的Windows消息，确保界面能够及时更新
            # 这对于循环中的界面更新非常重要，否则界面可能会卡住直到循环结束
            Application.ProcessMessages()

            # 暂停0.1秒，制造轮播的间隔效果
            # 这样用户能够看清每张图片，而不是一闪而过
            time.sleep(0.1)