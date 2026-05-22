import sys
from glcl import *
from Unit1 import *

def main():
    icon_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Extractor_Icon.ico")
    if not os.path.exists(icon_path):
        print('Extractor_Icon.ico is missing. Do not delete or rename this file.')
        return
    Application.Initialize()
    Application.Title = 'Project1'
    Application.MainFormOnTaskbar = True
    Application.Icon.LoadFromFile(icon_path)
    MainForm = Form1(Application)
    MainForm.Show()
    FreeConsole()
    Application.Run()
    MainForm.Free()

if __name__ == '__main__':
    main()

