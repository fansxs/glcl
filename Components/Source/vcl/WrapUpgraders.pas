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

unit WrapUpgraders;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses, Upgrader;

type
  TPyDelphiUpgrader = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TUpgrader;
    procedure SetDelphiObject(const Value: TUpgrader);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TUpgrader read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TUpgradersRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TUpgradersRegistration }
procedure TUpgradersRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TUpgradersRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('vpByDateTime', 'vpByDateTime');
  APyDelphiWrapper.DefineVar('vpByNumber', 'vpByNumber');
end;

function TUpgradersRegistration.Name: string;
begin
  Result := 'Upgrader';
end;

procedure TUpgradersRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiUpgrader);
end;

{ TPyDelphiUpgrader }

class function TPyDelphiUpgrader.DelphiObjectClass: TClass;
begin
  Result := TUpgrader;
end;

function TPyDelphiUpgrader.GetDelphiObject: TUpgrader;
begin
  Result := TUpgrader(inherited DelphiObject);
end;

procedure TPyDelphiUpgrader.SetDelphiObject(const Value: TUpgrader);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TUpgradersRegistration.Create);

end.
