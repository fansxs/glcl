import sys
from glcl import *
from Unit1 import *

def main():
    Application.Initialize()
    Application.Title = 'Project1'
    Application.MainFormOnTaskbar = True
    Application.Icon.LoadFromFile(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Extractor_Icon.ico"))
    MainForm = Form1(Application)
    MainForm.Show()
    FreeConsole()
    Application.Run()
    MainForm.Free()

if __name__ == '__main__':
    main()


