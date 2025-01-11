(**************************************************************************)
(*  This unit is part of the Python for Delphi (P4D) library              *)
(*  Project home: https://github.com/pyscripter/python4delphi             *)
(*                                                                        *)
(*  Project Maintainer:  PyScripter (pyscripter@gmail.com)                *)
(*  Original Authors:    Dr. Dietmar Budelsky (dbudelsky@web.de)          *)
(*                       Morgan Martinet (https://github.com/mmm-experts) *)
(*  Core developer:      Lucas Belo (lucas.belo@live.com)                 *)
(*  Contributors:        See contributors.md at project home              *)
(*                                                                        *)
(*  LICENCE and Copyright: MIT (see project home)                         *)
(**************************************************************************)

{$I Definition.Inc}

unit WrapDelphiWindows;

interface

{$IFDEF MSWINDOWS}
uses
  Windows, Classes, SysUtils, TypInfo, PythonEngine, WrapDelphi, WrapDelphiClasses;

function OwnerDrawStateToPython(const AOwnerDrawState: TOwnerDrawState): PPyObject;
{$ENDIF MSWINDOWS}

implementation

{$IFDEF MSWINDOWS}

{$IFDEF DELPHI11_OR_HIGHER}
uses
  System.Win.HighDpi, Winapi.ShellScaling;
{$ENDIF DELPHI11_OR_HIGHER}

function OwnerDrawStateToPython(const AOwnerDrawState: TOwnerDrawState): PPyObject;

  procedure Append(const AList: PPyObject; const AString: string);
  var
    LItem: PPyObject;
  begin
    with GetPythonEngine do begin
      LItem := PyUnicodeFromString(AString);
      PyList_Append(AList, LItem);
      Py_XDecRef(LItem);
    end;
  end;

var
  LState: integer;
begin
  Result := GetPythonEngine().PyList_New(0);
  for LState := Ord(odSelected) to Ord(odComboBoxEdit) do
    Append(Result, System.TypInfo.GetEnumName(TypeInfo(TOwnerDrawState), LState));
end;

{ Register the wrappers, the globals and the constants }
type
  TWindowsRegistration = class(TRegisteredUnit)
  private
    {$IFDEF DELPHI11_OR_HIGHER}
    class function IsDpiAware_Wrapper(PySelf, AArgs: PPyObject): PPyObject; cdecl; static;
    class function SetHighDpiAware_Wrapper(PySelf, AArgs: PPyObject): PPyObject; cdecl; static;
    class function GetProcessDpiAwareness_Wrapper(PySelf, AArgs: PPyObject): PPyObject; cdecl; static;
    class function SetProcessDpiAwareness_Wrapper(PySelf, AArgs: PPyObject): PPyObject; cdecl; static;
    {$ENDIF DELPHI11_OR_HIGHER}
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TWindowsRegistration }

function TWindowsRegistration.Name: string;
begin
  Result := 'Windows';
end;

procedure TWindowsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('MB_OK',  MB_OK);
  APyDelphiWrapper.DefineVar('MB_YESNO',  MB_YESNO);
  APyDelphiWrapper.DefineVar('MB_YESNOCANCEL',  MB_YESNOCANCEL);
  APyDelphiWrapper.DefineVar('MB_OKCANCEL',  MB_OKCANCEL);
  APyDelphiWrapper.DefineVar('MB_ABORTRETRYIGNORE',  MB_ABORTRETRYIGNORE);
  APyDelphiWrapper.DefineVar('MB_RETRYCANCEL', MB_RETRYCANCEL);
  APyDelphiWrapper.DefineVar('MB_ICONINFORMATION',  MB_ICONINFORMATION);
  APyDelphiWrapper.DefineVar('MB_ICONHAND', MB_ICONHAND);
  APyDelphiWrapper.DefineVar('MB_ICONQUESTION', MB_ICONQUESTION);
  APyDelphiWrapper.DefineVar('MB_ICONEXCLAMATION', MB_ICONEXCLAMATION);
  APyDelphiWrapper.DefineVar('MB_ICONASTERISK', MB_ICONASTERISK);
  APyDelphiWrapper.DefineVar('MB_ICONWARNING', MB_ICONWARNING);
  APyDelphiWrapper.DefineVar('MB_ICONERROR', MB_ICONERROR);
  APyDelphiWrapper.DefineVar('MB_ICONSTOP', MB_ICONSTOP);
  APyDelphiWrapper.DefineVar('MB_DEFBUTTON1', MB_DEFBUTTON1);
  APyDelphiWrapper.DefineVar('MB_DEFBUTTON2', MB_DEFBUTTON2);
  APyDelphiWrapper.DefineVar('MB_DEFBUTTON3', MB_DEFBUTTON3);
  APyDelphiWrapper.DefineVar('MB_DEFBUTTON4', MB_DEFBUTTON4);
  APyDelphiWrapper.DefineVar('MB_APPLMODAL', MB_APPLMODAL);
  APyDelphiWrapper.DefineVar('MB_SYSTEMMODAL', MB_SYSTEMMODAL);
  APyDelphiWrapper.DefineVar('MB_TASKMODAL', MB_TASKMODAL);
  APyDelphiWrapper.DefineVar('MB_HELP', MB_HELP);
  {$IFNDEF FPC}
  APyDelphiWrapper.DefineVar('MB_NOFOCUS', MB_NOFOCUS);
  {$ENDIF FPC}

  APyDelphiWrapper.DefineVar('IDOK', IDOK);
  APyDelphiWrapper.DefineVar('IDCANCEL', IDCANCEL);
  APyDelphiWrapper.DefineVar('IDABORT', IDABORT);
  APyDelphiWrapper.DefineVar('IDRETRY', IDRETRY);
  APyDelphiWrapper.DefineVar('IDIGNORE', IDIGNORE);
  APyDelphiWrapper.DefineVar('IDYES', IDYES);
  APyDelphiWrapper.DefineVar('IDNO', IDNO);
  APyDelphiWrapper.DefineVar('IDCLOSE', IDCLOSE);
  APyDelphiWrapper.DefineVar('IDHELP', IDHELP);
  {$IFNDEF FPC}
  APyDelphiWrapper.DefineVar('IDTRYAGAIN', IDTRYAGAIN);
  APyDelphiWrapper.DefineVar('IDCONTINUE', IDCONTINUE);
  {$ENDIF FPC}
  APyDelphiWrapper.DefineVar('VK_LBUTTON', VK_LBUTTON);
  APyDelphiWrapper.DefineVar('VK_RBUTTON', VK_RBUTTON);
  APyDelphiWrapper.DefineVar('VK_CANCEL', VK_CANCEL);
  APyDelphiWrapper.DefineVar('VK_MBUTTON', VK_MBUTTON);
  APyDelphiWrapper.DefineVar('VK_XBUTTON1', VK_XBUTTON1);
  APyDelphiWrapper.DefineVar('VK_XBUTTON2', VK_XBUTTON2);
  APyDelphiWrapper.DefineVar('VK_BACK', VK_BACK);
  APyDelphiWrapper.DefineVar('VK_TAB', VK_TAB);
  APyDelphiWrapper.DefineVar('VK_CLEAR', VK_CLEAR);
  APyDelphiWrapper.DefineVar('VK_RETURN', VK_RETURN);
  APyDelphiWrapper.DefineVar('VK_SHIFT', VK_SHIFT);
  APyDelphiWrapper.DefineVar('VK_CONTROL', VK_CONTROL);
  APyDelphiWrapper.DefineVar('VK_MENU', VK_MENU);
  APyDelphiWrapper.DefineVar('VK_PAUSE', VK_PAUSE);
  APyDelphiWrapper.DefineVar('VK_CAPITAL', VK_CAPITAL);
  APyDelphiWrapper.DefineVar('VK_KANA', VK_KANA);
  APyDelphiWrapper.DefineVar('VK_HANGUL', VK_HANGUL);
  APyDelphiWrapper.DefineVar('VK_JUNJA', VK_JUNJA);
  APyDelphiWrapper.DefineVar('VK_FINAL', VK_FINAL);
  APyDelphiWrapper.DefineVar('VK_HANJA', VK_HANJA);
  APyDelphiWrapper.DefineVar('VK_KANJI', VK_KANJI);
  APyDelphiWrapper.DefineVar('VK_CONVERT', VK_CONVERT);
  APyDelphiWrapper.DefineVar('VK_NONCONVERT', VK_NONCONVERT);
  APyDelphiWrapper.DefineVar('VK_ACCEPT', VK_ACCEPT);
  APyDelphiWrapper.DefineVar('VK_MODECHANGE', VK_MODECHANGE);
  APyDelphiWrapper.DefineVar('VK_ESCAPE', VK_ESCAPE);
  APyDelphiWrapper.DefineVar('VK_SPACE', VK_SPACE);
  APyDelphiWrapper.DefineVar('VK_PRIOR', VK_PRIOR);
  APyDelphiWrapper.DefineVar('VK_NEXT', VK_NEXT);
  APyDelphiWrapper.DefineVar('VK_END', VK_END);
  APyDelphiWrapper.DefineVar('VK_HOME', VK_HOME);
  APyDelphiWrapper.DefineVar('VK_LEFT', VK_LEFT);
  APyDelphiWrapper.DefineVar('VK_UP', VK_UP);
  APyDelphiWrapper.DefineVar('VK_RIGHT', VK_RIGHT);
  APyDelphiWrapper.DefineVar('VK_DOWN', VK_DOWN);
  APyDelphiWrapper.DefineVar('VK_SELECT', VK_SELECT);
  APyDelphiWrapper.DefineVar('VK_PRINT', VK_PRINT);
  APyDelphiWrapper.DefineVar('VK_EXECUTE', VK_EXECUTE);
  APyDelphiWrapper.DefineVar('VK_SNAPSHOT', VK_SNAPSHOT);
  APyDelphiWrapper.DefineVar('VK_INSERT', VK_INSERT);
  APyDelphiWrapper.DefineVar('VK_DELETE', VK_DELETE);
  APyDelphiWrapper.DefineVar('VK_HELP', VK_HELP);
{ VK_0 thru VK_9 are the same as ASCII '0' thru '9' ($30 - $39) }
{ VK_A thru VK_Z are the same as ASCII 'A' thru 'Z' ($41 - $5A) }
  APyDelphiWrapper.DefineVar('VK_LWIN', VK_LWIN);
  APyDelphiWrapper.DefineVar('VK_RWIN', VK_RWIN);
  APyDelphiWrapper.DefineVar('VK_APPS', VK_APPS);
  APyDelphiWrapper.DefineVar('VK_SLEEP', VK_SLEEP);
  APyDelphiWrapper.DefineVar('VK_NUMPAD0', VK_NUMPAD0);
  APyDelphiWrapper.DefineVar('VK_NUMPAD1', VK_NUMPAD1);
  APyDelphiWrapper.DefineVar('VK_NUMPAD2', VK_NUMPAD2);
  APyDelphiWrapper.DefineVar('VK_NUMPAD3', VK_NUMPAD3);
  APyDelphiWrapper.DefineVar('VK_NUMPAD4', VK_NUMPAD4);
  APyDelphiWrapper.DefineVar('VK_NUMPAD5', VK_NUMPAD5);
  APyDelphiWrapper.DefineVar('VK_NUMPAD6', VK_NUMPAD6);
  APyDelphiWrapper.DefineVar('VK_NUMPAD7', VK_NUMPAD7);
  APyDelphiWrapper.DefineVar('VK_NUMPAD8', VK_NUMPAD8);
  APyDelphiWrapper.DefineVar('VK_NUMPAD9', VK_NUMPAD9);
  APyDelphiWrapper.DefineVar('VK_MULTIPLY', VK_MULTIPLY);
  APyDelphiWrapper.DefineVar('VK_ADD', VK_ADD);
  APyDelphiWrapper.DefineVar('VK_SEPARATOR', VK_SEPARATOR);
  APyDelphiWrapper.DefineVar('VK_SUBTRACT', VK_SUBTRACT);
  APyDelphiWrapper.DefineVar('VK_DECIMAL', VK_DECIMAL);
  APyDelphiWrapper.DefineVar('VK_DIVIDE', VK_DIVIDE);
  APyDelphiWrapper.DefineVar('VK_F1', VK_F1);
  APyDelphiWrapper.DefineVar('VK_F2', VK_F2);
  APyDelphiWrapper.DefineVar('VK_F3', VK_F3);
  APyDelphiWrapper.DefineVar('VK_F4', VK_F4);
  APyDelphiWrapper.DefineVar('VK_F5', VK_F5);
  APyDelphiWrapper.DefineVar('VK_F6', VK_F6);
  APyDelphiWrapper.DefineVar('VK_F7', VK_F7);
  APyDelphiWrapper.DefineVar('VK_F8', VK_F8);
  APyDelphiWrapper.DefineVar('VK_F9', VK_F9);
  APyDelphiWrapper.DefineVar('VK_F10', VK_F10);
  APyDelphiWrapper.DefineVar('VK_F11', VK_F11);
  APyDelphiWrapper.DefineVar('VK_F12', VK_F12);
  APyDelphiWrapper.DefineVar('VK_F13', VK_F13);
  APyDelphiWrapper.DefineVar('VK_F14', VK_F14);
  APyDelphiWrapper.DefineVar('VK_F15', VK_F15);
  APyDelphiWrapper.DefineVar('VK_F16', VK_F16);
  APyDelphiWrapper.DefineVar('VK_F17', VK_F17);
  APyDelphiWrapper.DefineVar('VK_F18', VK_F18);
  APyDelphiWrapper.DefineVar('VK_F19', VK_F19);
  APyDelphiWrapper.DefineVar('VK_F20', VK_F20);
  APyDelphiWrapper.DefineVar('VK_F21', VK_F21);
  APyDelphiWrapper.DefineVar('VK_F22', VK_F22);
  APyDelphiWrapper.DefineVar('VK_F23', VK_F23);
  APyDelphiWrapper.DefineVar('VK_F24', VK_F24);
  APyDelphiWrapper.DefineVar('VK_SCROLL', VK_SCROLL);
  APyDelphiWrapper.DefineVar('VK_LSHIFT', VK_LSHIFT);
  APyDelphiWrapper.DefineVar('VK_RSHIFT', VK_RSHIFT);
  APyDelphiWrapper.DefineVar('VK_LCONTROL', VK_LCONTROL);
  APyDelphiWrapper.DefineVar('VK_RCONTROL', VK_RCONTROL);
  APyDelphiWrapper.DefineVar('VK_LMENU', VK_LMENU);
  APyDelphiWrapper.DefineVar('VK_RMENU', VK_RMENU);
  APyDelphiWrapper.DefineVar('VK_BROWSER_BACK', VK_BROWSER_BACK);
  APyDelphiWrapper.DefineVar('VK_BROWSER_FORWARD', VK_BROWSER_FORWARD);
  APyDelphiWrapper.DefineVar('VK_BROWSER_REFRESH', VK_BROWSER_REFRESH);
  APyDelphiWrapper.DefineVar('VK_BROWSER_STOP', VK_BROWSER_STOP);
  APyDelphiWrapper.DefineVar('VK_BROWSER_SEARCH', VK_BROWSER_SEARCH);
  APyDelphiWrapper.DefineVar('VK_BROWSER_FAVORITES', VK_BROWSER_FAVORITES);
  APyDelphiWrapper.DefineVar('VK_BROWSER_HOME', VK_BROWSER_HOME);
  APyDelphiWrapper.DefineVar('VK_VOLUME_MUTE', VK_VOLUME_MUTE);
  APyDelphiWrapper.DefineVar('VK_VOLUME_DOWN', VK_VOLUME_DOWN);
  APyDelphiWrapper.DefineVar('VK_VOLUME_UP', VK_VOLUME_UP);
  APyDelphiWrapper.DefineVar('VK_MEDIA_NEXT_TRACK', VK_MEDIA_NEXT_TRACK);
  APyDelphiWrapper.DefineVar('VK_MEDIA_PREV_TRACK', VK_MEDIA_PREV_TRACK);
  APyDelphiWrapper.DefineVar('VK_MEDIA_STOP', VK_MEDIA_STOP);
  APyDelphiWrapper.DefineVar('VK_MEDIA_PLAY_PAUSE', VK_MEDIA_PLAY_PAUSE);
  APyDelphiWrapper.DefineVar('VK_LAUNCH_MAIL', VK_LAUNCH_MAIL);
  APyDelphiWrapper.DefineVar('VK_LAUNCH_MEDIA_SELECT', VK_LAUNCH_MEDIA_SELECT);
  APyDelphiWrapper.DefineVar('VK_LAUNCH_APP1', VK_LAUNCH_APP1);
  APyDelphiWrapper.DefineVar('VK_LAUNCH_APP2', VK_LAUNCH_APP2);
  APyDelphiWrapper.DefineVar('VK_OEM_1', VK_OEM_1);
  APyDelphiWrapper.DefineVar('VK_OEM_PLUS', VK_OEM_PLUS);
  APyDelphiWrapper.DefineVar('VK_OEM_COMMA', VK_OEM_COMMA);
  APyDelphiWrapper.DefineVar('VK_OEM_MINUS', VK_OEM_MINUS);
  APyDelphiWrapper.DefineVar('VK_OEM_PERIOD', VK_OEM_PERIOD);
  APyDelphiWrapper.DefineVar('VK_OEM_2', VK_OEM_2);
  APyDelphiWrapper.DefineVar('VK_OEM_3', VK_OEM_3);
  APyDelphiWrapper.DefineVar('VK_OEM_4', VK_OEM_4);
  APyDelphiWrapper.DefineVar('VK_OEM_5', VK_OEM_5);
  APyDelphiWrapper.DefineVar('VK_OEM_6', VK_OEM_6);
  APyDelphiWrapper.DefineVar('VK_OEM_7', VK_OEM_7);
  APyDelphiWrapper.DefineVar('VK_OEM_8', VK_OEM_8);
  APyDelphiWrapper.DefineVar('VK_OEM_102', VK_OEM_102);
  APyDelphiWrapper.DefineVar('VK_PACKET', VK_PACKET);
  APyDelphiWrapper.DefineVar('VK_PROCESSKEY', VK_PROCESSKEY);
  APyDelphiWrapper.DefineVar('VK_ATTN', VK_ATTN);
  APyDelphiWrapper.DefineVar('VK_CRSEL', VK_CRSEL);
  APyDelphiWrapper.DefineVar('VK_EXSEL', VK_EXSEL);
  APyDelphiWrapper.DefineVar('VK_EREOF', VK_EREOF);
  APyDelphiWrapper.DefineVar('VK_PLAY', VK_PLAY);
  APyDelphiWrapper.DefineVar('VK_ZOOM', VK_ZOOM);
  APyDelphiWrapper.DefineVar('VK_NONAME', VK_NONAME);
  APyDelphiWrapper.DefineVar('VK_PA1', VK_PA1);
  APyDelphiWrapper.DefineVar('VK_OEM_CLEAR', VK_OEM_CLEAR);
end;

procedure TWindowsRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  {$IFDEF DELPHI11_OR_HIGHER}
  APyDelphiWrapper.RegisterFunction(PAnsiChar('IsDpiAware'),
    TWindowsRegistration.IsDpiAware_Wrapper,
    PAnsiChar('IsDPIAware()'#10 +
    'Check for process DPI awareness.'));

  APyDelphiWrapper.RegisterFunction(PAnsiChar('SetHighDpiAware'),
    TWindowsRegistration.SetHighDpiAware_Wrapper,
    PAnsiChar('SetHighDpiAware()'#10 +
    'Automatically set the DPI awareness that best fits to the process.'));

  APyDelphiWrapper.RegisterFunction(PAnsiChar('GetProcessDpiAwareness'),
    TWindowsRegistration.GetProcessDpiAwareness_Wrapper,
    PAnsiChar('GetProcessDpiAwareness()'#10 +
    'Get the DPI awareness of the process.'));

  APyDelphiWrapper.RegisterFunction(PAnsiChar('SetProcessDpiAwareness'),
    TWindowsRegistration.SetProcessDpiAwareness_Wrapper,
    PAnsiChar('SetProcessDpiAwareness()'#10 +
    'Set the DPI awareness to the process.'));
  {$ENDIF DELPHI11_OR_HIGHER}
end;

procedure TWindowsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

{$IFDEF DELPHI11_OR_HIGHER}
class function TWindowsRegistration.IsDpiAware_Wrapper(PySelf, AArgs: PPyObject): PPyObject;
begin
  with GetPythonEngine() do
  begin
    if IsDpiAware() then
      Result := GetPythonEngine().ReturnTrue()
    else
      Result := GetPythonEngine().ReturnFalse();
  end;
end;

class function TWindowsRegistration.SetHighDpiAware_Wrapper(PySelf, AArgs: PPyObject): PPyObject;
begin
  with GetPythonEngine() do
  begin
    if SetHighDpiAware() then
      Result := GetPythonEngine().ReturnTrue()
    else
      Result := GetPythonEngine().ReturnFalse();
  end;
end;

class function TWindowsRegistration.GetProcessDpiAwareness_Wrapper(PySelf,
  AArgs: PPyObject): PPyObject;
var
  LErrorCode: HResult;
  LDpiAwareness: TProcessDpiAwareness;
begin
  with GetPythonEngine() do
  begin
    if (PyArg_ParseTuple(AArgs, ':GetProcessDpiAwareness') <> 0) then
    begin
      LErrorCode :=  WinAPI.ShellScaling.GetProcessDpiAwareness(GetCurrentProcess(), LDpiAwareness);

      Result := PyList_New(0);
      PyList_Append(Result, PyLong_FromLong(LErrorCode));
      PyList_Append(Result, PyLong_FromLong(Ord(LDpiAwareness)));
    end else
      Result := nil;
  end;
end;

class function TWindowsRegistration.SetProcessDpiAwareness_Wrapper(PySelf,
  AArgs: PPyObject): PPyObject;
var
  LErrorCode: HResult;
  LDpiAwareness: integer;
begin
  with GetPythonEngine() do
  begin
    if (PyArg_ParseTuple(AArgs, 'i:SetProcessDpiAwareness', @LDpiAwareness) <> 0) then
    begin
      if not (LDpiAwareness in [
        Ord(Low(TProcessDpiAwareness))
        ..
        Ord(High(TProcessDpiAwareness))]) then
      begin
        PyErr_SetString(PyExc_ValueError^, 'DPI awareness value out of range');
        Result := nil;
      end else begin
        LErrorCode :=  WinAPI.ShellScaling.SetProcessDpiAwareness(TProcessDpiAwareness(LDpiAwareness));
        Result := PyLong_FromLong(LErrorCode);
      end;
    end else
      Result := nil;
  end;
end;
{$ENDIF DELPHI11_OR_HIGHER}

initialization
  RegisteredUnits.Add(TWindowsRegistration.Create);

  {$IFDEF DELPHI11_OR_HIGHER}
  SetHighDpiAware();
  {$ENDIF DELPHI11_OR_HIGHER}

{$ENDIF MSWINDOWS}

end.

