from glcl import *
from Main import *
from Splash import *

def main():
    icon_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Extractor_Icon.ico")
    if not os.path.exists(icon_path):
        print('Extractor_Icon.ico is missing. Do not delete or rename this file.')
        return
    Application.Initialize()
    Application.Title = 'Project1'
    Application.MainFormOnTaskbar = True
    Application.Icon.LoadFromFile(icon_path)
    Splash = SplashForm.Execute()
    MainForm1 = MainForm(Application)
    MainForm1.Show()
    FreeConsole()
    Splash.Free()
    Application.Run()
    MainForm1.Free()

if __name__ == '__main__':
    main()
