from glcl import *
from main import *

def main():
    Application.Initialize()
    Application.Title = 'Project1'
    Application.MainFormOnTaskbar = True
    Application.Icon.LoadFromFile(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Extractor_Icon.ico"))
    mForm = MainForm(Application)
    mForm.Show()
    FreeConsole()
    Application.Run()
    mForm.Free()

if __name__ == '__main__':
    main()
