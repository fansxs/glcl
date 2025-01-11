unit osSysPath;

interface

uses
  ShlObj,
  Windows,
  SysUtils,
  Registry;

type
  TSystemPath =
  (
    Desktop,
    StartMenu,
    Programs,
    Startup,
    Personal,
    AppData,
    Fonts,
    SendTo,
    Recent,
    Favorites,
    Cache,
    Cookies,
    History,
    NetHood,
    PrintHood,
    Templates,
    LocADat,
    WindRoot,
    WindSys,
    TempPath,
    RootDir,
    ProgFiles,
    ComFiles,
    ConfigPath,
    DevicePath,
    MediaPath,
    WallPaper
  );

function ExpandPathWithEnvironmentStrings(const Path: string): string;
function GetSpecialFolder(CSIDL: Integer): string;
function GetSystemPath(SystemPath: TSystemPath): string;

implementation

function ExpandPathWithEnvironmentStrings(const Path: string): string;
const
  MAXSIZE = 32768;
begin
  SetLength(Result, MAXSIZE);
  SetLength(Result, ExpandEnvironmentStrings(PChar(Path), @Result[1], Length(Result)) - 1);
end;

function GetSystemPath(SystemPath: TSystemPath): string;
var
  ph: PChar;
begin
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', True);
      case SystemPath of
        Desktop: Result   := ReadString('Desktop');
        StartMenu: Result := ReadString('Start Menu');
        Programs: Result  := ReadString('Programs');
        Startup: Result   := ReadString('Startup');
        Personal: Result  := ReadString('Personal');
        AppData: Result   := ReadString('AppData');
        Fonts: Result     := ReadString('Fonts');
        SendTo: Result    := ReadString('SendTo');
        Recent: Result    := ReadString('Recent');
        Favorites: Result := ReadString('Favorites');
        Cache: Result     := ReadString('Cache');
        Cookies: Result   := ReadString('Cookies');
        History: Result   := ReadString('History');
        NetHood: Result   := ReadString('NetHood');
        PrintHood: Result := ReadString('PrintHood');
        Templates: Result := ReadString('Templates');
        LocADat: Result   := ReadString('Local AppData');
        WindRoot:
          begin
            GetMem(ph, 255);
            GetWindowsDirectory(ph, 254);
            Result := Strpas(ph);
            Freemem(ph);
          end;
        WindSys:
          begin
            GetMem(ph, 255);
            GetSystemDirectory(ph, 254);
            Result := Strpas(ph);
            Freemem(ph);
          end;
        TempPath:
          begin
            GetMem(ph, 255);
            GetTempPath(254, ph);
            Result := Strpas(ph);
            Freemem(ph);
          end;
        RootDir:
          begin
            GetMem(ph, 255);
            GetSystemDirectory(ph, 254);
            Result := (Copy(Strpas(ph), 1, 2));
            Freemem(ph);
          end;
      end;
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion', True);
      case SystemPath of
        ProgFiles: Result := ReadString('ProgramFilesDir');
        ComFiles: Result := ReadString('CommonFilesDir');
        ConfigPath: Result := ReadString('ConfigPath');
        DevicePath: Result := ReadString('DevicePath');
        MediaPath: Result := ReadString('MediaPath');
        WallPaper: Result := ReadString('WallPaperDir');
      end;
    finally
      CloseKey;
      Free;
    end;
  if (Result <> '') and (Result[Length(Result)] <> '\') then
    Result := Result + '\';
end;

function GetSpecialFolder(CSIDL: Integer): string;
var
  Path: array [0..MAX_PATH - 1] of Char;
begin
  try
    if ShGetSpecialFolderPath(0, path, CSIDL, False) then
      Result := Path
    else
      Result := '';
  except
    Result := '';
  end;
end;

end.
