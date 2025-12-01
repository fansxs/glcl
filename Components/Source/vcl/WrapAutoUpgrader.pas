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

unit WrapAutoUpgrader;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
    auHTTP, auAutoUpgrader, auThread;

type
  TPyDelphiauAutoUpgrader = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TauAutoUpgrader;
    procedure SetDelphiObject(const Value: TauAutoUpgrader);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TauAutoUpgrader read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiauHTTP = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TauHTTP;
    procedure SetDelphiObject(const Value: TauHTTP);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TauHTTP read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiauThread = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TauThread;
    procedure SetDelphiObject(const Value: TauThread);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TauThread read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TAutoUpgraderRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TAutoUpgraderRegistration }
procedure TAutoUpgraderRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TAutoUpgraderRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TAutoUpgraderRegistration.Name: string;
begin
  Result := 'AutoUpgrader';
end;

procedure TAutoUpgraderRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiauAutoUpgrader);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiauHTTP);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiauThread);
end;

{ TPyDelphiauAutoUpgrader }

class function TPyDelphiauAutoUpgrader.DelphiObjectClass: TClass;
begin
  Result := TauAutoUpgrader;
end;

function TPyDelphiauAutoUpgrader.GetDelphiObject: TauAutoUpgrader;
begin
  Result := TauAutoUpgrader(inherited DelphiObject);
end;

procedure TPyDelphiauAutoUpgrader.SetDelphiObject(const Value: TauAutoUpgrader);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiauHTTP }

class function TPyDelphiauHTTP.DelphiObjectClass: TClass;
begin
  Result := TauHTTP;
end;

function TPyDelphiauHTTP.GetDelphiObject: TauHTTP;
begin
  Result := TauHTTP(inherited DelphiObject);
end;

procedure TPyDelphiauHTTP.SetDelphiObject(const Value: TauHTTP);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiauThread }

class function TPyDelphiauThread.DelphiObjectClass: TClass;
begin
  Result := TauThread;
end;

function TPyDelphiauThread.GetDelphiObject: TauThread;
begin
  Result := TauThread(inherited DelphiObject);
end;

procedure TPyDelphiauThread.SetDelphiObject(const Value: TauThread);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TAutoUpgraderRegistration.Create);

end.
