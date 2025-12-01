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

unit WrapPicShow;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses, PicShow,
  WrapVclControls;

type
  TPyDelphiCustomPicShow = class(TPyDelphiCustomControl)
  private
    function GetDelphiObject: TCustomPicShow;
    procedure SetDelphiObject(const Value: TCustomPicShow);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCustomPicShow read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiPicShow = class(TPyDelphiCustomPicShow)
  private
    function GetDelphiObject: TPicShow;
    procedure SetDelphiObject(const Value: TPicShow);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPicShow read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiDBPicShow = class(TPyDelphiCustomPicShow)
  private
    function GetDelphiObject: TDBPicShow;
    procedure SetDelphiObject(const Value: TDBPicShow);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TDBPicShow read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TPicShowRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TPicShowRegistration }
procedure TPicShowRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TPicShowRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('bmNone', 'bmNone');
  APyDelphiWrapper.DefineVar('bmTiled', 'bmTiled');
  APyDelphiWrapper.DefineVar('bmStretched', 'bmStretched');
  APyDelphiWrapper.DefineVar('bmCentered', 'bmCentered');
end;

function TPicShowRegistration.Name: string;
begin
  Result := 'PicShow';
end;

procedure TPicShowRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomPicShow);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPicShow);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDBPicShow);
end;

{ TPyDelphiCustomPicShow }

class function TPyDelphiCustomPicShow.DelphiObjectClass: TClass;
begin
  Result := TCustomPicShow;
end;

function TPyDelphiCustomPicShow.GetDelphiObject: TCustomPicShow;
begin
  Result := TCustomPicShow(inherited DelphiObject);
end;

procedure TPyDelphiCustomPicShow.SetDelphiObject(const Value: TCustomPicShow);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPicShow }

class function TPyDelphiPicShow.DelphiObjectClass: TClass;
begin
  Result := TPicShow;
end;

function TPyDelphiPicShow.GetDelphiObject: TPicShow;
begin
  Result := TPicShow(inherited DelphiObject);
end;

procedure TPyDelphiPicShow.SetDelphiObject(const Value: TPicShow);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiDBPicShow }

class function TPyDelphiDBPicShow.DelphiObjectClass: TClass;
begin
  Result := TDBPicShow;
end;

function TPyDelphiDBPicShow.GetDelphiObject: TDBPicShow;
begin
  Result := TDBPicShow(inherited DelphiObject);
end;

procedure TPyDelphiDBPicShow.SetDelphiObject(const Value: TDBPicShow);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TPicShowRegistration.Create);

end.
