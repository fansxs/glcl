# -*- coding: utf-8 -*-
"""
TestParamGrid.py  -  工程主程序 (对应 Delphi 的 TestParamGrid.dpr)

运行方式:  python TestParamGrid.py      (需要 Windows + glcl)
"""
from glcl import *
from Unit1 import *          # 引入主窗体类 Form1


def main():
    # 初始化应用程序对象
    Application.Initialize()
    Application.Title = 'TestParamGrid'
    Application.MainFormOnTaskbar = True

    # 创建并显示主窗体 (Form1 的构造函数里会加载窗体布局、定义参数/列并装载 ini 数据)
    MainForm = Form1(Application)
    MainForm.Show()

    # 隐藏控制台窗口 (如需看 print / 报错信息, 注释掉下面这一行)
    FreeConsole()

    # 进入消息循环, 窗口关闭后返回
    Application.Run()

    # 释放主窗体
    MainForm.Free()


if __name__ == '__main__':
    main()
