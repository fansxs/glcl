(**************************************************************************)
(*  This unit is part of the Python for Delphi (P4D) library              *)
(*  Project home: https://github.com/pyscripter/python4delphi             *)
(*                                                                        *)
(*  Project Maintainer:  PyScripter (pyscripter@gmail.com)                *)
(*  Original Authors:    Dr. Dietmar Budelsky (dbudelsky@web.de)          *)
(*                       Morgan Martinet (https://github.com/mmm-experts) *)
(*  Core developer:      Lucas Belo (lucas.belo@live.com)                 *)
(*  Core developer:      fansxs (admin@gliste.com)                        *)
(*  Contributors:        See contributors.md at project home              *)
(*                                                                        *)
(*  LICENCE and Copyright: MIT (see project home)                         *)
(**************************************************************************)

{$I ..\Definition.Inc}

unit WrapPJDropFiles;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  PJDropFiles, WrapVclControls;

type
  TPyDelphiPJDropFiles = class(TPyDelphiWinControl)
  private
    function GetDelphiObject: TPJDropFiles;
    procedure SetDelphiObject(const Value: TPJDropFiles);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPJDropFiles read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiPJFormDropFiles = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TPJFormDropFiles;
    procedure SetDelphiObject(const Value: TPJFormDropFiles);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPJFormDropFiles read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiPJCtrlDropFiles = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TPJCtrlDropFiles;
    procedure SetDelphiObject(const Value: TPJCtrlDropFiles);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPJCtrlDropFiles read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiPJExtFileFilter = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TPJExtFileFilter;
    procedure SetDelphiObject(const Value: TPJExtFileFilter);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPJExtFileFilter read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiPJWildCardFileFilter = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TPJWildCardFileFilter;
    procedure SetDelphiObject(const Value: TPJWildCardFileFilter);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPJWildCardFileFilter read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TPJDropFilesRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TPJDropFilesRegistration }
procedure TPJDropFilesRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TPJDropFilesRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('dfoIncFolders', 'dfoIncFolders');
  APyDelphiWrapper.DefineVar('dfoIncFiles', 'dfoIncFiles');
  APyDelphiWrapper.DefineVar('dfoRecurseFolders', 'dfoRecurseFolders');

  APyDelphiWrapper.DefineVar('fsFilterFilesOnly', 'fsFilterFilesOnly');
  APyDelphiWrapper.DefineVar('fsFilterFoldersOnly', 'fsFilterFoldersOnly');
  APyDelphiWrapper.DefineVar('fsAll', 'fsAll');
end;

function TPJDropFilesRegistration.Name: string;
begin
  Result := 'PJDropFiles';
end;

procedure TPJDropFilesRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPJDropFiles);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPJFormDropFiles);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPJCtrlDropFiles);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPJExtFileFilter);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPJWildCardFileFilter);
end;

{ TPyDelphiPJDropFiles }

class function TPyDelphiPJDropFiles.DelphiObjectClass: TClass;
begin
  Result := TPJDropFiles;
end;

function TPyDelphiPJDropFiles.GetDelphiObject: TPJDropFiles;
begin
  Result := TPJDropFiles(inherited DelphiObject);
end;

procedure TPyDelphiPJDropFiles.SetDelphiObject(const Value: TPJDropFiles);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPJFormDropFiles }

class function TPyDelphiPJFormDropFiles.DelphiObjectClass: TClass;
begin
  Result := TPJFormDropFiles;
end;

function TPyDelphiPJFormDropFiles.GetDelphiObject: TPJFormDropFiles;
begin
  Result := TPJFormDropFiles(inherited DelphiObject);
end;

procedure TPyDelphiPJFormDropFiles.SetDelphiObject(const Value: TPJFormDropFiles);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPJCtrlDropFiles }

class function TPyDelphiPJCtrlDropFiles.DelphiObjectClass: TClass;
begin
  Result := TPJCtrlDropFiles;
end;

function TPyDelphiPJCtrlDropFiles.GetDelphiObject: TPJCtrlDropFiles;
begin
  Result := TPJCtrlDropFiles(inherited DelphiObject);
end;

procedure TPyDelphiPJCtrlDropFiles.SetDelphiObject(const Value: TPJCtrlDropFiles);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPJExtFileFilter }

class function TPyDelphiPJExtFileFilter.DelphiObjectClass: TClass;
begin
  Result := TPJExtFileFilter;
end;

function TPyDelphiPJExtFileFilter.GetDelphiObject: TPJExtFileFilter;
begin
  Result := TPJExtFileFilter(inherited DelphiObject);
end;

procedure TPyDelphiPJExtFileFilter.SetDelphiObject(const Value: TPJExtFileFilter);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPJWildCardFileFilter }

class function TPyDelphiPJWildCardFileFilter.DelphiObjectClass: TClass;
begin
  Result := TPJWildCardFileFilter;
end;

function TPyDelphiPJWildCardFileFilter.GetDelphiObject: TPJWildCardFileFilter;
begin
  Result := TPJWildCardFileFilter(inherited DelphiObject);
end;

procedure TPyDelphiPJWildCardFileFilter.SetDelphiObject(const Value: TPJWildCardFileFilter);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TPJDropFilesRegistration.Create);

end.
