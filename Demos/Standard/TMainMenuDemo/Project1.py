# 从 glcl 模块导入所有内容。
from glcl import *

# 从 Unit1 模块导入所有内容。Unit1 通常包含定义了窗体的类，比如 Form1。
from Unit1 import *

def main():
    # 初始化应用程序。这个调用会设置应用程序的基本环境。
    Application.Initialize()

    # 设置应用程序的标题。这个标题会显示在任务栏或窗口的标题栏上。
    Application.Title = 'Project1'

    # 确保应用程序的主窗体在任务栏上显示。这个设置对 Windows 平台特别有效。
    Application.MainFormOnTaskbar = True

    # 加载应用程序的图标。图标文件的路径是相对于当前脚本文件所在目录的。
    # os.path.join 函数用于拼接路径，os.path.dirname 和 os.path.abspath 函数用于获取脚本的目录。
    Application.Icon.LoadFromFile(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Extractor_Icon.ico"))

    # 创建一个 Form1 类的实例，并将其作为主窗体传递给 Application 对象。
    MainForm = Form1(Application)

    # 显示主窗体。这个调用会使主窗体可见。
    MainForm.Show()

    # 释放控制台。如果脚本是在一个有控制台的环境中运行，这行代码会关闭控制台窗口。
    FreeConsole()

    # 启动应用程序的主事件循环。这个循环会处理用户输入和其他事件，直到应用程序退出。
    Application.Run()

    # 当应用程序的主事件循环结束后，释放主窗体占用的资源。
    MainForm.Free()

# 检查脚本是否作为主程序运行。如果是，调用 main 函数。
# 这个检查确保只有在脚本直接运行时才会执行 main 函数，而在被导入为模块时不会执行。
if __name__ == '__main__':
    main()
