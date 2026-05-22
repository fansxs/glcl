import sys
import sys
import sys
import sys
from glcl import *
from remain import *

def main():
    Application.Initialize()
    Application.Title = 'Project1'
    Application.MainFormOnTaskbar = True
    Application.Icon.LoadFromFile(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Extractor_Icon.ico"))
    MainForm1 = MainForm(Application)
    MainForm1.Show()
    FreeConsole()
    Application.Run()
    MainForm1.Free()

if __name__ == '__main__':
    main()






