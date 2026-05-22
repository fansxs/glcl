# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
# 导入操作系统模块，用于文件和路径操作
import os
# 从glcl库导入所有组件（这是一个GUI框架）
from glcl import *

class Form1(Form):
    """
    主窗体类，继承自Form基类
    实现了一个带有侧边导航菜单的界面
    """

    def __init__(self, owner):
        """
        构造函数，初始化窗体及其所有控件

        参数:
            owner: 窗体的所有者（父窗体）
        """
        # 分割视图控件，用于实现可折叠的侧边菜单
        self.svMenu = SplitView(self)

        # 多个面板容器，用于布局和组织其他控件
        self.Panel1 = Panel(self)    # 主面板1
        self.Panel2 = Panel(self)    # 主面板2
        self.Panel3 = Panel(self)    # 主面板3
        self.Panel4 = Panel(self)    # 主面板4（用于菜单头部）

        # 形状控件，用于装饰或分隔界面元素
        self.Shape2 = Shape(self)
        self.Shape3 = Shape(self)

        # 多个自定义按钮样式控件（具有特殊样式的按钮）
        self.PraButtonStyle1 = PraButtonStyle(self)
        self.PraButtonStyle3 = PraButtonStyle(self)
        self.PraButtonStyle4 = PraButtonStyle(self)
        self.PraButtonStyle2 = PraButtonStyle(self)
        self.PraButtonStyle5 = PraButtonStyle(self)
        self.PraButtonStyle6 = PraButtonStyle(self)
        self.PraButtonStyle7 = PraButtonStyle(self)  # 菜单展开/折叠按钮
        self.PraButtonStyle8 = PraButtonStyle(self)  # 关闭窗体按钮

        # 用于显示图标或背景图
        self.Image1 = Image(self)

        # 用于显示文本
        self.Label1 = Label(self)

        # 加载窗体的布局文件（.pydfm格式）
        # 使用__file__获取当前脚本的路径，构建完整的布局文件路径
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "main.pydfm"))

        # 绑定按钮点击事件
        self.PraButtonStyle7.OnClick = self.PraButtonStyle7Click  # 菜单按钮点击事件
        self.PraButtonStyle8.OnClick = self.PraButtonStyle8Click  # 关闭按钮点击事件

        # 设置窗体的初始位置（左上角坐标）
        self.Left = 0
        self.Top = 0

    def UpdateShowCaption(self, AShowCaption):
        """
        更新侧边菜单中所有按钮的标题显示状态

        参数:
            AShowCaption: 布尔值，True表示显示按钮标题，False表示隐藏
        """
        # 遍历分割视图中的所有控件
        for i in range(0, self.svMenu.ControlCount):
            # 检查控件是否为PraButtonStyle类型（自定义按钮）
            if isinstance(self.svMenu.Controls[i], PraButtonStyle):
                # 设置按钮的标题显示状态
                self.svMenu.Controls[i].ShowCaption = AShowCaption

    def PraButtonStyle8Click(self, Sender):
        """
        关闭按钮点击事件处理函数
        点击时关闭当前窗体

        参数:
            Sender: 触发事件的控件对象
        """
        self.Close()

    def PraButtonStyle7Click(self, Sender):
        """
        菜单按钮点击事件处理函数
        点击时展开或折叠侧边菜单，并调整相关控件的大小和显示状态

        参数:
            Sender: 触发事件的控件对象
        """
        if self.svMenu.Opened:
            # 如果菜单当前是展开状态，则关闭菜单
            self.svMenu.Close()
            # 将菜单容器宽度设置为60（折叠状态）
            self.Panel4.Width = 60
            # 隐藏标签（通常是菜单标题）
            self.Label1.Visible = False
            # 隐藏所有按钮的标题文本
            self.UpdateShowCaption(False)
        else:
            # 如果菜单当前是折叠状态，则展开菜单
            self.svMenu.Open()
            # 将菜单容器宽度设置为204（展开状态）
            self.Panel4.Width = 204
            # 显示标签（通常是菜单标题）
            self.Label1.Visible = True
            # 显示所有按钮的标题文本
            self.UpdateShowCaption(True)