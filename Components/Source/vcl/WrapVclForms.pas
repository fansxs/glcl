
(*  This unit is part of the Python for Delphi (P4D) library              *)
(*  Project home: https://github.com/pyscripter/python4delphi             *)
(*                                                                        *)
(*  Project Maintainer:  PyScripter (pyscripter@gmail.com)                *)
(*  Original Authors:    Dr. Dietmar Budelsky (dbudelsky@web.de)          *)
(*                       Morgan Martinet (https://github.com/mmm-experts) *)
(*  Core developer:      Lucas Belo (lucas.belo@live.com)                 *)
(*  Core developer:      fansxs (admin@glsite.com)                        *)
(*  Contributors:        See contributors.md at project home              *)
(*                                                                        *)
(*  LICENCE and Copyright: MIT (see project home)                         *)
(**************************************************************************)

{$I ..\Definition.Inc}

unit WrapVclForms;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses, WrapVclControls,
  Windows, Forms, Graphics, TypInfo, osSysPath, Messages(*, DelphiC, libFPC.Utils,
  libFPC*);

type
  TCloseQueryEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; var CanClose : Boolean);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

  TCloseEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; var Action: TCloseAction);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

  {
     PyObject wrapping TCustomForm
     Exposes methods ShowModal, Close, CloseQuery, Release
     Exposes property ModalResult
  }
  TPyDelphiCustomForm = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TCustomForm;
    procedure SetDelphiObject(const Value: TCustomForm);
  protected
    function  CreateComponent(AOwner : TComponent) : TComponent; override;
    // Exposed Methods
    function Close_Wrapper(args: PPyObject): PPyObject; cdecl;
    function CloseQuery_Wrapper(args: PPyObject): PPyObject; cdecl;
    function ShowModal_Wrapper(args: PPyObject): PPyObject; cdecl;
    function Release_Wrapper(args : PPyObject) : PPyObject; cdecl;
    //Load properties from .pydfm file
    function LoadProps_Wrapper(args : PPyObject) : PPyObject; cdecl;
    // Property Getters
    function Get_ModalResult(AContext : Pointer) : PPyObject; cdecl;
    // Property Setters
    function Set_ModalResult(AValue : PPyObject; AContext : Pointer) : Integer; cdecl;
  public
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TCustomForm read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiForm = class (TPyDelphiCustomForm)
  private
    function  GetDelphiObject: TForm;
    procedure SetDelphiObject(const Value: TForm);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TForm read GetDelphiObject write SetDelphiObject;
  end;

  {
     PyObject wrapping TMonitor
     Exposes properties Handle, MonitorNum, Left, Height, Top, Width, BoundsRect, WorkareaRect, Primary
  }
  TPyDelphiMonitor = class (TPyDelphiObject)
  private
    function  GetDelphiObject: TMonitor;
    procedure SetDelphiObject(const Value: TMonitor);
  protected
    function Get_Handle(AContext : Pointer): PPyObject; cdecl;
    function Get_MonitorNum(AContext : Pointer): PPyObject; cdecl;
    function Get_Left(AContext : Pointer): PPyObject; cdecl;
    function Get_Height(AContext : Pointer): PPyObject; cdecl;
    function Get_Top(AContext : Pointer): PPyObject; cdecl;
    function Get_Width(AContext : Pointer): PPyObject; cdecl;
    function Get_BoundsRect(AContext : Pointer): PPyObject; cdecl;
    function Get_WorkareaRect(AContext : Pointer): PPyObject; cdecl;
    function Get_Primary(AContext : Pointer): PPyObject; cdecl;
  public
    // Class methods
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TMonitor read GetDelphiObject write SetDelphiObject;
  end;

  TBaseScreenAccess = class(TContainerAccess)
  private
    function GetContainer: TScreen;
  public
    class function ExpectedContainerClass : TClass; override;

    property Container : TScreen read GetContainer;
  end;

  {
    Access to the custom forms of the Screen singleton.
  }
  TScreenCustomFormsAccess = class(TBaseScreenAccess)
  public
    function GetItem(AIndex : Integer) : PPyObject; override;
    function GetSize : Integer; override;
    //function IndexOf(AValue : PPyObject) : Integer; override;

    //class function SupportsIndexOf : Boolean; override;
    class function Name : string; override;
  end;

  {
    Access to the forms of the Screen singleton.
  }
  TScreenFormsAccess = class(TBaseScreenAccess)
  public
    function GetItem(AIndex : Integer) : PPyObject; override;
    function GetSize : Integer; override;
    //function IndexOf(AValue : PPyObject) : Integer; override;

    //class function SupportsIndexOf : Boolean; override;
    class function Name : string; override;
  end;

  {
    Access to the TDataModule items of the Screen singleton.
  }
  TScreenDataModulesAccess = class(TBaseScreenAccess)
  public
    function GetItem(AIndex : Integer) : PPyObject; override;
    function GetSize : Integer; override;
    //function IndexOf(AValue : PPyObject) : Integer; override;

    //class function SupportsIndexOf : Boolean; override;
    class function Name : string; override;
  end;

  {
    Access to the Cursors of the Screen singleton.
  }
  TScreenCursorsAccess = class(TBaseScreenAccess)
  public
    function GetItem(AIndex : Integer) : PPyObject; override;
    function GetSize : Integer; override;
    //function IndexOf(AValue : PPyObject) : Integer; override;

    //class function SupportsIndexOf : Boolean; override;
    class function Name : string; override;
  end;

  {
    Access to the Monitors of the Screen singleton.
  }
  TScreenMonitorsAccess = class(TBaseScreenAccess)
  public
    function GetItem(AIndex : Integer) : PPyObject; override;
    function GetSize : Integer; override;
    //function IndexOf(AValue : PPyObject) : Integer; override;

    //class function SupportsIndexOf : Boolean; override;
    class function Name : string; override;
  end;

  {
     PyObject wrapping TScreen
     Exposes methods DisableAlign, EnableAlign, Realign, ResetFonts
     Exposes all properties of TScreen
  }
  TPyDelphiScreen = class (TPyDelphiComponent)
  private
    fOnActiveControlChange: PPyObject;
    fOnActiveFormChange: PPyObject;
    function  GetDelphiObject: TScreen;
    procedure SetDelphiObject(const Value: TScreen);
    procedure HandleOnActiveControlChange(Sender : TObject);
    procedure HandleOnActiveFormChange(Sender : TObject);
  protected
    // Exposed Methods
    function DisableAlign_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function EnableAlign_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function MonitorFromPoint_Wrapper(args : PPyObject) : PPyObject; cdecl;
    //TODO: implementation
    //function MonitorFromRect(const Rect: TRect; MonitorDefault: TMonitorDefaultTo = mdNearest): TMonitor;
    //function MonitorFromWindow(const Handle: THandle; MonitorDefault: TMonitorDefaultTo = mdNearest): TMonitor;
    function Realign_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ResetFonts_Wrapper(args : PPyObject) : PPyObject; cdecl;
    // Property Getters
    function Get_ActiveControl(AContext : Pointer) : PPyObject; cdecl;
    function Get_ActiveCustomForm(AContext : Pointer) : PPyObject; cdecl;
    function Get_ActiveForm(AContext : Pointer) : PPyObject; cdecl;
    function Get_CustomFormCount(AContext : Pointer) : PPyObject; cdecl;
    function Get_CustomForms(AContext : Pointer) : PPyObject; cdecl;
    function Get_Cursor(AContext : Pointer) : PPyObject; cdecl;
    function Get_Cursors(AContext : Pointer) : PPyObject; cdecl;
    function Get_DataModules(AContext : Pointer) : PPyObject; cdecl;
    function Get_DataModuleCount(AContext : Pointer) : PPyObject; cdecl;
    function Get_MonitorCount(AContext : Pointer) : PPyObject; cdecl;
    function Get_Monitors(AContext : Pointer) : PPyObject; cdecl;
    function Get_DesktopRect(AContext : Pointer) : PPyObject; cdecl;
    function Get_DesktopLeft(AContext : Pointer) : PPyObject; cdecl;
    function Get_DesktopTop(AContext : Pointer) : PPyObject; cdecl;
    function Get_DesktopWidth(AContext : Pointer) : PPyObject; cdecl;
    function Get_DesktopHeight(AContext : Pointer) : PPyObject; cdecl;
    function Get_WorkAreaRect(AContext : Pointer) : PPyObject; cdecl;
    function Get_WorkAreaHeight(AContext : Pointer) : PPyObject; cdecl;
    function Get_WorkAreaLeft(AContext : Pointer) : PPyObject; cdecl;
    function Get_WorkAreaTop(AContext : Pointer) : PPyObject; cdecl;
    function Get_WorkAreaWidth(AContext : Pointer) : PPyObject; cdecl;
    function Get_HintFont(AContext : Pointer) : PPyObject; cdecl;
    function Get_IconFont(AContext : Pointer) : PPyObject; cdecl;
    function Get_MenuFont(AContext : Pointer) : PPyObject; cdecl;
    function Get_Fonts(AContext : Pointer) : PPyObject; cdecl;
    function Get_FormCount(AContext : Pointer) : PPyObject; cdecl;
    function Get_Forms(AContext : Pointer) : PPyObject; cdecl;
    function Get_Imes(AContext : Pointer) : PPyObject; cdecl;
    function Get_DefaultIme(AContext : Pointer) : PPyObject; cdecl;
    function Get_DefaultKbLayout(AContext : Pointer) : PPyObject; cdecl;
    function Get_Height(AContext : Pointer) : PPyObject; cdecl;
    function Get_PixelsPerInch(AContext : Pointer) : PPyObject; cdecl;
    function Get_Width(AContext : Pointer) : PPyObject; cdecl;
    function Get_OnActiveControlChange(AContext : Pointer) : PPyObject; cdecl;
    function Get_OnActiveFormChange(AContext : Pointer) : PPyObject; cdecl;
    // Property Setters
    function Set_Cursor(AValue : PPyObject; AContext : Pointer) : Integer; cdecl;
    function Set_HintFont(AValue : PPyObject; AContext : Pointer) : Integer; cdecl;
    function Set_IconFont(AValue : PPyObject; AContext : Pointer) : Integer; cdecl;
    function Set_MenuFont(AValue : PPyObject; AContext : Pointer) : Integer; cdecl;
    function Set_OnActiveControlChange(AValue : PPyObject; AContext : Pointer) : Integer; cdecl;
    function Set_OnActiveFormChange(AValue : PPyObject; AContext : Pointer) : Integer; cdecl;
  public
    destructor Destroy; override;
    // Class methods
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TScreen read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiApplication = class (TPyDelphiComponent)
  private
    function  GetDelphiObject: TApplication;
    procedure SetDelphiObject(const Value: TApplication);
  protected
    // Exposed Methods
    function ActivateHint_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function BringToFront_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CancelHint_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ExecuteAction_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function HandleException_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function HandleMessage_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function HelpCommand_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function HelpContext_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function HelpJump_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function HelpKeyword_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function HideHint_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Initialize_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsRightToLeft_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function MessageBox_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function MessageDlg_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function InputBox_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SelectDirectory_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PrintText_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PrintImage_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ColorToString_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ShowWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function WinExec_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ShellExecute_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SendMessage_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PostMessage_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetSystemPath_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ReleaseCapture_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetParent_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetWindowPos_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ShowCursor_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PtInRect_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetDC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ReleaseDC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function BitBlt_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateMutex_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function OpenMutex_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CloseHandle_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetLastError_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RGB_Wrapper(args : PPyObject) : PPyObject; cdecl;
    // ---- Additional Win32 API functions (kernel32/user32/gdi32) ----
    function Beep_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Sleep_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetTickCount_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetCurrentProcessId_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetCurrentThreadId_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetCurrentProcess_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetCurrentThread_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetLastError_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function MulDiv_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetComputerName_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetEnvironmentVariable_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetEnvironmentVariable_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetSystemDirectory_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetWindowsDirectory_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetTempPath_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetCurrentDirectory_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetCurrentDirectory_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateDirectory_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RemoveDirectory_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function DeleteFile_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CopyFile_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function MoveFile_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetFileAttributes_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetFileAttributes_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetFullPathName_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetLogicalDrives_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetDriveType_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function OutputDebugString_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetModuleFileName_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function LoadLibrary_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function FreeLibrary_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function TerminateProcess_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function OpenProcess_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function WaitForSingleObject_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateEvent_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function OpenEvent_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetEvent_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ResetEvent_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PulseEvent_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ReleaseMutex_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateSemaphore_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function OpenSemaphore_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ReleaseSemaphore_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsDebuggerPresent_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetVersion_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function MessageBeep_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function FindWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function FindWindowEx_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetWindowText_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetWindowText_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetWindowTextLength_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetClassName_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsWindowVisible_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsWindowEnabled_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsIconic_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsZoomed_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsChild_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function EnableWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function DestroyWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function MoveWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetParent_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetDesktopWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetForegroundWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetForegroundWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetActiveWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetActiveWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetWindowLong_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetWindowLong_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetSystemMetrics_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetAsyncKeyState_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetKeyState_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function keybd_event_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function mouse_event_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetCursorPos_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetCapture_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetCapture_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ShowWindowAsync_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function AnimateWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function FlashWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function BringWindowToTop_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function UpdateWindow_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegisterWindowMessage_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegisterClipboardFormat_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function OpenClipboard_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CloseClipboard_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function EmptyClipboard_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsClipboardFormatAvailable_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CountClipboardFormats_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetWindowDC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetDlgItem_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetDlgCtrlID_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetDlgItemText_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetDlgItemInt_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CheckDlgButton_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsDlgButtonChecked_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetMenu_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetMenu_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetSystemMenu_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetMenuItemCount_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetMenuItemID_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function EnableMenuItem_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function DeleteMenu_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RemoveMenu_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateMenu_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreatePopupMenu_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function DestroyMenu_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetCursor_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetCursor_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function LoadCursorFromFile_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetSysColor_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetDoubleClickTime_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetDoubleClickTime_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateCompatibleDC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateCompatibleBitmap_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function DeleteDC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function DeleteObject_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SelectObject_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetStockObject_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateSolidBrush_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateHatchBrush_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreatePen_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateRectRgn_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateEllipticRgn_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CreateRoundRectRgn_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CombineRgn_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function EqualRgn_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PtInRegion_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function LineTo_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Rectangle_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RoundRect_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Ellipse_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetPixel_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetPixel_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetTextColor_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetTextColor_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetBkColor_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetBkColor_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetBkMode_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetBkMode_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function TextOut_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetDeviceCaps_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SaveDC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RestoreDC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetMapMode_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetMapMode_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetROP2_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetROP2_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetStretchBltMode_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetStretchBltMode_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function StretchBlt_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PatBlt_Wrapper(args : PPyObject) : PPyObject; cdecl;
    // ---- Batch 2: advapi32 (registry/service) / shlwapi / winmm / shell32 ----
    function RegOpenKeyEx_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegCreateKeyEx_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegCloseKey_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegDeleteKey_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegDeleteValue_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegFlushKey_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegEnumKeyEx_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegEnumValue_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegQueryStringValue_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegSetStringValue_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegQueryDWordValue_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegSetDWordValue_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RegConnectRegistry_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetUserName_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function OpenSCManager_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function OpenService_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function CloseServiceHandle_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function QueryServiceState_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function StartService_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ControlService_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function DeleteService_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathFileExists_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathIsDirectory_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathIsRoot_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathIsRelative_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathIsUNC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathIsURL_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathRemoveBackslash_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathAddBackslash_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathRemoveExtension_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathRemoveFileSpec_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathFindExtension_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathFindFileName_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathGetDriveNumber_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathStripPath_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathIsPrefix_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathMatchSpec_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathIsSameRoot_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathCombine_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathAppend_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathQuoteSpaces_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathUnquoteSpaces_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PathCanonicalize_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function StrToInt_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function StrFormatByteSize_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function timeGetTime_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function timeBeginPeriod_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function timeEndPeriod_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function PlaySound_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function sndPlaySound_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function waveOutGetNumDevs_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function waveInGetNumDevs_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function midiOutGetNumDevs_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function midiInGetNumDevs_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function auxGetNumDevs_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function joyGetNumDevs_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function mixerGetNumDevs_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function mmioStringToFOURCC_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SHGetFolderPath_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ShellAbout_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ExtractIcon_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SHGetFileTypeDescription_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function IsUserAnAdmin_Wrapper(args : PPyObject) : PPyObject; cdecl;
    // ---- Batch 3: restored + additional kernel32/shlwapi/shell32 functions ----
    function ExitWindowsEx_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function LockWorkStation_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SHFileOperationDelete_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SHEmptyRecycleBin_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function StrChr_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function StrStr_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetProcAddress_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetExitCodeProcess_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetPriorityClass_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetPriorityClass_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetFileSize_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetLocalTime_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetSystemTime_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetCursorPos_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetWindowRect_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetClientRect_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ClientToScreen_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ScreenToClient_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function MoveToEx_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetShortPathName_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetLongPathName_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetLogicalDriveStrings_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function GetDlgItemText_Wrapper(args : PPyObject) : PPyObject; cdecl;
    //function CCompiler_Wrapper(args : PPyObject) : PPyObject; cdecl;
    //function CompileFPCFileToExeAndRun_Wrapper(args : PPyObject) : PPyObject; cdecl;
//    function CompileFPCCodeToDllAndCall_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Minimize_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ModalStarted_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ModalFinished_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function NormalizeAllTopMosts_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function NormalizeTopMosts_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function RestoreTopMosts_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ProcessMessages_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Restore_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Run_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ShowException_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Terminate_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function UpdateAction_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function UseRightToLeftAlignment_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function UseRightToLeftReading_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function UseRightToLeftScrollBar_Wrapper(args : PPyObject) : PPyObject; cdecl;
    // property getters
    function Get_Active(AContext : Pointer): PPyObject; cdecl;
    function Get_AllowTesting(AContext : Pointer): PPyObject; cdecl;
    function Get_AutoDragDocking(AContext : Pointer): PPyObject; cdecl;
    function Get_CurrentHelpFile(AContext : Pointer): PPyObject; cdecl;
    function Get_DialogHandle(AContext : Pointer): PPyObject; cdecl;
    function Get_Handle(AContext : Pointer): PPyObject; cdecl;
    function Get_ExeName(AContext : Pointer): PPyObject; cdecl;
    function Get_HelpFile(AContext : Pointer): PPyObject; cdecl;
    function Get_Hint(AContext : Pointer): PPyObject; cdecl;
    function Get_HintColor(AContext : Pointer): PPyObject; cdecl;
    function Get_HintHidePause(AContext : Pointer): PPyObject; cdecl;
    function Get_HintPause(AContext : Pointer): PPyObject; cdecl;
    function Get_HintShortCuts(AContext : Pointer): PPyObject; cdecl;
    function Get_HintShortPause(AContext : Pointer): PPyObject; cdecl;
    function Get_Icon(AContext : Pointer): PPyObject; cdecl;
    function Get_MainForm(AContext : Pointer): PPyObject; cdecl;
    function Get_BiDiMode(AContext : Pointer): PPyObject; cdecl;
    function Get_BiDiKeyboard(AContext : Pointer): PPyObject; cdecl;
    function Get_NonBiDiKeyboard(AContext : Pointer): PPyObject; cdecl;
    function Get_ShowHint(AContext : Pointer): PPyObject; cdecl;
    function Get_ShowMainForm(AContext : Pointer): PPyObject; cdecl;
    function Get_Terminated(AContext : Pointer): PPyObject; cdecl;
    function Get_Title(AContext : Pointer): PPyObject; cdecl;
    function Get_UpdateFormatSettings(AContext : Pointer): PPyObject; cdecl;
    function Get_UpdateMetricSettings(AContext : Pointer): PPyObject; cdecl;
    // property setters
    function Set_AllowTesting(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_AutoDragDocking(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_DialogHandle(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_Handle(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_HelpFile(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_Hint(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_HintColor(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_HintHidePause(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_HintPause(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_HintShortCuts(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_HintShortPause(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_Icon(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_BiDiMode(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_BiDiKeyboard(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_NonBiDiKeyboard(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_ShowHint(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_ShowMainForm(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_Title(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_UpdateFormatSettings(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
    function Set_UpdateMetricSettings(AValue : PPyObject; AContext : Pointer): Integer; cdecl;
  public
    // Class methods
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TApplication read GetDelphiObject write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes, System.IOUtils, System.Rtti, FileCtrl, Vcl.Dialogs, Printers,
  StrUtils, ShellAPI, ShlwApi, MMSystem, WinSvc, ShlObj;

{ Global Functions }
function FreeConsole_Wrapper(pself, args: PPyObject): PPyObject; cdecl;
begin
  FreeConsole;
  Result := GetPythonEngine.ReturnNone;
end;

{ Register the wrappers, the globals and the constants }
type
  TFormsRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TFormsRegistration }

procedure TFormsRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterFunction(PAnsiChar('FreeConsole'), FreeConsole_Wrapper,
       PAnsiChar('FreeConsole_Wrapper()'#10 +
       'Frees the MS-DOS console associated with the process.'));
end;

procedure TFormsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  // Singletons
  APyDelphiWrapper.DefineVar('Application', Application);
  APyDelphiWrapper.DefineVar('Screen',      Screen);

  // MessageBox flags
  APyDelphiWrapper.DefineVar('MB_ABORTRETRYIGNORE', MB_ABORTRETRYIGNORE);
  APyDelphiWrapper.DefineVar('MB_OK',               MB_OK);
  APyDelphiWrapper.DefineVar('MB_OKCANCEL',         MB_OKCANCEL);
  APyDelphiWrapper.DefineVar('MB_RETRYCANCEL',      MB_RETRYCANCEL);
  APyDelphiWrapper.DefineVar('MB_YESNO',            MB_YESNO);
  APyDelphiWrapper.DefineVar('MB_YESNOCANCEL',      MB_YESNOCANCEL);

  // MessageBox results
  APyDelphiWrapper.DefineVar('IDOK',      IDOK);
  APyDelphiWrapper.DefineVar('IDCANCEL',  IDCANCEL);
  APyDelphiWrapper.DefineVar('IDABORT',   IDABORT);
  APyDelphiWrapper.DefineVar('IDRETRY',   IDRETRY);
  APyDelphiWrapper.DefineVar('IDIGNORE',  IDIGNORE);
  APyDelphiWrapper.DefineVar('IDYES',     IDYES);
  APyDelphiWrapper.DefineVar('IDNO',      IDNO);

  // ShowWindow Commands
  APyDelphiWrapper.DefineVar('SW_HIDE',      SW_HIDE);
  APyDelphiWrapper.DefineVar('SW_SHOWNORMAL',      SW_SHOWNORMAL);
  APyDelphiWrapper.DefineVar('SW_NORMAL',      SW_NORMAL);
  APyDelphiWrapper.DefineVar('SW_SHOWMINIMIZED',      SW_SHOWMINIMIZED);
  APyDelphiWrapper.DefineVar('SW_SHOWMAXIMIZED',      SW_SHOWMAXIMIZED);
  APyDelphiWrapper.DefineVar('SW_MAXIMIZE',      SW_MAXIMIZE);
  APyDelphiWrapper.DefineVar('SW_SHOWNOACTIVATE',      SW_SHOWNOACTIVATE);
  APyDelphiWrapper.DefineVar('SW_SHOW',      SW_SHOW);
  APyDelphiWrapper.DefineVar('SW_MINIMIZE',      SW_MINIMIZE);
  APyDelphiWrapper.DefineVar('SW_SHOWMINNOACTIVE',      SW_SHOWMINNOACTIVE);
  APyDelphiWrapper.DefineVar('SW_SHOWNA',      SW_SHOWNA);
  APyDelphiWrapper.DefineVar('SW_RESTORE',      SW_RESTORE);
  APyDelphiWrapper.DefineVar('SW_SHOWDEFAULT',      SW_SHOWDEFAULT);
  APyDelphiWrapper.DefineVar('SW_FORCEMINIMIZE',      SW_FORCEMINIMIZE);
  APyDelphiWrapper.DefineVar('SW_MAX',      SW_MAX);

  // TCloseAction enum
  APyDelphiWrapper.DefineVar('caNone',      'caNone');
  APyDelphiWrapper.DefineVar('caHide',      'caHide');
  APyDelphiWrapper.DefineVar('caFree',      'caFree');
  APyDelphiWrapper.DefineVar('caMinimize',  'caMinimize');

  { TScrollingWinControl }
  APyDelphiWrapper.DefineVar('wsNormal',    'wsNormal');
  APyDelphiWrapper.DefineVar('wsMinimized', 'wsMinimized');
  APyDelphiWrapper.DefineVar('wsMaximized', 'wsMaximized');

  APyDelphiWrapper.DefineVar('biSystemMenu',      'biSystemMenu');
  APyDelphiWrapper.DefineVar('biMinimize',      'biMinimize');
  APyDelphiWrapper.DefineVar('biMaximize',      'biMaximize');
  APyDelphiWrapper.DefineVar('biHelp',  'biHelp');

  // TMonitorDefaultTo enum
  APyDelphiWrapper.DefineVar('mdNearest',   'mdNearest');
  APyDelphiWrapper.DefineVar('mdNull',      'mdNull');
  APyDelphiWrapper.DefineVar('mdPrimary',   'mdPrimary');

  APyDelphiWrapper.DefineVar('poDesigned', 'poDesigned');
  APyDelphiWrapper.DefineVar('poDefault', 'poDefault');
  APyDelphiWrapper.DefineVar('poDefaultPosOnly', 'poDefaultPosOnly');
  APyDelphiWrapper.DefineVar('poDefaultSizeOnly','poDefaultSizeOnly');
  APyDelphiWrapper.DefineVar('poScreenCenter', 'poScreenCenter');
  APyDelphiWrapper.DefineVar('poDesktopCenter', 'poDesktopCenter');
  APyDelphiWrapper.DefineVar('poMainFormCenter', 'poMainFormCenter');
  APyDelphiWrapper.DefineVar('poOwnerFormCenter', 'poOwnerFormCenter');

  // GetSystemPath Params
  APyDelphiWrapper.DefineVar('Desktop', Desktop);
  APyDelphiWrapper.DefineVar('StartMenu', StartMenu);
  APyDelphiWrapper.DefineVar('Programs', Programs);
  APyDelphiWrapper.DefineVar('Startup', Startup);
  APyDelphiWrapper.DefineVar('Personal', Personal);
  APyDelphiWrapper.DefineVar('AppData', AppData);
  APyDelphiWrapper.DefineVar('Fonts', Fonts);
  APyDelphiWrapper.DefineVar('SendTo', SendTo);
  APyDelphiWrapper.DefineVar('Recent', Recent);
  APyDelphiWrapper.DefineVar('Favorites', Favorites);
  APyDelphiWrapper.DefineVar('Cache', Cache);
  APyDelphiWrapper.DefineVar('Cookies', Cookies);
  APyDelphiWrapper.DefineVar('History', History);
  APyDelphiWrapper.DefineVar('NetHood', NetHood);
  APyDelphiWrapper.DefineVar('PrintHood', PrintHood);
  APyDelphiWrapper.DefineVar('Templates', Templates);
  APyDelphiWrapper.DefineVar('LocADat', LocADat);
  APyDelphiWrapper.DefineVar('WindRoot', WindRoot);
  APyDelphiWrapper.DefineVar('WindSys', WindSys);
  APyDelphiWrapper.DefineVar('TempPath', TempPath);
  APyDelphiWrapper.DefineVar('RootDir', RootDir);
  APyDelphiWrapper.DefineVar('ProgFiles', ProgFiles);
  APyDelphiWrapper.DefineVar('ComFiles', ComFiles);
  APyDelphiWrapper.DefineVar('ConfigPath', ConfigPath);
  APyDelphiWrapper.DefineVar('DevicePath', DevicePath);
  APyDelphiWrapper.DefineVar('MediaPath', MediaPath);
  APyDelphiWrapper.DefineVar('WallPaper', WallPaper);

  // Windows.Messages
  APyDelphiWrapper.DefineVar('WM_NULL', WM_NULL);
  APyDelphiWrapper.DefineVar('WM_CREATE', WM_CREATE);
  APyDelphiWrapper.DefineVar('WM_DESTROY', WM_DESTROY);
  APyDelphiWrapper.DefineVar('WM_MOVE', WM_MOVE);
  APyDelphiWrapper.DefineVar('WM_SIZE', WM_SIZE);
  APyDelphiWrapper.DefineVar('WM_ACTIVATE', WM_ACTIVATE);
  APyDelphiWrapper.DefineVar('WM_SETFOCUS', WM_SETFOCUS);
  APyDelphiWrapper.DefineVar('WM_KILLFOCUS', WM_KILLFOCUS);
  APyDelphiWrapper.DefineVar('WM_ENABLE', WM_ENABLE);
  APyDelphiWrapper.DefineVar('WM_SETREDRAW', WM_SETREDRAW);
  APyDelphiWrapper.DefineVar('WM_SETTEXT', WM_SETTEXT);
  APyDelphiWrapper.DefineVar('WM_GETTEXT', WM_GETTEXT);
  APyDelphiWrapper.DefineVar('WM_GETTEXTLENGTH', WM_GETTEXTLENGTH);
  APyDelphiWrapper.DefineVar('WM_PAINT', WM_PAINT);
  APyDelphiWrapper.DefineVar('WM_CLOSE', WM_CLOSE);
  APyDelphiWrapper.DefineVar('WM_QUERYENDSESSION', WM_QUERYENDSESSION);
  APyDelphiWrapper.DefineVar('WM_QUIT', WM_QUIT);
  APyDelphiWrapper.DefineVar('WM_QUERYOPEN', WM_QUERYOPEN);
  APyDelphiWrapper.DefineVar('WM_ERASEBKGND', WM_ERASEBKGND);
  APyDelphiWrapper.DefineVar('WM_SYSCOLORCHANGE', WM_SYSCOLORCHANGE);
  APyDelphiWrapper.DefineVar('WM_ENDSESSION', WM_ENDSESSION);
  APyDelphiWrapper.DefineVar('WM_SYSTEMERROR', WM_SYSTEMERROR);
  APyDelphiWrapper.DefineVar('WM_SHOWWINDOW', WM_SHOWWINDOW);
  APyDelphiWrapper.DefineVar('WM_CTLCOLOR', WM_CTLCOLOR);
  APyDelphiWrapper.DefineVar('WM_WININICHANGE', WM_WININICHANGE);
  APyDelphiWrapper.DefineVar('WM_SETTINGCHANGE', WM_SETTINGCHANGE);
  APyDelphiWrapper.DefineVar('WM_DEVMODECHANGE', WM_DEVMODECHANGE);
  APyDelphiWrapper.DefineVar('WM_ACTIVATEAPP', WM_ACTIVATEAPP);
  APyDelphiWrapper.DefineVar('WM_FONTCHANGE', WM_FONTCHANGE);
  APyDelphiWrapper.DefineVar('WM_TIMECHANGE', WM_TIMECHANGE);
  APyDelphiWrapper.DefineVar('WM_CANCELMODE', WM_CANCELMODE);
  APyDelphiWrapper.DefineVar('WM_SETCURSOR', WM_SETCURSOR);
  APyDelphiWrapper.DefineVar('WM_MOUSEACTIVATE', WM_MOUSEACTIVATE);
  APyDelphiWrapper.DefineVar('WM_CHILDACTIVATE', WM_CHILDACTIVATE);
  APyDelphiWrapper.DefineVar('WM_QUEUESYNC', WM_QUEUESYNC);
  APyDelphiWrapper.DefineVar('WM_GETMINMAXINFO', WM_GETMINMAXINFO);
  APyDelphiWrapper.DefineVar('WM_PAINTICON', WM_PAINTICON);
  APyDelphiWrapper.DefineVar('WM_ICONERASEBKGND', WM_ICONERASEBKGND);
  APyDelphiWrapper.DefineVar('WM_NEXTDLGCTL', WM_NEXTDLGCTL);
  APyDelphiWrapper.DefineVar('WM_SPOOLERSTATUS', WM_SPOOLERSTATUS);
  APyDelphiWrapper.DefineVar('WM_DRAWITEM', WM_DRAWITEM);
  APyDelphiWrapper.DefineVar('WM_MEASUREITEM', WM_MEASUREITEM);
  APyDelphiWrapper.DefineVar('WM_DELETEITEM', WM_DELETEITEM);
  APyDelphiWrapper.DefineVar('WM_VKEYTOITEM', WM_VKEYTOITEM);
  APyDelphiWrapper.DefineVar('WM_CHARTOITEM', WM_CHARTOITEM);
  APyDelphiWrapper.DefineVar('WM_SETFONT', WM_SETFONT);
  APyDelphiWrapper.DefineVar('WM_GETFONT', WM_GETFONT);
  APyDelphiWrapper.DefineVar('WM_SETHOTKEY', WM_SETHOTKEY);
  APyDelphiWrapper.DefineVar('WM_GETHOTKEY', WM_GETHOTKEY);
  APyDelphiWrapper.DefineVar('WM_QUERYDRAGICON', WM_QUERYDRAGICON);
  APyDelphiWrapper.DefineVar('WM_COMPAREITEM', WM_COMPAREITEM);
  APyDelphiWrapper.DefineVar('WM_GETOBJECT', WM_GETOBJECT);
  APyDelphiWrapper.DefineVar('WM_COMPACTING', WM_COMPACTING);
  APyDelphiWrapper.DefineVar('WM_COMMNOTIFY', WM_COMMNOTIFY);
  APyDelphiWrapper.DefineVar('WM_WINDOWPOSCHANGING', WM_WINDOWPOSCHANGING);
  APyDelphiWrapper.DefineVar('WM_WINDOWPOSCHANGED', WM_WINDOWPOSCHANGED);
  APyDelphiWrapper.DefineVar('WM_POWER', WM_POWER);
  APyDelphiWrapper.DefineVar('WM_COPYGLOBALDATA', WM_COPYGLOBALDATA);
  APyDelphiWrapper.DefineVar('WM_COPYDATA', WM_COPYDATA);
  APyDelphiWrapper.DefineVar('WM_CANCELJOURNAL', WM_CANCELJOURNAL);
  APyDelphiWrapper.DefineVar('WM_NOTIFY', WM_NOTIFY);
  APyDelphiWrapper.DefineVar('WM_INPUTLANGCHANGEREQUEST', WM_INPUTLANGCHANGEREQUEST);
  APyDelphiWrapper.DefineVar('WM_INPUTLANGCHANGE', WM_INPUTLANGCHANGE);
  APyDelphiWrapper.DefineVar('WM_TCARD', WM_TCARD);
  APyDelphiWrapper.DefineVar('WM_HELP', WM_HELP);
  APyDelphiWrapper.DefineVar('WM_USERCHANGED', WM_USERCHANGED);
  APyDelphiWrapper.DefineVar('WM_NOTIFYFORMAT', WM_NOTIFYFORMAT);
  APyDelphiWrapper.DefineVar('WM_CONTEXTMENU', WM_CONTEXTMENU);
  APyDelphiWrapper.DefineVar('WM_STYLECHANGING', WM_STYLECHANGING);
  APyDelphiWrapper.DefineVar('WM_STYLECHANGED', WM_STYLECHANGED);
  APyDelphiWrapper.DefineVar('WM_DISPLAYCHANGE', WM_DISPLAYCHANGE);
  APyDelphiWrapper.DefineVar('WM_GETICON', WM_GETICON);
  APyDelphiWrapper.DefineVar('WM_SETICON', WM_SETICON);
  APyDelphiWrapper.DefineVar('WM_NCCREATE', WM_NCCREATE);
  APyDelphiWrapper.DefineVar('WM_NCDESTROY', WM_NCDESTROY);
  APyDelphiWrapper.DefineVar('WM_NCCALCSIZE', WM_NCCALCSIZE);
  APyDelphiWrapper.DefineVar('WM_NCHITTEST', WM_NCHITTEST);
  APyDelphiWrapper.DefineVar('WM_NCPAINT', WM_NCPAINT);
  APyDelphiWrapper.DefineVar('WM_NCACTIVATE', WM_NCACTIVATE);
  APyDelphiWrapper.DefineVar('WM_GETDLGCODE', WM_GETDLGCODE);
  APyDelphiWrapper.DefineVar('WM_NCMOUSEMOVE', WM_NCMOUSEMOVE);
  APyDelphiWrapper.DefineVar('WM_NCLBUTTONDOWN', WM_NCLBUTTONDOWN);
  APyDelphiWrapper.DefineVar('WM_NCLBUTTONUP', WM_NCLBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_NCLBUTTONDBLCLK', WM_NCLBUTTONDBLCLK);
  APyDelphiWrapper.DefineVar('WM_NCRBUTTONDOWN', WM_NCRBUTTONDOWN);
  APyDelphiWrapper.DefineVar('WM_NCRBUTTONUP', WM_NCRBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_NCRBUTTONDBLCLK', WM_NCRBUTTONDBLCLK);
  APyDelphiWrapper.DefineVar('WM_NCMBUTTONDOWN', WM_NCMBUTTONDOWN);
  APyDelphiWrapper.DefineVar('WM_NCMBUTTONUP', WM_NCMBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_NCMBUTTONDBLCLK', WM_NCMBUTTONDBLCLK);
  APyDelphiWrapper.DefineVar('WM_NCXBUTTONDOWN', WM_NCXBUTTONDOWN);
  APyDelphiWrapper.DefineVar('WM_NCXBUTTONUP', WM_NCXBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_NCXBUTTONDBLCLK', WM_NCXBUTTONDBLCLK);
  APyDelphiWrapper.DefineVar('WM_INPUT_DEVICE_CHANGE', WM_INPUT_DEVICE_CHANGE);
  APyDelphiWrapper.DefineVar('WM_INPUT', WM_INPUT);
  APyDelphiWrapper.DefineVar('WM_KEYFIRST', WM_KEYFIRST);
  APyDelphiWrapper.DefineVar('WM_KEYDOWN', WM_KEYDOWN);
  APyDelphiWrapper.DefineVar('WM_KEYUP', WM_KEYUP);
  APyDelphiWrapper.DefineVar('WM_CHAR', WM_CHAR);
  APyDelphiWrapper.DefineVar('WM_DEADCHAR', WM_DEADCHAR);
  APyDelphiWrapper.DefineVar('WM_SYSKEYDOWN', WM_SYSKEYDOWN);
  APyDelphiWrapper.DefineVar('WM_SYSKEYUP', WM_SYSKEYUP);
  APyDelphiWrapper.DefineVar('WM_SYSCHAR', WM_SYSCHAR);
  APyDelphiWrapper.DefineVar('WM_SYSDEADCHAR', WM_SYSDEADCHAR);
  APyDelphiWrapper.DefineVar('WM_UNICHAR', WM_UNICHAR);
  APyDelphiWrapper.DefineVar('WM_KEYLAST', WM_KEYLAST);
  APyDelphiWrapper.DefineVar('WM_INITDIALOG', WM_INITDIALOG);
  APyDelphiWrapper.DefineVar('WM_COMMAND', WM_COMMAND);
  APyDelphiWrapper.DefineVar('WM_SYSCOMMAND', WM_SYSCOMMAND);
  APyDelphiWrapper.DefineVar('WM_TIMER', WM_TIMER);
  APyDelphiWrapper.DefineVar('WM_HSCROLL', WM_HSCROLL);
  APyDelphiWrapper.DefineVar('WM_VSCROLL', WM_VSCROLL);
  APyDelphiWrapper.DefineVar('WM_INITMENU', WM_INITMENU);
  APyDelphiWrapper.DefineVar('WM_INITMENUPOPUP', WM_INITMENUPOPUP);
  APyDelphiWrapper.DefineVar('WM_GESTURE', WM_GESTURE);
  APyDelphiWrapper.DefineVar('WM_GESTURENOTIFY', WM_GESTURENOTIFY);
  APyDelphiWrapper.DefineVar('WM_MENUSELECT', WM_MENUSELECT);
  APyDelphiWrapper.DefineVar('WM_MENUCHAR', WM_MENUCHAR);
  APyDelphiWrapper.DefineVar('WM_ENTERIDLE', WM_ENTERIDLE);
  APyDelphiWrapper.DefineVar('WM_MENURBUTTONUP', WM_MENURBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_MENUDRAG', WM_MENUDRAG);
  APyDelphiWrapper.DefineVar('WM_MENUGETOBJECT', WM_MENUGETOBJECT);
  APyDelphiWrapper.DefineVar('WM_UNINITMENUPOPUP', WM_UNINITMENUPOPUP);
  APyDelphiWrapper.DefineVar('WM_MENUCOMMAND', WM_MENUCOMMAND);
  APyDelphiWrapper.DefineVar('WM_CHANGEUISTATE', WM_CHANGEUISTATE);
  APyDelphiWrapper.DefineVar('WM_UPDATEUISTATE', WM_UPDATEUISTATE);
  APyDelphiWrapper.DefineVar('WM_QUERYUISTATE', WM_QUERYUISTATE);
  APyDelphiWrapper.DefineVar('WM_CTLCOLORMSGBOX', WM_CTLCOLORMSGBOX);
  APyDelphiWrapper.DefineVar('WM_CTLCOLOREDIT', WM_CTLCOLOREDIT);
  APyDelphiWrapper.DefineVar('WM_CTLCOLORLISTBOX', WM_CTLCOLORLISTBOX);
  APyDelphiWrapper.DefineVar('WM_CTLCOLORBTN', WM_CTLCOLORBTN);
  APyDelphiWrapper.DefineVar('WM_CTLCOLORDLG', WM_CTLCOLORDLG);
  APyDelphiWrapper.DefineVar('WM_CTLCOLORSCROLLBAR=', WM_CTLCOLORSCROLLBAR);
  APyDelphiWrapper.DefineVar('WM_CTLCOLORSTATIC', WM_CTLCOLORSTATIC);
  APyDelphiWrapper.DefineVar('WM_MOUSEFIRST', WM_MOUSEFIRST);
  APyDelphiWrapper.DefineVar('WM_MOUSEMOVE', WM_MOUSEMOVE);
  APyDelphiWrapper.DefineVar('WM_LBUTTONDOWN', WM_LBUTTONDOWN);
  APyDelphiWrapper.DefineVar('WM_LBUTTONUP', WM_LBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_LBUTTONDBLCLK', WM_LBUTTONDBLCLK);
  APyDelphiWrapper.DefineVar('WM_RBUTTONDOWN', WM_RBUTTONDOWN);
  APyDelphiWrapper.DefineVar('WM_RBUTTONUP', WM_RBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_RBUTTONDBLCLK', WM_RBUTTONDBLCLK);
  APyDelphiWrapper.DefineVar('WM_MBUTTONDOWN', WM_MBUTTONDOWN);
  APyDelphiWrapper.DefineVar('WM_MBUTTONUP', WM_MBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_MBUTTONDBLCLK', WM_MBUTTONDBLCLK);
  APyDelphiWrapper.DefineVar('WM_MOUSEWHEEL', WM_MOUSEWHEEL);
  APyDelphiWrapper.DefineVar('WM_XBUTTONDOWN', WM_XBUTTONDOWN);
  APyDelphiWrapper.DefineVar('WM_XBUTTONUP', WM_XBUTTONUP);
  APyDelphiWrapper.DefineVar('WM_XBUTTONDBLCLK', WM_XBUTTONDBLCLK);
  APyDelphiWrapper.DefineVar('WM_MOUSEHWHEEL', WM_MOUSEHWHEEL);
  APyDelphiWrapper.DefineVar('WM_MOUSELAST', WM_MOUSELAST);
  APyDelphiWrapper.DefineVar('WM_PARENTNOTIFY', WM_PARENTNOTIFY);
  APyDelphiWrapper.DefineVar('WM_ENTERMENULOOP', WM_ENTERMENULOOP);
  APyDelphiWrapper.DefineVar('WM_EXITMENULOOP', WM_EXITMENULOOP);
  APyDelphiWrapper.DefineVar('WM_NEXTMENU', WM_NEXTMENU);
  APyDelphiWrapper.DefineVar('WM_SIZING', WM_SIZING);
  APyDelphiWrapper.DefineVar('WM_CAPTURECHANGED', WM_CAPTURECHANGED);
  APyDelphiWrapper.DefineVar('WM_MOVING', WM_MOVING);
  APyDelphiWrapper.DefineVar('WM_POWERBROADCAST', WM_POWERBROADCAST);
  APyDelphiWrapper.DefineVar('WM_DEVICECHANGE', WM_DEVICECHANGE);
  APyDelphiWrapper.DefineVar('WM_IME_STARTCOMPOSITION', WM_IME_STARTCOMPOSITION);
  APyDelphiWrapper.DefineVar('WM_IME_ENDCOMPOSITION', WM_IME_ENDCOMPOSITION);
  APyDelphiWrapper.DefineVar('WM_IME_COMPOSITION', WM_IME_COMPOSITION);
  APyDelphiWrapper.DefineVar('WM_IME_KEYLAST', WM_IME_KEYLAST);
  APyDelphiWrapper.DefineVar('WM_IME_SETCONTEXT', WM_IME_SETCONTEXT);
  APyDelphiWrapper.DefineVar('WM_IME_NOTIFY', WM_IME_NOTIFY);
  APyDelphiWrapper.DefineVar('WM_IME_CONTROL', WM_IME_CONTROL);
  APyDelphiWrapper.DefineVar('WM_IME_COMPOSITIONFULL', WM_IME_COMPOSITIONFULL);
  APyDelphiWrapper.DefineVar('WM_IME_SELECT', WM_IME_SELECT);
  APyDelphiWrapper.DefineVar('WM_IME_CHAR', WM_IME_CHAR);
  APyDelphiWrapper.DefineVar('WM_IME_REQUEST', WM_IME_REQUEST);
  APyDelphiWrapper.DefineVar('WM_IME_KEYDOWN', WM_IME_KEYDOWN);
  APyDelphiWrapper.DefineVar('WM_IME_KEYUP', WM_IME_KEYUP);
  APyDelphiWrapper.DefineVar('WM_MDICREATE', WM_MDICREATE);
  APyDelphiWrapper.DefineVar('WM_MDIDESTROY', WM_MDIDESTROY);
  APyDelphiWrapper.DefineVar('WM_MDIACTIVATE', WM_MDIACTIVATE);
  APyDelphiWrapper.DefineVar('WM_MDIRESTORE', WM_MDIRESTORE);
  APyDelphiWrapper.DefineVar('WM_MDINEXT', WM_MDINEXT);
  APyDelphiWrapper.DefineVar('WM_MDIMAXIMIZE', WM_MDIMAXIMIZE);
  APyDelphiWrapper.DefineVar('WM_MDITILE', WM_MDITILE);
  APyDelphiWrapper.DefineVar('WM_MDICASCADE', WM_MDICASCADE);
  APyDelphiWrapper.DefineVar('WM_MDIICONARRANGE', WM_MDIICONARRANGE);
  APyDelphiWrapper.DefineVar('WM_MDIGETACTIVE', WM_MDIGETACTIVE);
  APyDelphiWrapper.DefineVar('WM_MDISETMENU', WM_MDISETMENU);
  APyDelphiWrapper.DefineVar('WM_ENTERSIZEMOVE', WM_ENTERSIZEMOVE);
  APyDelphiWrapper.DefineVar('WM_EXITSIZEMOVE', WM_EXITSIZEMOVE);
  APyDelphiWrapper.DefineVar('WM_DROPFILES', WM_DROPFILES);
  APyDelphiWrapper.DefineVar('WM_MDIREFRESHMENU', WM_MDIREFRESHMENU);
  APyDelphiWrapper.DefineVar('WM_POINTERDEVICECHANGE', WM_POINTERDEVICECHANGE);
  APyDelphiWrapper.DefineVar('WM_POINTERDEVICEINRANGE', WM_POINTERDEVICEINRANGE);
  APyDelphiWrapper.DefineVar('WM_POINTERDEVICEOUTOFRANGE', WM_POINTERDEVICEOUTOFRANGE);
  APyDelphiWrapper.DefineVar('WM_TOUCH', WM_TOUCH);
  APyDelphiWrapper.DefineVar('WM_NCPOINTERUPDATE', WM_NCPOINTERUPDATE);
  APyDelphiWrapper.DefineVar('WM_NCPOINTERDOWN', WM_NCPOINTERDOWN);
  APyDelphiWrapper.DefineVar('WM_NCPOINTERUP', WM_NCPOINTERUP);
  APyDelphiWrapper.DefineVar('WM_POINTERUPDATE', WM_POINTERUPDATE);
  APyDelphiWrapper.DefineVar('WM_POINTERDOWN', WM_POINTERDOWN);
  APyDelphiWrapper.DefineVar('WM_POINTERUP', WM_POINTERUP);
  APyDelphiWrapper.DefineVar('WM_POINTERENTER', WM_POINTERENTER);
  APyDelphiWrapper.DefineVar('WM_POINTERLEAVE', WM_POINTERLEAVE);
  APyDelphiWrapper.DefineVar('WM_POINTERACTIVATE', WM_POINTERACTIVATE);
  APyDelphiWrapper.DefineVar('WM_POINTERCAPTURECHANGED', WM_POINTERCAPTURECHANGED);
  APyDelphiWrapper.DefineVar('WM_TOUCHHITTESTING', WM_TOUCHHITTESTING);
  APyDelphiWrapper.DefineVar('WM_POINTERWHEEL', WM_POINTERWHEEL);
  APyDelphiWrapper.DefineVar('WM_POINTERHWHEEL', WM_POINTERHWHEEL);
  APyDelphiWrapper.DefineVar('DM_POINTERHITTEST', DM_POINTERHITTEST);
  APyDelphiWrapper.DefineVar('WM_POINTERROUTEDTO', WM_POINTERROUTEDTO);
  APyDelphiWrapper.DefineVar('WM_POINTERROUTEDAWAY', WM_POINTERROUTEDAWAY);
  APyDelphiWrapper.DefineVar('WM_POINTERROUTEDRELEASED', WM_POINTERROUTEDRELEASED);
  APyDelphiWrapper.DefineVar('WM_MOUSEHOVER', WM_MOUSEHOVER);
  APyDelphiWrapper.DefineVar('WM_MOUSELEAVE', WM_MOUSELEAVE);
  APyDelphiWrapper.DefineVar('WM_NCMOUSEHOVER', WM_NCMOUSEHOVER);
  APyDelphiWrapper.DefineVar('WM_NCMOUSELEAVE', WM_NCMOUSELEAVE);
  APyDelphiWrapper.DefineVar('WM_WTSSESSION_CHANGE', WM_WTSSESSION_CHANGE);
  APyDelphiWrapper.DefineVar('WM_TABLET_FIRST', WM_TABLET_FIRST);
  APyDelphiWrapper.DefineVar('WM_TABLET_LAST', WM_TABLET_LAST);
  APyDelphiWrapper.DefineVar('WM_DPICHANGED', WM_DPICHANGED);
  APyDelphiWrapper.DefineVar('WM_DPICHANGED_BEFOREPARENT', WM_DPICHANGED_BEFOREPARENT);
  APyDelphiWrapper.DefineVar('WM_DPICHANGED_AFTERPARENT', WM_DPICHANGED_AFTERPARENT);
  APyDelphiWrapper.DefineVar('WM_GETDPISCALEDSIZE', WM_GETDPISCALEDSIZE);
  APyDelphiWrapper.DefineVar('WM_CUT', WM_CUT);
  APyDelphiWrapper.DefineVar('WM_COPY', WM_COPY);
  APyDelphiWrapper.DefineVar('WM_PASTE', WM_PASTE);
  APyDelphiWrapper.DefineVar('WM_CLEAR', WM_CLEAR);
  APyDelphiWrapper.DefineVar('WM_UNDO', WM_UNDO);
  APyDelphiWrapper.DefineVar('WM_RENDERFORMAT', WM_RENDERFORMAT);
  APyDelphiWrapper.DefineVar('WM_RENDERALLFORMATS', WM_RENDERALLFORMATS);
  APyDelphiWrapper.DefineVar('WM_DESTROYCLIPBOARD', WM_DESTROYCLIPBOARD);
  APyDelphiWrapper.DefineVar('WM_DRAWCLIPBOARD', WM_DRAWCLIPBOARD);
  APyDelphiWrapper.DefineVar('WM_PAINTCLIPBOARD', WM_PAINTCLIPBOARD);
  APyDelphiWrapper.DefineVar('WM_VSCROLLCLIPBOARD', WM_VSCROLLCLIPBOARD);
  APyDelphiWrapper.DefineVar('WM_SIZECLIPBOARD', WM_SIZECLIPBOARD);
  APyDelphiWrapper.DefineVar('WM_ASKCBFORMATNAME', WM_ASKCBFORMATNAME);
  APyDelphiWrapper.DefineVar('WM_CHANGECBCHAIN', WM_CHANGECBCHAIN);
  APyDelphiWrapper.DefineVar('WM_HSCROLLCLIPBOARD', WM_HSCROLLCLIPBOARD);
  APyDelphiWrapper.DefineVar('WM_QUERYNEWPALETTE', WM_QUERYNEWPALETTE);
  APyDelphiWrapper.DefineVar('WM_PALETTEISCHANGING=', WM_PALETTEISCHANGING);
  APyDelphiWrapper.DefineVar('WM_PALETTECHANGED', WM_PALETTECHANGED);
  APyDelphiWrapper.DefineVar('WM_HOTKEY', WM_HOTKEY);
  APyDelphiWrapper.DefineVar('WM_PRINT', WM_PRINT);
  APyDelphiWrapper.DefineVar('WM_PRINTCLIENT', WM_PRINTCLIENT);
  APyDelphiWrapper.DefineVar('WM_APPCOMMAND', WM_APPCOMMAND);
  APyDelphiWrapper.DefineVar('WM_THEMECHANGED', WM_THEMECHANGED);
  APyDelphiWrapper.DefineVar('WM_CLIPBOARDUPDATE', WM_CLIPBOARDUPDATE);
  APyDelphiWrapper.DefineVar('WM_HANDHELDFIRST', WM_HANDHELDFIRST);
  APyDelphiWrapper.DefineVar('WM_HANDHELDLAST', WM_HANDHELDLAST);
  APyDelphiWrapper.DefineVar('WM_PENWINFIRST', WM_PENWINFIRST);
  APyDelphiWrapper.DefineVar('WM_PENWINLAST', WM_PENWINLAST);
  APyDelphiWrapper.DefineVar('WM_COALESCE_FIRST', WM_COALESCE_FIRST);
  APyDelphiWrapper.DefineVar('WM_COALESCE_LAST', WM_COALESCE_LAST);
  APyDelphiWrapper.DefineVar('WM_DDE_FIRST', WM_DDE_FIRST);
  APyDelphiWrapper.DefineVar('WM_DDE_INITIATE', WM_DDE_INITIATE);
  APyDelphiWrapper.DefineVar('WM_DDE_TERMINATE', WM_DDE_TERMINATE);
  APyDelphiWrapper.DefineVar('WM_DDE_ADVISE', WM_DDE_ADVISE);
  APyDelphiWrapper.DefineVar('WM_DDE_UNADVISE', WM_DDE_UNADVISE);
  APyDelphiWrapper.DefineVar('WM_DDE_ACK', WM_DDE_ACK);
  APyDelphiWrapper.DefineVar('WM_DDE_DATA', WM_DDE_DATA);
  APyDelphiWrapper.DefineVar('WM_DDE_REQUEST', WM_DDE_REQUEST);
  APyDelphiWrapper.DefineVar('WM_DDE_POKE', WM_DDE_POKE);
  APyDelphiWrapper.DefineVar('WM_DDE_EXECUTE', WM_DDE_EXECUTE);
  APyDelphiWrapper.DefineVar('WM_DDE_LAST', WM_DDE_LAST);
  APyDelphiWrapper.DefineVar('WM_DWMCOMPOSITIONCHANGED', WM_DWMCOMPOSITIONCHANGED);
  APyDelphiWrapper.DefineVar('WM_DWMNCRENDERINGCHANGED', WM_DWMNCRENDERINGCHANGED);
  APyDelphiWrapper.DefineVar('WM_DWMCOLORIZATIONCOLORCHANGED', WM_DWMCOLORIZATIONCOLORCHANGED);
  APyDelphiWrapper.DefineVar('WM_DWMWINDOWMAXIMIZEDCHANGE', WM_DWMWINDOWMAXIMIZEDCHANGE);
  APyDelphiWrapper.DefineVar('WM_DWMSENDICONICTHUMBNAIL', WM_DWMSENDICONICTHUMBNAIL);
  APyDelphiWrapper.DefineVar('WM_DWMSENDICONICLIVEPREVIEWBITMAP', WM_DWMSENDICONICLIVEPREVIEWBITMAP);
  APyDelphiWrapper.DefineVar('WM_GETTITLEBARINFOEX', WM_GETTITLEBARINFOEX);
  APyDelphiWrapper.DefineVar('WM_TABLET_DEFBASE', WM_TABLET_DEFBASE);
  APyDelphiWrapper.DefineVar('WM_TABLET_MAXOFFSET', WM_TABLET_MAXOFFSET);
  APyDelphiWrapper.DefineVar('WM_TABLET_ADDED', WM_TABLET_ADDED);
  APyDelphiWrapper.DefineVar('WM_TABLET_DELETED', WM_TABLET_DELETED);
  APyDelphiWrapper.DefineVar('WM_TABLET_FLICK', WM_TABLET_FLICK);
  APyDelphiWrapper.DefineVar('WM_TABLET_QUERYSYSTEMGESTURESTATUS', WM_TABLET_QUERYSYSTEMGESTURESTATUS);
  APyDelphiWrapper.DefineVar('WM_APP', WM_APP);
  APyDelphiWrapper.DefineVar('WM_USER', WM_USER);
  APyDelphiWrapper.DefineVar('BN_CLICKED', BN_CLICKED);
  APyDelphiWrapper.DefineVar('BN_PAINT', BN_PAINT);
  APyDelphiWrapper.DefineVar('BN_HILITE', BN_HILITE);
  APyDelphiWrapper.DefineVar('BN_UNHILITE', BN_UNHILITE);
  APyDelphiWrapper.DefineVar('BN_DISABLE', BN_DISABLE);
  APyDelphiWrapper.DefineVar('BN_DOUBLECLICKED', BN_DOUBLECLICKED);
  APyDelphiWrapper.DefineVar('BN_PUSHED', BN_PUSHED);
  APyDelphiWrapper.DefineVar('BN_UNPUSHED', BN_UNPUSHED);
  APyDelphiWrapper.DefineVar('BN_DBLCLK', BN_DBLCLK);
  APyDelphiWrapper.DefineVar('BN_SETFOCUS', BN_SETFOCUS);
  APyDelphiWrapper.DefineVar('BN_KILLFOCUS', BN_KILLFOCUS);
  APyDelphiWrapper.DefineVar('BM_GETCHECK', BM_GETCHECK);
  APyDelphiWrapper.DefineVar('BM_SETCHECK', BM_SETCHECK);
  APyDelphiWrapper.DefineVar('BM_GETSTATE', BM_GETSTATE);
  APyDelphiWrapper.DefineVar('BM_SETSTATE', BM_SETSTATE);
  APyDelphiWrapper.DefineVar('BM_SETSTYLE', BM_SETSTYLE);
  APyDelphiWrapper.DefineVar('BM_CLICK', BM_CLICK);
  APyDelphiWrapper.DefineVar('BM_GETIMAGE', BM_GETIMAGE);
  APyDelphiWrapper.DefineVar('BM_SETIMAGE', BM_SETIMAGE);
  APyDelphiWrapper.DefineVar('BM_SETDONTCLICK', BM_SETDONTCLICK);
  APyDelphiWrapper.DefineVar('LBN_ERRSPACE', LBN_ERRSPACE);
  APyDelphiWrapper.DefineVar('LBN_SELCHANGE', LBN_SELCHANGE);
  APyDelphiWrapper.DefineVar('LBN_DBLCLK', LBN_DBLCLK);
  APyDelphiWrapper.DefineVar('LBN_SELCANCEL', LBN_SELCANCEL);
  APyDelphiWrapper.DefineVar('LBN_SETFOCUS', LBN_SETFOCUS);
  APyDelphiWrapper.DefineVar('LBN_KILLFOCUS', LBN_KILLFOCUS);
  APyDelphiWrapper.DefineVar('LB_ADDSTRING', LB_ADDSTRING);
  APyDelphiWrapper.DefineVar('LB_INSERTSTRING', LB_INSERTSTRING);
  APyDelphiWrapper.DefineVar('LB_DELETESTRING', LB_DELETESTRING);
  APyDelphiWrapper.DefineVar('LB_SELITEMRANGEEX', LB_SELITEMRANGEEX);
  APyDelphiWrapper.DefineVar('LB_RESETCONTENT', LB_RESETCONTENT);
  APyDelphiWrapper.DefineVar('LB_SETSEL', LB_SETSEL);
  APyDelphiWrapper.DefineVar('LB_SETCURSEL', LB_SETCURSEL);
  APyDelphiWrapper.DefineVar('LB_GETSEL', LB_GETSEL);
  APyDelphiWrapper.DefineVar('LB_GETCURSEL', LB_GETCURSEL);
  APyDelphiWrapper.DefineVar('LB_GETTEXT', LB_GETTEXT);
  APyDelphiWrapper.DefineVar('LB_GETTEXTLEN', LB_GETTEXTLEN);
  APyDelphiWrapper.DefineVar('LB_GETCOUNT', LB_GETCOUNT);
  APyDelphiWrapper.DefineVar('LB_SELECTSTRING', LB_SELECTSTRING);
  APyDelphiWrapper.DefineVar('LB_DIR', LB_DIR);
  APyDelphiWrapper.DefineVar('LB_GETTOPINDEX', LB_GETTOPINDEX);
  APyDelphiWrapper.DefineVar('LB_FINDSTRING', LB_FINDSTRING);
  APyDelphiWrapper.DefineVar('LB_GETSELCOUNT', LB_GETSELCOUNT);
  APyDelphiWrapper.DefineVar('LB_GETSELITEMS', LB_GETSELITEMS);
  APyDelphiWrapper.DefineVar('LB_SETTABSTOPS', LB_SETTABSTOPS);
  APyDelphiWrapper.DefineVar('LB_GETHORIZONTALEXTENT', LB_GETHORIZONTALEXTENT);
  APyDelphiWrapper.DefineVar('LB_SETHORIZONTALEXTENT', LB_SETHORIZONTALEXTENT);
  APyDelphiWrapper.DefineVar('LB_SETCOLUMNWIDTH', LB_SETCOLUMNWIDTH);
  APyDelphiWrapper.DefineVar('LB_ADDFILE', LB_ADDFILE);
  APyDelphiWrapper.DefineVar('LB_SETTOPINDEX', LB_SETTOPINDEX);
  APyDelphiWrapper.DefineVar('LB_GETITEMRECT', LB_GETITEMRECT);
  APyDelphiWrapper.DefineVar('LB_GETITEMDATA', LB_GETITEMDATA);
  APyDelphiWrapper.DefineVar('LB_SETITEMDATA', LB_SETITEMDATA);
  APyDelphiWrapper.DefineVar('LB_SELITEMRANGE', LB_SELITEMRANGE);
  APyDelphiWrapper.DefineVar('LB_SETANCHORINDEX', LB_SETANCHORINDEX);
  APyDelphiWrapper.DefineVar('LB_GETANCHORINDEX', LB_GETANCHORINDEX);
  APyDelphiWrapper.DefineVar('LB_SETCARETINDEX', LB_SETCARETINDEX);
  APyDelphiWrapper.DefineVar('LB_GETCARETINDEX', LB_GETCARETINDEX);
  APyDelphiWrapper.DefineVar('LB_SETITEMHEIGHT', LB_SETITEMHEIGHT);
  APyDelphiWrapper.DefineVar('LB_GETITEMHEIGHT', LB_GETITEMHEIGHT);
  APyDelphiWrapper.DefineVar('LB_FINDSTRINGEXACT', LB_FINDSTRINGEXACT);
  APyDelphiWrapper.DefineVar('LB_SETLOCALE', LB_SETLOCALE);
  APyDelphiWrapper.DefineVar('LB_GETLOCALE', LB_GETLOCALE);
  APyDelphiWrapper.DefineVar('LB_SETCOUNT', LB_SETCOUNT);
  APyDelphiWrapper.DefineVar('LB_INITSTORAGE', LB_INITSTORAGE);
  APyDelphiWrapper.DefineVar('LB_ITEMFROMPOINT', LB_ITEMFROMPOINT);
  APyDelphiWrapper.DefineVar('LB_MSGMAX', LB_MSGMAX);
  APyDelphiWrapper.DefineVar('CBN_ERRSPACE', CBN_ERRSPACE);
  APyDelphiWrapper.DefineVar('CBN_SELCHANGE', CBN_SELCHANGE);
  APyDelphiWrapper.DefineVar('CBN_DBLCLK', CBN_DBLCLK);
  APyDelphiWrapper.DefineVar('CBN_SETFOCUS', CBN_SETFOCUS);
  APyDelphiWrapper.DefineVar('CBN_KILLFOCUS', CBN_KILLFOCUS);
  APyDelphiWrapper.DefineVar('CBN_EDITCHANGE', CBN_EDITCHANGE);
  APyDelphiWrapper.DefineVar('CBN_EDITUPDATE', CBN_EDITUPDATE);
  APyDelphiWrapper.DefineVar('CBN_DROPDOWN', CBN_DROPDOWN);
  APyDelphiWrapper.DefineVar('CBN_CLOSEUP', CBN_CLOSEUP);
  APyDelphiWrapper.DefineVar('CBN_SELENDOK', CBN_SELENDOK);
  APyDelphiWrapper.DefineVar('CBN_SELENDCANCEL', CBN_SELENDCANCEL);
  APyDelphiWrapper.DefineVar('CB_GETEDITSEL', CB_GETEDITSEL);
  APyDelphiWrapper.DefineVar('CB_LIMITTEXT', CB_LIMITTEXT);
  APyDelphiWrapper.DefineVar('CB_SETEDITSEL', CB_SETEDITSEL);
  APyDelphiWrapper.DefineVar('CB_ADDSTRING', CB_ADDSTRING);
  APyDelphiWrapper.DefineVar('CB_DELETESTRING', CB_DELETESTRING);
  APyDelphiWrapper.DefineVar('CB_DIR', CB_DIR);
  APyDelphiWrapper.DefineVar('CB_GETCOUNT', CB_GETCOUNT);
  APyDelphiWrapper.DefineVar('CB_GETCURSEL', CB_GETCURSEL);
  APyDelphiWrapper.DefineVar('CB_GETLBTEXT', CB_GETLBTEXT);
  APyDelphiWrapper.DefineVar('CB_GETLBTEXTLEN', CB_GETLBTEXTLEN);
  APyDelphiWrapper.DefineVar('CB_INSERTSTRING', CB_INSERTSTRING);
  APyDelphiWrapper.DefineVar('CB_RESETCONTENT', CB_RESETCONTENT);
  APyDelphiWrapper.DefineVar('CB_FINDSTRING', CB_FINDSTRING);
  APyDelphiWrapper.DefineVar('CB_SELECTSTRING', CB_SELECTSTRING);
  APyDelphiWrapper.DefineVar('CB_SETCURSEL', CB_SETCURSEL);
  APyDelphiWrapper.DefineVar('CB_SHOWDROPDOWN', CB_SHOWDROPDOWN);
  APyDelphiWrapper.DefineVar('CB_GETITEMDATA', CB_GETITEMDATA);
  APyDelphiWrapper.DefineVar('CB_SETITEMDATA', CB_SETITEMDATA);
  APyDelphiWrapper.DefineVar('CB_GETDROPPEDCONTROLRECT', CB_GETDROPPEDCONTROLRECT);
  APyDelphiWrapper.DefineVar('CB_SETITEMHEIGHT', CB_SETITEMHEIGHT);
  APyDelphiWrapper.DefineVar('CB_GETITEMHEIGHT', CB_GETITEMHEIGHT);
  APyDelphiWrapper.DefineVar('CB_SETEXTENDEDUI', CB_SETEXTENDEDUI);
  APyDelphiWrapper.DefineVar('CB_GETEXTENDEDUI', CB_GETEXTENDEDUI);
  APyDelphiWrapper.DefineVar('CB_GETDROPPEDSTATE', CB_GETDROPPEDSTATE);
  APyDelphiWrapper.DefineVar('CB_FINDSTRINGEXACT', CB_FINDSTRINGEXACT);
  APyDelphiWrapper.DefineVar('CB_SETLOCALE', CB_SETLOCALE);
  APyDelphiWrapper.DefineVar('CB_GETLOCALE', CB_GETLOCALE);
  APyDelphiWrapper.DefineVar('CB_GETTOPINDEX', CB_GETTOPINDEX);
  APyDelphiWrapper.DefineVar('CB_SETTOPINDEX', CB_SETTOPINDEX);
  APyDelphiWrapper.DefineVar('CB_GETHORIZONTALEXTENT', CB_GETHORIZONTALEXTENT);
  APyDelphiWrapper.DefineVar('CB_SETHORIZONTALEXTENT', CB_SETHORIZONTALEXTENT);
  APyDelphiWrapper.DefineVar('CB_GETDROPPEDWIDTH', CB_GETDROPPEDWIDTH);
  APyDelphiWrapper.DefineVar('CB_SETDROPPEDWIDTH', CB_SETDROPPEDWIDTH);
  APyDelphiWrapper.DefineVar('CB_INITSTORAGE', CB_INITSTORAGE);
  APyDelphiWrapper.DefineVar('CB_MSGMAX', CB_MSGMAX);
  APyDelphiWrapper.DefineVar('EN_SETFOCUS', EN_SETFOCUS);
  APyDelphiWrapper.DefineVar('EN_KILLFOCUS', EN_KILLFOCUS);
  APyDelphiWrapper.DefineVar('EN_CHANGE', EN_CHANGE);
  APyDelphiWrapper.DefineVar('EN_UPDATE', EN_UPDATE);
  APyDelphiWrapper.DefineVar('EN_ERRSPACE', EN_ERRSPACE);
  APyDelphiWrapper.DefineVar('EN_MAXTEXT', EN_MAXTEXT);
  APyDelphiWrapper.DefineVar('EN_HSCROLL', EN_HSCROLL);
  APyDelphiWrapper.DefineVar('EN_VSCROLL', EN_VSCROLL);
  APyDelphiWrapper.DefineVar('EM_GETSEL', EM_GETSEL);
  APyDelphiWrapper.DefineVar('EM_SETSEL', EM_SETSEL);
  APyDelphiWrapper.DefineVar('EM_GETRECT', EM_GETRECT);
  APyDelphiWrapper.DefineVar('EM_SETRECT', EM_SETRECT);
  APyDelphiWrapper.DefineVar('EM_SETRECTNP', EM_SETRECTNP);
  APyDelphiWrapper.DefineVar('EM_SCROLL', EM_SCROLL);
  APyDelphiWrapper.DefineVar('EM_LINESCROLL', EM_LINESCROLL);
  APyDelphiWrapper.DefineVar('EM_SCROLLCARET', EM_SCROLLCARET);
  APyDelphiWrapper.DefineVar('EM_GETMODIFY', EM_GETMODIFY);
  APyDelphiWrapper.DefineVar('EM_SETMODIFY', EM_SETMODIFY);
  APyDelphiWrapper.DefineVar('EM_GETLINECOUNT', EM_GETLINECOUNT);
  APyDelphiWrapper.DefineVar('EM_LINEINDEX', EM_LINEINDEX);
  APyDelphiWrapper.DefineVar('EM_SETHANDLE', EM_SETHANDLE);
  APyDelphiWrapper.DefineVar('EM_GETHANDLE', EM_GETHANDLE);
  APyDelphiWrapper.DefineVar('EM_GETTHUMB', EM_GETTHUMB);
  APyDelphiWrapper.DefineVar('EM_LINELENGTH', EM_LINELENGTH);
  APyDelphiWrapper.DefineVar('EM_REPLACESEL', EM_REPLACESEL);
  APyDelphiWrapper.DefineVar('EM_GETLINE', EM_GETLINE);
  APyDelphiWrapper.DefineVar('EM_LIMITTEXT', EM_LIMITTEXT);
  APyDelphiWrapper.DefineVar('EM_CANUNDO', EM_CANUNDO);
  APyDelphiWrapper.DefineVar('EM_UNDO', EM_UNDO);
  APyDelphiWrapper.DefineVar('EM_FMTLINES', EM_FMTLINES);
  APyDelphiWrapper.DefineVar('EM_LINEFROMCHAR', EM_LINEFROMCHAR);
  APyDelphiWrapper.DefineVar('EM_SETTABSTOPS', EM_SETTABSTOPS);
  APyDelphiWrapper.DefineVar('EM_SETPASSWORDCHAR', EM_SETPASSWORDCHAR);
  APyDelphiWrapper.DefineVar('EM_EMPTYUNDOBUFFER', EM_EMPTYUNDOBUFFER);
  APyDelphiWrapper.DefineVar('EM_GETFIRSTVISIBLELINE', EM_GETFIRSTVISIBLELINE);
  APyDelphiWrapper.DefineVar('EM_SETREADONLY', EM_SETREADONLY);
  APyDelphiWrapper.DefineVar('EM_SETWORDBREAKPROC', EM_SETWORDBREAKPROC);
  APyDelphiWrapper.DefineVar('EM_GETWORDBREAKPROC', EM_GETWORDBREAKPROC);
  APyDelphiWrapper.DefineVar('EM_GETPASSWORDCHAR', EM_GETPASSWORDCHAR);
  APyDelphiWrapper.DefineVar('EM_SETMARGINS', EM_SETMARGINS);
  APyDelphiWrapper.DefineVar('EM_GETMARGINS', EM_GETMARGINS);
  APyDelphiWrapper.DefineVar('EM_SETLIMITTEXT', EM_SETLIMITTEXT);
  APyDelphiWrapper.DefineVar('EM_GETLIMITTEXT', EM_GETLIMITTEXT);
  APyDelphiWrapper.DefineVar('EM_POSFROMCHAR', EM_POSFROMCHAR);
  APyDelphiWrapper.DefineVar('EM_CHARFROMPOS', EM_CHARFROMPOS);
  APyDelphiWrapper.DefineVar('EM_SETIMESTATUS', EM_SETIMESTATUS);
  APyDelphiWrapper.DefineVar('EM_GETIMESTATUS', EM_GETIMESTATUS);
  APyDelphiWrapper.DefineVar('EM_ENABLEFEATURE', EM_ENABLEFEATURE);
  APyDelphiWrapper.DefineVar('SBM_SETPOS', SBM_SETPOS);
  APyDelphiWrapper.DefineVar('SBM_GETPOS', SBM_GETPOS);
  APyDelphiWrapper.DefineVar('SBM_SETRANGE', SBM_SETRANGE);
  APyDelphiWrapper.DefineVar('SBM_SETRANGEREDRAW', SBM_SETRANGEREDRAW);
  APyDelphiWrapper.DefineVar('SBM_GETRANGE', SBM_GETRANGE);
  APyDelphiWrapper.DefineVar('SBM_ENABLE_ARROWS', SBM_ENABLE_ARROWS);
  APyDelphiWrapper.DefineVar('SBM_SETSCROLLINFO', SBM_SETSCROLLINFO);
  APyDelphiWrapper.DefineVar('SBM_GETSCROLLINFO', SBM_GETSCROLLINFO);
  APyDelphiWrapper.DefineVar('SBM_GETSCROLLBARINFO', SBM_GETSCROLLBARINFO);
  APyDelphiWrapper.DefineVar('DM_GETDEFID', DM_GETDEFID);
  APyDelphiWrapper.DefineVar('DM_SETDEFID', DM_SETDEFID);
  APyDelphiWrapper.DefineVar('DM_REPOSITION', DM_REPOSITION);

  { SetWindowPos Flags }
  APyDelphiWrapper.DefineVar('SWP_NOSIZE', SWP_NOSIZE);
  APyDelphiWrapper.DefineVar('SWP_NOMOVE', SWP_NOMOVE);
  APyDelphiWrapper.DefineVar('SWP_NOZORDER', SWP_NOZORDER);
  APyDelphiWrapper.DefineVar('SWP_NOREDRAW', SWP_NOREDRAW);
  APyDelphiWrapper.DefineVar('SWP_NOACTIVATE', SWP_NOACTIVATE);
  APyDelphiWrapper.DefineVar('SWP_FRAMECHANGED', SWP_FRAMECHANGED);
  APyDelphiWrapper.DefineVar('SWP_SHOWWINDOW', SWP_SHOWWINDOW);
  APyDelphiWrapper.DefineVar('SWP_HIDEWINDOW', SWP_HIDEWINDOW);
  APyDelphiWrapper.DefineVar('SWP_NOCOPYBITS', SWP_NOCOPYBITS);
  APyDelphiWrapper.DefineVar('SWP_NOOWNERZORDER', SWP_NOOWNERZORDER);
  APyDelphiWrapper.DefineVar('SWP_NOSENDCHANGING', SWP_NOSENDCHANGING);
  APyDelphiWrapper.DefineVar('SWP_DRAWFRAME', SWP_DRAWFRAME);
  APyDelphiWrapper.DefineVar('SWP_NOREPOSITION', SWP_NOREPOSITION);
  APyDelphiWrapper.DefineVar('SWP_DEFERERASE', SWP_DEFERERASE);
  APyDelphiWrapper.DefineVar('SWP_ASYNCWINDOWPOS', SWP_ASYNCWINDOWPOS);

  APyDelphiWrapper.DefineVar('HWND_TOP', 0);
  APyDelphiWrapper.DefineVar('HWND_BOTTOM', 1);
  APyDelphiWrapper.DefineVar('HWND_TOPMOST', -1);
  APyDelphiWrapper.DefineVar('HWND_NOTOPMOST', -2);

  { Ternary raster operations }
  APyDelphiWrapper.DefineVar('SRCCOPY', SRCCOPY);
  APyDelphiWrapper.DefineVar('SRCPAINT', SRCPAINT);
  APyDelphiWrapper.DefineVar('SRCAND', SRCAND);
  APyDelphiWrapper.DefineVar('SRCINVERT', SRCINVERT);
  APyDelphiWrapper.DefineVar('SRCERASE', SRCERASE);
  APyDelphiWrapper.DefineVar('NOTSRCCOPY', NOTSRCCOPY);
  APyDelphiWrapper.DefineVar('NOTSRCERASE', NOTSRCERASE);
  APyDelphiWrapper.DefineVar('MERGECOPY', MERGECOPY);
  APyDelphiWrapper.DefineVar('MERGEPAINT', MERGEPAINT);
  APyDelphiWrapper.DefineVar('PATCOPY', PATCOPY);
  APyDelphiWrapper.DefineVar('PATPAINT', PATPAINT);
  APyDelphiWrapper.DefineVar('PATINVERT', PATINVERT);
  APyDelphiWrapper.DefineVar('DSTINVERT', DSTINVERT);
  APyDelphiWrapper.DefineVar('BLACKNESS', BLACKNESS);
  APyDelphiWrapper.DefineVar('WHITENESS', WHITENESS);

  { Ternary raster operations }
  APyDelphiWrapper.DefineVar('ERROR_SUCCESS', ERROR_SUCCESS);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_FUNCTION', ERROR_INVALID_FUNCTION);
  APyDelphiWrapper.DefineVar('ERROR_FILE_NOT_FOUND', ERROR_FILE_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_PATH_NOT_FOUND', ERROR_PATH_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_OPEN_FILES', ERROR_TOO_MANY_OPEN_FILES);
  APyDelphiWrapper.DefineVar('ERROR_ACCESS_DENIED', ERROR_ACCESS_DENIED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_HANDLE', ERROR_INVALID_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_ARENA_TRASHED', ERROR_ARENA_TRASHED);
  APyDelphiWrapper.DefineVar('ERROR_NOT_ENOUGH_MEMORY', ERROR_NOT_ENOUGH_MEMORY);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_BLOCK', ERROR_INVALID_BLOCK);
  APyDelphiWrapper.DefineVar('ERROR_BAD_ENVIRONMENT', ERROR_BAD_ENVIRONMENT);
  APyDelphiWrapper.DefineVar('ERROR_BAD_FORMAT', ERROR_BAD_FORMAT);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_ACCESS', ERROR_INVALID_ACCESS);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_DATA', ERROR_INVALID_DATA);
  APyDelphiWrapper.DefineVar('ERROR_OUTOFMEMORY', ERROR_OUTOFMEMORY);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_DRIVE', ERROR_INVALID_DRIVE);
  APyDelphiWrapper.DefineVar('ERROR_CURRENT_DIRECTORY', ERROR_CURRENT_DIRECTORY);
  APyDelphiWrapper.DefineVar('ERROR_NOT_SAME_DEVICE', ERROR_NOT_SAME_DEVICE);
  APyDelphiWrapper.DefineVar('ERROR_NO_MORE_FILES', ERROR_NO_MORE_FILES);
  APyDelphiWrapper.DefineVar('ERROR_WRITE_PROTECT', ERROR_WRITE_PROTECT);
  APyDelphiWrapper.DefineVar('ERROR_BAD_UNIT', ERROR_BAD_UNIT);
  APyDelphiWrapper.DefineVar('ERROR_NOT_READY', ERROR_NOT_READY);
  APyDelphiWrapper.DefineVar('ERROR_BAD_COMMAND', ERROR_BAD_COMMAND);
  APyDelphiWrapper.DefineVar('ERROR_CRC', ERROR_CRC);
  APyDelphiWrapper.DefineVar('ERROR_BAD_LENGTH', ERROR_BAD_LENGTH);
  APyDelphiWrapper.DefineVar('ERROR_SEEK', ERROR_SEEK);
  APyDelphiWrapper.DefineVar('ERROR_NOT_DOS_DISK', ERROR_NOT_DOS_DISK);
  APyDelphiWrapper.DefineVar('ERROR_SECTOR_NOT_FOUND', ERROR_SECTOR_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_OUT_OF_PAPER', ERROR_OUT_OF_PAPER);
  APyDelphiWrapper.DefineVar('ERROR_WRITE_FAULT', ERROR_WRITE_FAULT);
  APyDelphiWrapper.DefineVar('ERROR_READ_FAULT', ERROR_READ_FAULT);
  APyDelphiWrapper.DefineVar('ERROR_GEN_FAILURE', ERROR_GEN_FAILURE);
  APyDelphiWrapper.DefineVar('ERROR_SHARING_VIOLATION', ERROR_SHARING_VIOLATION);
  APyDelphiWrapper.DefineVar('ERROR_LOCK_VIOLATION', ERROR_LOCK_VIOLATION);
  APyDelphiWrapper.DefineVar('ERROR_WRONG_DISK', ERROR_WRONG_DISK);
  APyDelphiWrapper.DefineVar('ERROR_SHARING_BUFFER_EXCEEDED', ERROR_SHARING_BUFFER_EXCEEDED);
  APyDelphiWrapper.DefineVar('ERROR_HANDLE_EOF', ERROR_HANDLE_EOF);
  APyDelphiWrapper.DefineVar('ERROR_HANDLE_DISK_FULL', ERROR_HANDLE_DISK_FULL);
  APyDelphiWrapper.DefineVar('ERROR_NOT_SUPPORTED', ERROR_NOT_SUPPORTED);
  APyDelphiWrapper.DefineVar('ERROR_REM_NOT_LIST', ERROR_REM_NOT_LIST);
  APyDelphiWrapper.DefineVar('ERROR_DUP_NAME', ERROR_DUP_NAME);
  APyDelphiWrapper.DefineVar('ERROR_BAD_NETPATH', ERROR_BAD_NETPATH);
  APyDelphiWrapper.DefineVar('ERROR_NETWORK_BUSY', ERROR_NETWORK_BUSY);
  APyDelphiWrapper.DefineVar('ERROR_DEV_NOT_EXIST', ERROR_DEV_NOT_EXIST);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_CMDS', ERROR_TOO_MANY_CMDS);
  APyDelphiWrapper.DefineVar('ERROR_ADAP_HDW_ERR', ERROR_ADAP_HDW_ERR);
  APyDelphiWrapper.DefineVar('ERROR_BAD_NET_RESP', ERROR_BAD_NET_RESP);
  APyDelphiWrapper.DefineVar('ERROR_UNEXP_NET_ERR', ERROR_UNEXP_NET_ERR);
  APyDelphiWrapper.DefineVar('ERROR_BAD_REM_ADAP', ERROR_BAD_REM_ADAP);
  APyDelphiWrapper.DefineVar('ERROR_PRINTQ_FULL', ERROR_PRINTQ_FULL);
  APyDelphiWrapper.DefineVar('ERROR_NO_SPOOL_SPACE', ERROR_NO_SPOOL_SPACE);
  APyDelphiWrapper.DefineVar('ERROR_PRINT_CANCELLED', ERROR_PRINT_CANCELLED);
  APyDelphiWrapper.DefineVar('ERROR_NETNAME_DELETED', ERROR_NETNAME_DELETED);
  APyDelphiWrapper.DefineVar('ERROR_NETWORK_ACCESS_DENIED', ERROR_NETWORK_ACCESS_DENIED);
  APyDelphiWrapper.DefineVar('ERROR_BAD_DEV_TYPE', ERROR_BAD_DEV_TYPE);
  APyDelphiWrapper.DefineVar('ERROR_BAD_NET_NAME', ERROR_BAD_NET_NAME);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_NAMES', ERROR_TOO_MANY_NAMES);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_SESS', ERROR_TOO_MANY_SESS);
  APyDelphiWrapper.DefineVar('ERROR_SHARING_PAUSED', ERROR_SHARING_PAUSED);
  APyDelphiWrapper.DefineVar('ERROR_REQ_NOT_ACCEP', ERROR_REQ_NOT_ACCEP);
  APyDelphiWrapper.DefineVar('ERROR_REDIR_PAUSED', ERROR_REDIR_PAUSED);
  APyDelphiWrapper.DefineVar('ERROR_FILE_EXISTS', ERROR_FILE_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_CANNOT_MAKE', ERROR_CANNOT_MAKE);
  APyDelphiWrapper.DefineVar('ERROR_FAIL_I24', ERROR_FAIL_I24);
  APyDelphiWrapper.DefineVar('ERROR_OUT_OF_STRUCTURES', ERROR_OUT_OF_STRUCTURES);
  APyDelphiWrapper.DefineVar('ERROR_ALREADY_ASSIGNED', ERROR_ALREADY_ASSIGNED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_PASSWORD', ERROR_INVALID_PASSWORD);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_PARAMETER', ERROR_INVALID_PARAMETER);
  APyDelphiWrapper.DefineVar('ERROR_NET_WRITE_FAULT', ERROR_NET_WRITE_FAULT);
  APyDelphiWrapper.DefineVar('ERROR_NO_PROC_SLOTS', ERROR_NO_PROC_SLOTS);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_SEMAPHORES', ERROR_TOO_MANY_SEMAPHORES);
  APyDelphiWrapper.DefineVar('ERROR_EXCL_SEM_ALREADY_OWNED', ERROR_EXCL_SEM_ALREADY_OWNED);
  APyDelphiWrapper.DefineVar('ERROR_SEM_IS_SET', ERROR_SEM_IS_SET);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_SEM_REQUESTS', ERROR_TOO_MANY_SEM_REQUESTS);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_AT_INTERRUPT_TIME', ERROR_INVALID_AT_INTERRUPT_TIME);
  APyDelphiWrapper.DefineVar('ERROR_SEM_OWNER_DIED', ERROR_SEM_OWNER_DIED);
  APyDelphiWrapper.DefineVar('ERROR_SEM_USER_LIMIT', ERROR_SEM_USER_LIMIT);
  APyDelphiWrapper.DefineVar('ERROR_DISK_CHANGE', ERROR_DISK_CHANGE);
  APyDelphiWrapper.DefineVar('ERROR_DRIVE_LOCKED', ERROR_DRIVE_LOCKED);
  APyDelphiWrapper.DefineVar('ERROR_BROKEN_PIPE', ERROR_BROKEN_PIPE);
  APyDelphiWrapper.DefineVar('ERROR_OPEN_FAILED', ERROR_OPEN_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_BUFFER_OVERFLOW', ERROR_BUFFER_OVERFLOW);
  APyDelphiWrapper.DefineVar('ERROR_DISK_FULL', ERROR_DISK_FULL);
  APyDelphiWrapper.DefineVar('ERROR_NO_MORE_SEARCH_HANDLES', ERROR_NO_MORE_SEARCH_HANDLES);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_TARGET_HANDLE', ERROR_INVALID_TARGET_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_CATEGORY', ERROR_INVALID_CATEGORY);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_VERIFY_SWITCH', ERROR_INVALID_VERIFY_SWITCH);
  APyDelphiWrapper.DefineVar('ERROR_BAD_DRIVER_LEVEL', ERROR_BAD_DRIVER_LEVEL);
  APyDelphiWrapper.DefineVar('ERROR_CALL_NOT_IMPLEMENTED', ERROR_CALL_NOT_IMPLEMENTED);
  APyDelphiWrapper.DefineVar('ERROR_SEM_TIMEOUT', ERROR_SEM_TIMEOUT);
  APyDelphiWrapper.DefineVar('ERROR_INSUFFICIENT_BUFFER', ERROR_INSUFFICIENT_BUFFER);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_NAME', ERROR_INVALID_NAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_LEVEL', ERROR_INVALID_LEVEL);
  APyDelphiWrapper.DefineVar('ERROR_NO_VOLUME_LABEL', ERROR_NO_VOLUME_LABEL);
  APyDelphiWrapper.DefineVar('ERROR_MOD_NOT_FOUND', ERROR_MOD_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_PROC_NOT_FOUND', ERROR_PROC_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_WAIT_NO_CHILDREN', ERROR_WAIT_NO_CHILDREN);
  APyDelphiWrapper.DefineVar('ERROR_CHILD_NOT_COMPLETE', ERROR_CHILD_NOT_COMPLETE);
  APyDelphiWrapper.DefineVar('ERROR_DIRECT_ACCESS_HANDLE', ERROR_DIRECT_ACCESS_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_NEGATIVE_SEEK', ERROR_NEGATIVE_SEEK);
  APyDelphiWrapper.DefineVar('ERROR_SEEK_ON_DEVICE', ERROR_SEEK_ON_DEVICE);
  APyDelphiWrapper.DefineVar('ERROR_IS_JOIN_TARGET', ERROR_IS_JOIN_TARGET);
  APyDelphiWrapper.DefineVar('ERROR_IS_JOINED', ERROR_IS_JOINED);
  APyDelphiWrapper.DefineVar('ERROR_IS_SUBSTED', ERROR_IS_SUBSTED);
  APyDelphiWrapper.DefineVar('ERROR_NOT_JOINED', ERROR_NOT_JOINED);
  APyDelphiWrapper.DefineVar('ERROR_NOT_SUBSTED', ERROR_NOT_SUBSTED);
  APyDelphiWrapper.DefineVar('ERROR_JOIN_TO_JOIN', ERROR_JOIN_TO_JOIN);
  APyDelphiWrapper.DefineVar('ERROR_SUBST_TO_SUBST', ERROR_SUBST_TO_SUBST);
  APyDelphiWrapper.DefineVar('ERROR_JOIN_TO_SUBST', ERROR_JOIN_TO_SUBST);
  APyDelphiWrapper.DefineVar('ERROR_SUBST_TO_JOIN', ERROR_SUBST_TO_JOIN);
  APyDelphiWrapper.DefineVar('ERROR_BUSY_DRIVE', ERROR_BUSY_DRIVE);
  APyDelphiWrapper.DefineVar('ERROR_SAME_DRIVE', ERROR_SAME_DRIVE);
  APyDelphiWrapper.DefineVar('ERROR_DIR_NOT_ROOT', ERROR_DIR_NOT_ROOT);
  APyDelphiWrapper.DefineVar('ERROR_DIR_NOT_EMPTY', ERROR_DIR_NOT_EMPTY);
  APyDelphiWrapper.DefineVar('ERROR_IS_SUBST_PATH', ERROR_IS_SUBST_PATH);
  APyDelphiWrapper.DefineVar('ERROR_IS_JOIN_PATH', ERROR_IS_JOIN_PATH);
  APyDelphiWrapper.DefineVar('ERROR_PATH_BUSY', ERROR_PATH_BUSY);
  APyDelphiWrapper.DefineVar('ERROR_IS_SUBST_TARGET', ERROR_IS_SUBST_TARGET);
  APyDelphiWrapper.DefineVar('ERROR_SYSTEM_TRACE', ERROR_SYSTEM_TRACE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_EVENT_COUNT', ERROR_INVALID_EVENT_COUNT);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_MUXWAITERS', ERROR_TOO_MANY_MUXWAITERS);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_LIST_FORMAT', ERROR_INVALID_LIST_FORMAT);
  APyDelphiWrapper.DefineVar('ERROR_LABEL_TOO_LONG', ERROR_LABEL_TOO_LONG);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_TCBS', ERROR_TOO_MANY_TCBS);
  APyDelphiWrapper.DefineVar('ERROR_SIGNAL_REFUSED', ERROR_SIGNAL_REFUSED);
  APyDelphiWrapper.DefineVar('ERROR_DISCARDED', ERROR_DISCARDED);
  APyDelphiWrapper.DefineVar('ERROR_NOT_LOCKED', ERROR_NOT_LOCKED);
  APyDelphiWrapper.DefineVar('ERROR_BAD_THREADID_ADDR', ERROR_BAD_THREADID_ADDR);
  APyDelphiWrapper.DefineVar('ERROR_BAD_ARGUMENTS', ERROR_BAD_ARGUMENTS);
  APyDelphiWrapper.DefineVar('ERROR_BAD_PATHNAME', ERROR_BAD_PATHNAME);
  APyDelphiWrapper.DefineVar('ERROR_SIGNAL_PENDING', ERROR_SIGNAL_PENDING);
  APyDelphiWrapper.DefineVar('ERROR_MAX_THRDS_REACHED', ERROR_MAX_THRDS_REACHED);
  APyDelphiWrapper.DefineVar('ERROR_LOCK_FAILED', ERROR_LOCK_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_BUSY', ERROR_BUSY);
  APyDelphiWrapper.DefineVar('ERROR_CANCEL_VIOLATION', ERROR_CANCEL_VIOLATION);
  APyDelphiWrapper.DefineVar('ERROR_ATOMIC_LOCKS_NOT_SUPPORTED', ERROR_ATOMIC_LOCKS_NOT_SUPPORTED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SEGMENT_NUMBER', ERROR_INVALID_SEGMENT_NUMBER);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_ORDINAL', ERROR_INVALID_ORDINAL);
  APyDelphiWrapper.DefineVar('ERROR_ALREADY_EXISTS', ERROR_ALREADY_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_FLAG_NUMBER', ERROR_INVALID_FLAG_NUMBER);
  APyDelphiWrapper.DefineVar('ERROR_SEM_NOT_FOUND', ERROR_SEM_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_STARTING_CODESEG', ERROR_INVALID_STARTING_CODESEG);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_STACKSEG', ERROR_INVALID_STACKSEG);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_MODULETYPE', ERROR_INVALID_MODULETYPE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_EXE_SIGNATURE', ERROR_INVALID_EXE_SIGNATURE);
  APyDelphiWrapper.DefineVar('ERROR_EXE_MARKED_INVALID', ERROR_EXE_MARKED_INVALID);
  APyDelphiWrapper.DefineVar('ERROR_BAD_EXE_FORMAT', ERROR_BAD_EXE_FORMAT);
  APyDelphiWrapper.DefineVar('ERROR_ITERATED_DATA_EXCEEDS_64k', ERROR_ITERATED_DATA_EXCEEDS_64k);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_MINALLOCSIZE', ERROR_INVALID_MINALLOCSIZE);
  APyDelphiWrapper.DefineVar('ERROR_DYNLINK_FROM_INVALID_RING', ERROR_DYNLINK_FROM_INVALID_RING);
  APyDelphiWrapper.DefineVar('ERROR_IOPL_NOT_ENABLED', ERROR_IOPL_NOT_ENABLED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SEGDPL', ERROR_INVALID_SEGDPL);
  APyDelphiWrapper.DefineVar('ERROR_AUTODATASEG_EXCEEDS_64k', ERROR_AUTODATASEG_EXCEEDS_64k);
  APyDelphiWrapper.DefineVar('ERROR_RING2SEG_MUST_BE_MOVABLE', ERROR_RING2SEG_MUST_BE_MOVABLE);
  APyDelphiWrapper.DefineVar('ERROR_RELOC_CHAIN_XEEDS_SEGLIM', ERROR_RELOC_CHAIN_XEEDS_SEGLIM);
  APyDelphiWrapper.DefineVar('ERROR_INFLOOP_IN_RELOC_CHAIN', ERROR_INFLOOP_IN_RELOC_CHAIN);
  APyDelphiWrapper.DefineVar('ERROR_ENVVAR_NOT_FOUND', ERROR_ENVVAR_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_NO_SIGNAL_SENT', ERROR_NO_SIGNAL_SENT);
  APyDelphiWrapper.DefineVar('ERROR_FILENAME_EXCED_RANGE', ERROR_FILENAME_EXCED_RANGE);
  APyDelphiWrapper.DefineVar('ERROR_RING2_STACK_IN_USE', ERROR_RING2_STACK_IN_USE);
  APyDelphiWrapper.DefineVar('ERROR_META_EXPANSION_TOO_LONG', ERROR_META_EXPANSION_TOO_LONG);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SIGNAL_NUMBER', ERROR_INVALID_SIGNAL_NUMBER);
  APyDelphiWrapper.DefineVar('ERROR_THREAD_1_INACTIVE', ERROR_THREAD_1_INACTIVE);
  APyDelphiWrapper.DefineVar('ERROR_LOCKED', ERROR_LOCKED);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_MODULES', ERROR_TOO_MANY_MODULES);
  APyDelphiWrapper.DefineVar('ERROR_NESTING_NOT_ALLOWED', ERROR_NESTING_NOT_ALLOWED);
  APyDelphiWrapper.DefineVar('ERROR_EXE_MACHINE_TYPE_MISMATCH', ERROR_EXE_MACHINE_TYPE_MISMATCH);
  APyDelphiWrapper.DefineVar('ERROR_BAD_PIPE', ERROR_BAD_PIPE);
  APyDelphiWrapper.DefineVar('ERROR_PIPE_BUSY', ERROR_PIPE_BUSY);
  APyDelphiWrapper.DefineVar('ERROR_NO_DATA', ERROR_NO_DATA);
  APyDelphiWrapper.DefineVar('ERROR_PIPE_NOT_CONNECTED', ERROR_PIPE_NOT_CONNECTED);
  APyDelphiWrapper.DefineVar('ERROR_MORE_DATA', ERROR_MORE_DATA);
  APyDelphiWrapper.DefineVar('ERROR_VC_DISCONNECTED', ERROR_VC_DISCONNECTED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_EA_NAME', ERROR_INVALID_EA_NAME);
  APyDelphiWrapper.DefineVar('ERROR_EA_LIST_INCONSISTENT', ERROR_EA_LIST_INCONSISTENT);
  APyDelphiWrapper.DefineVar('ERROR_NO_MORE_ITEMS', ERROR_NO_MORE_ITEMS);
  APyDelphiWrapper.DefineVar('ERROR_CANNOT_COPY', ERROR_CANNOT_COPY);
  APyDelphiWrapper.DefineVar('ERROR_DIRECTORY', ERROR_DIRECTORY);
  APyDelphiWrapper.DefineVar('ERROR_EAS_DIDNT_FIT', ERROR_EAS_DIDNT_FIT);
  APyDelphiWrapper.DefineVar('ERROR_EA_FILE_CORRUPT', ERROR_EA_FILE_CORRUPT);
  APyDelphiWrapper.DefineVar('ERROR_EA_TABLE_FULL', ERROR_EA_TABLE_FULL);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_EA_HANDLE', ERROR_INVALID_EA_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_EAS_NOT_SUPPORTED', ERROR_EAS_NOT_SUPPORTED);
  APyDelphiWrapper.DefineVar('ERROR_NOT_OWNER', ERROR_NOT_OWNER);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_POSTS', ERROR_TOO_MANY_POSTS);
  APyDelphiWrapper.DefineVar('ERROR_PARTIAL_COPY', ERROR_PARTIAL_COPY);
  APyDelphiWrapper.DefineVar('ERROR_MR_MID_NOT_FOUND', ERROR_MR_MID_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_ADDRESS', ERROR_INVALID_ADDRESS);
  APyDelphiWrapper.DefineVar('ERROR_ARITHMETIC_OVERFLOW', ERROR_ARITHMETIC_OVERFLOW);
  APyDelphiWrapper.DefineVar('ERROR_PIPE_CONNECTED', ERROR_PIPE_CONNECTED);
  APyDelphiWrapper.DefineVar('ERROR_PIPE_LISTENING', ERROR_PIPE_LISTENING);
  APyDelphiWrapper.DefineVar('ERROR_EA_ACCESS_DENIED', ERROR_EA_ACCESS_DENIED);
  APyDelphiWrapper.DefineVar('ERROR_OPERATION_ABORTED', ERROR_OPERATION_ABORTED);
  APyDelphiWrapper.DefineVar('ERROR_IO_INCOMPLETE', ERROR_IO_INCOMPLETE);
  APyDelphiWrapper.DefineVar('ERROR_IO_PENDING', ERROR_IO_PENDING);
  APyDelphiWrapper.DefineVar('ERROR_NOACCESS', ERROR_NOACCESS);
  APyDelphiWrapper.DefineVar('ERROR_SWAPERROR', ERROR_SWAPERROR);
  APyDelphiWrapper.DefineVar('ERROR_STACK_OVERFLOW', ERROR_STACK_OVERFLOW);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_MESSAGE', ERROR_INVALID_MESSAGE);
  APyDelphiWrapper.DefineVar('ERROR_CAN_NOT_COMPLETE', ERROR_CAN_NOT_COMPLETE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_FLAGS', ERROR_INVALID_FLAGS);
  APyDelphiWrapper.DefineVar('ERROR_UNRECOGNIZED_VOLUME', ERROR_UNRECOGNIZED_VOLUME);
  APyDelphiWrapper.DefineVar('ERROR_FILE_INVALID', ERROR_FILE_INVALID);
  APyDelphiWrapper.DefineVar('ERROR_FULLSCREEN_MODE', ERROR_FULLSCREEN_MODE);
  APyDelphiWrapper.DefineVar('ERROR_NO_TOKEN', ERROR_NO_TOKEN);
  APyDelphiWrapper.DefineVar('ERROR_BADDB', ERROR_BADDB);
  APyDelphiWrapper.DefineVar('ERROR_BADKEY', ERROR_BADKEY);
  APyDelphiWrapper.DefineVar('ERROR_CANTOPEN', ERROR_CANTOPEN);
  APyDelphiWrapper.DefineVar('ERROR_CANTREAD', ERROR_CANTREAD);
  APyDelphiWrapper.DefineVar('ERROR_CANTWRITE', ERROR_CANTWRITE);
  APyDelphiWrapper.DefineVar('ERROR_REGISTRY_RECOVERED', ERROR_REGISTRY_RECOVERED);
  APyDelphiWrapper.DefineVar('ERROR_REGISTRY_CORRUPT', ERROR_REGISTRY_CORRUPT);
  APyDelphiWrapper.DefineVar('ERROR_REGISTRY_IO_FAILED', ERROR_REGISTRY_IO_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_NOT_REGISTRY_FILE', ERROR_NOT_REGISTRY_FILE);
  APyDelphiWrapper.DefineVar('ERROR_KEY_DELETED', ERROR_KEY_DELETED);
  APyDelphiWrapper.DefineVar('ERROR_NO_LOG_SPACE', ERROR_NO_LOG_SPACE);
  APyDelphiWrapper.DefineVar('ERROR_KEY_HAS_CHILDREN', ERROR_KEY_HAS_CHILDREN);
  APyDelphiWrapper.DefineVar('ERROR_CHILD_MUST_BE_VOLATILE', ERROR_CHILD_MUST_BE_VOLATILE);
  APyDelphiWrapper.DefineVar('ERROR_NOTIFY_ENUM_DIR', ERROR_NOTIFY_ENUM_DIR);
  APyDelphiWrapper.DefineVar('ERROR_DEPENDENT_SERVICES_RUNNING', ERROR_DEPENDENT_SERVICES_RUNNING);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SERVICE_CONTROL', ERROR_INVALID_SERVICE_CONTROL);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_REQUEST_TIMEOUT', ERROR_SERVICE_REQUEST_TIMEOUT);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_NO_THREAD', ERROR_SERVICE_NO_THREAD);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_DATABASE_LOCKED', ERROR_SERVICE_DATABASE_LOCKED);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_ALREADY_RUNNING', ERROR_SERVICE_ALREADY_RUNNING);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SERVICE_ACCOUNT', ERROR_INVALID_SERVICE_ACCOUNT);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_DISABLED', ERROR_SERVICE_DISABLED);
  APyDelphiWrapper.DefineVar('ERROR_CIRCULAR_DEPENDENCY', ERROR_CIRCULAR_DEPENDENCY);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_DOES_NOT_EXIST', ERROR_SERVICE_DOES_NOT_EXIST);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_CANNOT_ACCEPT_CTRL', ERROR_SERVICE_CANNOT_ACCEPT_CTRL);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_NOT_ACTIVE', ERROR_SERVICE_NOT_ACTIVE);
  APyDelphiWrapper.DefineVar('ERROR_FAILED_SERVICE_CONTROLLER_', ERROR_FAILED_SERVICE_CONTROLLER_);
  APyDelphiWrapper.DefineVar('ERROR_EXCEPTION_IN_SERVICE', ERROR_EXCEPTION_IN_SERVICE);
  APyDelphiWrapper.DefineVar('ERROR_DATABASE_DOES_NOT_EXIST', ERROR_DATABASE_DOES_NOT_EXIST);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_SPECIFIC_ERROR', ERROR_SERVICE_SPECIFIC_ERROR);
  APyDelphiWrapper.DefineVar('ERROR_PROCESS_ABORTED', ERROR_PROCESS_ABORTED);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_DEPENDENCY_FAIL', ERROR_SERVICE_DEPENDENCY_FAIL);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_LOGON_FAILED', ERROR_SERVICE_LOGON_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_START_HANG', ERROR_SERVICE_START_HANG);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SERVICE_LOCK', ERROR_INVALID_SERVICE_LOCK);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_MARKED_FOR_DELETE', ERROR_SERVICE_MARKED_FOR_DELETE);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_EXISTS', ERROR_SERVICE_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_ALREADY_RUNNING_LKG', ERROR_ALREADY_RUNNING_LKG);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_DEPENDENCY_DELETED', ERROR_SERVICE_DEPENDENCY_DELETED);
  APyDelphiWrapper.DefineVar('ERROR_BOOT_ALREADY_ACCEPTED', ERROR_BOOT_ALREADY_ACCEPTED);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_NEVER_STARTED', ERROR_SERVICE_NEVER_STARTED);
  APyDelphiWrapper.DefineVar('ERROR_DUPLICATE_SERVICE_NAME', ERROR_DUPLICATE_SERVICE_NAME);
  APyDelphiWrapper.DefineVar('ERROR_DIFFERENT_SERVICE_ACCOUNT', ERROR_DIFFERENT_SERVICE_ACCOUNT);
  APyDelphiWrapper.DefineVar('ERROR_END_OF_MEDIA', ERROR_END_OF_MEDIA);
  APyDelphiWrapper.DefineVar('ERROR_FILEMARK_DETECTED', ERROR_FILEMARK_DETECTED);
  APyDelphiWrapper.DefineVar('ERROR_BEGINNING_OF_MEDIA', ERROR_BEGINNING_OF_MEDIA);
  APyDelphiWrapper.DefineVar('ERROR_SETMARK_DETECTED', ERROR_SETMARK_DETECTED);
  APyDelphiWrapper.DefineVar('ERROR_NO_DATA_DETECTED', ERROR_NO_DATA_DETECTED);
  APyDelphiWrapper.DefineVar('ERROR_PARTITION_FAILURE', ERROR_PARTITION_FAILURE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_BLOCK_LENGTH', ERROR_INVALID_BLOCK_LENGTH);
  APyDelphiWrapper.DefineVar('ERROR_DEVICE_NOT_PARTITIONED', ERROR_DEVICE_NOT_PARTITIONED);
  APyDelphiWrapper.DefineVar('ERROR_UNABLE_TO_LOCK_MEDIA', ERROR_UNABLE_TO_LOCK_MEDIA);
  APyDelphiWrapper.DefineVar('ERROR_UNABLE_TO_UNLOAD_MEDIA', ERROR_UNABLE_TO_UNLOAD_MEDIA);
  APyDelphiWrapper.DefineVar('ERROR_MEDIA_CHANGED', ERROR_MEDIA_CHANGED);
  APyDelphiWrapper.DefineVar('ERROR_BUS_RESET', ERROR_BUS_RESET);
  APyDelphiWrapper.DefineVar('ERROR_NO_MEDIA_IN_DRIVE', ERROR_NO_MEDIA_IN_DRIVE);
  APyDelphiWrapper.DefineVar('ERROR_NO_UNICODE_TRANSLATION', ERROR_NO_UNICODE_TRANSLATION);
  APyDelphiWrapper.DefineVar('ERROR_DLL_INIT_FAILED', ERROR_DLL_INIT_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_SHUTDOWN_IN_PROGRESS', ERROR_SHUTDOWN_IN_PROGRESS);
  APyDelphiWrapper.DefineVar('ERROR_NO_SHUTDOWN_IN_PROGRESS', ERROR_NO_SHUTDOWN_IN_PROGRESS);
  APyDelphiWrapper.DefineVar('ERROR_IO_DEVICE', ERROR_IO_DEVICE);
  APyDelphiWrapper.DefineVar('ERROR_SERIAL_NO_DEVICE', ERROR_SERIAL_NO_DEVICE);
  APyDelphiWrapper.DefineVar('ERROR_IRQ_BUSY', ERROR_IRQ_BUSY);
  APyDelphiWrapper.DefineVar('ERROR_MORE_WRITES', ERROR_MORE_WRITES);
  APyDelphiWrapper.DefineVar('ERROR_COUNTER_TIMEOUT', ERROR_COUNTER_TIMEOUT);
  APyDelphiWrapper.DefineVar('ERROR_FLOPPY_ID_MARK_NOT_FOUND', ERROR_FLOPPY_ID_MARK_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_FLOPPY_WRONG_CYLINDER', ERROR_FLOPPY_WRONG_CYLINDER);
  APyDelphiWrapper.DefineVar('ERROR_FLOPPY_UNKNOWN_ERROR', ERROR_FLOPPY_UNKNOWN_ERROR);
  APyDelphiWrapper.DefineVar('ERROR_FLOPPY_BAD_REGISTERS', ERROR_FLOPPY_BAD_REGISTERS);
  APyDelphiWrapper.DefineVar('ERROR_DISK_RECALIBRATE_FAILED', ERROR_DISK_RECALIBRATE_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_DISK_OPERATION_FAILED', ERROR_DISK_OPERATION_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_DISK_RESET_FAILED', ERROR_DISK_RESET_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_EOM_OVERFLOW', ERROR_EOM_OVERFLOW);
  APyDelphiWrapper.DefineVar('ERROR_NOT_ENOUGH_SERVER_MEMORY', ERROR_NOT_ENOUGH_SERVER_MEMORY);
  APyDelphiWrapper.DefineVar('ERROR_POSSIBLE_DEADLOCK', ERROR_POSSIBLE_DEADLOCK);
  APyDelphiWrapper.DefineVar('ERROR_MAPPED_ALIGNMENT', ERROR_MAPPED_ALIGNMENT);
  APyDelphiWrapper.DefineVar('ERROR_SET_POWER_STATE_VETOED', ERROR_SET_POWER_STATE_VETOED);
  APyDelphiWrapper.DefineVar('ERROR_SET_POWER_STATE_FAILED', ERROR_SET_POWER_STATE_FAILED);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_LINKS', ERROR_TOO_MANY_LINKS);
  APyDelphiWrapper.DefineVar('ERROR_OLD_WIN_VERSION', ERROR_OLD_WIN_VERSION);
  APyDelphiWrapper.DefineVar('ERROR_APP_WRONG_OS', ERROR_APP_WRONG_OS);
  APyDelphiWrapper.DefineVar('ERROR_SINGLE_INSTANCE_APP', ERROR_SINGLE_INSTANCE_APP);
  APyDelphiWrapper.DefineVar('ERROR_RMODE_APP', ERROR_RMODE_APP);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_DLL', ERROR_INVALID_DLL);
  APyDelphiWrapper.DefineVar('ERROR_NO_ASSOCIATION', ERROR_NO_ASSOCIATION);
  APyDelphiWrapper.DefineVar('ERROR_DDE_FAIL', ERROR_DDE_FAIL);
  APyDelphiWrapper.DefineVar('ERROR_DLL_NOT_FOUND', ERROR_DLL_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_BAD_USERNAME', ERROR_BAD_USERNAME);
  APyDelphiWrapper.DefineVar('ERROR_NOT_CONNECTED', ERROR_NOT_CONNECTED);
  APyDelphiWrapper.DefineVar('ERROR_OPEN_FILES', ERROR_OPEN_FILES);
  APyDelphiWrapper.DefineVar('ERROR_ACTIVE_CONNECTIONS', ERROR_ACTIVE_CONNECTIONS);
  APyDelphiWrapper.DefineVar('ERROR_DEVICE_IN_USE', ERROR_DEVICE_IN_USE);
  APyDelphiWrapper.DefineVar('ERROR_BAD_DEVICE', ERROR_BAD_DEVICE);
  APyDelphiWrapper.DefineVar('ERROR_CONNECTION_UNAVAIL', ERROR_CONNECTION_UNAVAIL);
  APyDelphiWrapper.DefineVar('ERROR_DEVICE_ALREADY_REMEMBERED', ERROR_DEVICE_ALREADY_REMEMBERED);
  APyDelphiWrapper.DefineVar('ERROR_NO_NET_OR_BAD_PATH', ERROR_NO_NET_OR_BAD_PATH);
  APyDelphiWrapper.DefineVar('ERROR_BAD_PROVIDER', ERROR_BAD_PROVIDER);
  APyDelphiWrapper.DefineVar('ERROR_CANNOT_OPEN_PROFILE', ERROR_CANNOT_OPEN_PROFILE);
  APyDelphiWrapper.DefineVar('ERROR_BAD_PROFILE', ERROR_BAD_PROFILE);
  APyDelphiWrapper.DefineVar('ERROR_NOT_CONTAINER', ERROR_NOT_CONTAINER);
  APyDelphiWrapper.DefineVar('ERROR_EXTENDED_ERROR', ERROR_EXTENDED_ERROR);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_GROUPNAME', ERROR_INVALID_GROUPNAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_COMPUTERNAME', ERROR_INVALID_COMPUTERNAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_EVENTNAME', ERROR_INVALID_EVENTNAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_DOMAINNAME', ERROR_INVALID_DOMAINNAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SERVICENAME', ERROR_INVALID_SERVICENAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_NETNAME', ERROR_INVALID_NETNAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SHARENAME', ERROR_INVALID_SHARENAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_PASSWORDNAME', ERROR_INVALID_PASSWORDNAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_MESSAGENAME', ERROR_INVALID_MESSAGENAME);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_MESSAGEDEST', ERROR_INVALID_MESSAGEDEST);
  APyDelphiWrapper.DefineVar('ERROR_SESSION_CREDENTIAL_CONFLICT', ERROR_SESSION_CREDENTIAL_CONFLICT);
  APyDelphiWrapper.DefineVar('ERROR_REMOTE_SESSION_LIMIT_EXCEEDED', ERROR_REMOTE_SESSION_LIMIT_EXCEEDED);
  APyDelphiWrapper.DefineVar('ERROR_DUP_DOMAINNAME', ERROR_DUP_DOMAINNAME);
  APyDelphiWrapper.DefineVar('ERROR_NO_NETWORK', ERROR_NO_NETWORK);
  APyDelphiWrapper.DefineVar('ERROR_CANCELLED', ERROR_CANCELLED);
  APyDelphiWrapper.DefineVar('ERROR_USER_MAPPED_FILE', ERROR_USER_MAPPED_FILE);
  APyDelphiWrapper.DefineVar('ERROR_CONNECTION_REFUSED', ERROR_CONNECTION_REFUSED);
  APyDelphiWrapper.DefineVar('ERROR_GRACEFUL_DISCONNECT', ERROR_GRACEFUL_DISCONNECT);
  APyDelphiWrapper.DefineVar('ERROR_ADDRESS_ALREADY_ASSOCIATED', ERROR_ADDRESS_ALREADY_ASSOCIATED);
  APyDelphiWrapper.DefineVar('ERROR_ADDRESS_NOT_ASSOCIATED', ERROR_ADDRESS_NOT_ASSOCIATED);
  APyDelphiWrapper.DefineVar('ERROR_CONNECTION_INVALID', ERROR_CONNECTION_INVALID);
  APyDelphiWrapper.DefineVar('ERROR_CONNECTION_ACTIVE', ERROR_CONNECTION_ACTIVE);
  APyDelphiWrapper.DefineVar('ERROR_NETWORK_UNREACHABLE', ERROR_NETWORK_UNREACHABLE);
  APyDelphiWrapper.DefineVar('ERROR_HOST_UNREACHABLE', ERROR_HOST_UNREACHABLE);
  APyDelphiWrapper.DefineVar('ERROR_PROTOCOL_UNREACHABLE', ERROR_PROTOCOL_UNREACHABLE);
  APyDelphiWrapper.DefineVar('ERROR_PORT_UNREACHABLE', ERROR_PORT_UNREACHABLE);
  APyDelphiWrapper.DefineVar('ERROR_REQUEST_ABORTED', ERROR_REQUEST_ABORTED);
  APyDelphiWrapper.DefineVar('ERROR_CONNECTION_ABORTED', ERROR_CONNECTION_ABORTED);
  APyDelphiWrapper.DefineVar('ERROR_RETRY', ERROR_RETRY);
  APyDelphiWrapper.DefineVar('ERROR_CONNECTION_COUNT_LIMIT', ERROR_CONNECTION_COUNT_LIMIT);
  APyDelphiWrapper.DefineVar('ERROR_LOGIN_TIME_RESTRICTION', ERROR_LOGIN_TIME_RESTRICTION);
  APyDelphiWrapper.DefineVar('ERROR_LOGIN_WKSTA_RESTRICTION', ERROR_LOGIN_WKSTA_RESTRICTION);
  APyDelphiWrapper.DefineVar('ERROR_INCORRECT_ADDRESS', ERROR_INCORRECT_ADDRESS);
  APyDelphiWrapper.DefineVar('ERROR_ALREADY_REGISTERED', ERROR_ALREADY_REGISTERED);
  APyDelphiWrapper.DefineVar('ERROR_SERVICE_NOT_FOUND', ERROR_SERVICE_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_NOT_AUTHENTICATED', ERROR_NOT_AUTHENTICATED);
  APyDelphiWrapper.DefineVar('ERROR_NOT_LOGGED_ON', ERROR_NOT_LOGGED_ON);
  APyDelphiWrapper.DefineVar('ERROR_CONTINUE', ERROR_CONTINUE);
  APyDelphiWrapper.DefineVar('ERROR_ALREADY_INITIALIZED', ERROR_ALREADY_INITIALIZED);
  APyDelphiWrapper.DefineVar('ERROR_NO_MORE_DEVICES', ERROR_NO_MORE_DEVICES);
  APyDelphiWrapper.DefineVar('ERROR_NOT_ALL_ASSIGNED', ERROR_NOT_ALL_ASSIGNED);
  APyDelphiWrapper.DefineVar('ERROR_SOME_NOT_MAPPED', ERROR_SOME_NOT_MAPPED);
  APyDelphiWrapper.DefineVar('ERROR_NO_QUOTAS_FOR_ACCOUNT', ERROR_NO_QUOTAS_FOR_ACCOUNT);
  APyDelphiWrapper.DefineVar('ERROR_LOCAL_USER_SESSION_KEY', ERROR_LOCAL_USER_SESSION_KEY);
  APyDelphiWrapper.DefineVar('ERROR_NULL_LM_PASSWORD', ERROR_NULL_LM_PASSWORD);
  APyDelphiWrapper.DefineVar('ERROR_UNKNOWN_REVISION', ERROR_UNKNOWN_REVISION);
  APyDelphiWrapper.DefineVar('ERROR_REVISION_MISMATCH', ERROR_REVISION_MISMATCH);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_OWNER', ERROR_INVALID_OWNER);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_PRIMARY_GROUP', ERROR_INVALID_PRIMARY_GROUP);
  APyDelphiWrapper.DefineVar('ERROR_NO_IMPERSONATION_TOKEN', ERROR_NO_IMPERSONATION_TOKEN);
  APyDelphiWrapper.DefineVar('ERROR_CANT_DISABLE_MANDATORY', ERROR_CANT_DISABLE_MANDATORY);
  APyDelphiWrapper.DefineVar('ERROR_NO_LOGON_SERVERS', ERROR_NO_LOGON_SERVERS);
  APyDelphiWrapper.DefineVar('ERROR_NO_SUCH_LOGON_SESSION', ERROR_NO_SUCH_LOGON_SESSION);
  APyDelphiWrapper.DefineVar('ERROR_NO_SUCH_PRIVILEGE', ERROR_NO_SUCH_PRIVILEGE);
  APyDelphiWrapper.DefineVar('ERROR_PRIVILEGE_NOT_HELD', ERROR_PRIVILEGE_NOT_HELD);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_ACCOUNT_NAME', ERROR_INVALID_ACCOUNT_NAME);
  APyDelphiWrapper.DefineVar('ERROR_USER_EXISTS', ERROR_USER_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_NO_SUCH_USER', ERROR_NO_SUCH_USER);
  APyDelphiWrapper.DefineVar('ERROR_GROUP_EXISTS', ERROR_GROUP_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_NO_SUCH_GROUP', ERROR_NO_SUCH_GROUP);
  APyDelphiWrapper.DefineVar('ERROR_MEMBER_IN_GROUP', ERROR_MEMBER_IN_GROUP);
  APyDelphiWrapper.DefineVar('ERROR_MEMBER_NOT_IN_GROUP', ERROR_MEMBER_NOT_IN_GROUP);
  APyDelphiWrapper.DefineVar('ERROR_LAST_ADMIN', ERROR_LAST_ADMIN);
  APyDelphiWrapper.DefineVar('ERROR_WRONG_PASSWORD', ERROR_WRONG_PASSWORD);
  APyDelphiWrapper.DefineVar('ERROR_ILL_FORMED_PASSWORD', ERROR_ILL_FORMED_PASSWORD);
  APyDelphiWrapper.DefineVar('ERROR_PASSWORD_RESTRICTION', ERROR_PASSWORD_RESTRICTION);
  APyDelphiWrapper.DefineVar('ERROR_LOGON_FAILURE', ERROR_LOGON_FAILURE);
  APyDelphiWrapper.DefineVar('ERROR_ACCOUNT_RESTRICTION', ERROR_ACCOUNT_RESTRICTION);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_LOGON_HOURS', ERROR_INVALID_LOGON_HOURS);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_WORKSTATION', ERROR_INVALID_WORKSTATION);
  APyDelphiWrapper.DefineVar('ERROR_PASSWORD_EXPIRED', ERROR_PASSWORD_EXPIRED);
  APyDelphiWrapper.DefineVar('ERROR_ACCOUNT_DISABLED', ERROR_ACCOUNT_DISABLED);
  APyDelphiWrapper.DefineVar('ERROR_NONE_MAPPED', ERROR_NONE_MAPPED);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_LUIDS_REQUESTED', ERROR_TOO_MANY_LUIDS_REQUESTED);
  APyDelphiWrapper.DefineVar('ERROR_LUIDS_EXHAUSTED', ERROR_LUIDS_EXHAUSTED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SUB_AUTHORITY', ERROR_INVALID_SUB_AUTHORITY);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_ACL', ERROR_INVALID_ACL);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SID', ERROR_INVALID_SID);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SECURITY_DESCR', ERROR_INVALID_SECURITY_DESCR);
  APyDelphiWrapper.DefineVar('ERROR_BAD_INHERITANCE_ACL', ERROR_BAD_INHERITANCE_ACL);
  APyDelphiWrapper.DefineVar('ERROR_SERVER_DISABLED', ERROR_SERVER_DISABLED);
  APyDelphiWrapper.DefineVar('ERROR_SERVER_NOT_DISABLED', ERROR_SERVER_NOT_DISABLED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_ID_AUTHORITY', ERROR_INVALID_ID_AUTHORITY);
  APyDelphiWrapper.DefineVar('ERROR_ALLOTTED_SPACE_EXCEEDED', ERROR_ALLOTTED_SPACE_EXCEEDED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_GROUP_ATTRIBUTES', ERROR_INVALID_GROUP_ATTRIBUTES);
  APyDelphiWrapper.DefineVar('ERROR_BAD_IMPERSONATION_LEVEL', ERROR_BAD_IMPERSONATION_LEVEL);
  APyDelphiWrapper.DefineVar('ERROR_CANT_OPEN_ANONYMOUS', ERROR_CANT_OPEN_ANONYMOUS);
  APyDelphiWrapper.DefineVar('ERROR_BAD_VALIDATION_CLASS', ERROR_BAD_VALIDATION_CLASS);
  APyDelphiWrapper.DefineVar('ERROR_BAD_TOKEN_TYPE', ERROR_BAD_TOKEN_TYPE);
  APyDelphiWrapper.DefineVar('ERROR_NO_SECURITY_ON_OBJECT', ERROR_NO_SECURITY_ON_OBJECT);
  APyDelphiWrapper.DefineVar('ERROR_CANT_ACCESS_DOMAIN_INFO', ERROR_CANT_ACCESS_DOMAIN_INFO);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SERVER_STATE', ERROR_INVALID_SERVER_STATE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_DOMAIN_STATE', ERROR_INVALID_DOMAIN_STATE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_DOMAIN_ROLE', ERROR_INVALID_DOMAIN_ROLE);
  APyDelphiWrapper.DefineVar('ERROR_NO_SUCH_DOMAIN', ERROR_NO_SUCH_DOMAIN);
  APyDelphiWrapper.DefineVar('ERROR_DOMAIN_EXISTS', ERROR_DOMAIN_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_DOMAIN_LIMIT_EXCEEDED', ERROR_DOMAIN_LIMIT_EXCEEDED);
  APyDelphiWrapper.DefineVar('ERROR_INTERNAL_DB_CORRUPTION', ERROR_INTERNAL_DB_CORRUPTION);
  APyDelphiWrapper.DefineVar('ERROR_INTERNAL_ERROR', ERROR_INTERNAL_ERROR);
  APyDelphiWrapper.DefineVar('ERROR_GENERIC_NOT_MAPPED', ERROR_GENERIC_NOT_MAPPED);
  APyDelphiWrapper.DefineVar('ERROR_BAD_DESCRIPTOR_FORMAT', ERROR_BAD_DESCRIPTOR_FORMAT);
  APyDelphiWrapper.DefineVar('ERROR_NOT_LOGON_PROCESS', ERROR_NOT_LOGON_PROCESS);
  APyDelphiWrapper.DefineVar('ERROR_LOGON_SESSION_EXISTS', ERROR_LOGON_SESSION_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_NO_SUCH_PACKAGE', ERROR_NO_SUCH_PACKAGE);
  APyDelphiWrapper.DefineVar('ERROR_BAD_LOGON_SESSION_STATE', ERROR_BAD_LOGON_SESSION_STATE);
  APyDelphiWrapper.DefineVar('ERROR_LOGON_SESSION_COLLISION', ERROR_LOGON_SESSION_COLLISION);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_LOGON_TYPE', ERROR_INVALID_LOGON_TYPE);
  APyDelphiWrapper.DefineVar('ERROR_CANNOT_IMPERSONATE', ERROR_CANNOT_IMPERSONATE);
  APyDelphiWrapper.DefineVar('ERROR_RXACT_INVALID_STATE', ERROR_RXACT_INVALID_STATE);
  APyDelphiWrapper.DefineVar('ERROR_RXACT_COMMIT_FAILURE', ERROR_RXACT_COMMIT_FAILURE);
  APyDelphiWrapper.DefineVar('ERROR_SPECIAL_ACCOUNT', ERROR_SPECIAL_ACCOUNT);
  APyDelphiWrapper.DefineVar('ERROR_SPECIAL_GROUP', ERROR_SPECIAL_GROUP);
  APyDelphiWrapper.DefineVar('ERROR_SPECIAL_USER', ERROR_SPECIAL_USER);
  APyDelphiWrapper.DefineVar('ERROR_MEMBERS_PRIMARY_GROUP', ERROR_MEMBERS_PRIMARY_GROUP);
  APyDelphiWrapper.DefineVar('ERROR_TOKEN_ALREADY_IN_USE', ERROR_TOKEN_ALREADY_IN_USE);
  APyDelphiWrapper.DefineVar('ERROR_NO_SUCH_ALIAS', ERROR_NO_SUCH_ALIAS);
  APyDelphiWrapper.DefineVar('ERROR_MEMBER_NOT_IN_ALIAS', ERROR_MEMBER_NOT_IN_ALIAS);
  APyDelphiWrapper.DefineVar('ERROR_MEMBER_IN_ALIAS', ERROR_MEMBER_IN_ALIAS);
  APyDelphiWrapper.DefineVar('ERROR_ALIAS_EXISTS', ERROR_ALIAS_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_LOGON_NOT_GRANTED', ERROR_LOGON_NOT_GRANTED);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_SECRETS', ERROR_TOO_MANY_SECRETS);
  APyDelphiWrapper.DefineVar('ERROR_SECRET_TOO_LONG', ERROR_SECRET_TOO_LONG);
  APyDelphiWrapper.DefineVar('ERROR_INTERNAL_DB_ERROR', ERROR_INTERNAL_DB_ERROR);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_CONTEXT_IDS', ERROR_TOO_MANY_CONTEXT_IDS);
  APyDelphiWrapper.DefineVar('ERROR_LOGON_TYPE_NOT_GRANTED', ERROR_LOGON_TYPE_NOT_GRANTED);
  APyDelphiWrapper.DefineVar('ERROR_NT_CROSS_ENCRYPTION_REQUIRED', ERROR_NT_CROSS_ENCRYPTION_REQUIRED);
  APyDelphiWrapper.DefineVar('ERROR_NO_SUCH_MEMBER', ERROR_NO_SUCH_MEMBER);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_MEMBER', ERROR_INVALID_MEMBER);
  APyDelphiWrapper.DefineVar('ERROR_TOO_MANY_SIDS', ERROR_TOO_MANY_SIDS);
  APyDelphiWrapper.DefineVar('ERROR_LM_CROSS_ENCRYPTION_REQUIRED', ERROR_LM_CROSS_ENCRYPTION_REQUIRED);
  APyDelphiWrapper.DefineVar('ERROR_NO_INHERITANCE', ERROR_NO_INHERITANCE);
  APyDelphiWrapper.DefineVar('ERROR_FILE_CORRUPT', ERROR_FILE_CORRUPT);
  APyDelphiWrapper.DefineVar('ERROR_DISK_CORRUPT', ERROR_DISK_CORRUPT);
  APyDelphiWrapper.DefineVar('ERROR_NO_USER_SESSION_KEY', ERROR_NO_USER_SESSION_KEY);
  APyDelphiWrapper.DefineVar('ERROR_LICENSE_QUOTA_EXCEEDED', ERROR_LICENSE_QUOTA_EXCEEDED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_WINDOW_HANDLE', ERROR_INVALID_WINDOW_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_MENU_HANDLE', ERROR_INVALID_MENU_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_CURSOR_HANDLE', ERROR_INVALID_CURSOR_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_ACCEL_HANDLE', ERROR_INVALID_ACCEL_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_HOOK_HANDLE', ERROR_INVALID_HOOK_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_DWP_HANDLE', ERROR_INVALID_DWP_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_TLW_WITH_WSCHILD', ERROR_TLW_WITH_WSCHILD);
  APyDelphiWrapper.DefineVar('ERROR_CANNOT_FIND_WND_CLASS', ERROR_CANNOT_FIND_WND_CLASS);
  APyDelphiWrapper.DefineVar('ERROR_WINDOW_OF_OTHER_THREAD', ERROR_WINDOW_OF_OTHER_THREAD);
  APyDelphiWrapper.DefineVar('ERROR_HOTKEY_ALREADY_REGISTERED', ERROR_HOTKEY_ALREADY_REGISTERED);
  APyDelphiWrapper.DefineVar('ERROR_CLASS_ALREADY_EXISTS', ERROR_CLASS_ALREADY_EXISTS);
  APyDelphiWrapper.DefineVar('ERROR_CLASS_DOES_NOT_EXIST', ERROR_CLASS_DOES_NOT_EXIST);
  APyDelphiWrapper.DefineVar('ERROR_CLASS_HAS_WINDOWS', ERROR_CLASS_HAS_WINDOWS);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_INDEX', ERROR_INVALID_INDEX);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_ICON_HANDLE', ERROR_INVALID_ICON_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_PRIVATE_DIALOG_INDEX', ERROR_PRIVATE_DIALOG_INDEX);
  APyDelphiWrapper.DefineVar('ERROR_LISTBOX_ID_NOT_FOUND', ERROR_LISTBOX_ID_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_NO_WILDCARD_CHARACTERS', ERROR_NO_WILDCARD_CHARACTERS);
  APyDelphiWrapper.DefineVar('ERROR_CLIPBOARD_NOT_OPEN', ERROR_CLIPBOARD_NOT_OPEN);
  APyDelphiWrapper.DefineVar('ERROR_HOTKEY_NOT_REGISTERED', ERROR_HOTKEY_NOT_REGISTERED);
  APyDelphiWrapper.DefineVar('ERROR_WINDOW_NOT_DIALOG', ERROR_WINDOW_NOT_DIALOG);
  APyDelphiWrapper.DefineVar('ERROR_CONTROL_ID_NOT_FOUND', ERROR_CONTROL_ID_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_COMBOBOX_MESSAGE', ERROR_INVALID_COMBOBOX_MESSAGE);
  APyDelphiWrapper.DefineVar('ERROR_WINDOW_NOT_COMBOBOX', ERROR_WINDOW_NOT_COMBOBOX);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_EDIT_HEIGHT', ERROR_INVALID_EDIT_HEIGHT);
  APyDelphiWrapper.DefineVar('ERROR_DC_NOT_FOUND', ERROR_DC_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_HOOK_FILTER', ERROR_INVALID_HOOK_FILTER);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_FILTER_PROC', ERROR_INVALID_FILTER_PROC);
  APyDelphiWrapper.DefineVar('ERROR_HOOK_NEEDS_HMOD', ERROR_HOOK_NEEDS_HMOD);
  APyDelphiWrapper.DefineVar('ERROR_GLOBAL_ONLY_HOOK', ERROR_GLOBAL_ONLY_HOOK);
  APyDelphiWrapper.DefineVar('ERROR_JOURNAL_HOOK_SET', ERROR_JOURNAL_HOOK_SET);
  APyDelphiWrapper.DefineVar('ERROR_HOOK_NOT_INSTALLED', ERROR_HOOK_NOT_INSTALLED);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_LB_MESSAGE', ERROR_INVALID_LB_MESSAGE);
  APyDelphiWrapper.DefineVar('ERROR_SETCOUNT_ON_BAD_LB', ERROR_SETCOUNT_ON_BAD_LB);
  APyDelphiWrapper.DefineVar('ERROR_LB_WITHOUT_TABSTOPS', ERROR_LB_WITHOUT_TABSTOPS);
  APyDelphiWrapper.DefineVar('ERROR_DESTROY_OBJECT_OF_OTHER_THREAD', ERROR_DESTROY_OBJECT_OF_OTHER_THREAD);
  APyDelphiWrapper.DefineVar('ERROR_CHILD_WINDOW_MENU', ERROR_CHILD_WINDOW_MENU);
  APyDelphiWrapper.DefineVar('ERROR_NO_SYSTEM_MENU', ERROR_NO_SYSTEM_MENU);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_MSGBOX_STYLE', ERROR_INVALID_MSGBOX_STYLE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SPI_VALUE', ERROR_INVALID_SPI_VALUE);
  APyDelphiWrapper.DefineVar('ERROR_SCREEN_ALREADY_LOCKED', ERROR_SCREEN_ALREADY_LOCKED);
  APyDelphiWrapper.DefineVar('ERROR_HWNDS_HAVE_DIFF_PARENT', ERROR_HWNDS_HAVE_DIFF_PARENT);
  APyDelphiWrapper.DefineVar('ERROR_NOT_CHILD_WINDOW', ERROR_NOT_CHILD_WINDOW);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_GW_COMMAND', ERROR_INVALID_GW_COMMAND);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_THREAD_ID', ERROR_INVALID_THREAD_ID);
  APyDelphiWrapper.DefineVar('ERROR_NON_MDICHILD_WINDOW', ERROR_NON_MDICHILD_WINDOW);
  APyDelphiWrapper.DefineVar('ERROR_POPUP_ALREADY_ACTIVE', ERROR_POPUP_ALREADY_ACTIVE);
  APyDelphiWrapper.DefineVar('ERROR_NO_SCROLLBARS', ERROR_NO_SCROLLBARS);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SCROLLBAR_RANGE', ERROR_INVALID_SCROLLBAR_RANGE);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_SHOWWIN_COMMAND', ERROR_INVALID_SHOWWIN_COMMAND);
  APyDelphiWrapper.DefineVar('ERROR_NO_SYSTEM_RESOURCES', ERROR_NO_SYSTEM_RESOURCES);
  APyDelphiWrapper.DefineVar('ERROR_NONPAGED_SYSTEM_RESOURCES', ERROR_NONPAGED_SYSTEM_RESOURCES);
  APyDelphiWrapper.DefineVar('ERROR_PAGED_SYSTEM_RESOURCES', ERROR_PAGED_SYSTEM_RESOURCES);
  APyDelphiWrapper.DefineVar('ERROR_WORKING_SET_QUOTA', ERROR_WORKING_SET_QUOTA);
  APyDelphiWrapper.DefineVar('ERROR_PAGEFILE_QUOTA', ERROR_PAGEFILE_QUOTA);
  APyDelphiWrapper.DefineVar('ERROR_COMMITMENT_LIMIT', ERROR_COMMITMENT_LIMIT);
  APyDelphiWrapper.DefineVar('ERROR_MENU_ITEM_NOT_FOUND', ERROR_MENU_ITEM_NOT_FOUND);
  APyDelphiWrapper.DefineVar('ERROR_INVALID_KEYBOARD_HANDLE', ERROR_INVALID_KEYBOARD_HANDLE);
  APyDelphiWrapper.DefineVar('ERROR_HOOK_TYPE_NOT_ALLOWED', ERROR_HOOK_TYPE_NOT_ALLOWED);
  APyDelphiWrapper.DefineVar('ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION', ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION);
  APyDelphiWrapper.DefineVar('ERROR_TIMEOUT', ERROR_TIMEOUT);
  APyDelphiWrapper.DefineVar('ERROR_EVENTLOG_FILE_CORRUPT', ERROR_EVENTLOG_FILE_CORRUPT);
  APyDelphiWrapper.DefineVar('ERROR_EVENTLOG_CANT_START', ERROR_EVENTLOG_CANT_START);
  APyDelphiWrapper.DefineVar('ERROR_LOG_FILE_FULL', ERROR_LOG_FILE_FULL);
  APyDelphiWrapper.DefineVar('ERROR_EVENTLOG_FILE_CHANGED', ERROR_EVENTLOG_FILE_CHANGED);

  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_READONLY',               FILE_ATTRIBUTE_READONLY);
  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_HIDDEN',               FILE_ATTRIBUTE_HIDDEN);
  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_SYSTEM',               FILE_ATTRIBUTE_SYSTEM);
  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_DIRECTORY',               FILE_ATTRIBUTE_DIRECTORY);
  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_ARCHIVE',               FILE_ATTRIBUTE_ARCHIVE);
  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_NORMAL',               FILE_ATTRIBUTE_NORMAL);
  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_TEMPORARY',               FILE_ATTRIBUTE_TEMPORARY);
  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_COMPRESSED',               FILE_ATTRIBUTE_COMPRESSED);
  APyDelphiWrapper.DefineVar('FILE_ATTRIBUTE_OFFLINE',               FILE_ATTRIBUTE_OFFLINE);
  APyDelphiWrapper.DefineVar('DRIVE_UNKNOWN',               DRIVE_UNKNOWN);
  APyDelphiWrapper.DefineVar('DRIVE_NO_ROOT_DIR',               DRIVE_NO_ROOT_DIR);
  APyDelphiWrapper.DefineVar('DRIVE_REMOVABLE',               DRIVE_REMOVABLE);
  APyDelphiWrapper.DefineVar('DRIVE_FIXED',               DRIVE_FIXED);
  APyDelphiWrapper.DefineVar('DRIVE_REMOTE',               DRIVE_REMOTE);
  APyDelphiWrapper.DefineVar('DRIVE_CDROM',               DRIVE_CDROM);
  APyDelphiWrapper.DefineVar('DRIVE_RAMDISK',               DRIVE_RAMDISK);
  APyDelphiWrapper.DefineVar('PROCESS_TERMINATE',               PROCESS_TERMINATE);
  APyDelphiWrapper.DefineVar('PROCESS_QUERY_INFORMATION',               PROCESS_QUERY_INFORMATION);
  APyDelphiWrapper.DefineVar('PROCESS_SET_QUOTA',               PROCESS_SET_QUOTA);
  APyDelphiWrapper.DefineVar('PROCESS_VM_READ',               PROCESS_VM_READ);
  APyDelphiWrapper.DefineVar('PROCESS_VM_WRITE',               PROCESS_VM_WRITE);
  APyDelphiWrapper.DefineVar('PROCESS_VM_OPERATION',               PROCESS_VM_OPERATION);
  APyDelphiWrapper.DefineVar('SYNCHRONIZE',               SYNCHRONIZE);
//  APyDelphiWrapper.DefineVar('INFINITE',               INFINITE);
  APyDelphiWrapper.DefineVar('WAIT_OBJECT_0',               WAIT_OBJECT_0);
  APyDelphiWrapper.DefineVar('WAIT_TIMEOUT',               WAIT_TIMEOUT);
//  APyDelphiWrapper.DefineVar('WAIT_FAILED',               WAIT_FAILED);
  APyDelphiWrapper.DefineVar('WAIT_ABANDONED',               WAIT_ABANDONED);
  APyDelphiWrapper.DefineVar('CREATE_EVENT_INITIAL_SET',               CREATE_EVENT_INITIAL_SET);
  APyDelphiWrapper.DefineVar('CREATE_EVENT_MANUAL_RESET',               CREATE_EVENT_MANUAL_RESET);
  APyDelphiWrapper.DefineVar('EVENT_MODIFY_STATE',               EVENT_MODIFY_STATE);
  APyDelphiWrapper.DefineVar('SEMAPHORE_MODIFY_STATE',               SEMAPHORE_MODIFY_STATE);
  APyDelphiWrapper.DefineVar('MB_ICONHAND',               MB_ICONHAND);
  APyDelphiWrapper.DefineVar('MB_ICONQUESTION',               MB_ICONQUESTION);
  APyDelphiWrapper.DefineVar('MB_ICONEXCLAMATION',               MB_ICONEXCLAMATION);
  APyDelphiWrapper.DefineVar('MB_ICONASTERISK',               MB_ICONASTERISK);

  APyDelphiWrapper.DefineVar('GWL_WNDPROC',               GWL_WNDPROC);
  APyDelphiWrapper.DefineVar('GWL_HINSTANCE',               GWL_HINSTANCE);
  APyDelphiWrapper.DefineVar('GWL_HWNDPARENT',               GWL_HWNDPARENT);
  APyDelphiWrapper.DefineVar('GWL_USERDATA',               GWL_USERDATA);
  APyDelphiWrapper.DefineVar('GWL_EXSTYLE',               GWL_EXSTYLE);
  APyDelphiWrapper.DefineVar('GWL_STYLE',               GWL_STYLE);
  APyDelphiWrapper.DefineVar('GWL_ID',               GWL_ID);
  APyDelphiWrapper.DefineVar('SM_CXSCREEN',               SM_CXSCREEN);
  APyDelphiWrapper.DefineVar('SM_CYSCREEN',               SM_CYSCREEN);
  APyDelphiWrapper.DefineVar('SM_CXFULLSCREEN',               SM_CXFULLSCREEN);
  APyDelphiWrapper.DefineVar('SM_CYFULLSCREEN',               SM_CYFULLSCREEN);
  APyDelphiWrapper.DefineVar('SM_CXICON',               SM_CXICON);
  APyDelphiWrapper.DefineVar('SM_CYICON',               SM_CYICON);
  APyDelphiWrapper.DefineVar('SM_CXCURSOR',               SM_CXCURSOR);
  APyDelphiWrapper.DefineVar('SM_CYCURSOR',               SM_CYCURSOR);
  APyDelphiWrapper.DefineVar('SM_CXSIZE',               SM_CXSIZE);
  APyDelphiWrapper.DefineVar('SM_CYSIZE',               SM_CYSIZE);
  APyDelphiWrapper.DefineVar('SM_CXMIN',               SM_CXMIN);
  APyDelphiWrapper.DefineVar('SM_CYMIN',               SM_CYMIN);
  APyDelphiWrapper.DefineVar('SM_CXMAXIMIZED',               SM_CXMAXIMIZED);
  APyDelphiWrapper.DefineVar('SM_CYMAXIMIZED',               SM_CYMAXIMIZED);
  APyDelphiWrapper.DefineVar('VK_LBUTTON',               VK_LBUTTON);
  APyDelphiWrapper.DefineVar('VK_RBUTTON',               VK_RBUTTON);
  APyDelphiWrapper.DefineVar('VK_MBUTTON',               VK_MBUTTON);
  APyDelphiWrapper.DefineVar('VK_BACK',               VK_BACK);
  APyDelphiWrapper.DefineVar('VK_TAB',               VK_TAB);
  APyDelphiWrapper.DefineVar('VK_RETURN',               VK_RETURN);
  APyDelphiWrapper.DefineVar('VK_SHIFT',               VK_SHIFT);
  APyDelphiWrapper.DefineVar('VK_CONTROL',               VK_CONTROL);
  APyDelphiWrapper.DefineVar('VK_MENU',               VK_MENU);
  APyDelphiWrapper.DefineVar('VK_PAUSE',               VK_PAUSE);
  APyDelphiWrapper.DefineVar('VK_CAPITAL',               VK_CAPITAL);
  APyDelphiWrapper.DefineVar('VK_ESCAPE',               VK_ESCAPE);
  APyDelphiWrapper.DefineVar('VK_SPACE',               VK_SPACE);
  APyDelphiWrapper.DefineVar('VK_PRIOR',               VK_PRIOR);
  APyDelphiWrapper.DefineVar('VK_NEXT',               VK_NEXT);
  APyDelphiWrapper.DefineVar('VK_END',               VK_END);
  APyDelphiWrapper.DefineVar('VK_HOME',               VK_HOME);
  APyDelphiWrapper.DefineVar('VK_LEFT',               VK_LEFT);
  APyDelphiWrapper.DefineVar('VK_UP',               VK_UP);
  APyDelphiWrapper.DefineVar('VK_RIGHT',               VK_RIGHT);
  APyDelphiWrapper.DefineVar('VK_DOWN',               VK_DOWN);
  APyDelphiWrapper.DefineVar('VK_SNAPSHOT',               VK_SNAPSHOT);
  APyDelphiWrapper.DefineVar('VK_INSERT',               VK_INSERT);
  APyDelphiWrapper.DefineVar('VK_DELETE',               VK_DELETE);

  APyDelphiWrapper.DefineVar('MOUSEEVENTF_MOVE',               MOUSEEVENTF_MOVE);
  APyDelphiWrapper.DefineVar('MOUSEEVENTF_LEFTDOWN',               MOUSEEVENTF_LEFTDOWN);
  APyDelphiWrapper.DefineVar('MOUSEEVENTF_LEFTUP',               MOUSEEVENTF_LEFTUP);
  APyDelphiWrapper.DefineVar('MOUSEEVENTF_RIGHTDOWN',               MOUSEEVENTF_RIGHTDOWN);
  APyDelphiWrapper.DefineVar('MOUSEEVENTF_RIGHTUP',               MOUSEEVENTF_RIGHTUP);
  APyDelphiWrapper.DefineVar('MOUSEEVENTF_MIDDLEDOWN',               MOUSEEVENTF_MIDDLEDOWN);
  APyDelphiWrapper.DefineVar('MOUSEEVENTF_MIDDLEUP',               MOUSEEVENTF_MIDDLEUP);
  APyDelphiWrapper.DefineVar('MOUSEEVENTF_WHEEL',               MOUSEEVENTF_WHEEL);
  APyDelphiWrapper.DefineVar('MOUSEEVENTF_ABSOLUTE',               MOUSEEVENTF_ABSOLUTE);
  APyDelphiWrapper.DefineVar('SW_HIDE',               SW_HIDE);
  APyDelphiWrapper.DefineVar('SW_SHOWNORMAL',               SW_SHOWNORMAL);
  APyDelphiWrapper.DefineVar('SW_SHOWMINIMIZED',               SW_SHOWMINIMIZED);
  APyDelphiWrapper.DefineVar('SW_SHOWMAXIMIZED',               SW_SHOWMAXIMIZED);
  APyDelphiWrapper.DefineVar('SW_SHOWNOACTIVATE',               SW_SHOWNOACTIVATE);
  APyDelphiWrapper.DefineVar('SW_SHOW',               SW_SHOW);
  APyDelphiWrapper.DefineVar('SW_MINIMIZE',               SW_MINIMIZE);
  APyDelphiWrapper.DefineVar('SW_SHOWMINNOACTIVE',               SW_SHOWMINNOACTIVE);
  APyDelphiWrapper.DefineVar('SW_SHOWNA',               SW_SHOWNA);
  APyDelphiWrapper.DefineVar('SW_RESTORE',               SW_RESTORE);
  APyDelphiWrapper.DefineVar('SW_SHOWDEFAULT',               SW_SHOWDEFAULT);
  APyDelphiWrapper.DefineVar('SW_FORCEMINIMIZE',               SW_FORCEMINIMIZE);
  APyDelphiWrapper.DefineVar('AW_HOR_POSITIVE',               AW_HOR_POSITIVE);
  APyDelphiWrapper.DefineVar('AW_HOR_NEGATIVE',               AW_HOR_NEGATIVE);
  APyDelphiWrapper.DefineVar('AW_VER_POSITIVE',               AW_VER_POSITIVE);
  APyDelphiWrapper.DefineVar('AW_VER_NEGATIVE',               AW_VER_NEGATIVE);
  APyDelphiWrapper.DefineVar('AW_CENTER',               AW_CENTER);
  APyDelphiWrapper.DefineVar('AW_HIDE',               AW_HIDE);
  APyDelphiWrapper.DefineVar('AW_ACTIVATE',               AW_ACTIVATE);
  APyDelphiWrapper.DefineVar('AW_SLIDE',               AW_SLIDE);
  APyDelphiWrapper.DefineVar('AW_BLEND',               AW_BLEND);
  APyDelphiWrapper.DefineVar('FLASHW_STOP',               FLASHW_STOP);
  APyDelphiWrapper.DefineVar('FLASHW_CAPTION',               FLASHW_CAPTION);
  APyDelphiWrapper.DefineVar('FLASHW_TRAY',               FLASHW_TRAY);
  APyDelphiWrapper.DefineVar('FLASHW_ALL',               FLASHW_ALL);
  APyDelphiWrapper.DefineVar('FLASHW_TIMER',               FLASHW_TIMER);
  APyDelphiWrapper.DefineVar('FLASHW_TIMERNOFG',               FLASHW_TIMERNOFG);
  APyDelphiWrapper.DefineVar('BST_CHECKED',               BST_CHECKED);
  APyDelphiWrapper.DefineVar('BST_UNCHECKED',               BST_UNCHECKED);
  APyDelphiWrapper.DefineVar('BST_INDETERMINATE',               BST_INDETERMINATE);
  APyDelphiWrapper.DefineVar('MF_BYCOMMAND',               MF_BYCOMMAND);
  APyDelphiWrapper.DefineVar('MF_BYPOSITION',               MF_BYPOSITION);
  APyDelphiWrapper.DefineVar('MF_ENABLED',               MF_ENABLED);
  APyDelphiWrapper.DefineVar('MF_GRAYED',               MF_GRAYED);
  APyDelphiWrapper.DefineVar('MF_DISABLED',               MF_DISABLED);
  APyDelphiWrapper.DefineVar('COLOR_SCROLLBAR',               COLOR_SCROLLBAR);
  APyDelphiWrapper.DefineVar('COLOR_BACKGROUND',               COLOR_BACKGROUND);
  APyDelphiWrapper.DefineVar('COLOR_DESKTOP',               COLOR_DESKTOP);
  APyDelphiWrapper.DefineVar('COLOR_ACTIVECAPTION',               COLOR_ACTIVECAPTION);
  APyDelphiWrapper.DefineVar('COLOR_INACTIVECAPTION',               COLOR_INACTIVECAPTION);
  APyDelphiWrapper.DefineVar('COLOR_MENU',               COLOR_MENU);
  APyDelphiWrapper.DefineVar('COLOR_WINDOW',               COLOR_WINDOW);
  APyDelphiWrapper.DefineVar('COLOR_WINDOWFRAME',               COLOR_WINDOWFRAME);
  APyDelphiWrapper.DefineVar('COLOR_MENUTEXT',               COLOR_MENUTEXT);
  APyDelphiWrapper.DefineVar('COLOR_WINDOWTEXT',               COLOR_WINDOWTEXT);
  APyDelphiWrapper.DefineVar('COLOR_CAPTIONTEXT',               COLOR_CAPTIONTEXT);
  APyDelphiWrapper.DefineVar('COLOR_ACTIVEBORDER',               COLOR_ACTIVEBORDER);
  APyDelphiWrapper.DefineVar('COLOR_INACTIVEBORDER',               COLOR_INACTIVEBORDER);
  APyDelphiWrapper.DefineVar('COLOR_APPWORKSPACE',               COLOR_APPWORKSPACE);
  APyDelphiWrapper.DefineVar('COLOR_HIGHLIGHT',               COLOR_HIGHLIGHT);
  APyDelphiWrapper.DefineVar('COLOR_HIGHLIGHTTEXT',               COLOR_HIGHLIGHTTEXT);
  APyDelphiWrapper.DefineVar('COLOR_BTNFACE',               COLOR_BTNFACE);
  APyDelphiWrapper.DefineVar('COLOR_BTNSHADOW',               COLOR_BTNSHADOW);
  APyDelphiWrapper.DefineVar('COLOR_GRAYTEXT',               COLOR_GRAYTEXT);
  APyDelphiWrapper.DefineVar('COLOR_BTNTEXT',               COLOR_BTNTEXT);
  APyDelphiWrapper.DefineVar('COLOR_INACTIVECAPTIONTEXT',               COLOR_INACTIVECAPTIONTEXT);
  APyDelphiWrapper.DefineVar('COLOR_BTNHIGHLIGHT',               COLOR_BTNHIGHLIGHT);
  APyDelphiWrapper.DefineVar('BLACK_BRUSH',               BLACK_BRUSH);
  APyDelphiWrapper.DefineVar('DKGRAY_BRUSH',               DKGRAY_BRUSH);
  APyDelphiWrapper.DefineVar('GRAY_BRUSH',               GRAY_BRUSH);
  APyDelphiWrapper.DefineVar('HOLLOW_BRUSH',               HOLLOW_BRUSH);
  APyDelphiWrapper.DefineVar('LTGRAY_BRUSH',               LTGRAY_BRUSH);
  APyDelphiWrapper.DefineVar('NULL_BRUSH',               NULL_BRUSH);
  APyDelphiWrapper.DefineVar('WHITE_BRUSH',               WHITE_BRUSH);
  APyDelphiWrapper.DefineVar('BLACK_PEN',               BLACK_PEN);
  APyDelphiWrapper.DefineVar('WHITE_PEN',               WHITE_PEN);
  APyDelphiWrapper.DefineVar('DC_PEN',               DC_PEN);
  APyDelphiWrapper.DefineVar('ANSI_FIXED_FONT',               ANSI_FIXED_FONT);
  APyDelphiWrapper.DefineVar('ANSI_VAR_FONT',               ANSI_VAR_FONT);
  APyDelphiWrapper.DefineVar('DEFAULT_GUI_FONT',               DEFAULT_GUI_FONT);
  APyDelphiWrapper.DefineVar('OEM_FIXED_FONT',               OEM_FIXED_FONT);
  APyDelphiWrapper.DefineVar('SYSTEM_FONT',               SYSTEM_FONT);
  APyDelphiWrapper.DefineVar('SYSTEM_FIXED_FONT',               SYSTEM_FIXED_FONT);
  APyDelphiWrapper.DefineVar('DEFAULT_PALETTE',               DEFAULT_PALETTE);
  APyDelphiWrapper.DefineVar('PS_SOLID',               PS_SOLID);
  APyDelphiWrapper.DefineVar('PS_DASH',               PS_DASH);
  APyDelphiWrapper.DefineVar('PS_DOT',               PS_DOT);
  APyDelphiWrapper.DefineVar('PS_DASHDOT',               PS_DASHDOT);
  APyDelphiWrapper.DefineVar('PS_DASHDOTDOT',               PS_DASHDOTDOT);
  APyDelphiWrapper.DefineVar('PS_NULL',               PS_NULL);
  APyDelphiWrapper.DefineVar('PS_INSIDEFRAME',               PS_INSIDEFRAME);
  APyDelphiWrapper.DefineVar('RGN_AND',               RGN_AND);
  APyDelphiWrapper.DefineVar('RGN_OR',               RGN_OR);
  APyDelphiWrapper.DefineVar('RGN_XOR',               RGN_XOR);
  APyDelphiWrapper.DefineVar('RGN_DIFF',               RGN_DIFF);
  APyDelphiWrapper.DefineVar('RGN_COPY',               RGN_COPY);
  APyDelphiWrapper.DefineVar('RGN_MIN',               RGN_MIN);
  APyDelphiWrapper.DefineVar('RGN_MAX',               RGN_MAX);
  APyDelphiWrapper.DefineVar('TRANSPARENT',               TRANSPARENT);
  APyDelphiWrapper.DefineVar('OPAQUE',               OPAQUE);
  APyDelphiWrapper.DefineVar('DRIVERVERSION',               DRIVERVERSION);
  APyDelphiWrapper.DefineVar('TECHNOLOGY',               TECHNOLOGY);
  APyDelphiWrapper.DefineVar('HORZSIZE',               HORZSIZE);
  APyDelphiWrapper.DefineVar('VERTSIZE',               VERTSIZE);
  APyDelphiWrapper.DefineVar('HORZRES',               HORZRES);
  APyDelphiWrapper.DefineVar('VERTRES',               VERTRES);
  APyDelphiWrapper.DefineVar('BITSPIXEL',               BITSPIXEL);
  APyDelphiWrapper.DefineVar('PLANES',               PLANES);
  APyDelphiWrapper.DefineVar('NUMBRUSHES',               NUMBRUSHES);
  APyDelphiWrapper.DefineVar('NUMPENS',               NUMPENS);
  APyDelphiWrapper.DefineVar('NUMFONTS',               NUMFONTS);
  APyDelphiWrapper.DefineVar('NUMCOLORS',               NUMCOLORS);
  APyDelphiWrapper.DefineVar('ASPECTX',               ASPECTX);
  APyDelphiWrapper.DefineVar('ASPECTY',               ASPECTY);
  APyDelphiWrapper.DefineVar('ASPECTXY',               ASPECTXY);
  APyDelphiWrapper.DefineVar('LOGPIXELSX',               LOGPIXELSX);
  APyDelphiWrapper.DefineVar('LOGPIXELSY',               LOGPIXELSY);
  APyDelphiWrapper.DefineVar('SIZEPALETTE',               SIZEPALETTE);
  APyDelphiWrapper.DefineVar('NUMRESERVED',               NUMRESERVED);
  APyDelphiWrapper.DefineVar('COLORRES',               COLORRES);
  APyDelphiWrapper.DefineVar('RASTERCAPS',               RASTERCAPS);
  APyDelphiWrapper.DefineVar('CURVECAPS',               CURVECAPS);
  APyDelphiWrapper.DefineVar('LINECAPS',               LINECAPS);
  APyDelphiWrapper.DefineVar('POLYGONALCAPS',               POLYGONALCAPS);
  APyDelphiWrapper.DefineVar('TEXTCAPS',               TEXTCAPS);
  APyDelphiWrapper.DefineVar('CLIPCAPS',               CLIPCAPS);
  APyDelphiWrapper.DefineVar('SHADEBLENDCAPS',               SHADEBLENDCAPS);
  APyDelphiWrapper.DefineVar('MM_TEXT',               MM_TEXT);
  APyDelphiWrapper.DefineVar('MM_LOMETRIC',               MM_LOMETRIC);
  APyDelphiWrapper.DefineVar('MM_HIMETRIC',               MM_HIMETRIC);
  APyDelphiWrapper.DefineVar('MM_LOENGLISH',               MM_LOENGLISH);
  APyDelphiWrapper.DefineVar('MM_HIENGLISH',               MM_HIENGLISH);
  APyDelphiWrapper.DefineVar('MM_TWIPS',               MM_TWIPS);
  APyDelphiWrapper.DefineVar('MM_ISOTROPIC',               MM_ISOTROPIC);
  APyDelphiWrapper.DefineVar('MM_ANISOTROPIC',               MM_ANISOTROPIC);
  APyDelphiWrapper.DefineVar('R2_BLACK',               R2_BLACK);
  APyDelphiWrapper.DefineVar('R2_WHITE',               R2_WHITE);
  APyDelphiWrapper.DefineVar('R2_NOP',               R2_NOP);
  APyDelphiWrapper.DefineVar('R2_NOT',               R2_NOT);
  APyDelphiWrapper.DefineVar('R2_COPYPEN',               R2_COPYPEN);
  APyDelphiWrapper.DefineVar('R2_NOTCOPYPEN',               R2_NOTCOPYPEN);
  APyDelphiWrapper.DefineVar('R2_MERGEPENNOT',               R2_MERGEPENNOT);
  APyDelphiWrapper.DefineVar('R2_MASKPENNOT',               R2_MASKPENNOT);
  APyDelphiWrapper.DefineVar('R2_MERGENOTPEN',               R2_MERGENOTPEN);
  APyDelphiWrapper.DefineVar('R2_MASKNOTPEN',               R2_MASKNOTPEN);
  APyDelphiWrapper.DefineVar('R2_MERGEPEN',               R2_MERGEPEN);
  APyDelphiWrapper.DefineVar('R2_NOTMERGEPEN',               R2_NOTMERGEPEN);
  APyDelphiWrapper.DefineVar('R2_MASKPEN',               R2_MASKPEN);
  APyDelphiWrapper.DefineVar('R2_NOTMASKPEN',               R2_NOTMASKPEN);
  APyDelphiWrapper.DefineVar('R2_XORPEN',               R2_XORPEN);
  APyDelphiWrapper.DefineVar('R2_NOTXORPEN',               R2_NOTXORPEN);
  APyDelphiWrapper.DefineVar('STRETCH_ANDSCANS',               STRETCH_ANDSCANS);
  APyDelphiWrapper.DefineVar('STRETCH_ORSCANS',               STRETCH_ORSCANS);
  APyDelphiWrapper.DefineVar('STRETCH_DELETESCANS',               STRETCH_DELETESCANS);
  APyDelphiWrapper.DefineVar('STRETCH_HALFTONE',               STRETCH_HALFTONE);

  APyDelphiWrapper.DefineVar('MB_ICONWARNING',               MB_ICONWARNING);
  APyDelphiWrapper.DefineVar('MB_ICONERROR',               MB_ICONERROR);
  APyDelphiWrapper.DefineVar('MB_ICONINFORMATION',               MB_ICONINFORMATION);
  APyDelphiWrapper.DefineVar('MB_ICONSTOP',               MB_ICONSTOP);
  APyDelphiWrapper.DefineVar('MB_DEFBUTTON1',               MB_DEFBUTTON1);
  APyDelphiWrapper.DefineVar('MB_DEFBUTTON2',               MB_DEFBUTTON2);
  APyDelphiWrapper.DefineVar('MB_DEFBUTTON3',               MB_DEFBUTTON3);
  APyDelphiWrapper.DefineVar('MB_APPLMODAL',               MB_APPLMODAL);
  APyDelphiWrapper.DefineVar('MB_SYSTEMMODAL',               MB_SYSTEMMODAL);
  APyDelphiWrapper.DefineVar('MB_TASKMODAL',               MB_TASKMODAL);
  APyDelphiWrapper.DefineVar('MB_HELP',               MB_HELP);
  APyDelphiWrapper.DefineVar('MB_SETFOREGROUND',               MB_SETFOREGROUND);
  APyDelphiWrapper.DefineVar('MB_DEFAULT_DESKTOP_ONLY',               MB_DEFAULT_DESKTOP_ONLY);

  APyDelphiWrapper.DefineVar('KEY_ALL_ACCESS',               KEY_ALL_ACCESS);
  APyDelphiWrapper.DefineVar('KEY_READ',               KEY_READ);
  APyDelphiWrapper.DefineVar('KEY_WRITE',               KEY_WRITE);
  APyDelphiWrapper.DefineVar('KEY_EXECUTE',               KEY_EXECUTE);
  APyDelphiWrapper.DefineVar('KEY_QUERY_VALUE',               KEY_QUERY_VALUE);
  APyDelphiWrapper.DefineVar('KEY_SET_VALUE',               KEY_SET_VALUE);
  APyDelphiWrapper.DefineVar('KEY_CREATE_SUB_KEY',               KEY_CREATE_SUB_KEY);
  APyDelphiWrapper.DefineVar('KEY_ENUMERATE_SUB_KEYS',               KEY_ENUMERATE_SUB_KEYS);
  APyDelphiWrapper.DefineVar('KEY_NOTIFY',               KEY_NOTIFY);
  APyDelphiWrapper.DefineVar('KEY_CREATE_LINK',               KEY_CREATE_LINK);
  APyDelphiWrapper.DefineVar('KEY_WOW64_64KEY',               KEY_WOW64_64KEY);
  APyDelphiWrapper.DefineVar('KEY_WOW64_32KEY',               KEY_WOW64_32KEY);
  APyDelphiWrapper.DefineVar('REG_OPTION_NON_VOLATILE',               REG_OPTION_NON_VOLATILE);
  APyDelphiWrapper.DefineVar('REG_OPTION_VOLATILE',               REG_OPTION_VOLATILE);
  APyDelphiWrapper.DefineVar('REG_OPTION_BACKUP_RESTORE',               REG_OPTION_BACKUP_RESTORE);
  APyDelphiWrapper.DefineVar('SC_MANAGER_CONNECT',               SC_MANAGER_CONNECT);
  APyDelphiWrapper.DefineVar('SC_MANAGER_CREATE_SERVICE',               SC_MANAGER_CREATE_SERVICE);
  APyDelphiWrapper.DefineVar('SC_MANAGER_ENUMERATE_SERVICE',               SC_MANAGER_ENUMERATE_SERVICE);
  APyDelphiWrapper.DefineVar('SC_MANAGER_LOCK',               SC_MANAGER_LOCK);
  APyDelphiWrapper.DefineVar('SC_MANAGER_QUERY_LOCK_STATUS',               SC_MANAGER_QUERY_LOCK_STATUS);
  APyDelphiWrapper.DefineVar('SC_MANAGER_MODIFY_BOOT_CONFIG',               SC_MANAGER_MODIFY_BOOT_CONFIG);
  APyDelphiWrapper.DefineVar('SC_MANAGER_ALL_ACCESS',               SC_MANAGER_ALL_ACCESS);
  APyDelphiWrapper.DefineVar('SERVICE_QUERY_CONFIG',               SERVICE_QUERY_CONFIG);
  APyDelphiWrapper.DefineVar('SERVICE_CHANGE_CONFIG',               SERVICE_CHANGE_CONFIG);
  APyDelphiWrapper.DefineVar('SERVICE_QUERY_STATUS',               SERVICE_QUERY_STATUS);
  APyDelphiWrapper.DefineVar('SERVICE_ENUMERATE_DEPENDENTS',               SERVICE_ENUMERATE_DEPENDENTS);
  APyDelphiWrapper.DefineVar('SERVICE_START',               SERVICE_START);
  APyDelphiWrapper.DefineVar('SERVICE_STOP',               SERVICE_STOP);
  APyDelphiWrapper.DefineVar('SERVICE_PAUSE_CONTINUE',               SERVICE_PAUSE_CONTINUE);
  APyDelphiWrapper.DefineVar('SERVICE_INTERROGATE',               SERVICE_INTERROGATE);
  APyDelphiWrapper.DefineVar('SERVICE_ALL_ACCESS',               SERVICE_ALL_ACCESS);
  APyDelphiWrapper.DefineVar('SERVICE_STOPPED',               SERVICE_STOPPED);
  APyDelphiWrapper.DefineVar('SERVICE_START_PENDING',               SERVICE_START_PENDING);
  APyDelphiWrapper.DefineVar('SERVICE_STOP_PENDING',               SERVICE_STOP_PENDING);
  APyDelphiWrapper.DefineVar('SERVICE_RUNNING',               SERVICE_RUNNING);
  APyDelphiWrapper.DefineVar('SERVICE_CONTINUE_PENDING',               SERVICE_CONTINUE_PENDING);
  APyDelphiWrapper.DefineVar('SERVICE_PAUSE_PENDING',               SERVICE_PAUSE_PENDING);
  APyDelphiWrapper.DefineVar('SERVICE_PAUSED',               SERVICE_PAUSED);
  APyDelphiWrapper.DefineVar('SERVICE_BOOT_START',               SERVICE_BOOT_START);
  APyDelphiWrapper.DefineVar('SERVICE_SYSTEM_START',               SERVICE_SYSTEM_START);
  APyDelphiWrapper.DefineVar('SERVICE_AUTO_START',               SERVICE_AUTO_START);
  APyDelphiWrapper.DefineVar('SERVICE_DEMAND_START',               SERVICE_DEMAND_START);
  APyDelphiWrapper.DefineVar('SERVICE_DISABLED',               SERVICE_DISABLED);
  APyDelphiWrapper.DefineVar('SERVICE_ERROR_IGNORE',               SERVICE_ERROR_IGNORE);
  APyDelphiWrapper.DefineVar('SERVICE_ERROR_NORMAL',               SERVICE_ERROR_NORMAL);
  APyDelphiWrapper.DefineVar('SERVICE_ERROR_SEVERE',               SERVICE_ERROR_SEVERE);
  APyDelphiWrapper.DefineVar('SERVICE_ERROR_CRITICAL',               SERVICE_ERROR_CRITICAL);
  APyDelphiWrapper.DefineVar('SERVICE_CONTROL_STOP',               SERVICE_CONTROL_STOP);
  APyDelphiWrapper.DefineVar('SERVICE_CONTROL_PAUSE',               SERVICE_CONTROL_PAUSE);
  APyDelphiWrapper.DefineVar('SERVICE_CONTROL_CONTINUE',               SERVICE_CONTROL_CONTINUE);
  APyDelphiWrapper.DefineVar('SERVICE_CONTROL_INTERROGATE',               SERVICE_CONTROL_INTERROGATE);
  APyDelphiWrapper.DefineVar('SERVICE_CONTROL_PARAMCHANGE',               SERVICE_CONTROL_PARAMCHANGE);
  APyDelphiWrapper.DefineVar('SERVICE_CONTROL_SHUTDOWN',               SERVICE_CONTROL_SHUTDOWN);
  APyDelphiWrapper.DefineVar('SERVICE_CONTROL_PRESHUTDOWN',               SERVICE_CONTROL_PRESHUTDOWN);
  APyDelphiWrapper.DefineVar('SND_SYNC',               SND_SYNC);
  APyDelphiWrapper.DefineVar('SND_ASYNC',               SND_ASYNC);
  APyDelphiWrapper.DefineVar('SND_NODEFAULT',               SND_NODEFAULT);
  APyDelphiWrapper.DefineVar('SND_MEMORY',               SND_MEMORY);
  APyDelphiWrapper.DefineVar('SND_LOOP',               SND_LOOP);
  APyDelphiWrapper.DefineVar('SND_NOSTOP',               SND_NOSTOP);
  APyDelphiWrapper.DefineVar('SND_NOWAIT',               SND_NOWAIT);
  APyDelphiWrapper.DefineVar('SND_FILENAME',               SND_FILENAME);
  APyDelphiWrapper.DefineVar('SND_RESOURCE',               SND_RESOURCE);
  APyDelphiWrapper.DefineVar('SND_PURGE',               SND_PURGE);
  APyDelphiWrapper.DefineVar('SND_APPLICATION',               SND_APPLICATION);
  APyDelphiWrapper.DefineVar('SND_ALIAS',               SND_ALIAS);
  APyDelphiWrapper.DefineVar('CSIDL_DESKTOP',               CSIDL_DESKTOP);
  APyDelphiWrapper.DefineVar('CSIDL_INTERNET',               CSIDL_INTERNET);
  APyDelphiWrapper.DefineVar('CSIDL_PROGRAMS',               CSIDL_PROGRAMS);
  APyDelphiWrapper.DefineVar('CSIDL_CONTROLS',               CSIDL_CONTROLS);
  APyDelphiWrapper.DefineVar('CSIDL_PRINTERS',               CSIDL_PRINTERS);
  APyDelphiWrapper.DefineVar('CSIDL_PERSONAL',               CSIDL_PERSONAL);
  APyDelphiWrapper.DefineVar('CSIDL_FAVORITES',               CSIDL_FAVORITES);
  APyDelphiWrapper.DefineVar('CSIDL_STARTUP',               CSIDL_STARTUP);
  APyDelphiWrapper.DefineVar('CSIDL_RECENT',               CSIDL_RECENT);
  APyDelphiWrapper.DefineVar('CSIDL_SENDTO',               CSIDL_SENDTO);
  APyDelphiWrapper.DefineVar('CSIDL_BITBUCKET',               CSIDL_BITBUCKET);
  APyDelphiWrapper.DefineVar('CSIDL_STARTMENU',               CSIDL_STARTMENU);
  APyDelphiWrapper.DefineVar('CSIDL_MYDOCUMENTS',               CSIDL_MYDOCUMENTS);
  APyDelphiWrapper.DefineVar('CSIDL_MYMUSIC',               CSIDL_MYMUSIC);
  APyDelphiWrapper.DefineVar('CSIDL_MYVIDEO',               CSIDL_MYVIDEO);
  APyDelphiWrapper.DefineVar('CSIDL_DESKTOPDIRECTORY',               CSIDL_DESKTOPDIRECTORY);
  APyDelphiWrapper.DefineVar('CSIDL_DRIVES',               CSIDL_DRIVES);
  APyDelphiWrapper.DefineVar('CSIDL_NETWORK',               CSIDL_NETWORK);
  APyDelphiWrapper.DefineVar('CSIDL_FONTS',               CSIDL_FONTS);
  APyDelphiWrapper.DefineVar('CSIDL_TEMPLATES',               CSIDL_TEMPLATES);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_STARTMENU',               CSIDL_COMMON_STARTMENU);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_PROGRAMS',               CSIDL_COMMON_PROGRAMS);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_STARTUP',               CSIDL_COMMON_STARTUP);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_DESKTOPDIRECTORY',               CSIDL_COMMON_DESKTOPDIRECTORY);
  APyDelphiWrapper.DefineVar('CSIDL_APPDATA',               CSIDL_APPDATA);
  APyDelphiWrapper.DefineVar('CSIDL_PRINTHOOD',               CSIDL_PRINTHOOD);
  APyDelphiWrapper.DefineVar('CSIDL_LOCAL_APPDATA',               CSIDL_LOCAL_APPDATA);
  APyDelphiWrapper.DefineVar('CSIDL_ALTSTARTUP',               CSIDL_ALTSTARTUP);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_ALTSTARTUP',               CSIDL_COMMON_ALTSTARTUP);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_FAVORITES',               CSIDL_COMMON_FAVORITES);
  APyDelphiWrapper.DefineVar('CSIDL_INTERNET_CACHE',               CSIDL_INTERNET_CACHE);
  APyDelphiWrapper.DefineVar('CSIDL_COOKIES',               CSIDL_COOKIES);
  APyDelphiWrapper.DefineVar('CSIDL_HISTORY',               CSIDL_HISTORY);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_APPDATA',               CSIDL_COMMON_APPDATA);
  APyDelphiWrapper.DefineVar('CSIDL_WINDOWS',               CSIDL_WINDOWS);
  APyDelphiWrapper.DefineVar('CSIDL_SYSTEM',               CSIDL_SYSTEM);
  APyDelphiWrapper.DefineVar('CSIDL_PROGRAM_FILES',               CSIDL_PROGRAM_FILES);
  APyDelphiWrapper.DefineVar('CSIDL_MYPICTURES',               CSIDL_MYPICTURES);
  APyDelphiWrapper.DefineVar('CSIDL_PROFILE',               CSIDL_PROFILE);
  APyDelphiWrapper.DefineVar('CSIDL_SYSTEMX86',               CSIDL_SYSTEMX86);
  APyDelphiWrapper.DefineVar('CSIDL_PROGRAM_FILESX86',               CSIDL_PROGRAM_FILESX86);
  APyDelphiWrapper.DefineVar('CSIDL_PROGRAM_FILES_COMMON',               CSIDL_PROGRAM_FILES_COMMON);
  APyDelphiWrapper.DefineVar('CSIDL_PROGRAM_FILES_COMMONX86',               CSIDL_PROGRAM_FILES_COMMONX86);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_TEMPLATES',               CSIDL_COMMON_TEMPLATES);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_DOCUMENTS',               CSIDL_COMMON_DOCUMENTS);
  APyDelphiWrapper.DefineVar('CSIDL_COMMON_ADMINTOOLS',               CSIDL_COMMON_ADMINTOOLS);
  APyDelphiWrapper.DefineVar('CSIDL_ADMINTOOLS',               CSIDL_ADMINTOOLS);
  APyDelphiWrapper.DefineVar('SHERB_NOCONFIRMATION',               SHERB_NOCONFIRMATION);
  APyDelphiWrapper.DefineVar('SHERB_NOPROGRESSUI',               SHERB_NOPROGRESSUI);
  APyDelphiWrapper.DefineVar('SHERB_NOSOUND',               SHERB_NOSOUND);
  APyDelphiWrapper.DefineVar('STILL_ACTIVE',               STILL_ACTIVE);
  APyDelphiWrapper.DefineVar('IDLE_PRIORITY_CLASS',               IDLE_PRIORITY_CLASS);
  APyDelphiWrapper.DefineVar('BELOW_NORMAL_PRIORITY_CLASS',               BELOW_NORMAL_PRIORITY_CLASS);
  APyDelphiWrapper.DefineVar('NORMAL_PRIORITY_CLASS',               NORMAL_PRIORITY_CLASS);
  APyDelphiWrapper.DefineVar('ABOVE_NORMAL_PRIORITY_CLASS',               ABOVE_NORMAL_PRIORITY_CLASS);
  APyDelphiWrapper.DefineVar('HIGH_PRIORITY_CLASS',               HIGH_PRIORITY_CLASS);
  APyDelphiWrapper.DefineVar('REALTIME_PRIORITY_CLASS',               REALTIME_PRIORITY_CLASS);
//  APyDelphiWrapper.DefineVar('INVALID_FILE_SIZE',               INVALID_FILE_SIZE);
  APyDelphiWrapper.DefineVar('EWX_LOGOFF',               EWX_LOGOFF);
  APyDelphiWrapper.DefineVar('EWX_SHUTDOWN',               EWX_SHUTDOWN);
  APyDelphiWrapper.DefineVar('EWX_REBOOT',               EWX_REBOOT);
  APyDelphiWrapper.DefineVar('EWX_POWEROFF',               EWX_POWEROFF);
  APyDelphiWrapper.DefineVar('EWX_FORCE',               EWX_FORCE);
  APyDelphiWrapper.DefineVar('EWX_FORCEIFHUNG',               EWX_FORCEIFHUNG);
end;

function TFormsRegistration.Name: string;
begin
  Result := 'Forms';
end;

procedure TFormsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomForm);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiForm);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiApplication);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiScreen);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiMonitor);

  APyDelphiWrapper.EventHandlers.RegisterHandler(TCloseQueryEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TCloseEventHandler);
end;

{ TPyDelphiCustomForm }

function TPyDelphiCustomForm.Close_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if GetPythonEngine.PyArg_ParseTuple( args, ':Close') <> 0 then begin
      DelphiObject.Close;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiCustomForm.CloseQuery_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':CloseQuery') <> 0 then begin
      Result := VariantAsPyObject(DelphiObject.CloseQuery)
    end else
      Result := nil;
  end;
end;

function TPyDelphiCustomForm.Release_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if PyArg_ParseTuple( args, ':Release') <> 0 then
    begin
      if Owned then begin
        (DelphiObject as TForm).Release;
        DelphiObject := nil;
        Owned := False;
        Result := ReturnNone;
      end else begin
        PyErr_SetString (PyExc_AttributeError^,
          PAnsiChar('The Delphi form cannot be released, since it is not Owned'));
        Result := nil;
      end;
    end
    else
      Result := nil;
  end;
end;

function TPyDelphiCustomForm.ShowModal_Wrapper(args: PPyObject): PPyObject;
Var
  ModalResult : integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':ShowModal') <> 0 then begin
      ModalResult := (DelphiObject as TForm).ShowModal;
      Result := PyLong_FromLong(ModalResult);
    end else
      Result := nil;
  end;
end;

function TPyDelphiCustomForm.GetDelphiObject: TCustomForm;
begin
  Result := TCustomForm(inherited DelphiObject);
end;

procedure TPyDelphiCustomForm.SetDelphiObject(const Value: TCustomForm);
begin
  inherited DelphiObject := Value;
end;

class procedure TPyDelphiCustomForm.RegisterGetSets(PythonType: TPythonType);
begin
  with PythonType do
    begin
      AddGetSet('ModalResult', @TPyDelphiCustomForm.Get_ModalResult, @TPyDelphiCustomForm.Set_ModalResult,
        'Represents the return value of a form that is used as a modal dialog.', nil);
    end;
end;

class procedure TPyDelphiCustomForm.RegisterMethods(PythonType: TPythonType);
begin
  PythonType.AddMethod('Close', @TPyDelphiCustomForm.Close_Wrapper,
    'TForm.Close()'#10 +
    'Closes the wrapped Form');
  PythonType.AddMethod('CloseQuery', @TPyDelphiCustomForm.CloseQuery_Wrapper,
    'TForm.CloseQuery()'#10 +
    'Asked the wrapped Form if it can close');
  PythonType.AddMethod('ShowModal', @TPyDelphiCustomForm.ShowModal_Wrapper,
    'TForm.ShowModal()'#10 +
    'Shows the wrapped Form as a modal form');
  PythonType.AddMethod('Release', @TPyDelphiCustomForm.Release_Wrapper,
    'TForm.Release()'#10 +
    'Releases (destroys) the wrapped Form');
  PythonType.AddMethod('LoadProps', @TPyDelphiCustomForm.LoadProps_Wrapper,
    'TForm.LoadProps()'#10 +
    'Load properties from a .pydfm file');
end;

class function TPyDelphiCustomForm.DelphiObjectClass: TClass;
begin
  Result := TCustomForm;
end;

function TPyDelphiCustomForm.Get_ModalResult(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.ModalResult);
end;

//function TPyDelphiCustomForm.LoadProps_Wrapper(args: PPyObject): PPyObject;
//
//  function FindResource(): string;
//  var
//    LStr: PPyObject;
//  begin
//    with GetPythonEngine() do begin
//      if PyArg_ParseTuple(args, 'O:LoadProps', @LStr) <> 0 then begin
//        Result := PyObjectAsString(LStr);
//      end else
//        Result := String.Empty;
//    end;
//  end;
//
//begin
//  Adjust(@Self);
//  try
//    if InternalReadComponent(FindResource(), DelphiObject) then
//      Exit(GetPythonEngine().ReturnTrue)
//    else
//      Exit(GetPythonEngine().ReturnFalse);
//  except
//    on E: Exception do
//      with GetPythonEngine() do
//        PyErr_SetString(PyExc_RuntimeError^, PAnsiChar(AnsiString(E.Message)));
//  end;
//  Result := nil;
//end;

function TPyDelphiCustomForm.LoadProps_Wrapper(args: PPyObject): PPyObject;
var
    LStr: PPyObject;
    TempStr: String;
begin
  Adjust(@Self);

  with GetPythonEngine() do begin
    if PyArg_ParseTuple(args, 'O:LoadProps', @LStr) <> 0 then begin
      TempStr := PyObjectAsString(LStr);
    end else
      TempStr := String.Empty;
  end;

  try
    if InternalReadComponent(TempStr, DelphiObject) then
      Exit(GetPythonEngine().ReturnTrue)
    else
      Exit(GetPythonEngine().ReturnFalse);
  except
    on E: Exception do
      with GetPythonEngine() do
        PyErr_SetString(PyExc_RuntimeError^, PAnsiChar(EncodeString(E.Message)));
  end;
  Result := nil;
end;

function TPyDelphiCustomForm.Set_ModalResult(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _modalResult : Integer;
begin
  if CheckIntAttribute(AValue, 'ModalResult', _modalResult) then
    with GetPythonEngine do begin
      Adjust(@Self);
      DelphiObject.ModalResult := _modalResult;
      Result := 0;
    end
    else
      Result := -1;
end;

function TPyDelphiCustomForm.CreateComponent(AOwner: TComponent): TComponent;
var
  _class : TClass;
  _compClass : TComponentClass;
  _className : string;
begin
  // get the default form class
  _compClass := TComponentClass(DelphiObjectClass);
  // if we have a subclass of our Form wrapper, then check if we can find
  // a Delphi class that would have the same name as the Python class.
  // This would allow Python to instanciate an existing Delphi form class,
  // instead of only using a blank form.
  if ob_type <> PythonType.TheTypePtr then
  begin
    _className := string(ob_type.tp_name);
    _class := GetClass(_className);
    if not Assigned(_class) then
      _class := GetClass('T'+_className);
    if Assigned(_class) and _class.InheritsFrom(TCustomForm) then
      _compClass := TComponentClass(_class);
  end;
  // if the Owner is Application, then we have to call its CreateForm method,
  // otherwise we won't have a main form defined, as the main form is the
  // first created form. Of course, this is a concern only when Python
  // controls all the GUI and calls Application.Run by itself.
  if AOwner = Application then
    Application.CreateForm(_compClass, Result)
  else
    Result := _compClass.Create(AOwner);
end;

{ TPyDelphiForm }

class function TPyDelphiForm.DelphiObjectClass: TClass;
begin
  Result := TForm;
end;

function TPyDelphiForm.GetDelphiObject: TForm;
begin
  Result := TForm(inherited DelphiObject);
end;

procedure TPyDelphiForm.SetDelphiObject(const Value: TForm);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiScreen }

class function TPyDelphiScreen.DelphiObjectClass: TClass;
begin
  Result := TScreen;
end;

destructor TPyDelphiScreen.Destroy;
begin
  if PythonOK then
  begin
    GetPythonEngine.Py_XDECREF(fOnActiveControlChange);
    GetPythonEngine.Py_XDECREF(fOnActiveFormChange);
  end;
  inherited;
end;

function TPyDelphiScreen.DisableAlign_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':DisableAlign') <> 0 then begin
      DelphiObject.DisableAlign;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiScreen.EnableAlign_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':EnableAlign') <> 0 then begin
      DelphiObject.EnableAlign;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiScreen.GetDelphiObject: TScreen;
begin
  Result := TScreen(inherited DelphiObject);
end;

function TPyDelphiScreen.Get_ActiveControl(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.ActiveControl);
end;

function TPyDelphiScreen.Get_ActiveCustomForm(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.ActiveCustomForm);
end;

function TPyDelphiScreen.Get_ActiveForm(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.ActiveForm);
end;

function TPyDelphiScreen.Get_Cursor(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Cursor);
end;

function TPyDelphiScreen.Get_Cursors(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := PyDelphiWrapper.DefaultContainerType.CreateInstance;
  with PythonToDelphi(Result) as TPyDelphiContainer do
    Setup(Self.PyDelphiWrapper, TScreenCursorsAccess.Create(Self.PyDelphiWrapper, Self.DelphiObject));
end;

function TPyDelphiScreen.Get_CustomFormCount(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.CustomFormCount);
end;

function TPyDelphiScreen.Get_CustomForms(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := PyDelphiWrapper.DefaultContainerType.CreateInstance;
  with PythonToDelphi(Result) as TPyDelphiContainer do
    Setup(Self.PyDelphiWrapper, TScreenCustomFormsAccess.Create(Self.PyDelphiWrapper, Self.DelphiObject));
end;

function TPyDelphiScreen.Get_DataModuleCount(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.DataModuleCount);
end;

function TPyDelphiScreen.Get_DataModules(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := PyDelphiWrapper.DefaultContainerType.CreateInstance;
  with PythonToDelphi(Result) as TPyDelphiContainer do
    Setup(Self.PyDelphiWrapper, TScreenDataModulesAccess.Create(Self.PyDelphiWrapper, Self.DelphiObject));
end;

function TPyDelphiScreen.Get_DefaultIme(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyUnicodeFromString(DelphiObject.DefaultIme);
end;

function TPyDelphiScreen.Get_DefaultKbLayout(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.DefaultKbLayout);
end;

function TPyDelphiScreen.Get_DesktopHeight(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.DesktopHeight);
end;

function TPyDelphiScreen.Get_DesktopLeft(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.DesktopLeft);
end;

function TPyDelphiScreen.Get_DesktopRect(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := WrapRect(PyDelphiWrapper, DelphiObject.DesktopRect);
end;

function TPyDelphiScreen.Get_DesktopTop(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.DesktopTop);
end;

function TPyDelphiScreen.Get_DesktopWidth(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.DesktopWidth);
end;

function TPyDelphiScreen.Get_Fonts(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.Fonts);
end;

function TPyDelphiScreen.Get_FormCount(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.FormCount);
end;

function TPyDelphiScreen.Get_Forms(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := PyDelphiWrapper.DefaultContainerType.CreateInstance;
  with PythonToDelphi(Result) as TPyDelphiContainer do
    Setup(Self.PyDelphiWrapper, TScreenFormsAccess.Create(Self.PyDelphiWrapper, Self.DelphiObject));
end;

function TPyDelphiScreen.Get_Height(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Height);
end;

function TPyDelphiScreen.Get_HintFont(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.HintFont);
end;

function TPyDelphiScreen.Get_IconFont(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.IconFont);
end;

function TPyDelphiScreen.Get_Imes(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.Imes);
end;

function TPyDelphiScreen.Get_MenuFont(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.MenuFont);
end;

function TPyDelphiScreen.Get_MonitorCount(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.MonitorCount);
end;

function TPyDelphiScreen.Get_Monitors(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := PyDelphiWrapper.DefaultContainerType.CreateInstance;
  with PythonToDelphi(Result) as TPyDelphiContainer do
    Setup(Self.PyDelphiWrapper, TScreenMonitorsAccess.Create(Self.PyDelphiWrapper, Self.DelphiObject));
end;

function TPyDelphiScreen.Get_OnActiveControlChange(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  with GetPythonEngine do begin
    if Assigned(fOnActiveControlChange) then
    begin
      Result := fOnActiveControlChange;
      Py_XINCREF(Result);
    end
    else
      Result := ReturnNone;
  end;
end;

function TPyDelphiScreen.Get_OnActiveFormChange(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  with GetPythonEngine do begin
    if Assigned(fOnActiveFormChange) then
    begin
      Result := fOnActiveFormChange;
      Py_XINCREF(Result);
    end
    else
      Result := ReturnNone;
  end;
end;

function TPyDelphiScreen.Get_PixelsPerInch(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.PixelsPerInch);
end;

function TPyDelphiScreen.Get_Width(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Width);
end;

function TPyDelphiScreen.Get_WorkAreaHeight(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.WorkAreaHeight);
end;

function TPyDelphiScreen.Get_WorkAreaLeft(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.WorkAreaLeft);
end;

function TPyDelphiScreen.Get_WorkAreaRect(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := WrapRect(PyDelphiWrapper, DelphiObject.WorkAreaRect);
end;

function TPyDelphiScreen.Get_WorkAreaTop(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.WorkAreaTop);
end;

function TPyDelphiScreen.Get_WorkAreaWidth(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.WorkAreaWidth);
end;

procedure TPyDelphiScreen.HandleOnActiveControlChange(Sender: TObject);
begin
  RaiseNotifyEvent(PyDelphiWrapper, fOnActiveControlChange, Sender);
end;

procedure TPyDelphiScreen.HandleOnActiveFormChange(Sender: TObject);
begin
  RaiseNotifyEvent(PyDelphiWrapper, fOnActiveFormChange, Sender);
end;

function TPyDelphiScreen.MonitorFromPoint_Wrapper(args: PPyObject): PPyObject;
var
  p : TPoint;
  _pointObj : PPyObject;
  _monitorDefault : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  if GetPythonEngine.PyArg_ParseTuple( args, 'Oi:MonitorFromPoint',@_pointObj, @_monitorDefault ) <> 0 then
  begin
    if CheckPointAttribute(_pointObj, 'First parameter', p) and
       CheckEnum('TMonitorDefaultTo', _monitorDefault, Ord(Low(TMonitorDefaultTo)), Ord(High(TMonitorDefaultTo))) then
    begin
      Result := Wrap(DelphiObject.MonitorFromPoint(p, TMonitorDefaultTo(_monitorDefault)));
    end
    else
      Result := nil;
  end
  else
    Result := nil;
end;

function TPyDelphiScreen.Realign_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Realign') <> 0 then begin
      DelphiObject.Realign;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiScreen.ResetFonts_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':ResetFonts') <> 0 then begin
      DelphiObject.ResetFonts;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

class procedure TPyDelphiScreen.RegisterGetSets(PythonType: TPythonType);
begin
  with PythonType do
    begin
      AddGetSet('ActiveControl', @TPyDelphiScreen.Get_ActiveControl, nil,
        'Indicates which control currently has input focus on the screen.', nil);
      AddGetSet('ActiveCustomForm', @TPyDelphiScreen.Get_ActiveCustomForm, nil,
        'Indicates the descendant of TCustomForm that currently has focus.', nil);
      AddGetSet('ActiveForm', @TPyDelphiScreen.Get_ActiveForm, nil,
        'Indicates which form currently has focus.', nil);
      AddGetSet('CustomFormCount', @TPyDelphiScreen.Get_CustomFormCount, nil,
        'Indicates the number of forms or property pages displayed on the screen.', nil);
      AddGetSet('CustomForms', @TPyDelphiScreen.Get_CustomForms, nil,
        'Lists all the forms and property pages that are currently displayed in the application.', nil);
      AddGetSet('Cursor', @TPyDelphiScreen.Get_Cursor, @TPyDelphiScreen.Set_Cursor,
        'Controls the mouse cursor image on a global level.', nil);
      AddGetSet('Cursors', @TPyDelphiScreen.Get_Cursors, nil,
        'Lists the cursors available to the application.', nil);
      AddGetSet('DataModules', @TPyDelphiScreen.Get_DataModules, nil,
        'Lists all the data modules that are currently instantiated in the application.', nil);
      AddGetSet('DataModuleCount', @TPyDelphiScreen.Get_DataModuleCount, nil,
        'Indicates the number of data modules that are currently instantiated in the application.', nil);
      AddGetSet('MonitorCount', @TPyDelphiScreen.Get_MonitorCount, nil,
        'Specifies the number of monitors used to comprise the desktop.', nil);
      AddGetSet('Monitors', @TPyDelphiScreen.Get_Monitors, nil,
        'Provides access to an individual monitor used to comprise the desktop.', nil);
      AddGetSet('DesktopRect', @TPyDelphiScreen.Get_DesktopRect, nil,
        'Specifies the boundaries of the virtual desktop relative to the upper-left corner of the primary monitor.', nil);
      AddGetSet('DesktopLeft', @TPyDelphiScreen.Get_DesktopLeft, nil,
        'Specifies the x-coordinate of the desktop’s left edge relative to the upper-left corner of the primary monitor.', nil);
      AddGetSet('DesktopTop', @TPyDelphiScreen.Get_DesktopTop, nil,
        'Specifies the y-coordinate of the entire desktop’s top edge relative to the upper-left corner of the primary monitor.', nil);
      AddGetSet('DesktopWidth', @TPyDelphiScreen.Get_DesktopWidth, nil,
        'Specifies the width of the entire virtual desktop.', nil);
      AddGetSet('DesktopHeight', @TPyDelphiScreen.Get_DesktopHeight, nil,
        'Specifies the height of the entire virtual desktop.', nil);
      AddGetSet('WorkAreaRect', @TPyDelphiScreen.Get_WorkAreaRect, nil,
        'Specifies the boundaries of the usable work area on the primary monitor.', nil);
      AddGetSet('WorkAreaHeight', @TPyDelphiScreen.Get_WorkAreaHeight, nil,
        'Specifies the height of the work area on the primary monitor.', nil);
      AddGetSet('WorkAreaLeft', @TPyDelphiScreen.Get_WorkAreaLeft, nil,
        'Specifies the left edge of the work area on the primary monitor.', nil);
      AddGetSet('WorkAreaTop', @TPyDelphiScreen.Get_WorkAreaTop, nil,
        'Specifies the top edge of the work area on the primary monitor.', nil);
      AddGetSet('WorkAreaWidth', @TPyDelphiScreen.Get_WorkAreaWidth, nil,
        'Specifies the width of the work area on the primary monitor.', nil);
      AddGetSet('HintFont', @TPyDelphiScreen.Get_HintFont, @TPyDelphiScreen.Set_HintFont,
        'Specifies the font used to display help hints.', nil);
      AddGetSet('IconFont', @TPyDelphiScreen.Get_IconFont, @TPyDelphiScreen.Set_IconFont,
        'Specifies the font used to display the labels on the icons in file selection dialogs.', nil);
      AddGetSet('MenuFont', @TPyDelphiScreen.Get_MenuFont, @TPyDelphiScreen.Set_MenuFont,
        'Specifies the font used for menu commands.', nil);
      AddGetSet('Fonts', @TPyDelphiScreen.Get_Fonts, nil,
        'Lists the face names for all fonts supported by the screen.', nil);
      AddGetSet('FormCount', @TPyDelphiScreen.Get_FormCount, nil,
        'Indicates the number of forms or property pages displayed on the screen.', nil);
      AddGetSet('Forms', @TPyDelphiScreen.Get_Forms, nil,
        'Lists all the forms currently displayed in the application.', nil);
      AddGetSet('Imes', @TPyDelphiScreen.Get_Imes, nil,
        'Lists all input method editors (IMEs) installed on the system.', nil);
      AddGetSet('DefaultIme', @TPyDelphiScreen.Get_DefaultIme, nil,
        'Indicates which input method editor (IME) is active when the TScreen object is created.', nil);
      AddGetSet('DefaultKbLayout', @TPyDelphiScreen.Get_DefaultKbLayout, nil,
        'Indicates the Windows handle to the keyboard layout that was active when the application started running.', nil);
      AddGetSet('Height', @TPyDelphiScreen.Get_Height, nil,
        'Indicates the vertical size of the screen in pixels.', nil);
      AddGetSet('PixelsPerInch', @TPyDelphiScreen.Get_PixelsPerInch, nil,
        'Indicates the number of screen pixels that make up a logical inch in the vertical direction.', nil);
      AddGetSet('Width', @TPyDelphiScreen.Get_Width, nil,
        'Indicates the horizontal size of the screen in pixels.', nil);
      AddGetSet('OnActiveControlChange', @TPyDelphiScreen.Get_OnActiveControlChange, @TPyDelphiScreen.Set_OnActiveControlChange,
        'Occurs immediately after input focus changes to a new windowed control.', nil);
      AddGetSet('OnActiveFormChange', @TPyDelphiScreen.Get_OnActiveFormChange, @TPyDelphiScreen.Set_OnActiveFormChange,
        'Occurs immediately after a new form becomes active in a multi-form application.', nil);
    end;
end;

class procedure TPyDelphiScreen.RegisterMethods(PythonType: TPythonType);
begin
  PythonType.AddMethod('DisableAlign', @TPyDelphiScreen.DisableAlign_Wrapper,
    'TScreen.DisableAlign()'#10 +
    'Prevents forms from being aligned in the screen.');
  PythonType.AddMethod('EnableAlign', @TPyDelphiScreen.EnableAlign_Wrapper,
    'TScreen.EnableAlign()'#10 +
    'Allows forms to be aligned in the screen.');
  PythonType.AddMethod('Realign', @TPyDelphiScreen.Realign_Wrapper,
    'TScreen.Realign()'#10 +
    'Realigns the screen''s forms according to their Align properties.');
  PythonType.AddMethod('ResetFonts', @TPyDelphiScreen.ResetFonts_Wrapper,
    'TScreen.ResetFonts()'#10 +
    'Reinitializes the fonts listed in the Fonts property.');
  PythonType.AddMethod('MonitorFromPoint', @TPyDelphiScreen.MonitorFromPoint_Wrapper,
    'TScreen.MonitorFromPoint(APoint, AMonitorDefault)'#10 +
    'Returns the monitor where a specified point is located.');
end;

procedure TPyDelphiScreen.SetDelphiObject(const Value: TScreen);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiScreen.Set_Cursor(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _cursor : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'Cursor', _cursor) then
  begin
    DelphiObject.Cursor := _cursor;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiScreen.Set_HintFont(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _font : TObject;
begin
  Adjust(@Self);
  if CheckObjAttribute(AValue, 'HintFont', TFont, _font) then
  begin
    DelphiObject.HintFont := TFont(_font);
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiScreen.Set_IconFont(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _font : TObject;
begin
  Adjust(@Self);
  if CheckObjAttribute(AValue, 'IconFont', TFont, _font) then
  begin
    DelphiObject.IconFont := TFont(_font);
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiScreen.Set_MenuFont(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _font : TObject;
begin
  Adjust(@Self);
  if CheckObjAttribute(AValue, 'MenuFont', TFont, _font) then
  begin
    DelphiObject.MenuFont := TFont(_font);
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiScreen.Set_OnActiveControlChange(AValue: PPyObject;
  AContext: Pointer): Integer;
begin
  Adjust(@Self);
  with GetPythonEngine do begin
    if CheckCallableAttribute(AValue, 'OnActiveControlChange') then
    begin
      Py_XDECREF(fOnActiveControlChange);
      if AValue = Py_None then
      begin
        DelphiObject.OnActiveControlChange := nil;
        fOnActiveControlChange := nil;
      end
      else
      begin
        fOnActiveControlChange := AValue;
        Py_XINCREF(fOnActiveControlChange);
        DelphiObject.OnActiveControlChange := HandleOnActiveControlChange;
      end;
      Result := 0;
    end
    else
      Result := -1;
  end;
end;

function TPyDelphiScreen.Set_OnActiveFormChange(AValue: PPyObject;
  AContext: Pointer): Integer;
begin
  Adjust(@Self);
  with GetPythonEngine do begin
    if CheckCallableAttribute(AValue, 'OnActiveFormChange') then
    begin
      Py_XDECREF(fOnActiveFormChange);
      if AValue = Py_None then
      begin
        DelphiObject.OnActiveFormChange := nil;
        fOnActiveFormChange := nil;
      end
      else
      begin
        fOnActiveFormChange := AValue;
        Py_XINCREF(fOnActiveFormChange);
        DelphiObject.OnActiveFormChange := HandleOnActiveFormChange;
      end;
      Result := 0;
    end
    else
      Result := -1;
  end;
end;

{ TBaseScreenAccess }

class function TBaseScreenAccess.ExpectedContainerClass: TClass;
begin
  Result := TScreen;
end;

function TBaseScreenAccess.GetContainer: TScreen;
begin
  Result := TScreen(inherited Container);
end;

{ TScreenCustomFormsAccess }

function TScreenCustomFormsAccess.GetItem(AIndex: Integer): PPyObject;
begin
  Result := Wrap(Container.CustomForms[AIndex]);
end;

function TScreenCustomFormsAccess.GetSize: Integer;
begin
  Result := Container.CustomFormCount;
end;

class function TScreenCustomFormsAccess.Name: string;
begin
  Result := 'TScreen.CustomForms';
end;

{ TScreenFormsAccess }

function TScreenFormsAccess.GetItem(AIndex: Integer): PPyObject;
begin
  Result := Wrap(Container.Forms[AIndex]);
end;

function TScreenFormsAccess.GetSize: Integer;
begin
  Result := Container.FormCount;
end;

class function TScreenFormsAccess.Name: string;
begin
  Result := 'TScreen.Forms';
end;

{ TScreenDataModulesAccess }

function TScreenDataModulesAccess.GetItem(AIndex: Integer): PPyObject;
begin
  Result := Wrap(Container.DataModules[AIndex]);
end;

function TScreenDataModulesAccess.GetSize: Integer;
begin
  Result := Container.DataModuleCount;
end;

class function TScreenDataModulesAccess.Name: string;
begin
  Result := 'TScreen.DataModules';
end;

{ TScreenCursorsAccess }

function TScreenCursorsAccess.GetItem(AIndex: Integer): PPyObject;
begin
  Result := GetPythonEngine.PyLong_FromLong( Container.Cursors[AIndex] );
end;

function TScreenCursorsAccess.GetSize: Integer;
begin
  Result := 32767;
end;

class function TScreenCursorsAccess.Name: string;
begin
  Result := 'TScreen.Cursors';
end;

{ TScreenMonitorsAccess }

function TScreenMonitorsAccess.GetItem(AIndex: Integer): PPyObject;
begin
  Result := Wrap(Container.Monitors[AIndex]);
end;

function TScreenMonitorsAccess.GetSize: Integer;
begin
  Result := Container.MonitorCount;
end;

class function TScreenMonitorsAccess.Name: string;
begin
  Result := 'TScreen.Monitors';
end;

{ TPyDelphiMonitor }

function TPyDelphiMonitor.Get_BoundsRect(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := WrapRect(PyDelphiWrapper, DelphiObject.BoundsRect);
end;

function TPyDelphiMonitor.Get_Handle(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Handle);
end;

function TPyDelphiMonitor.Get_Height(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Height);
end;

function TPyDelphiMonitor.Get_Left(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Left);
end;

function TPyDelphiMonitor.Get_MonitorNum(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.MonitorNum);
end;

function TPyDelphiMonitor.Get_Primary(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.Primary);
end;

function TPyDelphiMonitor.Get_Top(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Top);
end;

function TPyDelphiMonitor.Get_Width(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Width);
end;

function TPyDelphiMonitor.Get_WorkareaRect(AContext : Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := WrapRect(PyDelphiWrapper, DelphiObject.WorkareaRect);
end;

function TPyDelphiMonitor.GetDelphiObject: TMonitor;
begin
  Result := TMonitor(inherited DelphiObject);
end;

class procedure TPyDelphiMonitor.RegisterGetSets(PythonType: TPythonType);
begin
  with PythonType do
  begin
    AddGetSet('Handle', @TPyDelphiMonitor.Get_Handle, nil,
              'Indicates the Windows handle for the monitor.', nil);
    AddGetSet('MonitorNum', @TPyDelphiMonitor.Get_MonitorNum, nil,
              'Specifies the index of the monitor in the global screen object''s Monitors list.', nil);
    AddGetSet('Left', @TPyDelphiMonitor.Get_Left, nil,
              'Indicates the logical position of the left edge of the monitor.', nil);
    AddGetSet('Height', @TPyDelphiMonitor.Get_Height, nil,
              'Indicates the vertical size of the monitor in pixels.', nil);
    AddGetSet('Top', @TPyDelphiMonitor.Get_Top, nil,
              'Indicates the logical position of the top edge of the monitor.', nil);
    AddGetSet('Width', @TPyDelphiMonitor.Get_Width, nil,
              'Indicates the horizontal size of the monitor in pixels.', nil);
    AddGetSet('BoundsRect', @TPyDelphiMonitor.Get_BoundsRect, nil,
              'Indicates the dimensions of the monitor in pixels.', nil);
    AddGetSet('WorkareaRect', @TPyDelphiMonitor.Get_WorkareaRect, nil,
              'Indicates the dimensions of the usable area on the monitor.', nil);
    AddGetSet('Primary', @TPyDelphiMonitor.Get_Primary, nil,
              'Indicates whether this is the primary monitor.', nil);
  end;
end;

procedure TPyDelphiMonitor.SetDelphiObject(const Value: TMonitor);
begin
  inherited DelphiObject := Value;
end;

class function TPyDelphiMonitor.DelphiObjectClass: TClass;
begin
  Result := TMonitor;
end;

{ TPyDelphiApplication }

function TPyDelphiApplication.ActivateHint_Wrapper(
  args: PPyObject): PPyObject;
var
  _obj : PPyObject;
  _point : TPoint;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'O:ActivateHint',@_obj ) <> 0 then begin
      if CheckPointAttribute(_obj, 'The first argument of ActivateHint', _point) then
      begin
        DelphiObject.ActivateHint(_point);
        Result := ReturnNone;
      end else
        Result := nil;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.BringToFront_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':BringToFront') <> 0 then begin
      DelphiObject.BringToFront;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CancelHint_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':CancelHint') <> 0 then begin
      DelphiObject.CancelHint;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ExecuteAction_Wrapper(
  args: PPyObject): PPyObject;
var
  _obj : PPyObject;
  _value : TObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'O:ExecuteAction',@_obj ) <> 0 then begin
      if CheckObjAttribute(_obj, 'The first argument of ExecuteAction', TBasicAction, _value) then
      begin
        Result := VariantAsPyObject( DelphiObject.ExecuteAction(TBasicAction(_value)) );
      end else
        Result := nil;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDelphiObject: TApplication;
begin
  Result := TApplication(inherited DelphiObject);
end;

function TPyDelphiApplication.HandleException_Wrapper(
  args: PPyObject): PPyObject;
var
  _obj : PPyObject;
  _sender : TObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'O:HandleException',@_obj ) <> 0 then begin
      if CheckObjAttribute(_obj, 'The first argument of HandleException', TObject, _sender) then
      begin
        DelphiObject.HandleException(_sender);
        Result := ReturnNone;
      end else
        Result := nil;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.HandleMessage_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':HandleMessage') <> 0 then begin
      DelphiObject.HandleMessage;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.HelpCommand_Wrapper(
  args: PPyObject): PPyObject;
var
  _command : Integer;
  _data : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'i:HelpCommand',@_command, @_data ) <> 0 then begin
      Result := VariantAsPyObject( DelphiObject.HelpCommand(_command, _data) );
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.HelpContext_Wrapper(
  args: PPyObject): PPyObject;
var
  _context : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'i:HelpContext',@_context ) <> 0 then begin
      Result := VariantAsPyObject( DelphiObject.HelpContext(_context) );
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.HelpJump_Wrapper(args: PPyObject): PPyObject;
var
  _jumpID : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'O:HelpJump', @_jumpID ) <> 0 then begin
      Result := VariantAsPyObject( DelphiObject.HelpJump(PyObjectAsString(_jumpID)) );
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.HelpKeyword_Wrapper(
  args: PPyObject): PPyObject;
var
  _keyword : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'O:HelpKeyword', @_keyword ) <> 0 then begin
      Result := VariantAsPyObject( DelphiObject.HelpKeyword(PyObjectAsString(_keyword)) );
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.HideHint_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':HideHint') <> 0 then begin
      DelphiObject.HideHint;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.Initialize_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Initialize') <> 0 then begin
      DelphiObject.Initialize;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsRightToLeft_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':IsRightToLeft') <> 0 then begin
      Result := VariantAsPyObject( DelphiObject.IsRightToLeft );
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.MessageBox_Wrapper(
  args: PPyObject): PPyObject;
var
  _text : PPyObject;
  _caption : PPyObject;
  _flags : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'OOi:MessageBox', @_text, @_caption, @_flags ) <> 0 then begin
      Result := PyLong_FromLong(
        DelphiObject.MessageBox(PChar(PyObjectAsString(_text)), PChar(PyObjectAsString(_caption)), _flags) );
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.MessageDlg_Wrapper(
  args: PPyObject): PPyObject;
var
  _msg : PPyObject;
  _dlg_type : Integer;
  _buttons : Integer;
  _help_ctx : LongInt;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if (PyArg_ParseTuple( args, 'Oiii:MessageDlg', @_msg, @_dlg_type, @_buttons, @_help_ctx ) <> 0) and
    CheckEnum('TMsgDlgType', _dlg_type, Ord(Low(TMsgDlgType)), Ord(High(TMsgDlgType))) and
    CheckEnum('TMsgDlgBtn', _buttons, Ord(Low(TMsgDlgBtn)), Ord(High(TMsgDlgBtn))) then
      begin
        Result := PyLong_FromLong(
          MessageDlg(PChar(PyObjectAsString(_msg)), TMsgDlgType(_dlg_type),
          [TMsgDlgBtn(_buttons)], _help_ctx) );
      end else
        Result := nil;
  end;
end;

function TPyDelphiApplication.InputBox_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  LPyCaption: PPyObject;
  LPyPrompt: PPyObject;
  LPyDefault: PPyObject;
  threadid: cardinal;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OOO:InputBox', @LPyCaption, @LPyPrompt, @LPyDefault) <> 0) then
    begin
      var res :=  InputBox(PyObjectAsString(LPyCaption), PyObjectAsString(LPyPrompt), PyObjectAsString(LPyDefault));
      Result := GetPythonEngine.PyUnicodeFromString(res);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SelectDirectory_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  LPyCaption: PPyObject;
  LPyRoot: PPyObject;
  sDir: String;
  _obj : TObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:SelectDirectory', @LPyCaption, @LPyRoot) <> 0) then
    begin
      SelectDirectory(PyObjectAsString(LPyCaption), PyObjectAsString(LPyRoot), sDir);
      Result := PyUnicodeFromString(sDir);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PrintText_Wrapper(
  args : PPyObject) : PPyObject; cdecl;
var
  LPyText: PPyObject;
  LPyFont: PPyObject;
  _x, _y: Integer;
  _obj : TObject;
  _font: TFont;

  (* 打印文本 *)
  procedure PrintText(Text: String; x, y: Integer; _Font: TFont);
  var
    arr: TArray<String>;
  begin
    arr := SplitString(Text, #13#10);
    Printer.BeginDoc;
    with Printer.Canvas do
    begin
      Font.Name := _Font.Name;
      Font.Size := _Font.Size;
      Font.Color := _Font.Color;
      for var i := 0 to High(arr) do
         TextOut(x, y + (i * TextHeight(arr[i])), arr[i]);
    end;
    Printer.EndDoc;
  end;

begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OiiO:PrintText', @LPyText, @_x, @_y, @LPyFont) <> 0) and
      CheckObjAttribute(LPyFont, 'Font', TFont, _obj) then
    begin
      _font := TFont(_obj);
      PrintText(PyObjectAsString(LPyText), _x, _y, _font);
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PrintImage_Wrapper(
  args : PPyObject) : PPyObject; cdecl;
var
  LPyBitmap: PPyObject;
  _obj : TObject;
  _x, _y, _scale: Integer;
  _bitmap: TBitmap;

  (* 打印位图 *)
  procedure PrintImage(Bitmap: TBitmap; x, y, scale: Integer);
  var
    strect:TRect; //定义打印输出矩形框的大小
  begin
    with Printer do
    begin
      BeginDoc;
      if scale <= 0 then scale := 1;
      with strect do
      begin
        Left := x;
        Top := y;
        Right := PageWidth div scale;
        Bottom := PageHeight div scale;
      end;
      Canvas.StretchDraw(strect, Bitmap);
      EndDoc;
    end;
  end;

begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'Oiii:PrintImage', @LPyBitmap, @_x, @_y,
      @_scale) <> 0) and CheckObjAttribute(LPyBitmap, 'Bitmap', TBitmap, _obj) then
    begin
      _bitmap := TBitmap(_obj);
      PrintImage(_bitmap, _x, _y, _scale);
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ColorToString_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _color : TColor;
  ColorStr : String;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:ColorToString', @_color) <> 0) then
    begin
      ColorStr := ColorToString(_color);
      Result := PyUnicodeFromString(ColorStr);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.WinExec_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  LPyCmdLine: PPyObject;
  _cmdshow: Cardinal;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'Oi:WinExec', @LPyCmdLine, @_cmdshow) <> 0) then
    begin
      Result := PyLong_FromLong(WinExec(PAnsiChar(AnsiString(PyObjectAsString(LPyCmdLine))), _cmdshow));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ShowWindow_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _nCmdShow : Integer;
  preVisible : LongBool;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:ShowWindow', @_hWnd, @_nCmdShow) <> 0) then
    begin
      preVisible := ShowWindow(_hWnd, _nCmdShow);
      Result := PyLong_FromLong(Integer(preVisible));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ShellExecute_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  LPyOperation, LPyFileName, LPyParameters, LPyDirectory: PPyObject;
  _hwnd: HWND;
  _showcmd: Cardinal;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iOOOOi:WinExec', @_hwnd, @LPyOperation, @LPyFileName,
      @LPyParameters, @LPyDirectory, @_showcmd) <> 0) then
    begin
      Result := PyLong_FromLong(ShellExecute(_hwnd, PChar(PyObjectAsString(LPyOperation)),
        PChar(PyObjectAsString(LPyFileName)), PChar(PyObjectAsString(LPyParameters)),
        PChar(PyObjectAsString(LPyDirectory)), _showcmd));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SendMessage_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  _hwnd: HWND;
  _msg: UINT;
  _wparam: NativeUInt;
  _lparam: NativeInt;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiii:SendMessage', @_hwnd, @_msg, @_wparam,
      @_lparam) <> 0) then
    begin
      Result := PyLong_FromLong(SendMessage(_hwnd, _msg, _wparam, _lparam));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PostMessage_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  _hwnd: HWND;
  _msg: UINT;
  _wparam: NativeUInt;
  _lparam: NativeInt;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiii:PostMessage', @_hwnd, @_msg, @_wparam,
      @_lparam) <> 0) then
    begin
      Result := PyBool_FromLong(LongInt(PostMessage(_hwnd, _msg, _wparam, _lparam)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetSystemPath_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _SystemPath : Integer;
  SPath : String;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetSystemPath', @_SystemPath) <> 0) and
      CheckEnum('TSystemPath', _SystemPath, Ord(Low(TSystemPath)), Ord(High(TSystemPath))) then
    begin
      SPath := GetSystemPath(TSystemPath(_SystemPath));
      Result := PyUnicodeFromString(SPath);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ReleaseCapture_Wrapper(
  args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':ReleaseCapture') <> 0) then
    begin
      if ReleaseCapture then
        Result := ReturnTrue
      else
        Result := ReturnFalse;
    end else
      Result := ReturnFalse;
  end;
end;

function TPyDelphiApplication.SetParent_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _hWndChild : HWND;
  _hWndNewParent : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetParent', @_hWndChild, @_hWndNewParent) <> 0) then
    begin
      Result := PyLong_FromLong(SetParent(_hWndChild, _hWndNewParent));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetWindowPos_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _hWndInsertAfter : HWND;
  _X, _Y, _cx, _cy : Integer;
  _uFlags : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiiiii:SetWindowPos', @_hWnd, @_hWndInsertAfter,
      @_X, @_Y, @_cx, @_cy, @_uFlags) <> 0) then
    begin
      Result := PyBool_FromLong(UINT(SetWindowPos(_hWnd, _hWndInsertAfter, _X, _Y,
        _cx, _cy, _uFlags)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ShowCursor_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _bShow: BOOL;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:ShowCursor', @_bShow) <> 0) then
    begin
      Result := PyLong_FromLong(ShowCursor(_bShow));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PtInRect_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _lprc : TRect;
  _pt : TPoint;
  LPyPoint: PPyObject;
  LPyRect: PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:PtInRect', @LPyRect, @LPyPoint) <> 0) and
      CheckPointAttribute(LPyPoint, 'TPoint', _pt) and
      CheckRectAttribute(LPyRect, 'TRect', _lprc) then
    begin
      Result := PyBool_FromLong(Integer(PtInRect(_lprc, _pt)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDC_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetDC', @_hWnd) <> 0) then
    begin
      Result := PyLong_FromLong(GetDC(_hWnd));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ReleaseDC_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _hDC : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:ReleaseDC', @_hWnd, @_hDC) <> 0) then
    begin
      Result := PyLong_FromLong(ReleaseDC(_hWnd, _hDC));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.BitBlt_Wrapper(
  args: PPyObject): PPyObject; cdecl;
var
  _destDC : HDC;
  _X, _Y, _width, _height : Integer;
  _srcDC : HDC;
  _xSrc, _ySrc : Integer;
  _rop : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiiiiiii:BitBlt', @_destDC, @_X, @_Y, @_width,
      @_height, @_srcDC, @_xSrc, @_ySrc, @_rop) <> 0) then
    begin
      Result := PyBool_FromLong(UINT(BitBlt(_destDC, _X, _Y, _width,
        _height, _srcDC, _xSrc, _ySrc, _rop)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateMutex_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  LPyName: PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:CreateMutex', @LPyName) <> 0) then
    begin
      Result := PyLong_FromLong(CreateMutex(nil, False, PChar(PyObjectAsString(LPyName))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.OpenMutex_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  LPyName: PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:OpenMutex', @LPyName) <> 0) then
    begin
      Result := PyLong_FromLong(OpenMutex(MUTEX_ALL_ACCESS, False, PChar(PyObjectAsString(LPyName))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CloseHandle_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  _handle: THandle;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:CloseHandle', @_handle) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(CloseHandle(_handle)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetLastError_Wrapper(args : PPyObject) : PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetLastError') <> 0) then
    begin
      Result := PyLong_FromLong(GetLastError);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RGB_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _r, _g, _b: Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:RGB', @_r, @_g, @_b) <> 0) then
    begin
      Result := PyLong_FromLong(RGB(_r, _g, _b));
    end else
      Result := nil;
  end;
end;

{ Additional Win32 API functions (kernel32/user32/gdi32) }

function TPyDelphiApplication.Beep_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _dwFreq : DWORD;
  _dwDuration : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:Beep', @_dwFreq, @_dwDuration) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(Beep(_dwFreq, _dwDuration)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.Sleep_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _dwMilliseconds : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:Sleep', @_dwMilliseconds) <> 0) then
    begin
      Sleep(_dwMilliseconds);
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetTickCount_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetTickCount') <> 0) then
    begin
      Result := PyLong_FromLong(GetTickCount());
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetCurrentProcessId_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetCurrentProcessId') <> 0) then
    begin
      Result := PyLong_FromLong(GetCurrentProcessId());
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetCurrentThreadId_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetCurrentThreadId') <> 0) then
    begin
      Result := PyLong_FromLong(GetCurrentThreadId());
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetCurrentProcess_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetCurrentProcess') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetCurrentProcess()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetCurrentThread_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetCurrentThread') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetCurrentThread()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetLastError_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _dwErrCode : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SetLastError', @_dwErrCode) <> 0) then
    begin
      SetLastError(_dwErrCode);
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.MulDiv_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _nNumber : Integer;
  _nNumerator : Integer;
  _nDenominator : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:MulDiv', @_nNumber, @_nNumerator, @_nDenominator) <> 0) then
    begin
      Result := PyLong_FromLong(MulDiv(_nNumber, _nNumerator, _nDenominator));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetComputerName_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _buf: array[0..255] of Char;
  _size: DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetComputerName') <> 0) then
    begin
      _size := 256;
      if Windows.GetComputerName(_buf, _size) then
        Result := PyUnicodeFromString(_buf)
      else
        Result := PyUnicodeFromString('');
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetEnvironmentVariable_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpName : PPyObject;
  _lpValue : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:SetEnvironmentVariable', @_lpName, @_lpValue) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetEnvironmentVariable(PChar(PyObjectAsString(_lpName)), PChar(PyObjectAsString(_lpValue)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetEnvironmentVariable_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpName : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:GetEnvironmentVariable', @_lpName) <> 0) then
    begin
      Windows.GetEnvironmentVariable(PChar(PyObjectAsString(_lpName)), _buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetSystemDirectory_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetSystemDirectory') <> 0) then
    begin
      Windows.GetSystemDirectory(_buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetWindowsDirectory_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetWindowsDirectory') <> 0) then
    begin
      Windows.GetWindowsDirectory(_buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetTempPath_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetTempPath') <> 0) then
    begin
      Windows.GetTempPath(1024, _buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetCurrentDirectory_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetCurrentDirectory') <> 0) then
    begin
      Windows.GetCurrentDirectory(1024, _buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetCurrentDirectory_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpPathName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:SetCurrentDirectory', @_lpPathName) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetCurrentDirectory(PChar(PyObjectAsString(_lpPathName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateDirectory_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpPathName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:CreateDirectory', @_lpPathName) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(CreateDirectory(PChar(PyObjectAsString(_lpPathName)), nil)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RemoveDirectory_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpPathName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:RemoveDirectory', @_lpPathName) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(RemoveDirectory(PChar(PyObjectAsString(_lpPathName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.DeleteFile_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpFileName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:DeleteFile', @_lpFileName) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(DeleteFile(PChar(PyObjectAsString(_lpFileName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CopyFile_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpExistingFileName : PPyObject;
  _lpNewFileName : PPyObject;
  _bFailIfExists : BOOL;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OOi:CopyFile', @_lpExistingFileName, @_lpNewFileName, @_bFailIfExists) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(CopyFile(PChar(PyObjectAsString(_lpExistingFileName)), PChar(PyObjectAsString(_lpNewFileName)), _bFailIfExists)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.MoveFile_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpExistingFileName : PPyObject;
  _lpNewFileName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:MoveFile', @_lpExistingFileName, @_lpNewFileName) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(MoveFile(PChar(PyObjectAsString(_lpExistingFileName)), PChar(PyObjectAsString(_lpNewFileName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetFileAttributes_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpFileName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:GetFileAttributes', @_lpFileName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetFileAttributes(PChar(PyObjectAsString(_lpFileName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetFileAttributes_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpFileName : PPyObject;
  _dwFileAttributes : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'Oi:SetFileAttributes', @_lpFileName, @_dwFileAttributes) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetFileAttributes(PChar(PyObjectAsString(_lpFileName)), _dwFileAttributes)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetFullPathName_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpFileName : PPyObject;
  _buf: array[0..1023] of Char;
  _filePart: PChar;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:GetFullPathName', @_lpFileName) <> 0) then
    begin
      _filePart := nil;
      Windows.GetFullPathName(PChar(PyObjectAsString(_lpFileName)), 1024, _buf, _filePart);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetLogicalDrives_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetLogicalDrives') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetLogicalDrives()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDriveType_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpRootPathName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:GetDriveType', @_lpRootPathName) <> 0) then
    begin
      Result := PyLong_FromLong(GetDriveType(PChar(PyObjectAsString(_lpRootPathName))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.OutputDebugString_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpOutputString : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:OutputDebugString', @_lpOutputString) <> 0) then
    begin
      OutputDebugString(PChar(PyObjectAsString(_lpOutputString)));
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetModuleFileName_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hModule : HMODULE;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetModuleFileName', @_hModule) <> 0) then
    begin
      Windows.GetModuleFileName(_hModule, _buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.LoadLibrary_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpLibFileName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:LoadLibrary', @_lpLibFileName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(LoadLibrary(PChar(PyObjectAsString(_lpLibFileName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.FreeLibrary_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hLibModule : HMODULE;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:FreeLibrary', @_hLibModule) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(FreeLibrary(_hLibModule)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.TerminateProcess_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hProcess : THandle;
  _uExitCode : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:TerminateProcess', @_hProcess, @_uExitCode) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(TerminateProcess(_hProcess, _uExitCode)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.OpenProcess_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _dwDesiredAccess : DWORD;
  _bInheritHandle : BOOL;
  _dwProcessId : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:OpenProcess', @_dwDesiredAccess, @_bInheritHandle, @_dwProcessId) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(OpenProcess(_dwDesiredAccess, _bInheritHandle, _dwProcessId)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.WaitForSingleObject_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hHandle : THandle;
  _dwMilliseconds : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:WaitForSingleObject', @_hHandle, @_dwMilliseconds) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(WaitForSingleObject(_hHandle, _dwMilliseconds)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateEvent_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _bManualReset : BOOL;
  _bInitialState : BOOL;
  _lpName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiO:CreateEvent', @_bManualReset, @_bInitialState, @_lpName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateEvent(nil, _bManualReset, _bInitialState, PChar(PyObjectAsString(_lpName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.OpenEvent_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _dwDesiredAccess : DWORD;
  _bInheritHandle : BOOL;
  _lpName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiO:OpenEvent', @_dwDesiredAccess, @_bInheritHandle, @_lpName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(OpenEvent(_dwDesiredAccess, _bInheritHandle, PChar(PyObjectAsString(_lpName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetEvent_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hEvent : THandle;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SetEvent', @_hEvent) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetEvent(_hEvent)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ResetEvent_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hEvent : THandle;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:ResetEvent', @_hEvent) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(ResetEvent(_hEvent)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PulseEvent_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hEvent : THandle;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:PulseEvent', @_hEvent) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PulseEvent(_hEvent)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ReleaseMutex_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hMutex : THandle;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:ReleaseMutex', @_hMutex) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(ReleaseMutex(_hMutex)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateSemaphore_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lInitialCount : Longint;
  _lMaximumCount : Longint;
  _lpName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiO:CreateSemaphore', @_lInitialCount, @_lMaximumCount, @_lpName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateSemaphore(nil, _lInitialCount, _lMaximumCount, PChar(PyObjectAsString(_lpName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.OpenSemaphore_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _dwDesiredAccess : DWORD;
  _bInheritHandle : BOOL;
  _lpName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiO:OpenSemaphore', @_dwDesiredAccess, @_bInheritHandle, @_lpName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(OpenSemaphore(_dwDesiredAccess, _bInheritHandle, PChar(PyObjectAsString(_lpName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ReleaseSemaphore_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hSemaphore : THandle;
  _lReleaseCount : Longint;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:ReleaseSemaphore', @_hSemaphore, @_lReleaseCount) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(ReleaseSemaphore(_hSemaphore, _lReleaseCount, nil)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsDebuggerPresent_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':IsDebuggerPresent') <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsDebuggerPresent()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetVersion_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetVersion') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetVersion()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.MessageBeep_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _uType : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:MessageBeep', @_uType) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(MessageBeep(_uType)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.FindWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpClassName : PPyObject;
  _lpWindowName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:FindWindow', @_lpClassName, @_lpWindowName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(FindWindow(PChar(PyObjectAsString(_lpClassName)), PChar(PyObjectAsString(_lpWindowName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.FindWindowEx_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWndParent : HWND;
  _hWndChildAfter : HWND;
  _lpszClass : PPyObject;
  _lpszWindow : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiOO:FindWindowEx', @_hWndParent, @_hWndChildAfter, @_lpszClass, @_lpszWindow) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(FindWindowEx(_hWndParent, _hWndChildAfter, PChar(PyObjectAsString(_lpszClass)), PChar(PyObjectAsString(_lpszWindow)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetWindowText_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetWindowText', @_hWnd) <> 0) then
    begin
      Windows.GetWindowText(_hWnd, _buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetWindowText_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _lpString : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iO:SetWindowText', @_hWnd, @_lpString) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetWindowText(_hWnd, PChar(PyObjectAsString(_lpString)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetWindowTextLength_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetWindowTextLength', @_hWnd) <> 0) then
    begin
      Result := PyLong_FromLong(GetWindowTextLength(_hWnd));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetClassName_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetClassName', @_hWnd) <> 0) then
    begin
      Windows.GetClassName(_hWnd, _buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:IsWindow', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsWindow(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsWindowVisible_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:IsWindowVisible', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsWindowVisible(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsWindowEnabled_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:IsWindowEnabled', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsWindowEnabled(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsIconic_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:IsIconic', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsIconic(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsZoomed_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:IsZoomed', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsZoomed(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsChild_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWndParent : HWND;
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:IsChild', @_hWndParent, @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsChild(_hWndParent, _hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.EnableWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _bEnable : BOOL;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:EnableWindow', @_hWnd, @_bEnable) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(EnableWindow(_hWnd, _bEnable)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.DestroyWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:DestroyWindow', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(DestroyWindow(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.MoveWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _X : Integer;
  _Y : Integer;
  _nWidth : Integer;
  _nHeight : Integer;
  _bRepaint : BOOL;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiiii:MoveWindow', @_hWnd, @_X, @_Y, @_nWidth, @_nHeight, @_bRepaint) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(MoveWindow(_hWnd, _X, _Y, _nWidth, _nHeight, _bRepaint)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetParent_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetParent', @_hWnd) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetParent(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDesktopWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetDesktopWindow') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetDesktopWindow()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetForegroundWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetForegroundWindow') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetForegroundWindow()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetForegroundWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SetForegroundWindow', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetForegroundWindow(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetActiveWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetActiveWindow') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetActiveWindow()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetActiveWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SetActiveWindow', @_hWnd) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(SetActiveWindow(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetWindowLong_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _nIndex : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:GetWindowLong', @_hWnd, @_nIndex) <> 0) then
    begin
      Result := PyLong_FromLong(GetWindowLong(_hWnd, _nIndex));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetWindowLong_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _nIndex : Integer;
  _dwNewLong : Longint;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:SetWindowLong', @_hWnd, @_nIndex, @_dwNewLong) <> 0) then
    begin
      Result := PyLong_FromLong(SetWindowLong(_hWnd, _nIndex, _dwNewLong));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetSystemMetrics_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _nIndex : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetSystemMetrics', @_nIndex) <> 0) then
    begin
      Result := PyLong_FromLong(GetSystemMetrics(_nIndex));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetAsyncKeyState_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _vKey : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetAsyncKeyState', @_vKey) <> 0) then
    begin
      Result := PyLong_FromLong(GetAsyncKeyState(_vKey));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetKeyState_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _nVirtKey : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetKeyState', @_nVirtKey) <> 0) then
    begin
      Result := PyLong_FromLong(GetKeyState(_nVirtKey));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.keybd_event_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _bVk : Byte;
  _bScan : Byte;
  _dwFlags : DWORD;
  _dwExtraInfo : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiii:keybd_event', @_bVk, @_bScan, @_dwFlags, @_dwExtraInfo) <> 0) then
    begin
      keybd_event(_bVk, _bScan, _dwFlags, _dwExtraInfo);
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.mouse_event_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _dwFlags : DWORD;
  _dx : DWORD;
  _dy : DWORD;
  _dwData : DWORD;
  _dwExtraInfo : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiii:mouse_event', @_dwFlags, @_dx, @_dy, @_dwData, @_dwExtraInfo) <> 0) then
    begin
      mouse_event(_dwFlags, _dx, _dy, _dwData, _dwExtraInfo);
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetCursorPos_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _X : Integer;
  _Y : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetCursorPos', @_X, @_Y) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetCursorPos(_X, _Y)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetCapture_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetCapture') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetCapture()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetCapture_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SetCapture', @_hWnd) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(SetCapture(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ShowWindowAsync_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _nCmdShow : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:ShowWindowAsync', @_hWnd, @_nCmdShow) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(ShowWindowAsync(_hWnd, _nCmdShow)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.AnimateWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _dwTime : DWORD;
  _dwFlags : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:AnimateWindow', @_hWnd, @_dwTime, @_dwFlags) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(AnimateWindow(_hWnd, _dwTime, _dwFlags)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.FlashWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _bInvert : BOOL;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:FlashWindow', @_hWnd, @_bInvert) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(FlashWindow(_hWnd, _bInvert)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.BringWindowToTop_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:BringWindowToTop', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(BringWindowToTop(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.UpdateWindow_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:UpdateWindow', @_hWnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(UpdateWindow(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegisterWindowMessage_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpString : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:RegisterWindowMessage', @_lpString) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(RegisterWindowMessage(PChar(PyObjectAsString(_lpString)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegisterClipboardFormat_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpszFormat : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:RegisterClipboardFormat', @_lpszFormat) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(RegisterClipboardFormat(PChar(PyObjectAsString(_lpszFormat)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.OpenClipboard_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWndNewOwner : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:OpenClipboard', @_hWndNewOwner) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(OpenClipboard(_hWndNewOwner)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CloseClipboard_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':CloseClipboard') <> 0) then
    begin
      Result := PyBool_FromLong(Integer(CloseClipboard()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.EmptyClipboard_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':EmptyClipboard') <> 0) then
    begin
      Result := PyBool_FromLong(Integer(EmptyClipboard()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsClipboardFormatAvailable_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _format : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:IsClipboardFormatAvailable', @_format) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsClipboardFormatAvailable(_format)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CountClipboardFormats_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':CountClipboardFormats') <> 0) then
    begin
      Result := PyLong_FromLong(CountClipboardFormats());
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetWindowDC_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetWindowDC', @_hWnd) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetWindowDC(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDlgItem_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hDlg : HWND;
  _nIDDlgItem : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:GetDlgItem', @_hDlg, @_nIDDlgItem) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetDlgItem(_hDlg, _nIDDlgItem)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDlgCtrlID_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetDlgCtrlID', @_hWnd) <> 0) then
    begin
      Result := PyLong_FromLong(GetDlgCtrlID(_hWnd));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetDlgItemText_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hDlg : HWND;
  _nIDDlgItem : Integer;
  _lpString : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiO:SetDlgItemText', @_hDlg, @_nIDDlgItem, @_lpString) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetDlgItemText(_hDlg, _nIDDlgItem, PChar(PyObjectAsString(_lpString)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetDlgItemInt_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hDlg : HWND;
  _nIDDlgItem : Integer;
  _uValue : UINT;
  _bSigned : BOOL;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiii:SetDlgItemInt', @_hDlg, @_nIDDlgItem, @_uValue, @_bSigned) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetDlgItemInt(_hDlg, _nIDDlgItem, _uValue, _bSigned)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CheckDlgButton_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hDlg : HWND;
  _nIDButton : Integer;
  _uCheck : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:CheckDlgButton', @_hDlg, @_nIDButton, @_uCheck) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(CheckDlgButton(_hDlg, _nIDButton, _uCheck)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsDlgButtonChecked_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hDlg : HWND;
  _nIDButton : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:IsDlgButtonChecked', @_hDlg, @_nIDButton) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(IsDlgButtonChecked(_hDlg, _nIDButton)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetMenu_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetMenu', @_hWnd) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetMenu(_hWnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetMenu_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _hMenu : HMENU;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetMenu', @_hWnd, @_hMenu) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetMenu(_hWnd, _hMenu)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetSystemMenu_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _bRevert : BOOL;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:GetSystemMenu', @_hWnd, @_bRevert) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetSystemMenu(_hWnd, _bRevert)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetMenuItemCount_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hMenu : HMENU;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetMenuItemCount', @_hMenu) <> 0) then
    begin
      Result := PyLong_FromLong(GetMenuItemCount(_hMenu));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetMenuItemID_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hMenu : HMENU;
  _nPos : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:GetMenuItemID', @_hMenu, @_nPos) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetMenuItemID(_hMenu, _nPos)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.EnableMenuItem_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hMenu : HMENU;
  _uIDEnableItem : UINT;
  _uEnable : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:EnableMenuItem', @_hMenu, @_uIDEnableItem, @_uEnable) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(EnableMenuItem(_hMenu, _uIDEnableItem, _uEnable)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.DeleteMenu_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hMenu : HMENU;
  _uPosition : UINT;
  _uFlags : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:DeleteMenu', @_hMenu, @_uPosition, @_uFlags) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(DeleteMenu(_hMenu, _uPosition, _uFlags)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RemoveMenu_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hMenu : HMENU;
  _uPosition : UINT;
  _uFlags : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:RemoveMenu', @_hMenu, @_uPosition, @_uFlags) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(RemoveMenu(_hMenu, _uPosition, _uFlags)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateMenu_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':CreateMenu') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateMenu()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreatePopupMenu_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':CreatePopupMenu') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreatePopupMenu()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.DestroyMenu_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hMenu : HMENU;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:DestroyMenu', @_hMenu) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(DestroyMenu(_hMenu)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetCursor_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hCursor : HCURSOR;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SetCursor', @_hCursor) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(SetCursor(_hCursor)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetCursor_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetCursor') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetCursor()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.LoadCursorFromFile_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpFileName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:LoadCursorFromFile', @_lpFileName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(LoadCursorFromFile(PChar(PyObjectAsString(_lpFileName)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetSysColor_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _nIndex : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetSysColor', @_nIndex) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetSysColor(_nIndex)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDoubleClickTime_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetDoubleClickTime') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetDoubleClickTime()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetDoubleClickTime_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _uInterval : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SetDoubleClickTime', @_uInterval) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetDoubleClickTime(_uInterval)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateCompatibleDC_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:CreateCompatibleDC', @_hdc) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateCompatibleDC(_hdc)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateCompatibleBitmap_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _cx : Integer;
  _cy : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:CreateCompatibleBitmap', @_hdc, @_cx, @_cy) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateCompatibleBitmap(_hdc, _cx, _cy)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.DeleteDC_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:DeleteDC', @_hdc) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(DeleteDC(_hdc)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.DeleteObject_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hObject : HGDIOBJ;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:DeleteObject', @_hObject) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(DeleteObject(_hObject)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SelectObject_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _hgdiobj : HGDIOBJ;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SelectObject', @_hdc, @_hgdiobj) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(SelectObject(_hdc, _hgdiobj)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetStockObject_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _fnObject : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetStockObject', @_fnObject) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetStockObject(_fnObject)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateSolidBrush_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _color : TColor;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:CreateSolidBrush', @_color) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateSolidBrush(ColorToRGB(_color))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateHatchBrush_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _fnStyle : Integer;
  _clrref : TColor;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:CreateHatchBrush', @_fnStyle, @_clrref) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateHatchBrush(_fnStyle, ColorToRGB(_clrref))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreatePen_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _fnPenStyle : Integer;
  _nWidth : Integer;
  _crColor : TColor;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:CreatePen', @_fnPenStyle, @_nWidth, @_crColor) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreatePen(_fnPenStyle, _nWidth, ColorToRGB(_crColor))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateRectRgn_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _nLeftRect : Integer;
  _nTopRect : Integer;
  _nRightRect : Integer;
  _nBottomRect : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiii:CreateRectRgn', @_nLeftRect, @_nTopRect, @_nRightRect, @_nBottomRect) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateRectRgn(_nLeftRect, _nTopRect, _nRightRect, _nBottomRect)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateEllipticRgn_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _nLeftRect : Integer;
  _nTopRect : Integer;
  _nRightRect : Integer;
  _nBottomRect : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiii:CreateEllipticRgn', @_nLeftRect, @_nTopRect, @_nRightRect, @_nBottomRect) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateEllipticRgn(_nLeftRect, _nTopRect, _nRightRect, _nBottomRect)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CreateRoundRectRgn_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _x1 : Integer;
  _y1 : Integer;
  _x2 : Integer;
  _y2 : Integer;
  _x3 : Integer;
  _y3 : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiiii:CreateRoundRectRgn', @_x1, @_y1, @_x2, @_y2, @_x3, @_y3) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(CreateRoundRectRgn(_x1, _y1, _x2, _y2, _x3, _y3)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CombineRgn_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hrgnDest : HRGN;
  _hrgnSrc1 : HRGN;
  _hrgnSrc2 : HRGN;
  _fnCombineMode : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiii:CombineRgn', @_hrgnDest, @_hrgnSrc1, @_hrgnSrc2, @_fnCombineMode) <> 0) then
    begin
      Result := PyLong_FromLong(CombineRgn(_hrgnDest, _hrgnSrc1, _hrgnSrc2, _fnCombineMode));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.EqualRgn_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hSrcRgn1 : HRGN;
  _hSrcRgn2 : HRGN;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:EqualRgn', @_hSrcRgn1, @_hSrcRgn2) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(EqualRgn(_hSrcRgn1, _hSrcRgn2)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PtInRegion_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hrgn : HRGN;
  _x : Integer;
  _y : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:PtInRegion', @_hrgn, @_x, @_y) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PtInRegion(_hrgn, _x, _y)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.LineTo_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nXEnd : Integer;
  _nYEnd : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:LineTo', @_hdc, @_nXEnd, @_nYEnd) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(LineTo(_hdc, _nXEnd, _nYEnd)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.Rectangle_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nLeftRect : Integer;
  _nTopRect : Integer;
  _nRightRect : Integer;
  _nBottomRect : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiii:Rectangle', @_hdc, @_nLeftRect, @_nTopRect, @_nRightRect, @_nBottomRect) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(Windows.Rectangle(_hdc, _nLeftRect, _nTopRect, _nRightRect, _nBottomRect)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RoundRect_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nLeftRect : Integer;
  _nTopRect : Integer;
  _nRightRect : Integer;
  _nBottomRect : Integer;
  _nWidth : Integer;
  _nHeight : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiiiii:RoundRect', @_hdc, @_nLeftRect, @_nTopRect, @_nRightRect, @_nBottomRect, @_nWidth, @_nHeight) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(Windows.RoundRect(_hdc, _nLeftRect, _nTopRect, _nRightRect, _nBottomRect, _nWidth, _nHeight)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.Ellipse_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nLeftRect : Integer;
  _nTopRect : Integer;
  _nRightRect : Integer;
  _nBottomRect : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiii:Ellipse', @_hdc, @_nLeftRect, @_nTopRect, @_nRightRect, @_nBottomRect) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(Windows.Ellipse(_hdc, _nLeftRect, _nTopRect, _nRightRect, _nBottomRect)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetPixel_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nXPos : Integer;
  _nYPos : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:GetPixel', @_hdc, @_nXPos, @_nYPos) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetPixel(_hdc, _nXPos, _nYPos)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetPixel_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _X : Integer;
  _Y : Integer;
  _crColor : TColor;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiii:SetPixel', @_hdc, @_X, @_Y, @_crColor) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(SetPixel(_hdc, _X, _Y, ColorToRGB(_crColor))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetTextColor_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetTextColor', @_hdc) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetTextColor(_hdc)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetTextColor_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _crColor : TColor;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetTextColor', @_hdc, @_crColor) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(SetTextColor(_hdc, ColorToRGB(_crColor))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetBkColor_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetBkColor', @_hdc) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetBkColor(_hdc)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetBkColor_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _crColor : TColor;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetBkColor', @_hdc, @_crColor) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(SetBkColor(_hdc, ColorToRGB(_crColor))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetBkMode_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _iBkMode : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetBkMode', @_hdc, @_iBkMode) <> 0) then
    begin
      Result := PyLong_FromLong(SetBkMode(_hdc, _iBkMode));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetBkMode_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetBkMode', @_hdc) <> 0) then
    begin
      Result := PyLong_FromLong(GetBkMode(_hdc));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.TextOut_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nXStart : Integer;
  _nYStart : Integer;
  _lpString : PPyObject;
  _s: string;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiO:TextOut', @_hdc, @_nXStart, @_nYStart, @_lpString) <> 0) then
    begin
      _s := PyObjectAsString(_lpString);
      Result := PyBool_FromLong(Integer(Windows.TextOut(_hdc, _nXStart, _nYStart, PChar(_s), Length(_s))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDeviceCaps_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nIndex : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:GetDeviceCaps', @_hdc, @_nIndex) <> 0) then
    begin
      Result := PyLong_FromLong(GetDeviceCaps(_hdc, _nIndex));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SaveDC_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SaveDC', @_hdc) <> 0) then
    begin
      Result := PyLong_FromLong(SaveDC(_hdc));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RestoreDC_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nSavedDC : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:RestoreDC', @_hdc, @_nSavedDC) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(RestoreDC(_hdc, _nSavedDC)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetMapMode_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _fnMapMode : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetMapMode', @_hdc, @_fnMapMode) <> 0) then
    begin
      Result := PyLong_FromLong(SetMapMode(_hdc, _fnMapMode));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetMapMode_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetMapMode', @_hdc) <> 0) then
    begin
      Result := PyLong_FromLong(GetMapMode(_hdc));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetROP2_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _fnDrawMode : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetROP2', @_hdc, @_fnDrawMode) <> 0) then
    begin
      Result := PyLong_FromLong(SetROP2(_hdc, _fnDrawMode));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetROP2_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetROP2', @_hdc) <> 0) then
    begin
      Result := PyLong_FromLong(GetROP2(_hdc));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetStretchBltMode_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _fnStretchMode : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetStretchBltMode', @_hdc, @_fnStretchMode) <> 0) then
    begin
      Result := PyLong_FromLong(SetStretchBltMode(_hdc, _fnStretchMode));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetStretchBltMode_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetStretchBltMode', @_hdc) <> 0) then
    begin
      Result := PyLong_FromLong(GetStretchBltMode(_hdc));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.StretchBlt_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdcDest : HDC;
  _xDest : Integer;
  _yDest : Integer;
  _wDest : Integer;
  _hDest : Integer;
  _hdcSrc : HDC;
  _xSrc : Integer;
  _ySrc : Integer;
  _wSrc : Integer;
  _hSrc : Integer;
  _rop : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiiiiiiiii:StretchBlt', @_hdcDest, @_xDest, @_yDest, @_wDest, @_hDest, @_hdcSrc, @_xSrc, @_ySrc, @_wSrc, @_hSrc, @_rop) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(StretchBlt(_hdcDest, _xDest, _yDest, _wDest, _hDest, _hdcSrc, _xSrc, _ySrc, _wSrc, _hSrc, _rop)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PatBlt_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _nXLeft : Integer;
  _nYLeft : Integer;
  _nWidth : Integer;
  _nHeight : Integer;
  _dwRop : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iiiiii:PatBlt', @_hdc, @_nXLeft, @_nYLeft, @_nWidth, @_nHeight, @_dwRop) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PatBlt(_hdc, _nXLeft, _nYLeft, _nWidth, _nHeight, _dwRop)));
    end else
      Result := nil;
  end;
end;

{ Batch 2: advapi32 (registry/service) / shlwapi / winmm / shell32 }

function TPyDelphiApplication.RegOpenKeyEx_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _lpSubKey : PPyObject;
  _samDesired : REGSAM;
  _hResult: HKEY;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iOi:RegOpenKeyEx', @_hKey, @_lpSubKey, @_samDesired) <> 0) then
    begin
      if Windows.RegOpenKeyEx(_hKey, PChar(PyObjectAsString(_lpSubKey)), 0, _samDesired, _hResult) = 0 then
        Result := PyLong_FromLong(Integer(_hResult))
      else
        Result := PyLong_FromLong(0);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegCreateKeyEx_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _lpSubKey : PPyObject;
  _samDesired : REGSAM;
  _hResult: HKEY;
  _disp: DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iOi:RegCreateKeyEx', @_hKey, @_lpSubKey, @_samDesired) <> 0) then
    begin
      if Windows.RegCreateKeyEx(_hKey, PChar(PyObjectAsString(_lpSubKey)), 0, nil, 0, _samDesired, nil, _hResult, @_disp) = 0 then
        Result := PyLong_FromLong(Integer(_hResult))
      else
        Result := PyLong_FromLong(0);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegCloseKey_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:RegCloseKey', @_hKey) <> 0) then
    begin
      Result := PyLong_FromLong(Windows.RegCloseKey(_hKey));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegDeleteKey_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _lpSubKey : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iO:RegDeleteKey', @_hKey, @_lpSubKey) <> 0) then
    begin
      Result := PyLong_FromLong(Windows.RegDeleteKey(_hKey, PChar(PyObjectAsString(_lpSubKey))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegDeleteValue_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _lpValueName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iO:RegDeleteValue', @_hKey, @_lpValueName) <> 0) then
    begin
      Result := PyLong_FromLong(Windows.RegDeleteValue(_hKey, PChar(PyObjectAsString(_lpValueName))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegFlushKey_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:RegFlushKey', @_hKey) <> 0) then
    begin
      Result := PyLong_FromLong(Windows.RegFlushKey(_hKey));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegEnumKeyEx_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _dwIndex : DWORD;
  _buf: array[0..255] of Char;
  _len: DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:RegEnumKeyEx', @_hKey, @_dwIndex) <> 0) then
    begin
      _len := 256;
      if Windows.RegEnumKeyEx(_hKey, _dwIndex, _buf, _len, nil, nil, nil, nil) = 0 then
        Result := PyUnicodeFromString(_buf)
      else
        Result := PyUnicodeFromString('');
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegEnumValue_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _dwIndex : DWORD;
  _buf: array[0..255] of Char;
  _len: DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:RegEnumValue', @_hKey, @_dwIndex) <> 0) then
    begin
      _len := 256;
      if Windows.RegEnumValue(_hKey, _dwIndex, _buf, _len, nil, nil, nil, nil) = 0 then
        Result := PyUnicodeFromString(_buf)
      else
        Result := PyUnicodeFromString('');
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegQueryStringValue_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _lpValueName : PPyObject;
  _buf: array[0..1023] of Char;
  _len: DWORD;
  _dtype: DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iO:RegQueryStringValue', @_hKey, @_lpValueName) <> 0) then
    begin
      _len := SizeOf(_buf);
      if Windows.RegQueryValueEx(_hKey, PChar(PyObjectAsString(_lpValueName)), nil, @_dtype, @_buf, @_len) = 0 then
        Result := PyUnicodeFromString(_buf)
      else
        Result := PyUnicodeFromString('');
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegSetStringValue_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _lpValueName : PPyObject;
  _lpData : PPyObject;
  _data: string;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iOO:RegSetStringValue', @_hKey, @_lpValueName, @_lpData) <> 0) then
    begin
      _data := PyObjectAsString(_lpData);
      Result := PyLong_FromLong(Windows.RegSetValueEx(_hKey, PChar(PyObjectAsString(_lpValueName)), 0, REG_SZ, PChar(_data), (Length(_data) + 1) * SizeOf(Char)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegQueryDWordValue_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _lpValueName : PPyObject;
  _data: DWORD;
  _len: DWORD;
  _dtype: DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iO:RegQueryDWordValue', @_hKey, @_lpValueName) <> 0) then
    begin
      _data := 0;
      _len := SizeOf(_data);
      Windows.RegQueryValueEx(_hKey, PChar(PyObjectAsString(_lpValueName)), nil, @_dtype, @_data, @_len);
      Result := PyLong_FromLong(Integer(_data));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegSetDWordValue_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hKey : HKEY;
  _lpValueName : PPyObject;
  _dwData : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iOi:RegSetDWordValue', @_hKey, @_lpValueName, @_dwData) <> 0) then
    begin
      Result := PyLong_FromLong(Windows.RegSetValueEx(_hKey, PChar(PyObjectAsString(_lpValueName)), 0, REG_DWORD, @_dwData, SizeOf(_dwData)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RegConnectRegistry_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpMachineName : PPyObject;
  _hKey : HKEY;
  _hResult: HKEY;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'Oi:RegConnectRegistry', @_lpMachineName, @_hKey) <> 0) then
    begin
      if Windows.RegConnectRegistry(PChar(PyObjectAsString(_lpMachineName)), _hKey, _hResult) = 0 then
        Result := PyLong_FromLong(Integer(_hResult))
      else
        Result := PyLong_FromLong(0);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetUserName_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _buf: array[0..255] of Char;
  _size: DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetUserName') <> 0) then
    begin
      _size := 256;
      if Windows.GetUserName(_buf, _size) then
        Result := PyUnicodeFromString(_buf)
      else
        Result := PyUnicodeFromString('');
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.OpenSCManager_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpMachineName : PPyObject;
  _lpDatabaseName : PPyObject;
  _dwDesiredAccess : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OOi:OpenSCManager', @_lpMachineName, @_lpDatabaseName, @_dwDesiredAccess) <> 0) then
    begin
      if (PyObjectAsString(_lpMachineName) = '') and (PyObjectAsString(_lpDatabaseName) = '') then
        Result := PyLong_FromLong(Integer(OpenSCManager(nil, nil, _dwDesiredAccess)))
      else
        Result := PyLong_FromLong(Integer(OpenSCManager(PChar(PyObjectAsString(_lpMachineName)), PChar(PyObjectAsString(_lpDatabaseName)), _dwDesiredAccess)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.OpenService_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hSCManager : SC_HANDLE;
  _lpServiceName : PPyObject;
  _dwDesiredAccess : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iOi:OpenService', @_hSCManager, @_lpServiceName, @_dwDesiredAccess) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(OpenService(_hSCManager, PChar(PyObjectAsString(_lpServiceName)), _dwDesiredAccess)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.CloseServiceHandle_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hSCObject : SC_HANDLE;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:CloseServiceHandle', @_hSCObject) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(CloseServiceHandle(_hSCObject)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.QueryServiceState_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hService : SC_HANDLE;
  _status: TServiceStatus;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:QueryServiceState', @_hService) <> 0) then
    begin
      if QueryServiceStatus(_hService, _status) then
        Result := PyLong_FromLong(Integer(_status.dwCurrentState))
      else
        Result := PyLong_FromLong(0);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.StartService_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hService : SC_HANDLE;
  _argp: PWideChar;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:StartService', @_hService) <> 0) then
    begin
      _argp := nil;
      Result := PyBool_FromLong(Integer(StartService(_hService, 0, _argp)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ControlService_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hService : SC_HANDLE;
  _dwControl : DWORD;
  _status: TServiceStatus;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:ControlService', @_hService, @_dwControl) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(ControlService(_hService, _dwControl, _status)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.DeleteService_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hService : SC_HANDLE;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:DeleteService', @_hService) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(DeleteService(_hService)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathFileExists_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathFileExists', @_Path) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PathFileExists(PChar(PyObjectAsString(_Path)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathIsDirectory_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathIsDirectory', @_Path) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(Integer(PathIsDirectory(PChar(PyObjectAsString(_Path)))) <> 0));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathIsRoot_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathIsRoot', @_Path) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PathIsRoot(PChar(PyObjectAsString(_Path)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathIsRelative_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathIsRelative', @_Path) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PathIsRelative(PChar(PyObjectAsString(_Path)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathIsUNC_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathIsUNC', @_Path) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PathIsUNC(PChar(PyObjectAsString(_Path)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathIsURL_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathIsURL', @_Path) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PathIsURL(PChar(PyObjectAsString(_Path)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathRemoveBackslash_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathRemoveBackslash', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1023);
      PathRemoveBackslash(_buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathAddBackslash_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathAddBackslash', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1020);
      PathAddBackslash(_buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathRemoveExtension_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathRemoveExtension', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1023);
      PathRemoveExtension(_buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathRemoveFileSpec_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathRemoveFileSpec', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1023);
      PathRemoveFileSpec(_buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathFindExtension_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
  _p: PChar;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathFindExtension', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1023);
      _p := PathFindExtension(_buf);
      Result := PyUnicodeFromString(_p);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathFindFileName_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
  _p: PChar;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathFindFileName', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1023);
      _p := PathFindFileName(_buf);
      Result := PyUnicodeFromString(_p);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathGetDriveNumber_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathGetDriveNumber', @_Path) <> 0) then
    begin
      Result := PyLong_FromLong(PathGetDriveNumber(PChar(PyObjectAsString(_Path))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathStripPath_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathStripPath', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1023);
      PathStripPath(_buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathIsPrefix_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Prefix : PPyObject;
  _Path : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:PathIsPrefix', @_Prefix, @_Path) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PathIsPrefix(PChar(PyObjectAsString(_Prefix)), PChar(PyObjectAsString(_Path)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathMatchSpec_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _FileName : PPyObject;
  _Spec : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:PathMatchSpec', @_FileName, @_Spec) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PathMatchSpec(PChar(PyObjectAsString(_FileName)), PChar(PyObjectAsString(_Spec)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathIsSameRoot_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path1 : PPyObject;
  _Path2 : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:PathIsSameRoot', @_Path1, @_Path2) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PathIsSameRoot(PChar(PyObjectAsString(_Path1)), PChar(PyObjectAsString(_Path2)))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathCombine_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Dir : PPyObject;
  _FileName : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:PathCombine', @_Dir, @_FileName) <> 0) then
    begin
      PathCombine(_buf, PChar(PyObjectAsString(_Dir)), PChar(PyObjectAsString(_FileName)));
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathAppend_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _More : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:PathAppend', @_Path, @_More) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 700);
      PathAppend(_buf, PChar(PyObjectAsString(_More)));
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathQuoteSpaces_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathQuoteSpaces', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1020);
      PathQuoteSpaces(_buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathUnquoteSpaces_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathUnquoteSpaces', @_Path) <> 0) then
    begin
      StrPLCopy(_buf, PyObjectAsString(_Path), 1023);
      PathUnquoteSpaces(_buf);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PathCanonicalize_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Path : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:PathCanonicalize', @_Path) <> 0) then
    begin
      PathCanonicalize(_buf, PChar(PyObjectAsString(_Path)));
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.StrToInt_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Text : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:StrToInt', @_Text) <> 0) then
    begin
      Result := PyLong_FromLong(StrToInt(PChar(PyObjectAsString(_Text))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.StrFormatByteSize_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Size : Integer;
  _buf: array[0..255] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:StrFormatByteSize', @_Size) <> 0) then
    begin
      StrFormatByteSize(_Size, _buf, 255);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.timeGetTime_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':timeGetTime') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(timeGetTime()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.timeBeginPeriod_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _uPeriod : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:timeBeginPeriod', @_uPeriod) <> 0) then
    begin
      Result := PyLong_FromLong(timeBeginPeriod(_uPeriod));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.timeEndPeriod_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _uPeriod : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:timeEndPeriod', @_uPeriod) <> 0) then
    begin
      Result := PyLong_FromLong(timeEndPeriod(_uPeriod));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.PlaySound_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _SoundName : PPyObject;
  _Flags : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'Oi:PlaySound', @_SoundName, @_Flags) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(PlaySound(PChar(PyObjectAsString(_SoundName)), 0, _Flags)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.sndPlaySound_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _SoundName : PPyObject;
  _Flags : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'Oi:sndPlaySound', @_SoundName, @_Flags) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(sndPlaySound(PChar(PyObjectAsString(_SoundName)), _Flags)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.waveOutGetNumDevs_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':waveOutGetNumDevs') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(waveOutGetNumDevs()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.waveInGetNumDevs_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':waveInGetNumDevs') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(waveInGetNumDevs()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.midiOutGetNumDevs_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':midiOutGetNumDevs') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(midiOutGetNumDevs()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.midiInGetNumDevs_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':midiInGetNumDevs') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(midiInGetNumDevs()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.auxGetNumDevs_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':auxGetNumDevs') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(auxGetNumDevs()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.joyGetNumDevs_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':joyGetNumDevs') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(joyGetNumDevs()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.mixerGetNumDevs_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':mixerGetNumDevs') <> 0) then
    begin
      Result := PyLong_FromLong(Integer(mixerGetNumDevs()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.mmioStringToFOURCC_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Text : PPyObject;
  _uFlags : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'Oi:mmioStringToFOURCC', @_Text, @_uFlags) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(mmioStringToFOURCC(PChar(PyObjectAsString(_Text)), _uFlags)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SHGetFolderPath_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Csidl : Integer;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:SHGetFolderPath', @_Csidl) <> 0) then
    begin
      if SHGetFolderPath(0, _Csidl, 0, 0, _buf) = S_OK then
        Result := PyUnicodeFromString(_buf)
      else
        Result := PyUnicodeFromString('');
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ShellAbout_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _AppName : PPyObject;
  _OtherStuff : PPyObject;
  _Icon : HICON;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iOOi:ShellAbout', @_hWnd, @_AppName, @_OtherStuff, @_Icon) <> 0) then
    begin
      Result := PyLong_FromLong(ShellAbout(_hWnd, PChar(PyObjectAsString(_AppName)), PChar(PyObjectAsString(_OtherStuff)), _Icon));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ExtractIcon_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hInst : HINST;
  _FileName : PPyObject;
  _IconIndex : UINT;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iOi:ExtractIcon', @_hInst, @_FileName, @_IconIndex) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(ExtractIcon(_hInst, PChar(PyObjectAsString(_FileName)), _IconIndex)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SHGetFileTypeDescription_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _FileName : PPyObject;
  _shfi: TSHFileInfo;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:SHGetFileTypeDescription', @_FileName) <> 0) then
    begin
      FillChar(_shfi, SizeOf(_shfi), 0);
      SHGetFileInfo(PChar(PyObjectAsString(_FileName)), 0, _shfi, SizeOf(_shfi), SHGFI_TYPENAME);
      Result := PyUnicodeFromString(_shfi.szTypeName);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.IsUserAnAdmin_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':IsUserAnAdmin') <> 0) then
    begin
      Result := PyBool_FromLong(Integer(IsUserAnAdmin()));
    end else
      Result := nil;
  end;
end;

{ Batch 3: restored + additional kernel32/shlwapi/shell32 functions }

function TPyDelphiApplication.ExitWindowsEx_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _uFlags : UINT;
  _dwReason : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:ExitWindowsEx', @_uFlags, @_dwReason) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(ExitWindowsEx(_uFlags, _dwReason)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.LockWorkStation_Wrapper(args: PPyObject): PPyObject; cdecl;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':LockWorkStation') <> 0) then
    begin
      Result := PyBool_FromLong(Integer(LockWorkStation()));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SHFileOperationDelete_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _FileName : PPyObject;
  _AllowUndo : BOOL;
  _s: string;
  _buf: array[0..1023] of Char;
  _op: TSHFileOpStruct;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'Oi:SHFileOperationDelete', @_FileName, @_AllowUndo) <> 0) then
    begin
      _s := PyObjectAsString(_FileName);
      FillChar(_buf, SizeOf(_buf), 0);
      StrPLCopy(_buf, _s, 1020);
      FillChar(_op, SizeOf(_op), 0);
      _op.Wnd := 0;
      _op.wFunc := FO_DELETE;
      _op.pFrom := _buf;
      _op.pTo := nil;
      _op.fFlags := FOF_NOCONFIRMATION or FOF_SILENT;
      if _AllowUndo then
        _op.fFlags := _op.fFlags or FOF_ALLOWUNDO;
      Result := PyLong_FromLong(SHFileOperation(_op));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SHEmptyRecycleBin_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _RootPath : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:SHEmptyRecycleBin', @_RootPath) <> 0) then
    begin
      Result := PyLong_FromLong(SHEmptyRecycleBin(0, PChar(PyObjectAsString(_RootPath)), 0));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.StrChr_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Text : PPyObject;
  _Ch : PPyObject;
  _s, _chs: string;
  _c: Word;
  _p: PChar;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:StrChr', @_Text, @_Ch) <> 0) then
    begin
      _s := PyObjectAsString(_Text);
      _chs := PyObjectAsString(_Ch);
      if Length(_chs) > 0 then _c := Word(_chs[1]) else _c := Word(#0);
      _p := StrChr(PChar(_s), _c);
      if _p = nil then
        Result := PyLong_FromLong(0)
      else
        Result := PyLong_FromLong((NativeUInt(_p) - NativeUInt(PChar(_s))) div SizeOf(Char) + 1);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.StrStr_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _Text : PPyObject;
  _Search : PPyObject;
  _s: string;
  _p: PChar;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:StrStr', @_Text, @_Search) <> 0) then
    begin
      _s := PyObjectAsString(_Text);
      _p := StrStr(PChar(_s), PChar(PyObjectAsString(_Search)));
      if _p = nil then
        Result := PyLong_FromLong(0)
      else
        Result := PyLong_FromLong((NativeUInt(_p) - NativeUInt(PChar(_s))) div SizeOf(Char) + 1);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetProcAddress_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hModule : HMODULE;
  _ProcName : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iO:GetProcAddress', @_hModule, @_ProcName) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetProcAddress(_hModule, PAnsiChar(AnsiString(PyObjectAsString(_ProcName))))));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetExitCodeProcess_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hProcess : THandle;
  _code: DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetExitCodeProcess', @_hProcess) <> 0) then
    begin
      _code := 0;
      GetExitCodeProcess(_hProcess, _code);
      Result := PyLong_FromLong(Integer(_code));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.SetPriorityClass_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hProcess : THandle;
  _dwPriorityClass : DWORD;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:SetPriorityClass', @_hProcess, @_dwPriorityClass) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(SetPriorityClass(_hProcess, _dwPriorityClass)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetPriorityClass_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hProcess : THandle;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetPriorityClass', @_hProcess) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetPriorityClass(_hProcess)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetFileSize_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hFile : THandle;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetFileSize', @_hFile) <> 0) then
    begin
      Result := PyLong_FromLong(Integer(GetFileSize(_hFile, nil)));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetLocalTime_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _st: TSystemTime;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetLocalTime') <> 0) then
    begin
      Windows.GetLocalTime(_st);
      Result := PyUnicodeFromString(Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d', [_st.wYear, _st.wMonth, _st.wDay, _st.wHour, _st.wMinute, _st.wSecond]));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetSystemTime_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _st: TSystemTime;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetSystemTime') <> 0) then
    begin
      Windows.GetSystemTime(_st);
      Result := PyUnicodeFromString(Format('%.4d-%.2d-%.2d %.2d:%.2d:%.2d', [_st.wYear, _st.wMonth, _st.wDay, _st.wHour, _st.wMinute, _st.wSecond]));
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetCursorPos_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _pt: TPoint;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetCursorPos') <> 0) then
    begin
      Windows.GetCursorPos(_pt);
      Result := WrapPoint(PyDelphiWrapper, _pt);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetWindowRect_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _r: TRect;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetWindowRect', @_hWnd) <> 0) then
    begin
      Windows.GetWindowRect(_hWnd, _r);
      Result := WrapRect(PyDelphiWrapper, _r);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetClientRect_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _r: TRect;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'i:GetClientRect', @_hWnd) <> 0) then
    begin
      Windows.GetClientRect(_hWnd, _r);
      Result := WrapRect(PyDelphiWrapper, _r);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ClientToScreen_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _APoint : PPyObject;
  _pt: TPoint;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iO:ClientToScreen', @_hWnd, @_APoint) <> 0) then
    begin
      if not CheckPointAttribute(_APoint, 'APoint', _pt) then begin Result := nil; Exit; end;
      Windows.ClientToScreen(_hWnd, _pt);
      Result := WrapPoint(PyDelphiWrapper, _pt);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ScreenToClient_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hWnd : HWND;
  _APoint : PPyObject;
  _pt: TPoint;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iO:ScreenToClient', @_hWnd, @_APoint) <> 0) then
    begin
      if not CheckPointAttribute(_APoint, 'APoint', _pt) then begin Result := nil; Exit; end;
      Windows.ScreenToClient(_hWnd, _pt);
      Result := WrapPoint(PyDelphiWrapper, _pt);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.MoveToEx_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hdc : HDC;
  _X : Integer;
  _Y : Integer;
  _pt: TPoint;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'iii:MoveToEx', @_hdc, @_X, @_Y) <> 0) then
    begin
      Windows.MoveToEx(_hdc, _X, _Y, @_pt);
      Result := WrapPoint(PyDelphiWrapper, _pt);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetShortPathName_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpszLongPath : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:GetShortPathName', @_lpszLongPath) <> 0) then
    begin
      Windows.GetShortPathName(PChar(PyObjectAsString(_lpszLongPath)), _buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetLongPathName_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _lpszShortPath : PPyObject;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'O:GetLongPathName', @_lpszShortPath) <> 0) then
    begin
      Windows.GetLongPathName(PChar(PyObjectAsString(_lpszShortPath)), _buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetLogicalDriveStrings_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _buf: array[0..1023] of Char;
  _n, _i: Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, ':GetLogicalDriveStrings') <> 0) then
    begin
      _n := Windows.GetLogicalDriveStrings(1024, _buf);
      for _i := 0 to _n - 1 do
        if _buf[_i] = #0 then _buf[_i] := '|';
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.GetDlgItemText_Wrapper(args: PPyObject): PPyObject; cdecl;
var
  _hDlg : HWND;
  _nIDDlgItem : Integer;
  _buf: array[0..1023] of Char;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'ii:GetDlgItemText', @_hDlg, @_nIDDlgItem) <> 0) then
    begin
      Windows.GetDlgItemText(_hDlg, _nIDDlgItem, _buf, 1024);
      Result := PyUnicodeFromString(_buf);
    end else
      Result := nil;
  end;
end;

(*
function CCompiler(CCode, FileName: String): BOOL;
var
  LCompiler: TDelphiC;
begin
  try
    LCompiler := TDelphiC.Create();
    LCompiler.SetOuput(opEXE);
    LCompiler.SetSubsystem(ssConsole);
    LCompiler.CompileString(CCode);
    Result := LCompiler.OutputFile(FileName);
  except
      Result := False;
  end;
  LCompiler.Free();
end;

function TPyDelphiApplication.CCompiler_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  LPyCCode, LPyFileName: PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:CCompiler', @LPyCCode, @LPyFileName) <> 0) then
    begin
      Result := PyBool_FromLong(Integer(CCompiler(PyObjectAsString(LPyCCode),
        PyObjectAsString(LPyFileName))));
    end else
      Result := nil;
  end;
end;

function CompileFPCFileToExeAndRun(FileName: String; Params: String): Integer;
var
  LlibFPC: TLibFPC;
  LExitCode: DWORD;
begin
  // Create an instance of TLibFPC
  LlibFPC := TLibFPC.Create();
  try
    // Assign the Pascal source file to compile
    LlibFPC.SetProjectSource(psFile, FileName);

    // Set the output path to the in-memory cache directory
    LlibFPC.SetOutputPathToCacheDir();

    // Turn off debug mode
    LlibFPC.SetDebugMode(False);

    // Compile the file and check for success
    if LlibFPC.Compile() then
    begin
      // Attempt to run EXE from cache with argument '7'
      if LlibFPC.RunEXE(Params, LExitCode) then
      begin
        Result := LExitCode;
      end
      else
        Result := 0; // Run failed.
    end
    else
    begin
      Result := -1; // Compile failed
    end;
  finally
    // Free the instance to release resources
    LlibFPC.Free();
  end;
end;

function TPyDelphiApplication.CompileFPCFileToExeAndRun_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  LPyFileName, LPyParams: PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:CompileFPCFileToExeAndRun', @LPyFileName, @LPyParams) <> 0) then
    begin
      Result := PyLong_FromLong(CompileFPCFileToExeAndRun(PyObjectAsString(LPyFileName),
        PyObjectAsString(LPyParams)));
    end else
      Result := nil;
  end;
end;

function CompileFPCCodeToDllAndCall(FPCCode: String; FunctionName: String): Integer;
var
  LlibFPC: TLibFPC;
  LHandle: THandle;
  Test1: procedure();
begin
  // Create an instance of TLibFPC
  LlibFPC := TLibFPC.Create();
  try
    // Assign the Pascal source string to compile
    LlibFPC.SetProjectSource(psString, FPCCode);

    // Set the output path to the in-memory cache directory
    LlibFPC.SetOutputPathToCacheDir();

    // Turn off debug mode
    LlibFPC.SetDebugMode(False);

    // Compile the file and check for success
    if LlibFPC.Compile() then
    begin
      // Attempt to load the DLL from cache
      LHandle := LlibFPC.LoadDLL();
      if LHandle <> 0 then
      begin
        // Resolve the 'Test01' exported procedure
        Test1 := GetProcAddress(LHandle, PChar(FunctionName));
        if Assigned(Test1) then
        begin
          Test1();                                   // Execute the export
          Result := 1;
        end;

        FreeLibrary(LHandle);              // Unload the DLL after use
      end
      else
        Result := 0;
    end
    else
    begin
      Result := -1;                        // Notify compile failure
    end;
  finally
    // Free the instance to release resources
    LlibFPC.Free();
  end;
end;

function TPyDelphiApplication.CompileFPCCodeToDllAndCall_Wrapper(args : PPyObject) : PPyObject; cdecl;
var
  LPyFPCCode, LPyFuncName: PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do
  begin
    if (PyArg_ParseTuple(args, 'OO:CompileFPCCodeToDllAndCall', @LPyFPCCode, @LPyFuncName) <> 0) then
    begin
      Result := PyLong_FromLong(CompileFPCCodeToDllAndCall(PyObjectAsString(LPyFPCCode),
        PyObjectAsString(LPyFuncName)));
    end else
      Result := nil;
  end;
end;*)

function TPyDelphiApplication.Minimize_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Minimize') <> 0 then begin
      DelphiObject.Minimize;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ModalFinished_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':ModalFinished') <> 0 then begin
      DelphiObject.ModalFinished;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ModalStarted_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':ModalStarted') <> 0 then begin
      DelphiObject.ModalStarted;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.NormalizeAllTopMosts_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':NormalizeAllTopMosts') <> 0 then begin
      DelphiObject.NormalizeAllTopMosts;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.NormalizeTopMosts_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':NormalizeTopMosts') <> 0 then begin
      DelphiObject.NormalizeTopMosts;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.RestoreTopMosts_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':RestoreTopMosts') <> 0 then begin
      DelphiObject.RestoreTopMosts;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.ProcessMessages_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':ProcessMessages') <> 0 then begin
      DelphiObject.ProcessMessages;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

class procedure TPyDelphiApplication.RegisterGetSets(
  PythonType: TPythonType);
begin
  with PythonType do
  begin
    AddGetSet('Active', @TPyDelphiApplication.Get_Active, nil,
      'Specifies whether the application is active and has focus.', nil);
    AddGetSet('AllowTesting', @TPyDelphiApplication.Get_AllowTesting, @TPyDelphiApplication.Set_AllowTesting,
      'Represents information for the IDE.', nil);
    AddGetSet('AutoDragDocking', @TPyDelphiApplication.Get_AutoDragDocking, @TPyDelphiApplication.Set_AutoDragDocking,
      'Indicates whether dragged windows are automatically docked.', nil);
    AddGetSet('CurrentHelpFile', @TPyDelphiApplication.Get_CurrentHelpFile, nil,
      'Indicates the current help file.', nil);
    AddGetSet('ExeName', @TPyDelphiApplication.Get_ExeName, nil,
      'Contains the file name of the application''s executable file including path information.', nil);
    AddGetSet('DialogHandle', @TPyDelphiApplication.Get_DialogHandle, @TPyDelphiApplication.Set_DialogHandle,
      'Provides a mechanism for using non-VCL dialog boxes in an application.', nil);
    AddGetSet('Handle', @TPyDelphiApplication.Get_Handle, @TPyDelphiApplication.Set_Handle,
      'Provides access to the window handle of the main form (window) of the application.', nil);
    AddGetSet('HelpFile', @TPyDelphiApplication.Get_HelpFile, @TPyDelphiApplication.Set_HelpFile,
      'Specifies the name of the default file the application uses to display Help.', nil);
    AddGetSet('Hint', @TPyDelphiApplication.Get_Hint, @TPyDelphiApplication.Set_Hint,
      'Specifies the text string that appears in the Help Hint box.', nil);
    AddGetSet('HintColor', @TPyDelphiApplication.Get_HintColor, @TPyDelphiApplication.Set_HintColor,
      'color of the hint boxes for the Help Hints for the application.', nil);
    AddGetSet('HintPause', @TPyDelphiApplication.Get_HintPause, @TPyDelphiApplication.Set_HintPause,
      'Specifies the time interval that passes before the control''s Help Hint appears when the user places the mouse pointer on a control or menu item.', nil);
    AddGetSet('HintHidePause', @TPyDelphiApplication.Get_HintHidePause, @TPyDelphiApplication.Set_HintHidePause,
      'Specifies the time interval to wait before hiding the Help Hint if the mouse has not moved from the control or menu item.', nil);
    AddGetSet('HintShortCuts', @TPyDelphiApplication.Get_HintShortCuts, @TPyDelphiApplication.Set_HintShortCuts,
      'Specifies whether the application’s pop-up hints include shortcut information.', nil);
    AddGetSet('HintShortPause', @TPyDelphiApplication.Get_HintShortPause, @TPyDelphiApplication.Set_HintShortPause,
      'Specifies the time period to wait before bringing up a hint if another hint has already been shown.', nil);
    AddGetSet('Icon', @TPyDelphiApplication.Get_Icon, @TPyDelphiApplication.Set_Icon,
      'Determines which icon represents the application on the Windows task bar.', nil);
    AddGetSet('MainForm', @TPyDelphiApplication.Get_MainForm, nil,
      'Identifies which form in the application is the main window.', nil);
    AddGetSet('BiDiMode', @TPyDelphiApplication.Get_BiDiMode, @TPyDelphiApplication.Set_BiDiMode,
      'Indicates the layout of the application when running under Middle Eastern versions of Windows.', nil);
    AddGetSet('BiDiKeyboard', @TPyDelphiApplication.Get_BiDiKeyboard, @TPyDelphiApplication.Set_BiDiKeyboard,
      'Specifies the name of the keyboard map that should be used in middle-east locales when text reads from right to left.', nil);
    AddGetSet('NonBiDiKeyboard', @TPyDelphiApplication.Get_NonBiDiKeyboard, @TPyDelphiApplication.Set_NonBiDiKeyboard,
      'Specifies the name of the keyboard map that should be used unless text reads from right to left.', nil);
    AddGetSet('ShowHint', @TPyDelphiApplication.Get_ShowHint, @TPyDelphiApplication.Set_ShowHint,
      'Determines whether Help Hints are enabled or disabled for the entire application.', nil);
    AddGetSet('ShowMainForm', @TPyDelphiApplication.Get_ShowMainForm, @TPyDelphiApplication.Set_ShowMainForm,
      'Determines whether the application shows its main form on startup.', nil);
    AddGetSet('Terminated', @TPyDelphiApplication.Get_Terminated, nil,
      'Reports whether the application is in the process of shutting down.', nil);
    AddGetSet('Title', @TPyDelphiApplication.Get_Title, @TPyDelphiApplication.Set_Title,
      'Contains the text that appears below the icon representing the application when it is minimized.', nil);
    AddGetSet('UpdateFormatSettings', @TPyDelphiApplication.Get_UpdateFormatSettings, @TPyDelphiApplication.Set_UpdateFormatSettings,
      'Specifies whether format settings are updated automatically when the user alters the system configuration.', nil);
    AddGetSet('UpdateMetricSettings', @TPyDelphiApplication.Get_UpdateMetricSettings, @TPyDelphiApplication.Set_UpdateMetricSettings,
      'Specifies whether the settings used for the hint window font and the icon title font are updated.', nil);
  end;
end;

class procedure TPyDelphiApplication.RegisterMethods(
  PythonType: TPythonType);
begin
  PythonType.AddMethod('ActivateHint', @TPyDelphiApplication.ActivateHint_Wrapper,
    'TApplication.ActivateHint()'#10 +
    'Displays a hint window for the control at a specified position.');
  PythonType.AddMethod('BringToFront', @TPyDelphiApplication.BringToFront_Wrapper,
    'TApplication.BringToFront()'#10 +
    'Sets the last active window as the topmost window on the desktop above all other applications.');
  PythonType.AddMethod('CancelHint', @TPyDelphiApplication.CancelHint_Wrapper,
    'TApplication.CancelHint()'#10 +
    'Cancels the display of a hint for a control.');
  PythonType.AddMethod('ExecuteAction', @TPyDelphiApplication.ExecuteAction_Wrapper,
    'TApplication.ExecuteAction()'#10 +
    'Generates an OnActionExecute event.');
  PythonType.AddMethod('HandleException', @TPyDelphiApplication.HandleException_Wrapper,
    'TApplication.HandleException()'#10 +
    'Provides default handling of exceptions for the application.');
  PythonType.AddMethod('HandleMessage', @TPyDelphiApplication.HandleMessage_Wrapper,
    'TApplication.HandleMessage()'#10 +
    'Interrupts the execution of an application while Windows processes a message in the Windows message queue. ');
  PythonType.AddMethod('HelpCommand', @TPyDelphiApplication.HelpCommand_Wrapper,
    'TApplication.HelpCommand()'#10 +
    'Provides quick access to any of the Help commands in the WinHelp API (application programming interface).');
  PythonType.AddMethod('HelpContext', @TPyDelphiApplication.HelpContext_Wrapper,
    'TApplication.HelpContext()'#10 +
    'Displays a specified help topic.');
  PythonType.AddMethod('HelpJump', @TPyDelphiApplication.HelpJump_Wrapper,
    'TApplication.HelpJump()'#10 +
    'Displays a specified help topic.');
  PythonType.AddMethod('HelpKeyword', @TPyDelphiApplication.HelpKeyword_Wrapper,
    'TApplication.HelpKeyword()'#10 +
    'Displays a specified help topic.');
  PythonType.AddMethod('HideHint', @TPyDelphiApplication.HideHint_Wrapper,
    'TApplication.HideHint()'#10 +
    'Hides the current hint.');
  PythonType.AddMethod('Initialize', @TPyDelphiApplication.Initialize_Wrapper,
    'TApplication.Initialize()'#10 +
    'Provides an opportunity to initialize subsystems.');
  PythonType.AddMethod('IsRightToLeft', @TPyDelphiApplication.IsRightToLeft_Wrapper,
    'TApplication.IsRightToLeft()'#10 +
    'Specifies whether the application adjusts its interface for Middle Eastern locales.');
  PythonType.AddMethod('MessageBox', @TPyDelphiApplication.MessageBox_Wrapper,
    'TApplication.MessageBox()'#10 +
    'Displays a specified message to the user.');
  PythonType.AddMethod('MessageDlg', @TPyDelphiApplication.MessageDlg_Wrapper,
    'TApplication.MessageDlg()'#10 +
    'Displays a specified message to the user.');
  PythonType.AddMethod('InputBox', @TPyDelphiApplication.InputBox_Wrapper,
    'InputBox_Wrapper()'#10 +
    'Used to create a simple dialog box for users to input text.');
  PythonType.AddMethod('SelectDirectory', @TPyDelphiApplication.SelectDirectory_Wrapper,
    'SelectDirectory_Wrapper()'#10 +
    'Used to display a dialog box that allows users to select a folder and return the path of the selected folder.');
  PythonType.AddMethod('PrintText', @TPyDelphiApplication.PrintText_Wrapper,
    'PrintText_Wrapper()'#10 +
    'Used to send a piece of text to the printer for printing.');
  PythonType.AddMethod('PrintImage', @TPyDelphiApplication.PrintImage_Wrapper,
    'PrintImage_Wrapper()'#10 +
    'Used to send a bitmap to a printer for printing.');
  PythonType.AddMethod('ColorToString', @TPyDelphiApplication.ColorToString_Wrapper,
    'ColorToString_Wrapper()'#10 +
    'Converts a color value of type TColor to a string representation.');
  PythonType.AddMethod('WinExec', @TPyDelphiApplication.WinExec_Wrapper,
    'WinExec_Wrapper()'#10 +
    'Used to run a Windows program asynchronously.');
  PythonType.AddMethod('ShowWindow', @TPyDelphiApplication.ShowWindow_Wrapper,
    'ShowWindow_Wrapper()'#10 +
    'Set the display status of the specified window.');
  PythonType.AddMethod('ShellExecute', @TPyDelphiApplication.ShellExecute_Wrapper,
    'ShellExecute_Wrapper()'#10 +
    'Run an external program (or open a registered file, open a directory, print a file, etc.) and have some control over the external program.');
  PythonType.AddMethod('SendMessage', @TPyDelphiApplication.SendMessage_Wrapper,
    'SendMessage_Wrapper()'#10 +
    'Send a message directly to a window procedure and wait for the message to be processed (synchronous operation).');
  PythonType.AddMethod('PostMessage', @TPyDelphiApplication.PostMessage_Wrapper,
    'PostMessage_Wrapper()'#10 +
    'Asynchronously post a message to a windows message queue and return immediately without waiting for the message to be processed.'#10 +
    'This is different from SendMessage, which blocks until the message is processed.');
  PythonType.AddMethod('GetSystemPath', @TPyDelphiApplication.GetSystemPath_Wrapper,
    'GetSystemPath_Wrapper()'#10 +
    'Obtain various system paths.');
  PythonType.AddMethod('ReleaseCapture', @TPyDelphiApplication.ReleaseCapture_Wrapper,
    'ReleaseCapture_Wrapper()'#10 +
    'Release the mouse capture of the window in the current thread.');
  PythonType.AddMethod('SetParent', @TPyDelphiApplication.SetParent_Wrapper,
    'SetParent_Wrapper()'#10 +
    'Used to change the parent window of a window.');
  PythonType.AddMethod('SetWindowPos', @TPyDelphiApplication.SetWindowPos_Wrapper,
    'SetWindowPos_Wrapper()'#10 +
    'Used to set the position, size, and Z-order (display order) of a window.');
  PythonType.AddMethod('ShowCursor', @TPyDelphiApplication.ShowCursor_Wrapper,
    'ShowCursor_Wrapper()'#10 +
    'Used to control the display and hiding of the mouse cursor.');
  PythonType.AddMethod('PtInRect', @TPyDelphiApplication.PtInRect_Wrapper,
    'PtInRect_Wrapper()'#10 +
    'Used to determine whether a point is within a specified rectangular area.');
  PythonType.AddMethod('GetDC', @TPyDelphiApplication.GetDC_Wrapper,
    'GetDC_Wrapper()'#10 +
    'Retrieves a handle to a device context for the client area of the specified window.');
  PythonType.AddMethod('ReleaseDC', @TPyDelphiApplication.ReleaseDC_Wrapper,
    'ReleaseDC_Wrapper()'#10 +
    'The ReleaseDC function releases a device context, freeing it for use by other applications.');
  PythonType.AddMethod('BitBlt', @TPyDelphiApplication.BitBlt_Wrapper,
    'BitBlt_Wrapper()'#10 +
    'The BitBlt function performs a bit-block transfer of the color data.');
  PythonType.AddMethod('CreateMutex', @TPyDelphiApplication.CreateMutex_Wrapper,
    'CreateMutex_Wrapper()'#10 +
    'It is used to create a named mutex object, thereby achieving single-instance control of an application.');
  PythonType.AddMethod('OpenMutex', @TPyDelphiApplication.OpenMutex_Wrapper,
    'OpenMutex_Wrapper()'#10 +
    'It is used to open an existing named mutex object, thereby obtaining its handle for subsequent wait or release operations.');
  PythonType.AddMethod('CloseHandle', @TPyDelphiApplication.CloseHandle_Wrapper,
    'CloseHandle_Wrapper()'#10 +
    'It is used to close an open object handle (such as a mutex, file, etc.), releasing the system resources allocated for that handle.');
  PythonType.AddMethod('GetLastError', @TPyDelphiApplication.GetLastError_Wrapper,
    'GetLastError_Wrapper()'#10 +
    'It is used to retrieve the error code returned by the previous Windows API function call in the current thread.');
  PythonType.AddMethod('RGB', @TPyDelphiApplication.RGB_Wrapper,
    'RGB_Wrapper()'#10 +
    'Returns an integer value (COLORREF) representing a color by combining the red, green, and blue color components (0-255).');
  // ---- Additional Win32 API functions (kernel32/user32/gdi32) ----
  PythonType.AddMethod('Beep', @TPyDelphiApplication.Beep_Wrapper,
    'Beep_Wrapper()'#10 +
    'Generates simple tones on the speaker.');
  PythonType.AddMethod('Sleep', @TPyDelphiApplication.Sleep_Wrapper,
    'Sleep_Wrapper()'#10 +
    'Suspends the execution of the current thread for the specified interval.');
  PythonType.AddMethod('GetTickCount', @TPyDelphiApplication.GetTickCount_Wrapper,
    'GetTickCount_Wrapper()'#10 +
    'Retrieves the number of milliseconds that have elapsed since the system was started.');
  PythonType.AddMethod('GetCurrentProcessId', @TPyDelphiApplication.GetCurrentProcessId_Wrapper,
    'GetCurrentProcessId_Wrapper()'#10 +
    'Retrieves the process identifier of the calling process.');
  PythonType.AddMethod('GetCurrentThreadId', @TPyDelphiApplication.GetCurrentThreadId_Wrapper,
    'GetCurrentThreadId_Wrapper()'#10 +
    'Retrieves the thread identifier of the calling thread.');
  PythonType.AddMethod('GetCurrentProcess', @TPyDelphiApplication.GetCurrentProcess_Wrapper,
    'GetCurrentProcess_Wrapper()'#10 +
    'Retrieves a pseudo handle for the current process.');
  PythonType.AddMethod('GetCurrentThread', @TPyDelphiApplication.GetCurrentThread_Wrapper,
    'GetCurrentThread_Wrapper()'#10 +
    'Retrieves a pseudo handle for the current thread.');
  PythonType.AddMethod('SetLastError', @TPyDelphiApplication.SetLastError_Wrapper,
    'SetLastError_Wrapper()'#10 +
    'Sets the last-error code for the calling thread.');
  PythonType.AddMethod('MulDiv', @TPyDelphiApplication.MulDiv_Wrapper,
    'MulDiv_Wrapper()'#10 +
    'Multiplies two 32-bit values and then divides the result by a third 32-bit value.');
  PythonType.AddMethod('GetComputerName', @TPyDelphiApplication.GetComputerName_Wrapper,
    'GetComputerName_Wrapper()'#10 +
    'Retrieves the NetBIOS name of the local computer.');
  PythonType.AddMethod('SetEnvironmentVariable', @TPyDelphiApplication.SetEnvironmentVariable_Wrapper,
    'SetEnvironmentVariable_Wrapper()'#10 +
    'Sets the value of an environment variable for the current process.');
  PythonType.AddMethod('GetEnvironmentVariable', @TPyDelphiApplication.GetEnvironmentVariable_Wrapper,
    'GetEnvironmentVariable_Wrapper()'#10 +
    'Retrieves the value of an environment variable for the current process.');
  PythonType.AddMethod('GetSystemDirectory', @TPyDelphiApplication.GetSystemDirectory_Wrapper,
    'GetSystemDirectory_Wrapper()'#10 +
    'Retrieves the path of the Windows system directory.');
  PythonType.AddMethod('GetWindowsDirectory', @TPyDelphiApplication.GetWindowsDirectory_Wrapper,
    'GetWindowsDirectory_Wrapper()'#10 +
    'Retrieves the path of the Windows directory.');
  PythonType.AddMethod('GetTempPath', @TPyDelphiApplication.GetTempPath_Wrapper,
    'GetTempPath_Wrapper()'#10 +
    'Retrieves the path of the directory designated for temporary files.');
  PythonType.AddMethod('GetCurrentDirectory', @TPyDelphiApplication.GetCurrentDirectory_Wrapper,
    'GetCurrentDirectory_Wrapper()'#10 +
    'Retrieves the current directory for the current process.');
  PythonType.AddMethod('SetCurrentDirectory', @TPyDelphiApplication.SetCurrentDirectory_Wrapper,
    'SetCurrentDirectory_Wrapper()'#10 +
    'Changes the current directory for the current process.');
  PythonType.AddMethod('CreateDirectory', @TPyDelphiApplication.CreateDirectory_Wrapper,
    'CreateDirectory_Wrapper()'#10 +
    'Creates a new directory.');
  PythonType.AddMethod('RemoveDirectory', @TPyDelphiApplication.RemoveDirectory_Wrapper,
    'RemoveDirectory_Wrapper()'#10 +
    'Deletes an existing empty directory.');
  PythonType.AddMethod('DeleteFile', @TPyDelphiApplication.DeleteFile_Wrapper,
    'DeleteFile_Wrapper()'#10 +
    'Deletes an existing file.');
  PythonType.AddMethod('CopyFile', @TPyDelphiApplication.CopyFile_Wrapper,
    'CopyFile_Wrapper()'#10 +
    'Copies an existing file to a new file.');
  PythonType.AddMethod('MoveFile', @TPyDelphiApplication.MoveFile_Wrapper,
    'MoveFile_Wrapper()'#10 +
    'Moves (or renames) an existing file or a directory.');
  PythonType.AddMethod('GetFileAttributes', @TPyDelphiApplication.GetFileAttributes_Wrapper,
    'GetFileAttributes_Wrapper()'#10 +
    'Retrieves file system attributes for a specified file or directory.');
  PythonType.AddMethod('SetFileAttributes', @TPyDelphiApplication.SetFileAttributes_Wrapper,
    'SetFileAttributes_Wrapper()'#10 +
    'Sets the attributes for a file or directory.');
  PythonType.AddMethod('GetFullPathName', @TPyDelphiApplication.GetFullPathName_Wrapper,
    'GetFullPathName_Wrapper()'#10 +
    'Retrieves the full path and file name of a specified file.');
  PythonType.AddMethod('GetLogicalDrives', @TPyDelphiApplication.GetLogicalDrives_Wrapper,
    'GetLogicalDrives_Wrapper()'#10 +
    'Retrieves a bitmask representing the currently available disk drives.');
  PythonType.AddMethod('GetDriveType', @TPyDelphiApplication.GetDriveType_Wrapper,
    'GetDriveType_Wrapper()'#10 +
    'Determines whether a disk drive is removable, fixed, CD-ROM, RAM disk, or network drive.');
  PythonType.AddMethod('OutputDebugString', @TPyDelphiApplication.OutputDebugString_Wrapper,
    'OutputDebugString_Wrapper()'#10 +
    'Sends a string to the debugger for display.');
  PythonType.AddMethod('GetModuleFileName', @TPyDelphiApplication.GetModuleFileName_Wrapper,
    'GetModuleFileName_Wrapper()'#10 +
    'Retrieves the full path of the executable file of a specified module (pass 0 for the current process).');
  PythonType.AddMethod('LoadLibrary', @TPyDelphiApplication.LoadLibrary_Wrapper,
    'LoadLibrary_Wrapper()'#10 +
    'Loads the specified module into the address space of the calling process.');
  PythonType.AddMethod('FreeLibrary', @TPyDelphiApplication.FreeLibrary_Wrapper,
    'FreeLibrary_Wrapper()'#10 +
    'Frees a previously loaded dynamic-link library.');
  PythonType.AddMethod('TerminateProcess', @TPyDelphiApplication.TerminateProcess_Wrapper,
    'TerminateProcess_Wrapper()'#10 +
    'Terminates the specified process and all of its threads.');
  PythonType.AddMethod('OpenProcess', @TPyDelphiApplication.OpenProcess_Wrapper,
    'OpenProcess_Wrapper()'#10 +
    'Opens an existing local process object.');
  PythonType.AddMethod('WaitForSingleObject', @TPyDelphiApplication.WaitForSingleObject_Wrapper,
    'WaitForSingleObject_Wrapper()'#10 +
    'Waits until the specified object is in the signaled state or the time-out interval elapses.');
  PythonType.AddMethod('CreateEvent', @TPyDelphiApplication.CreateEvent_Wrapper,
    'CreateEvent_Wrapper()'#10 +
    'Creates or opens a named or unnamed event object.');
  PythonType.AddMethod('OpenEvent', @TPyDelphiApplication.OpenEvent_Wrapper,
    'OpenEvent_Wrapper()'#10 +
    'Opens an existing named event object.');
  PythonType.AddMethod('SetEvent', @TPyDelphiApplication.SetEvent_Wrapper,
    'SetEvent_Wrapper()'#10 +
    'Sets the specified event object to the signaled state.');
  PythonType.AddMethod('ResetEvent', @TPyDelphiApplication.ResetEvent_Wrapper,
    'ResetEvent_Wrapper()'#10 +
    'Sets the specified event object to the nonsignaled state.');
  PythonType.AddMethod('PulseEvent', @TPyDelphiApplication.PulseEvent_Wrapper,
    'PulseEvent_Wrapper()'#10 +
    'Sets the specified event object to the signaled state and then resets it after releasing waiting threads.');
  PythonType.AddMethod('ReleaseMutex', @TPyDelphiApplication.ReleaseMutex_Wrapper,
    'ReleaseMutex_Wrapper()'#10 +
    'Releases ownership of the specified mutex object.');
  PythonType.AddMethod('CreateSemaphore', @TPyDelphiApplication.CreateSemaphore_Wrapper,
    'CreateSemaphore_Wrapper()'#10 +
    'Creates or opens a named or unnamed semaphore object.');
  PythonType.AddMethod('OpenSemaphore', @TPyDelphiApplication.OpenSemaphore_Wrapper,
    'OpenSemaphore_Wrapper()'#10 +
    'Opens an existing named semaphore object.');
  PythonType.AddMethod('ReleaseSemaphore', @TPyDelphiApplication.ReleaseSemaphore_Wrapper,
    'ReleaseSemaphore_Wrapper()'#10 +
    'Increases the count of the specified semaphore object by a specified amount.');
  PythonType.AddMethod('IsDebuggerPresent', @TPyDelphiApplication.IsDebuggerPresent_Wrapper,
    'IsDebuggerPresent_Wrapper()'#10 +
    'Determines whether the calling process is being debugged by a user-mode debugger.');
  PythonType.AddMethod('GetVersion', @TPyDelphiApplication.GetVersion_Wrapper,
    'GetVersion_Wrapper()'#10 +
    'Retrieves information about the current version of the operating system.');
  PythonType.AddMethod('MessageBeep', @TPyDelphiApplication.MessageBeep_Wrapper,
    'MessageBeep_Wrapper()'#10 +
    'Plays a waveform sound associated with a system event.');
  PythonType.AddMethod('FindWindow', @TPyDelphiApplication.FindWindow_Wrapper,
    'FindWindow_Wrapper()'#10 +
    'Retrieves a handle to the top-level window whose class name and window name match the specified strings.');
  PythonType.AddMethod('FindWindowEx', @TPyDelphiApplication.FindWindowEx_Wrapper,
    'FindWindowEx_Wrapper()'#10 +
    'Retrieves a handle to a window whose class name and window name match the specified strings, with support for a starting child window.');
  PythonType.AddMethod('GetWindowText', @TPyDelphiApplication.GetWindowText_Wrapper,
    'GetWindowText_Wrapper()'#10 +
    'Retrieves the text of the specified window''s title bar (for controls, the control text).');
  PythonType.AddMethod('SetWindowText', @TPyDelphiApplication.SetWindowText_Wrapper,
    'SetWindowText_Wrapper()'#10 +
    'Sets the text of the specified window''s title bar (for controls, the control text).');
  PythonType.AddMethod('GetWindowTextLength', @TPyDelphiApplication.GetWindowTextLength_Wrapper,
    'GetWindowTextLength_Wrapper()'#10 +
    'Retrieves the length, in characters, of the specified window''s title bar text.');
  PythonType.AddMethod('GetClassName', @TPyDelphiApplication.GetClassName_Wrapper,
    'GetClassName_Wrapper()'#10 +
    'Retrieves the name of the class to which the specified window belongs.');
  PythonType.AddMethod('IsWindow', @TPyDelphiApplication.IsWindow_Wrapper,
    'IsWindow_Wrapper()'#10 +
    'Determines whether the specified window handle identifies an existing window.');
  PythonType.AddMethod('IsWindowVisible', @TPyDelphiApplication.IsWindowVisible_Wrapper,
    'IsWindowVisible_Wrapper()'#10 +
    'Determines the visibility state of the specified window.');
  PythonType.AddMethod('IsWindowEnabled', @TPyDelphiApplication.IsWindowEnabled_Wrapper,
    'IsWindowEnabled_Wrapper()'#10 +
    'Determines whether the specified window is enabled for mouse and keyboard input.');
  PythonType.AddMethod('IsIconic', @TPyDelphiApplication.IsIconic_Wrapper,
    'IsIconic_Wrapper()'#10 +
    'Determines whether the specified window is minimized.');
  PythonType.AddMethod('IsZoomed', @TPyDelphiApplication.IsZoomed_Wrapper,
    'IsZoomed_Wrapper()'#10 +
    'Determines whether the specified window is maximized.');
  PythonType.AddMethod('IsChild', @TPyDelphiApplication.IsChild_Wrapper,
    'IsChild_Wrapper()'#10 +
    'Determines whether a window is a child (or descendant) window of a specified parent window.');
  PythonType.AddMethod('EnableWindow', @TPyDelphiApplication.EnableWindow_Wrapper,
    'EnableWindow_Wrapper()'#10 +
    'Enables or disables mouse and keyboard input to the specified window.');
  PythonType.AddMethod('DestroyWindow', @TPyDelphiApplication.DestroyWindow_Wrapper,
    'DestroyWindow_Wrapper()'#10 +
    'Destroys the specified window.');
  PythonType.AddMethod('MoveWindow', @TPyDelphiApplication.MoveWindow_Wrapper,
    'MoveWindow_Wrapper()'#10 +
    'Changes the position and dimensions of the specified window.');
  PythonType.AddMethod('GetParent', @TPyDelphiApplication.GetParent_Wrapper,
    'GetParent_Wrapper()'#10 +
    'Retrieves a handle to the specified window''s parent or owner.');
  PythonType.AddMethod('GetDesktopWindow', @TPyDelphiApplication.GetDesktopWindow_Wrapper,
    'GetDesktopWindow_Wrapper()'#10 +
    'Retrieves a handle to the desktop window.');
  PythonType.AddMethod('GetForegroundWindow', @TPyDelphiApplication.GetForegroundWindow_Wrapper,
    'GetForegroundWindow_Wrapper()'#10 +
    'Retrieves a handle to the foreground window.');
  PythonType.AddMethod('SetForegroundWindow', @TPyDelphiApplication.SetForegroundWindow_Wrapper,
    'SetForegroundWindow_Wrapper()'#10 +
    'Brings the specified window to the foreground.');
  PythonType.AddMethod('GetActiveWindow', @TPyDelphiApplication.GetActiveWindow_Wrapper,
    'GetActiveWindow_Wrapper()'#10 +
    'Retrieves the handle to the active window attached to the calling thread.');
  PythonType.AddMethod('SetActiveWindow', @TPyDelphiApplication.SetActiveWindow_Wrapper,
    'SetActiveWindow_Wrapper()'#10 +
    'Activates a window.');
  PythonType.AddMethod('GetWindowLong', @TPyDelphiApplication.GetWindowLong_Wrapper,
    'GetWindowLong_Wrapper()'#10 +
    'Retrieves information about the specified window.');
  PythonType.AddMethod('SetWindowLong', @TPyDelphiApplication.SetWindowLong_Wrapper,
    'SetWindowLong_Wrapper()'#10 +
    'Changes an attribute of the specified window.');
  PythonType.AddMethod('GetSystemMetrics', @TPyDelphiApplication.GetSystemMetrics_Wrapper,
    'GetSystemMetrics_Wrapper()'#10 +
    'Retrieves the specified system metric or system configuration setting.');
  PythonType.AddMethod('GetAsyncKeyState', @TPyDelphiApplication.GetAsyncKeyState_Wrapper,
    'GetAsyncKeyState_Wrapper()'#10 +
    'Determines whether a key is up or down at the time the function is called, and whether it was pressed after a previous call.');
  PythonType.AddMethod('GetKeyState', @TPyDelphiApplication.GetKeyState_Wrapper,
    'GetKeyState_Wrapper()'#10 +
    'Retrieves the status of the specified virtual key.');
  PythonType.AddMethod('keybd_event', @TPyDelphiApplication.keybd_event_Wrapper,
    'keybd_event_Wrapper()'#10 +
    'Synthesizes a keystroke.');
  PythonType.AddMethod('mouse_event', @TPyDelphiApplication.mouse_event_Wrapper,
    'mouse_event_Wrapper()'#10 +
    'Synthesizes mouse motion and button clicks.');
  PythonType.AddMethod('SetCursorPos', @TPyDelphiApplication.SetCursorPos_Wrapper,
    'SetCursorPos_Wrapper()'#10 +
    'Moves the cursor to the specified screen coordinates.');
  PythonType.AddMethod('GetCapture', @TPyDelphiApplication.GetCapture_Wrapper,
    'GetCapture_Wrapper()'#10 +
    'Retrieves a handle to the window that has captured the mouse.');
  PythonType.AddMethod('SetCapture', @TPyDelphiApplication.SetCapture_Wrapper,
    'SetCapture_Wrapper()'#10 +
    'Sets the mouse capture to the specified window.');
  PythonType.AddMethod('ShowWindowAsync', @TPyDelphiApplication.ShowWindowAsync_Wrapper,
    'ShowWindowAsync_Wrapper()'#10 +
    'Sets the show state of a window created by a different thread.');
  PythonType.AddMethod('AnimateWindow', @TPyDelphiApplication.AnimateWindow_Wrapper,
    'AnimateWindow_Wrapper()'#10 +
    'Enables you to produce special effects when showing or hiding windows.');
  PythonType.AddMethod('FlashWindow', @TPyDelphiApplication.FlashWindow_Wrapper,
    'FlashWindow_Wrapper()'#10 +
    'Flashes the specified window one time.');
  PythonType.AddMethod('BringWindowToTop', @TPyDelphiApplication.BringWindowToTop_Wrapper,
    'BringWindowToTop_Wrapper()'#10 +
    'Brings the specified window to the top of the Z order.');
  PythonType.AddMethod('UpdateWindow', @TPyDelphiApplication.UpdateWindow_Wrapper,
    'UpdateWindow_Wrapper()'#10 +
    'Updates the client area of the specified window.');
  PythonType.AddMethod('RegisterWindowMessage', @TPyDelphiApplication.RegisterWindowMessage_Wrapper,
    'RegisterWindowMessage_Wrapper()'#10 +
    'Defines a new window message that is guaranteed to be unique throughout the system.');
  PythonType.AddMethod('RegisterClipboardFormat', @TPyDelphiApplication.RegisterClipboardFormat_Wrapper,
    'RegisterClipboardFormat_Wrapper()'#10 +
    'Registers a new clipboard format.');
  PythonType.AddMethod('OpenClipboard', @TPyDelphiApplication.OpenClipboard_Wrapper,
    'OpenClipboard_Wrapper()'#10 +
    'Opens the clipboard for examination.');
  PythonType.AddMethod('CloseClipboard', @TPyDelphiApplication.CloseClipboard_Wrapper,
    'CloseClipboard_Wrapper()'#10 +
    'Closes the clipboard.');
  PythonType.AddMethod('EmptyClipboard', @TPyDelphiApplication.EmptyClipboard_Wrapper,
    'EmptyClipboard_Wrapper()'#10 +
    'Empties the clipboard and frees handles to data in the clipboard.');
  PythonType.AddMethod('IsClipboardFormatAvailable', @TPyDelphiApplication.IsClipboardFormatAvailable_Wrapper,
    'IsClipboardFormatAvailable_Wrapper()'#10 +
    'Determines whether the clipboard contains data in the specified format.');
  PythonType.AddMethod('CountClipboardFormats', @TPyDelphiApplication.CountClipboardFormats_Wrapper,
    'CountClipboardFormats_Wrapper()'#10 +
    'Retrieves the number of different data formats currently on the clipboard.');
  PythonType.AddMethod('GetWindowDC', @TPyDelphiApplication.GetWindowDC_Wrapper,
    'GetWindowDC_Wrapper()'#10 +
    'Retrieves the device context (DC) for the entire window, including title bar, menus, and scroll bars.');
  PythonType.AddMethod('GetDlgItem', @TPyDelphiApplication.GetDlgItem_Wrapper,
    'GetDlgItem_Wrapper()'#10 +
    'Retrieves a handle to a control in the specified dialog box.');
  PythonType.AddMethod('GetDlgCtrlID', @TPyDelphiApplication.GetDlgCtrlID_Wrapper,
    'GetDlgCtrlID_Wrapper()'#10 +
    'Retrieves the identifier of the specified control.');
  PythonType.AddMethod('SetDlgItemText', @TPyDelphiApplication.SetDlgItemText_Wrapper,
    'SetDlgItemText_Wrapper()'#10 +
    'Sets the text of a control in a dialog box.');
  PythonType.AddMethod('SetDlgItemInt', @TPyDelphiApplication.SetDlgItemInt_Wrapper,
    'SetDlgItemInt_Wrapper()'#10 +
    'Sets the text of a control in a dialog box to the string representation of a specified integer value.');
  PythonType.AddMethod('CheckDlgButton', @TPyDelphiApplication.CheckDlgButton_Wrapper,
    'CheckDlgButton_Wrapper()'#10 +
    'Changes the check state of a button control.');
  PythonType.AddMethod('IsDlgButtonChecked', @TPyDelphiApplication.IsDlgButtonChecked_Wrapper,
    'IsDlgButtonChecked_Wrapper()'#10 +
    'Determines the check state of a button control.');
  PythonType.AddMethod('GetMenu', @TPyDelphiApplication.GetMenu_Wrapper,
    'GetMenu_Wrapper()'#10 +
    'Retrieves a handle to the menu assigned to the specified window.');
  PythonType.AddMethod('SetMenu', @TPyDelphiApplication.SetMenu_Wrapper,
    'SetMenu_Wrapper()'#10 +
    'Assigns a new menu to the specified window.');
  PythonType.AddMethod('GetSystemMenu', @TPyDelphiApplication.GetSystemMenu_Wrapper,
    'GetSystemMenu_Wrapper()'#10 +
    'Enables the application to access the window menu (also known as the System menu or Control menu) for copying and modifying.');
  PythonType.AddMethod('GetMenuItemCount', @TPyDelphiApplication.GetMenuItemCount_Wrapper,
    'GetMenuItemCount_Wrapper()'#10 +
    'Determines the number of items in the specified menu.');
  PythonType.AddMethod('GetMenuItemID', @TPyDelphiApplication.GetMenuItemID_Wrapper,
    'GetMenuItemID_Wrapper()'#10 +
    'Retrieves the menu item identifier of a menu item located at a specified position.');
  PythonType.AddMethod('EnableMenuItem', @TPyDelphiApplication.EnableMenuItem_Wrapper,
    'EnableMenuItem_Wrapper()'#10 +
    'Enables, disables, or grays a menu item.');
  PythonType.AddMethod('DeleteMenu', @TPyDelphiApplication.DeleteMenu_Wrapper,
    'DeleteMenu_Wrapper()'#10 +
    'Deletes an item from the specified menu.');
  PythonType.AddMethod('RemoveMenu', @TPyDelphiApplication.RemoveMenu_Wrapper,
    'RemoveMenu_Wrapper()'#10 +
    'Removes an item from the specified menu without destroying a submenu handle.');
  PythonType.AddMethod('CreateMenu', @TPyDelphiApplication.CreateMenu_Wrapper,
    'CreateMenu_Wrapper()'#10 +
    'Creates a menu.');
  PythonType.AddMethod('CreatePopupMenu', @TPyDelphiApplication.CreatePopupMenu_Wrapper,
    'CreatePopupMenu_Wrapper()'#10 +
    'Creates a drop-down menu, submenu, or shortcut menu.');
  PythonType.AddMethod('DestroyMenu', @TPyDelphiApplication.DestroyMenu_Wrapper,
    'DestroyMenu_Wrapper()'#10 +
    'Destroys the specified menu.');
  PythonType.AddMethod('SetCursor', @TPyDelphiApplication.SetCursor_Wrapper,
    'SetCursor_Wrapper()'#10 +
    'Sets the cursor shape.');
  PythonType.AddMethod('GetCursor', @TPyDelphiApplication.GetCursor_Wrapper,
    'GetCursor_Wrapper()'#10 +
    'Retrieves a handle to the current cursor.');
  PythonType.AddMethod('LoadCursorFromFile', @TPyDelphiApplication.LoadCursorFromFile_Wrapper,
    'LoadCursorFromFile_Wrapper()'#10 +
    'Creates a cursor from a cursor or animated cursor file.');
  PythonType.AddMethod('GetSysColor', @TPyDelphiApplication.GetSysColor_Wrapper,
    'GetSysColor_Wrapper()'#10 +
    'Retrieves the current color of a display element.');
  PythonType.AddMethod('GetDoubleClickTime', @TPyDelphiApplication.GetDoubleClickTime_Wrapper,
    'GetDoubleClickTime_Wrapper()'#10 +
    'Retrieves the current double-click time for the mouse.');
  PythonType.AddMethod('SetDoubleClickTime', @TPyDelphiApplication.SetDoubleClickTime_Wrapper,
    'SetDoubleClickTime_Wrapper()'#10 +
    'Sets the double-click time for the mouse.');
  PythonType.AddMethod('CreateCompatibleDC', @TPyDelphiApplication.CreateCompatibleDC_Wrapper,
    'CreateCompatibleDC_Wrapper()'#10 +
    'Creates a memory device context (DC) compatible with the specified device.');
  PythonType.AddMethod('CreateCompatibleBitmap', @TPyDelphiApplication.CreateCompatibleBitmap_Wrapper,
    'CreateCompatibleBitmap_Wrapper()'#10 +
    'Creates a bitmap compatible with the device that is associated with the specified device context.');
  PythonType.AddMethod('DeleteDC', @TPyDelphiApplication.DeleteDC_Wrapper,
    'DeleteDC_Wrapper()'#10 +
    'Deletes the specified device context.');
  PythonType.AddMethod('DeleteObject', @TPyDelphiApplication.DeleteObject_Wrapper,
    'DeleteObject_Wrapper()'#10 +
    'Deletes a logical pen, brush, font, bitmap, region, or palette.');
  PythonType.AddMethod('SelectObject', @TPyDelphiApplication.SelectObject_Wrapper,
    'SelectObject_Wrapper()'#10 +
    'Selects an object into the specified device context.');
  PythonType.AddMethod('GetStockObject', @TPyDelphiApplication.GetStockObject_Wrapper,
    'GetStockObject_Wrapper()'#10 +
    'Retrieves a handle to one of the stock pens, brushes, fonts, or palettes.');
  PythonType.AddMethod('CreateSolidBrush', @TPyDelphiApplication.CreateSolidBrush_Wrapper,
    'CreateSolidBrush_Wrapper()'#10 +
    'Creates a logical brush that has the specified solid color.');
  PythonType.AddMethod('CreateHatchBrush', @TPyDelphiApplication.CreateHatchBrush_Wrapper,
    'CreateHatchBrush_Wrapper()'#10 +
    'Creates a logical brush that has the specified hatch pattern and color.');
  PythonType.AddMethod('CreatePen', @TPyDelphiApplication.CreatePen_Wrapper,
    'CreatePen_Wrapper()'#10 +
    'Creates a logical pen that has the specified style, width, and color.');
  PythonType.AddMethod('CreateRectRgn', @TPyDelphiApplication.CreateRectRgn_Wrapper,
    'CreateRectRgn_Wrapper()'#10 +
    'Creates a rectangular region.');
  PythonType.AddMethod('CreateEllipticRgn', @TPyDelphiApplication.CreateEllipticRgn_Wrapper,
    'CreateEllipticRgn_Wrapper()'#10 +
    'Creates an elliptical region.');
  PythonType.AddMethod('CreateRoundRectRgn', @TPyDelphiApplication.CreateRoundRectRgn_Wrapper,
    'CreateRoundRectRgn_Wrapper()'#10 +
    'Creates a rectangular region with rounded corners.');
  PythonType.AddMethod('CombineRgn', @TPyDelphiApplication.CombineRgn_Wrapper,
    'CombineRgn_Wrapper()'#10 +
    'Combines two regions and stores the result in the destination region.');
  PythonType.AddMethod('EqualRgn', @TPyDelphiApplication.EqualRgn_Wrapper,
    'EqualRgn_Wrapper()'#10 +
    'Checks the two specified regions to determine whether they are identical.');
  PythonType.AddMethod('PtInRegion', @TPyDelphiApplication.PtInRegion_Wrapper,
    'PtInRegion_Wrapper()'#10 +
    'Determines whether the specified point is inside the specified region.');
  PythonType.AddMethod('LineTo', @TPyDelphiApplication.LineTo_Wrapper,
    'LineTo_Wrapper()'#10 +
    'Draws a line from the current position up to, but not including, the specified point.');
  PythonType.AddMethod('Rectangle', @TPyDelphiApplication.Rectangle_Wrapper,
    'Rectangle_Wrapper()'#10 +
    'Draws a rectangle.');
  PythonType.AddMethod('RoundRect', @TPyDelphiApplication.RoundRect_Wrapper,
    'RoundRect_Wrapper()'#10 +
    'Draws a rectangle with rounded corners.');
  PythonType.AddMethod('Ellipse', @TPyDelphiApplication.Ellipse_Wrapper,
    'Ellipse_Wrapper()'#10 +
    'Draws an ellipse.');
  PythonType.AddMethod('GetPixel', @TPyDelphiApplication.GetPixel_Wrapper,
    'GetPixel_Wrapper()'#10 +
    'Retrieves the color of the pixel at the specified coordinates.');
  PythonType.AddMethod('SetPixel', @TPyDelphiApplication.SetPixel_Wrapper,
    'SetPixel_Wrapper()'#10 +
    'Sets the pixel at the specified coordinates to the specified color.');
  PythonType.AddMethod('GetTextColor', @TPyDelphiApplication.GetTextColor_Wrapper,
    'GetTextColor_Wrapper()'#10 +
    'Retrieves the current text color for the specified device context.');
  PythonType.AddMethod('SetTextColor', @TPyDelphiApplication.SetTextColor_Wrapper,
    'SetTextColor_Wrapper()'#10 +
    'Sets the text color for the specified device context to the specified color.');
  PythonType.AddMethod('GetBkColor', @TPyDelphiApplication.GetBkColor_Wrapper,
    'GetBkColor_Wrapper()'#10 +
    'Retrieves the current background color for the specified device context.');
  PythonType.AddMethod('SetBkColor', @TPyDelphiApplication.SetBkColor_Wrapper,
    'SetBkColor_Wrapper()'#10 +
    'Sets the current background color to the specified color.');
  PythonType.AddMethod('SetBkMode', @TPyDelphiApplication.SetBkMode_Wrapper,
    'SetBkMode_Wrapper()'#10 +
    'Sets the background mix mode of the specified device context.');
  PythonType.AddMethod('GetBkMode', @TPyDelphiApplication.GetBkMode_Wrapper,
    'GetBkMode_Wrapper()'#10 +
    'Retrieves the current background mix mode.');
  PythonType.AddMethod('TextOut', @TPyDelphiApplication.TextOut_Wrapper,
    'TextOut_Wrapper()'#10 +
    'Writes a character string at the specified location, using the currently selected font.');
  PythonType.AddMethod('GetDeviceCaps', @TPyDelphiApplication.GetDeviceCaps_Wrapper,
    'GetDeviceCaps_Wrapper()'#10 +
    'Retrieves device-specific information about a specified device.');
  PythonType.AddMethod('SaveDC', @TPyDelphiApplication.SaveDC_Wrapper,
    'SaveDC_Wrapper()'#10 +
    'Saves the current state of the specified device context.');
  PythonType.AddMethod('RestoreDC', @TPyDelphiApplication.RestoreDC_Wrapper,
    'RestoreDC_Wrapper()'#10 +
    'Restores a device context to the specified state.');
  PythonType.AddMethod('SetMapMode', @TPyDelphiApplication.SetMapMode_Wrapper,
    'SetMapMode_Wrapper()'#10 +
    'Sets the mapping mode of the specified device context.');
  PythonType.AddMethod('GetMapMode', @TPyDelphiApplication.GetMapMode_Wrapper,
    'GetMapMode_Wrapper()'#10 +
    'Retrieves the current mapping mode.');
  PythonType.AddMethod('SetROP2', @TPyDelphiApplication.SetROP2_Wrapper,
    'SetROP2_Wrapper()'#10 +
    'Sets the current foreground mix mode.');
  PythonType.AddMethod('GetROP2', @TPyDelphiApplication.GetROP2_Wrapper,
    'GetROP2_Wrapper()'#10 +
    'Retrieves the foreground mix mode of the specified device context.');
  PythonType.AddMethod('SetStretchBltMode', @TPyDelphiApplication.SetStretchBltMode_Wrapper,
    'SetStretchBltMode_Wrapper()'#10 +
    'Sets the bitmap stretching mode.');
  PythonType.AddMethod('GetStretchBltMode', @TPyDelphiApplication.GetStretchBltMode_Wrapper,
    'GetStretchBltMode_Wrapper()'#10 +
    'Retrieves the current bitmap-stretching mode.');
  PythonType.AddMethod('StretchBlt', @TPyDelphiApplication.StretchBlt_Wrapper,
    'StretchBlt_Wrapper()'#10 +
    'Copies a bitmap from a source rectangle into a destination rectangle, stretching or compressing to fit.');
  PythonType.AddMethod('PatBlt', @TPyDelphiApplication.PatBlt_Wrapper,
    'PatBlt_Wrapper()'#10 +
    'Paints the specified rectangle using the brush that is currently selected into the device context.');
  // ---- Batch 2: advapi32 (registry/service) / shlwapi / winmm / shell32 ----
  PythonType.AddMethod('RegOpenKeyEx', @TPyDelphiApplication.RegOpenKeyEx_Wrapper,
    'RegOpenKeyEx_Wrapper()'#10 +
    'Opens the specified registry key and returns its handle (0 on failure).');
  PythonType.AddMethod('RegCreateKeyEx', @TPyDelphiApplication.RegCreateKeyEx_Wrapper,
    'RegCreateKeyEx_Wrapper()'#10 +
    'Creates the specified registry key (or opens it if it already exists) and returns its handle (0 on failure).');
  PythonType.AddMethod('RegCloseKey', @TPyDelphiApplication.RegCloseKey_Wrapper,
    'RegCloseKey_Wrapper()'#10 +
    'Closes a handle to the specified registry key. Returns 0 on success.');
  PythonType.AddMethod('RegDeleteKey', @TPyDelphiApplication.RegDeleteKey_Wrapper,
    'RegDeleteKey_Wrapper()'#10 +
    'Deletes a subkey (which must not itself have subkeys). Returns 0 on success.');
  PythonType.AddMethod('RegDeleteValue', @TPyDelphiApplication.RegDeleteValue_Wrapper,
    'RegDeleteValue_Wrapper()'#10 +
    'Removes a named value from the specified registry key. Returns 0 on success.');
  PythonType.AddMethod('RegFlushKey', @TPyDelphiApplication.RegFlushKey_Wrapper,
    'RegFlushKey_Wrapper()'#10 +
    'Writes all the attributes of the specified key to the registry. Returns 0 on success.');
  PythonType.AddMethod('RegEnumKeyEx', @TPyDelphiApplication.RegEnumKeyEx_Wrapper,
    'RegEnumKeyEx_Wrapper()'#10 +
    'Returns the name of the subkey at the given zero-based index, or an empty string when there are no more subkeys.');
  PythonType.AddMethod('RegEnumValue', @TPyDelphiApplication.RegEnumValue_Wrapper,
    'RegEnumValue_Wrapper()'#10 +
    'Returns the name of the value at the given zero-based index, or an empty string when there are no more values.');
  PythonType.AddMethod('RegQueryStringValue', @TPyDelphiApplication.RegQueryStringValue_Wrapper,
    'RegQueryStringValue_Wrapper()'#10 +
    'Reads a REG_SZ / REG_EXPAND_SZ string value.');
  PythonType.AddMethod('RegSetStringValue', @TPyDelphiApplication.RegSetStringValue_Wrapper,
    'RegSetStringValue_Wrapper()'#10 +
    'Writes a REG_SZ string value.');
  PythonType.AddMethod('RegQueryDWordValue', @TPyDelphiApplication.RegQueryDWordValue_Wrapper,
    'RegQueryDWordValue_Wrapper()'#10 +
    'Reads a REG_DWORD value (returns 0 if the value does not exist).');
  PythonType.AddMethod('RegSetDWordValue', @TPyDelphiApplication.RegSetDWordValue_Wrapper,
    'RegSetDWordValue_Wrapper()'#10 +
    'Writes a REG_DWORD value.');
  PythonType.AddMethod('RegConnectRegistry', @TPyDelphiApplication.RegConnectRegistry_Wrapper,
    'RegConnectRegistry_Wrapper()'#10 +
    'Establishes a connection to a predefined registry key on another computer.');
  PythonType.AddMethod('GetUserName', @TPyDelphiApplication.GetUserName_Wrapper,
    'GetUserName_Wrapper()'#10 +
    'Retrieves the name of the user associated with the current thread.');
  PythonType.AddMethod('OpenSCManager', @TPyDelphiApplication.OpenSCManager_Wrapper,
    'OpenSCManager_Wrapper()'#10 +
    'Establishes a connection to the service control manager and opens the specified database.');
  PythonType.AddMethod('OpenService', @TPyDelphiApplication.OpenService_Wrapper,
    'OpenService_Wrapper()'#10 +
    'Opens a handle to the specified service.');
  PythonType.AddMethod('CloseServiceHandle', @TPyDelphiApplication.CloseServiceHandle_Wrapper,
    'CloseServiceHandle_Wrapper()'#10 +
    'Closes a handle to a service control manager or service object.');
  PythonType.AddMethod('QueryServiceState', @TPyDelphiApplication.QueryServiceState_Wrapper,
    'QueryServiceState_Wrapper()'#10 +
    'Returns the current state of the specified service (e.g. SERVICE_RUNNING = 4, SERVICE_STOPPED = 1).');
  PythonType.AddMethod('StartService', @TPyDelphiApplication.StartService_Wrapper,
    'StartService_Wrapper()'#10 +
    'Starts a service with no extra start arguments.');
  PythonType.AddMethod('ControlService', @TPyDelphiApplication.ControlService_Wrapper,
    'ControlService_Wrapper()'#10 +
    'Sends a control code (e.g. SERVICE_CONTROL_STOP = 1) to a service.');
  PythonType.AddMethod('DeleteService', @TPyDelphiApplication.DeleteService_Wrapper,
    'DeleteService_Wrapper()'#10 +
    'Marks the specified service for deletion from the service control manager database.');
  PythonType.AddMethod('PathFileExists', @TPyDelphiApplication.PathFileExists_Wrapper,
    'PathFileExists_Wrapper()'#10 +
    'Determines whether a path to a file system object such as a file or folder is valid.');
  PythonType.AddMethod('PathIsDirectory', @TPyDelphiApplication.PathIsDirectory_Wrapper,
    'PathIsDirectory_Wrapper()'#10 +
    'Verifies that a path is a valid directory.');
  PythonType.AddMethod('PathIsRoot', @TPyDelphiApplication.PathIsRoot_Wrapper,
    'PathIsRoot_Wrapper()'#10 +
    'Determines whether a path is a root path.');
  PythonType.AddMethod('PathIsRelative', @TPyDelphiApplication.PathIsRelative_Wrapper,
    'PathIsRelative_Wrapper()'#10 +
    'Determines whether a path is relative.');
  PythonType.AddMethod('PathIsUNC', @TPyDelphiApplication.PathIsUNC_Wrapper,
    'PathIsUNC_Wrapper()'#10 +
    'Determines whether a path string is a valid universal naming convention (UNC) path.');
  PythonType.AddMethod('PathIsURL', @TPyDelphiApplication.PathIsURL_Wrapper,
    'PathIsURL_Wrapper()'#10 +
    'Tests a given string to determine if it conforms to a valid URL format.');
  PythonType.AddMethod('PathRemoveBackslash', @TPyDelphiApplication.PathRemoveBackslash_Wrapper,
    'PathRemoveBackslash_Wrapper()'#10 +
    'Removes the trailing backslash from a path, if one is present, and returns the result.');
  PythonType.AddMethod('PathAddBackslash', @TPyDelphiApplication.PathAddBackslash_Wrapper,
    'PathAddBackslash_Wrapper()'#10 +
    'Adds a trailing backslash to a path, if it does not already have one, and returns the result.');
  PythonType.AddMethod('PathRemoveExtension', @TPyDelphiApplication.PathRemoveExtension_Wrapper,
    'PathRemoveExtension_Wrapper()'#10 +
    'Removes the file name extension from a path, if present, and returns the result.');
  PythonType.AddMethod('PathRemoveFileSpec', @TPyDelphiApplication.PathRemoveFileSpec_Wrapper,
    'PathRemoveFileSpec_Wrapper()'#10 +
    'Removes the trailing file name and backslash from a path, if present, and returns the result.');
  PythonType.AddMethod('PathFindExtension', @TPyDelphiApplication.PathFindExtension_Wrapper,
    'PathFindExtension_Wrapper()'#10 +
    'Returns the extension (including the leading dot) of a file name, or an empty string if it has none.');
  PythonType.AddMethod('PathFindFileName', @TPyDelphiApplication.PathFindFileName_Wrapper,
    'PathFindFileName_Wrapper()'#10 +
    'Returns the filename portion (without directory) of a path.');
  PythonType.AddMethod('PathGetDriveNumber', @TPyDelphiApplication.PathGetDriveNumber_Wrapper,
    'PathGetDriveNumber_Wrapper()'#10 +
    'Returns the drive number (0 = A:, 1 = B:, ...) from a path, or -1 if no drive letter is present.');
  PythonType.AddMethod('PathStripPath', @TPyDelphiApplication.PathStripPath_Wrapper,
    'PathStripPath_Wrapper()'#10 +
    'Removes the directory portion of a path in place, leaving just the file name, and returns the result.');
  PythonType.AddMethod('PathIsPrefix', @TPyDelphiApplication.PathIsPrefix_Wrapper,
    'PathIsPrefix_Wrapper()'#10 +
    'Determines whether a path string is a valid prefix for another path string.');
  PythonType.AddMethod('PathMatchSpec', @TPyDelphiApplication.PathMatchSpec_Wrapper,
    'PathMatchSpec_Wrapper()'#10 +
    'Searches a string using a Microsoft MS-DOS wild card match type, e.g. ''*.txt''.');
  PythonType.AddMethod('PathIsSameRoot', @TPyDelphiApplication.PathIsSameRoot_Wrapper,
    'PathIsSameRoot_Wrapper()'#10 +
    'Compares two paths to determine if they have a common root component.');
  PythonType.AddMethod('PathCombine', @TPyDelphiApplication.PathCombine_Wrapper,
    'PathCombine_Wrapper()'#10 +
    'Concatenates two paths into a single, well-formed path.');
  PythonType.AddMethod('PathAppend', @TPyDelphiApplication.PathAppend_Wrapper,
    'PathAppend_Wrapper()'#10 +
    'Appends one path to the end of another and returns the combined result.');
  PythonType.AddMethod('PathQuoteSpaces', @TPyDelphiApplication.PathQuoteSpaces_Wrapper,
    'PathQuoteSpaces_Wrapper()'#10 +
    'Places quotation marks around a path if it contains spaces, and returns the result.');
  PythonType.AddMethod('PathUnquoteSpaces', @TPyDelphiApplication.PathUnquoteSpaces_Wrapper,
    'PathUnquoteSpaces_Wrapper()'#10 +
    'Removes quotation marks from the beginning and end of a path, and returns the result.');
  PythonType.AddMethod('PathCanonicalize', @TPyDelphiApplication.PathCanonicalize_Wrapper,
    'PathCanonicalize_Wrapper()'#10 +
    'Resolves ''.'' and ''..'' segments in a path and returns the simplified result.');
  PythonType.AddMethod('StrToInt', @TPyDelphiApplication.StrToInt_Wrapper,
    'StrToInt_Wrapper()'#10 +
    'Converts a string representation of a number to an integer value.');
  PythonType.AddMethod('StrFormatByteSize', @TPyDelphiApplication.StrFormatByteSize_Wrapper,
    'StrFormatByteSize_Wrapper()'#10 +
    'Formats a byte count as a human readable string (e.g. ''1.44 MB'').');
  PythonType.AddMethod('timeGetTime', @TPyDelphiApplication.timeGetTime_Wrapper,
    'timeGetTime_Wrapper()'#10 +
    'Retrieves the system time, in milliseconds.');
  PythonType.AddMethod('timeBeginPeriod', @TPyDelphiApplication.timeBeginPeriod_Wrapper,
    'timeBeginPeriod_Wrapper()'#10 +
    'Requests a minimum timer resolution for the application (returns 0 on success).');
  PythonType.AddMethod('timeEndPeriod', @TPyDelphiApplication.timeEndPeriod_Wrapper,
    'timeEndPeriod_Wrapper()'#10 +
    'Clears a previously set minimum timer resolution (returns 0 on success).');
  PythonType.AddMethod('PlaySound', @TPyDelphiApplication.PlaySound_Wrapper,
    'PlaySound_Wrapper()'#10 +
    'Plays a sound specified by a file name, system event alias, or resource (see SND_* flags).');
  PythonType.AddMethod('sndPlaySound', @TPyDelphiApplication.sndPlaySound_Wrapper,
    'sndPlaySound_Wrapper()'#10 +
    'Plays a waveform sound specified by a file name or system event alias (legacy API, simpler than PlaySound).');
  PythonType.AddMethod('waveOutGetNumDevs', @TPyDelphiApplication.waveOutGetNumDevs_Wrapper,
    'waveOutGetNumDevs_Wrapper()'#10 +
    'Returns the number of waveform-audio output devices present.');
  PythonType.AddMethod('waveInGetNumDevs', @TPyDelphiApplication.waveInGetNumDevs_Wrapper,
    'waveInGetNumDevs_Wrapper()'#10 +
    'Returns the number of waveform-audio input devices present.');
  PythonType.AddMethod('midiOutGetNumDevs', @TPyDelphiApplication.midiOutGetNumDevs_Wrapper,
    'midiOutGetNumDevs_Wrapper()'#10 +
    'Returns the number of MIDI output devices present.');
  PythonType.AddMethod('midiInGetNumDevs', @TPyDelphiApplication.midiInGetNumDevs_Wrapper,
    'midiInGetNumDevs_Wrapper()'#10 +
    'Returns the number of MIDI input devices present.');
  PythonType.AddMethod('auxGetNumDevs', @TPyDelphiApplication.auxGetNumDevs_Wrapper,
    'auxGetNumDevs_Wrapper()'#10 +
    'Returns the number of auxiliary output devices present.');
  PythonType.AddMethod('joyGetNumDevs', @TPyDelphiApplication.joyGetNumDevs_Wrapper,
    'joyGetNumDevs_Wrapper()'#10 +
    'Returns the number of joystick devices supported by the current driver.');
  PythonType.AddMethod('mixerGetNumDevs', @TPyDelphiApplication.mixerGetNumDevs_Wrapper,
    'mixerGetNumDevs_Wrapper()'#10 +
    'Returns the number of mixer devices present.');
  PythonType.AddMethod('mmioStringToFOURCC', @TPyDelphiApplication.mmioStringToFOURCC_Wrapper,
    'mmioStringToFOURCC_Wrapper()'#10 +
    'Converts a string of at most 4 characters to a four-character code (FOURCC).');
  PythonType.AddMethod('SHGetFolderPath', @TPyDelphiApplication.SHGetFolderPath_Wrapper,
    'SHGetFolderPath_Wrapper()'#10 +
    'Retrieves the path of a well-known special folder (e.g. CSIDL_PERSONAL = 5 for My Documents, CSIDL_DESKTOP = 0, CSIDL_APPDATA = 26).');
  PythonType.AddMethod('ShellAbout', @TPyDelphiApplication.ShellAbout_Wrapper,
    'ShellAbout_Wrapper()'#10 +
    'Displays the standard Windows ''About'' dialog box.');
  PythonType.AddMethod('ExtractIcon', @TPyDelphiApplication.ExtractIcon_Wrapper,
    'ExtractIcon_Wrapper()'#10 +
    'Extracts an icon from the specified executable file, DLL, or icon file.');
  PythonType.AddMethod('SHGetFileTypeDescription', @TPyDelphiApplication.SHGetFileTypeDescription_Wrapper,
    'SHGetFileTypeDescription_Wrapper()'#10 +
    'Retrieves the human-readable file type description for a file (e.g. ''Text Document'').');
  PythonType.AddMethod('IsUserAnAdmin', @TPyDelphiApplication.IsUserAnAdmin_Wrapper,
    'IsUserAnAdmin_Wrapper()'#10 +
    'Determines whether the current process is running with administrative privileges.');
  // ---- Batch 3: restored + additional kernel32/shlwapi/shell32 functions ----
  PythonType.AddMethod('ExitWindowsEx', @TPyDelphiApplication.ExitWindowsEx_Wrapper,
    'ExitWindowsEx_Wrapper()'#10 +
    'Logs off, shuts down, or restarts the system (behaviour controlled by uFlags, e.g. EWX_LOGOFF=0, EWX_SHUTDOWN=1, EWX_REBOOT=2).');
  PythonType.AddMethod('LockWorkStation', @TPyDelphiApplication.LockWorkStation_Wrapper,
    'LockWorkStation_Wrapper()'#10 +
    'Locks the workstation''s display, requiring the user to log back in.');
  PythonType.AddMethod('SHFileOperationDelete', @TPyDelphiApplication.SHFileOperationDelete_Wrapper,
    'SHFileOperationDelete_Wrapper()'#10 +
    'Deletes a file using the Shell (so it goes to the Recycle Bin when AllowUndo is True). Returns 0 on success.');
  PythonType.AddMethod('SHEmptyRecycleBin', @TPyDelphiApplication.SHEmptyRecycleBin_Wrapper,
    'SHEmptyRecycleBin_Wrapper()'#10 +
    'Empties the Recycle Bin for the given drive/root path (permanently deletes its contents). Returns 0 on success.');
  PythonType.AddMethod('StrChr', @TPyDelphiApplication.StrChr_Wrapper,
    'StrChr_Wrapper()'#10 +
    'Returns the 1-based index of the first occurrence of a character in a string, or 0 if not found.');
  PythonType.AddMethod('StrStr', @TPyDelphiApplication.StrStr_Wrapper,
    'StrStr_Wrapper()'#10 +
    'Returns the 1-based index of the first occurrence of a substring, or 0 if not found.');
  PythonType.AddMethod('GetProcAddress', @TPyDelphiApplication.GetProcAddress_Wrapper,
    'GetProcAddress_Wrapper()'#10 +
    'Retrieves the address of an exported function or variable from a loaded DLL, as a raw integer address.');
  PythonType.AddMethod('GetExitCodeProcess', @TPyDelphiApplication.GetExitCodeProcess_Wrapper,
    'GetExitCodeProcess_Wrapper()'#10 +
    'Retrieves the termination status of the specified process (still running = STILL_ACTIVE = 259).');
  PythonType.AddMethod('SetPriorityClass', @TPyDelphiApplication.SetPriorityClass_Wrapper,
    'SetPriorityClass_Wrapper()'#10 +
    'Sets the priority class for the specified process.');
  PythonType.AddMethod('GetPriorityClass', @TPyDelphiApplication.GetPriorityClass_Wrapper,
    'GetPriorityClass_Wrapper()'#10 +
    'Retrieves the priority class for the specified process.');
  PythonType.AddMethod('GetFileSize', @TPyDelphiApplication.GetFileSize_Wrapper,
    'GetFileSize_Wrapper()'#10 +
    'Retrieves the size, in bytes, of a file that is open with the given handle (files under 4GB).');
  PythonType.AddMethod('GetLocalTime', @TPyDelphiApplication.GetLocalTime_Wrapper,
    'GetLocalTime_Wrapper()'#10 +
    'Retrieves the current local date and time, formatted as ''YYYY-MM-DD HH:MM:SS''.');
  PythonType.AddMethod('GetSystemTime', @TPyDelphiApplication.GetSystemTime_Wrapper,
    'GetSystemTime_Wrapper()'#10 +
    'Retrieves the current system (UTC) date and time, formatted as ''YYYY-MM-DD HH:MM:SS''.');
  PythonType.AddMethod('GetCursorPos', @TPyDelphiApplication.GetCursorPos_Wrapper,
    'GetCursorPos_Wrapper()'#10 +
    'Retrieves the position of the mouse cursor, in screen coordinates.');
  PythonType.AddMethod('GetWindowRect', @TPyDelphiApplication.GetWindowRect_Wrapper,
    'GetWindowRect_Wrapper()'#10 +
    'Retrieves the dimensions of the bounding rectangle of the specified window, in screen coordinates.');
  PythonType.AddMethod('GetClientRect', @TPyDelphiApplication.GetClientRect_Wrapper,
    'GetClientRect_Wrapper()'#10 +
    'Retrieves the coordinates of a window''s client area.');
  PythonType.AddMethod('ClientToScreen', @TPyDelphiApplication.ClientToScreen_Wrapper,
    'ClientToScreen_Wrapper()'#10 +
    'Converts the client-area coordinates of a specified point to screen coordinates.');
  PythonType.AddMethod('ScreenToClient', @TPyDelphiApplication.ScreenToClient_Wrapper,
    'ScreenToClient_Wrapper()'#10 +
    'Converts the screen coordinates of a specified point to client-area coordinates.');
  PythonType.AddMethod('MoveToEx', @TPyDelphiApplication.MoveToEx_Wrapper,
    'MoveToEx_Wrapper()'#10 +
    'Updates the current position to the specified point and returns the previous position.');
  PythonType.AddMethod('GetShortPathName', @TPyDelphiApplication.GetShortPathName_Wrapper,
    'GetShortPathName_Wrapper()'#10 +
    'Retrieves the short path form of the specified path.');
  PythonType.AddMethod('GetLongPathName', @TPyDelphiApplication.GetLongPathName_Wrapper,
    'GetLongPathName_Wrapper()'#10 +
    'Converts the specified path to its long form.');
  PythonType.AddMethod('GetLogicalDriveStrings', @TPyDelphiApplication.GetLogicalDriveStrings_Wrapper,
    'GetLogicalDriveStrings_Wrapper()'#10 +
    'Retrieves a list of drive letters (root paths) of all logical drives, separated by ''|''.');
  PythonType.AddMethod('GetDlgItemText', @TPyDelphiApplication.GetDlgItemText_Wrapper,
    'GetDlgItemText_Wrapper()'#10 +
    'Retrieves the text of a control in a dialog box.');
//  PythonType.AddMethod('CCompiler', @TPyDelphiApplication.CCompiler_Wrapper,
//    'CCompiler_Wrapper()'#10 +
//    'Compile C code into an exe.');
//  PythonType.AddMethod('CompileFPCFileToRun', @TPyDelphiApplication.CompileFPCFileToExeAndRun_Wrapper,
//    'CompileFPCFileToExeAndRun_Wrapper()'#10 +
//    'Compile the FPC file and then run it.');
//  PythonType.AddMethod('CompileFPCCodeToDllAndCall', @TPyDelphiApplication.CompileFPCCodeToDllAndCall_Wrapper,
//    'CompileFPCCodeToDllAndCall_Wrapper()'#10 +
//    'Compile the FPC code into a DLL and then call the function.');
  PythonType.AddMethod('Minimize', @TPyDelphiApplication.Minimize_Wrapper,
    'TApplication.Minimize()'#10 +
    'Shrinks an application to the Windows task bar.');
  PythonType.AddMethod('ModalStarted', @TPyDelphiApplication.ModalStarted_Wrapper,
    'TApplication.ModalStarted()'#10 +
    'Track opening of modal form.');
  PythonType.AddMethod('ModalFinished', @TPyDelphiApplication.ModalFinished_Wrapper,
    'TApplication.ModalFinished()'#10 +
    'Track closing of modal form.');
  PythonType.AddMethod('NormalizeAllTopMosts', @TPyDelphiApplication.NormalizeAllTopMosts_Wrapper,
    'TApplication.NormalizeAllTopMosts()'#10 +
    'Makes forms that have been designated as topmost forms (their FormStyle is fsStayOnTop) behave as if they were not topmost forms. ');
  PythonType.AddMethod('RestoreTopMosts', @TPyDelphiApplication.RestoreTopMosts_Wrapper,
    'TApplication.RestoreTopMosts()'#10 +
    'Restores forms designated as fsStayOnTop to be topmost again.');
  PythonType.AddMethod('ProcessMessages', @TPyDelphiApplication.ProcessMessages_Wrapper,
    'TApplication.ProcessMessages()'#10 +
    'Interrupts the execution of an application so that it can process the message queue.');
  PythonType.AddMethod('Restore', @TPyDelphiApplication.Restore_Wrapper,
    'TApplication.Restore()'#10 +
    'Restores a minimized application to its normal size.');
  PythonType.AddMethod('Run', @TPyDelphiApplication.Run_Wrapper,
    'TApplication.Run()'#10 +
    'Executes the application.');
  PythonType.AddMethod('ShowException', @TPyDelphiApplication.ShowException_Wrapper,
    'TApplication.ShowException()'#10 +
    'Displays a message box for exceptions that are not caught by application code.');
  PythonType.AddMethod('Terminate', @TPyDelphiApplication.Terminate_Wrapper,
    'TApplication.Terminate()'#10 +
    'Ends application execution.');
  PythonType.AddMethod('UpdateAction', @TPyDelphiApplication.UpdateAction_Wrapper,
    'TApplication.UpdateAction()'#10 +
    'Generates an OnActionUpdate event.');
  PythonType.AddMethod('UseRightToLeftAlignment', @TPyDelphiApplication.UseRightToLeftAlignment_Wrapper,
    'TApplication.UseRightToLeftAlignment()'#10 +
    'Specifies whether the application object is in a right-to-left alignment mode.');
  PythonType.AddMethod('UseRightToLeftReading', @TPyDelphiApplication.UseRightToLeftReading_Wrapper,
    'TApplication.UseRightToLeftReading()'#10 +
    'Specifies whether the application object is in a right-to-left text mode.');
  PythonType.AddMethod('UseRightToLeftScrollBar', @TPyDelphiApplication.UseRightToLeftScrollBar_Wrapper,
    'TApplication.UseRightToLeftScrollBar()'#10 +
    'Specifies whether the vertical scroll bar appears on the left side controls.');
end;

function TPyDelphiApplication.Restore_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Restore') <> 0 then begin
      DelphiObject.Restore;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.Run_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Run') <> 0 then
    begin
      DelphiObject.Run;
      Result := ReturnNone;
    end
    else
      Result := nil;
  end;
end;

procedure TPyDelphiApplication.SetDelphiObject(const Value: TApplication);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiApplication.ShowException_Wrapper(
  args: PPyObject): PPyObject;
var
  _obj : PPyObject;
  _value : TObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'O:ShowException', @_obj ) <> 0 then begin
      if CheckObjAttribute(_obj, 'The first argument of ShowException', Exception, _value) then
      begin
        DelphiObject.ShowException(Exception(_value));
        Result := ReturnNone;
      end else
        Result := nil;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.Terminate_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Terminate') <> 0 then begin
      DelphiObject.Terminate;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.UpdateAction_Wrapper(
  args: PPyObject): PPyObject;
var
  _obj : PPyObject;
  _value : TObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'O:UpdateAction',@_obj ) <> 0 then begin
      if CheckObjAttribute(_obj, 'The first argument of UpdateAction', TBasicAction, _value) then
      begin
        DelphiObject.UpdateAction(TBasicAction(_value));
        Result := ReturnNone;
      end else
        Result := nil;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.UseRightToLeftAlignment_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':UseRightToLeftAlignment') <> 0 then begin
      DelphiObject.UseRightToLeftAlignment;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.UseRightToLeftReading_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':UseRightToLeftReading') <> 0 then begin
      DelphiObject.UseRightToLeftReading;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.UseRightToLeftScrollBar_Wrapper(
  args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':UseRightToLeftScrollBar') <> 0 then begin
      DelphiObject.UseRightToLeftScrollBar;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiApplication.Get_Active(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.Active);
end;

function TPyDelphiApplication.Get_AllowTesting(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.AllowTesting);
end;

function TPyDelphiApplication.Get_AutoDragDocking(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.AutoDragDocking);
end;

function TPyDelphiApplication.Get_BiDiKeyboard(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyUnicodeFromString(DelphiObject.BiDiKeyboard);
end;

function TPyDelphiApplication.Get_BiDiMode(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(Ord(DelphiObject.BiDiMode));
end;

function TPyDelphiApplication.Get_CurrentHelpFile(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyUnicodeFromString(DelphiObject.CurrentHelpFile);
end;

function TPyDelphiApplication.Get_DialogHandle(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.DialogHandle);
end;

function TPyDelphiApplication.Get_ExeName(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyUnicodeFromString(DelphiObject.ExeName);
end;

function TPyDelphiApplication.Get_Handle(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Handle);
end;

function TPyDelphiApplication.Get_HelpFile(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyUnicodeFromString(DelphiObject.HelpFile);
end;

function TPyDelphiApplication.Get_Hint(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyUnicodeFromString(DelphiObject.Hint);
end;

function TPyDelphiApplication.Get_HintColor(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.HintColor);
end;

function TPyDelphiApplication.Get_HintHidePause(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.HintHidePause);
end;

function TPyDelphiApplication.Get_HintPause(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.HintPause);
end;

function TPyDelphiApplication.Get_HintShortCuts(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.HintShortCuts);
end;

function TPyDelphiApplication.Get_HintShortPause(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.HintShortPause);
end;

function TPyDelphiApplication.Get_Icon(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.Icon);
end;

function TPyDelphiApplication.Get_MainForm(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.MainForm);
end;

function TPyDelphiApplication.Get_NonBiDiKeyboard(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyUnicodeFromString(DelphiObject.NonBiDiKeyboard);
end;

function TPyDelphiApplication.Get_ShowHint(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.ShowHint);
end;

function TPyDelphiApplication.Get_ShowMainForm(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.ShowMainForm);
end;

function TPyDelphiApplication.Get_Terminated(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.Terminated);
end;

function TPyDelphiApplication.Get_Title(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyUnicodeFromString(DelphiObject.Title);
end;

function TPyDelphiApplication.Get_UpdateFormatSettings(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.UpdateFormatSettings);
end;

function TPyDelphiApplication.Get_UpdateMetricSettings(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.UpdateMetricSettings);
end;

function TPyDelphiApplication.Set_AllowTesting(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Boolean;
begin
  Adjust(@Self);
  if CheckBoolAttribute(AValue, 'AllowTesting', _value) then
  begin
    DelphiObject.AllowTesting := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_AutoDragDocking(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Boolean;
begin
  Adjust(@Self);
  if CheckBoolAttribute(AValue, 'AutoDragDocking', _value) then
  begin
    DelphiObject.AutoDragDocking := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_BiDiKeyboard(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : string;
begin
  Adjust(@Self);
  if CheckStrAttribute(AValue, 'BiDiKeyboard', _value) then
  begin
    DelphiObject.BiDiKeyboard := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_BiDiMode(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'BiDiMode', _value) then
  begin
    DelphiObject.BiDiMode := TBiDiMode(_value);
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_DialogHandle(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'DialogHandle', _value) then
  begin
    DelphiObject.DialogHandle := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_Handle(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'Handle', _value) then
  begin
    DelphiObject.Handle := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_HelpFile(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : string;
begin
  Adjust(@Self);
  if CheckStrAttribute(AValue, 'HelpFile', _value) then
  begin
    DelphiObject.HelpFile := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_Hint(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : string;
begin
  Adjust(@Self);
  if CheckStrAttribute(AValue, 'Hint', _value) then
  begin
    DelphiObject.Hint := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_HintColor(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'HintColor', _value) then
  begin
    DelphiObject.HintColor := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_HintHidePause(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'HintHidePause', _value) then
  begin
    DelphiObject.HintHidePause := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_HintPause(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'HintPause', _value) then
  begin
    DelphiObject.HintPause := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_HintShortCuts(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Boolean;
begin
  Adjust(@Self);
  if CheckBoolAttribute(AValue, 'HintShortCuts', _value) then
  begin
    DelphiObject.HintShortCuts := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_HintShortPause(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'HintShortPause', _value) then
  begin
    DelphiObject.HintShortPause := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_Icon(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : TObject;
begin
  Adjust(@Self);
  if CheckObjAttribute(AValue, 'Icon', TIcon, _value) then
  begin
    DelphiObject.Icon := TIcon(_value);
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_NonBiDiKeyboard(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : string;
begin
  Adjust(@Self);
  if CheckStrAttribute(AValue, 'NonBiDiKeyboard', _value) then
  begin
    DelphiObject.NonBiDiKeyboard := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_ShowHint(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Boolean;
begin
  Adjust(@Self);
  if CheckBoolAttribute(AValue, 'ShowHint', _value) then
  begin
    DelphiObject.ShowHint := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_ShowMainForm(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Boolean;
begin
  Adjust(@Self);
  if CheckBoolAttribute(AValue, 'ShowMainForm', _value) then
  begin
    DelphiObject.ShowMainForm := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_Title(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : string;
begin
  Adjust(@Self);
  if CheckStrAttribute(AValue, 'Title', _value) then
  begin
    DelphiObject.Title := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_UpdateFormatSettings(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Boolean;
begin
  Adjust(@Self);
  if CheckBoolAttribute(AValue, 'UpdateFormatSettings', _value) then
  begin
    DelphiObject.UpdateFormatSettings := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiApplication.Set_UpdateMetricSettings(AValue: PPyObject;
  AContext: Pointer): Integer;
var
  _value : Boolean;
begin
  Adjust(@Self);
  if CheckBoolAttribute(AValue, 'UpdateMetricSettings', _value) then
  begin
    DelphiObject.UpdateMetricSettings := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

class function TPyDelphiApplication.DelphiObjectClass: TClass;
begin
  Result := TApplication;
end;

{ TCloseQueryEventHandler }

constructor TCloseQueryEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  Method : TMethod;
begin
  inherited;
  Method.Code := @TCloseQueryEventHandler.DoEvent;
  Method.Data := Self;
  SetMethodProp(Component, PropertyInfo, Method);
end;

procedure TCloseQueryEventHandler.DoEvent(Sender: TObject;
  var CanClose: Boolean);
Var
  PyObject, PyTuple, PyResult, PyCanClose : PPyObject;
  _varParam : TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyCanClose := CreateVarParam(PyDelphiWrapper, CanClose);
      _varParam := PythonToDelphi(PyCanClose) as TPyDelphiVarParameter;
      PyTuple := PyTuple_New(2);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, PyCanClose);
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);
          CanClose := PyObject_IsTrue(_varParam.Value) = 1;
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TCloseQueryEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TCloseQueryEvent);
end;

{ TCloseActionEventHandler }

constructor TCloseEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  Method : TMethod;
begin
  inherited;
  Method.Code := @TCloseEventHandler.DoEvent;
  Method.Data := Self;
  SetMethodProp(Component, PropertyInfo, Method);
end;

procedure TCloseEventHandler.DoEvent(Sender: TObject;
  var Action: TCloseAction);
Var
  PyObject, PyTuple, PyResult, PyAction : PPyObject;
  _varParam : TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyAction := CreateVarParam(PyDelphiWrapper, NativeInt(Action));
      _varParam := PythonToDelphi(PyAction) as TPyDelphiVarParameter;
      PyTuple := PyTuple_New(2);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, PyAction);
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);
          if PyLong_Check(_varParam.Value) and
             CheckEnum('TCloseAction', PyLong_AsLong(_varParam.Value), Ord(Low(TCloseAction)), Ord(High(TCloseAction))) then
            Action := TCloseAction(PyLong_AsLong(_varParam.Value));
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TCloseEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TCloseEvent);
end;

initialization
  RegisteredUnits.Add( TFormsRegistration.Create );
  Classes.RegisterClasses([TForm, TScreen, TApplication]);
end.
