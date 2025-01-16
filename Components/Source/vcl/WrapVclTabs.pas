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

unit WrapVclTabs;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.Tabs;

type
  TPyDelphiTabSet = class (TPyDelphiCustomControl)
  private
    function  GetDelphiObject: TTabSet;
    procedure SetDelphiObject(const Value: TTabSet);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TTabSet read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TTabSetRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TTabSetRegistration }

procedure TTabSetRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('epSelectedLeft', 'epSelectedLeft');
  APyDelphiWrapper.DefineVar('epUnselectedLeft', 'epUnselectedLeft');
  APyDelphiWrapper.DefineVar('epSelectedRight', 'epSelectedRight');
  APyDelphiWrapper.DefineVar('epUnselectedRight', 'epUnselectedRight');
  APyDelphiWrapper.DefineVar('etNone', 'etNone');
  APyDelphiWrapper.DefineVar('etFirstIsSel', 'etFirstIsSel');
  APyDelphiWrapper.DefineVar('etFirstNotSel', 'etFirstNotSel');
  APyDelphiWrapper.DefineVar('etLastIsSel', 'etLastIsSel');
  APyDelphiWrapper.DefineVar('etLastNotSel', 'etLastNotSel');
  APyDelphiWrapper.DefineVar('etNotSelToSel', 'etNotSelToSel');
  APyDelphiWrapper.DefineVar('etSelToNotSel', 'etSelToNotSel');
  APyDelphiWrapper.DefineVar('etNotSelToNotSel', 'etNotSelToNotSel');
  APyDelphiWrapper.DefineVar('tsStandard', 'tsStandard');
  APyDelphiWrapper.DefineVar('tsOwnerDraw', 'tsOwnerDraw');
  APyDelphiWrapper.DefineVar('tsSoftTabs', 'tsSoftTabs');
  APyDelphiWrapper.DefineVar('tsModernTabs', 'tsModernTabs');
  APyDelphiWrapper.DefineVar('tsModernPopout', 'tsModernPopout');
  APyDelphiWrapper.DefineVar('tsIDETabs', 'tsIDETabs');
end;

function TTabSetRegistration.Name: string;
begin
  Result := 'Additional.TabSet';
end;

procedure TTabSetRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTabSet);
end;

{ TPyDelphiTabSet }

class function TPyDelphiTabSet.DelphiObjectClass: TClass;
begin
  Result := TTabSet;
end;

function TPyDelphiTabSet.GetDelphiObject: TTabSet;
begin
  Result := TTabSet(inherited DelphiObject);
end;

procedure TPyDelphiTabSet.SetDelphiObject(const Value: TTabSet);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TTabSetRegistration.Create );
  Classes.RegisterClasses([TTabSet]);
end.
