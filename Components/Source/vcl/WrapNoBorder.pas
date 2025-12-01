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

unit WrapNoBorder;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
    Upgrader, NoBorderForm, Ysizer, WrapVclControls;

type
  TPyDelphiNoBorderForm = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TNoBorderForm;
    procedure SetDelphiObject(const Value: TNoBorderForm);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TNoBorderForm read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiYSizer = class(TPyDelphiGraphicControl)
  private
    function GetDelphiObject: TYSizer;
    procedure SetDelphiObject(const Value: TYSizer);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TYSizer read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TNoBorderRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TNoBorderRegistration }
procedure TNoBorderRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TNoBorderRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TNoBorderRegistration.Name: string;
begin
  Result := 'NoBorder';
end;

procedure TNoBorderRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiNoBorderForm);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiYSizer);
end;

{ TPyDelphiNoBorderForm }

class function TPyDelphiNoBorderForm.DelphiObjectClass: TClass;
begin
  Result := TNoBorderForm;
end;

function TPyDelphiNoBorderForm.GetDelphiObject: TNoBorderForm;
begin
  Result := TNoBorderForm(inherited DelphiObject);
end;

procedure TPyDelphiNoBorderForm.SetDelphiObject(const Value: TNoBorderForm);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiYSizer }

class function TPyDelphiYSizer.DelphiObjectClass: TClass;
begin
  Result := TYSizer;
end;

function TPyDelphiYSizer.GetDelphiObject: TYSizer;
begin
  Result := TYSizer(inherited DelphiObject);
end;

procedure TPyDelphiYSizer.SetDelphiObject(const Value: TYSizer);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TNoBorderRegistration.Create);

end.
