# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
# 导入操作系统模块，用于文件和路径操作
import os
# 从glcl库导入所有组件（这是一个GUI框架）
from glcl import *

class Form1(Form):
    """
    主窗体类，继承自Form基类
    实现了一个用于演示按钮样式设置和控制的界面
    包含复选框、下拉框和自定义按钮，用于动态调整按钮的外观
    """

    def __init__(self, owner):
        """
        构造函数，初始化窗体及其所有控件

        参数:
            owner: 窗体的所有者（父窗体）
        """
        # 两个复选框控件，用于控制按钮的状态
        self.CheckBox1 = CheckBox(self)  # 用于控制按钮的轮廓样式
        self.CheckBox2 = CheckBox(self)  # 用于控制按钮的启用/禁用状态

        # 两个下拉框控件，用于选择按钮的样式
        self.ComboBox1 = ComboBox(self)  # 用于选择按钮的主题样式（Primary, Secondary等）
        self.ComboBox2 = ComboBox(self)  # 用于选择按钮的形状（圆角矩形或普通矩形）

        # 标签控件，用于显示说明文字
        self.Label1 = Label(self)
        self.Label2 = Label(self)

        # 自定义按钮控件，这是主要演示的对象
        self.PraButtonStyle = PraButtonStyle(self)

        # 加载窗体的布局文件（.pydfm格式）
        # 使用__file__获取当前脚本的路径，构建完整的布局文件路径
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "main.pydfm"))

        # 绑定事件处理函数
        self.CheckBox1.OnClick = self.CheckBox1Click  # 轮廓样式复选框点击事件
        self.CheckBox2.OnClick = self.CheckBox2Click  # 启用状态复选框点击事件
        self.ComboBox2.OnSelect = self.ComboBox2Select  # 形状选择下拉框选择事件

        # 定义按钮主题样式的数组，包含所有可用的样式类型
        # 这些常量（bsPrimary, bsSecondary等）是从glcl库导入的
        self.bsArr = [bsPrimary, bsSecondary, bsSuccess, bsDanger, bsWarning, bsInfo, bsLight, bsDark]

        # 绑定主题样式选择下拉框的选择事件
        self.ComboBox1.OnSelect = self.ComboBox1Select

    def ComboBox1Select(self, Sender):
        """
        主题样式选择下拉框的选择事件处理函数
        根据用户选择的样式，改变按钮的主题样式和标题文字

        参数:
            Sender: 触发事件的控件对象（这里是ComboBox1）
        """
        # 获取选中的项的索引（ItemIndex从0开始，减1是为了匹配bsArr数组的索引）
        index = self.ComboBox1.ItemIndex - 1

        # 根据选择的索引设置按钮的样式
        if index == self.bsArr.index(bsPrimary):
            # 设置为主样式（通常是蓝色）
            self.PraButtonStyle.Style = bsPrimary
            self.PraButtonStyle.Caption = 'Primary'
        elif index == self.bsArr.index(bsSecondary):
            # 设置为次级样式（通常是灰色）
            self.PraButtonStyle.Style = bsSecondary
            self.PraButtonStyle.Caption = 'Secondary'
        elif index == self.bsArr.index(bsSuccess):
            # 设置为成功样式（通常是绿色）
            self.PraButtonStyle.Style = bsSuccess
            self.PraButtonStyle.Caption = 'Success'
        elif index == self.bsArr.index(bsDanger):
            # 设置为危险样式（通常是红色）
            self.PraButtonStyle.Style = bsDanger
            self.PraButtonStyle.Caption = 'Danger'
        elif index == self.bsArr.index(bsWarning):
            # 设置为警告样式（通常是黄色）
            self.PraButtonStyle.Style = bsWarning
            self.PraButtonStyle.Caption = 'Warning'
        elif index == self.bsArr.index(bsInfo):
            # 设置为信息样式（通常是浅蓝色）
            self.PraButtonStyle.Style = bsInfo
            self.PraButtonStyle.Caption = 'Info'
        elif index == self.bsArr.index(bsLight):
            # 设置为亮色样式（通常是浅灰色）
            self.PraButtonStyle.Style = bsLight
            self.PraButtonStyle.Caption = 'Light'
        elif index == self.bsArr.index(bsDark):
            # 设置为暗色样式（通常是深灰色或黑色）
            self.PraButtonStyle.Style = bsDark
            self.PraButtonStyle.Caption = 'Dark'

    def ComboBox2Select(self, Sender):
        """
        形状选择下拉框的选择事件处理函数
        根据用户选择的形状类型，改变按钮的形状

        参数:
            Sender: 触发事件的控件对象（这里是ComboBox2）
        """
        if self.ComboBox2.ItemIndex == 0:
            # 选择第一个选项：设置为圆角矩形
            self.PraButtonStyle.Shape = stRoundRect
        elif self.ComboBox2.ItemIndex == 1:
            # 选择第二个选项：设置为普通矩形（直角）
            self.PraButtonStyle.Shape = stRectangle

    def CheckBox2Click(self, Sender):
        """
        启用状态复选框的点击事件处理函数
        控制按钮的启用/禁用状态

        参数:
            Sender: 触发事件的控件对象（这里是CheckBox2）
        """
        # 将按钮的启用状态设置为复选框的选中状态
        # 当复选框选中时，按钮可用；取消选中时，按钮禁用
        self.PraButtonStyle.Enabled = self.CheckBox2.Checked

    def CheckBox1Click(self, Sender):
        """
        轮廓样式复选框的点击事件处理函数
        控制按钮是否显示轮廓样式（outline风格）

        参数:
            Sender: 触发事件的控件对象（这里是CheckBox1）
        """
        # 将按钮的轮廓样式属性设置为复选框的选中状态
        # 当复选框选中时，按钮显示为轮廓样式（只有边框，没有背景色）
        # 取消选中时，按钮显示为普通样式（有背景色）
        self.PraButtonStyle.StyleOutline = self.CheckBox1.Checked