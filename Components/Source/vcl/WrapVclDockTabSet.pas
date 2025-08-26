
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

unit WrapVclDockTabSet;

interface

uses
  Classes, WrapDelphi, WrapDelphiClasses, WrapVclControls, Vcl.DockTabSet,
  WrapVclTabs;

type

  TPyDelphiDockTabSet = class (TPyDelphiTabSet)
  private
    function  GetDelphiObject: TDockTabSet;
    procedure SetDelphiObject(const Value: TDockTabSet);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TDockTabSet read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TDockTabSetRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TDockTabSetRegistration }

procedure TDockTabSetRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TDockTabSetRegistration.Name: string;
begin
  Result := 'Additional.DockTabSet';
end;

procedure TDockTabSetRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDockTabSet);
end;

{ TPyDelphiDockTabSet }

class function TPyDelphiDockTabSet.DelphiObjectClass: TClass;
begin
  Result := TDockTabSet;
end;

function TPyDelphiDockTabSet.GetDelphiObject: TDockTabSet;
begin
  Result := TDockTabSet(inherited DelphiObject);
end;

procedure TPyDelphiDockTabSet.SetDelphiObject(const Value: TDockTabSet);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TDockTabSetRegistration.Create );
  Classes.RegisterClasses([TDockTabSet]);
end.
