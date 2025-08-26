
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

unit WrapVclSamplesColorGrid;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.ColorGrd;

type

  TPyDelphiColorGrid = class(TPyDelphiCustomControl)
  private
    function GetDelphiObject: TColorGrid;
    procedure SetDelphiObject(const Value: TColorGrid);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TColorGrid read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TColorGridRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TColorGridRegistration }

procedure TColorGridRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('go16x1', 'go16x1');
  APyDelphiWrapper.DefineVar('go8x2', 'go8x2');
  APyDelphiWrapper.DefineVar('go4x4', 'go4x4');
  APyDelphiWrapper.DefineVar('go2x8', 'go2x8');
  APyDelphiWrapper.DefineVar('go1x16', 'go1x16');
end;

function TColorGridRegistration.Name: string;
begin
  Result := 'Samples.ColorGrid';
end;

procedure TColorGridRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiColorGrid);
end;

{ TPyDelphiColorGrid }

class function TPyDelphiColorGrid.DelphiObjectClass: TClass;
begin
  Result := TColorGrid;
end;

function TPyDelphiColorGrid.GetDelphiObject: TColorGrid;
begin
  Result := TColorGrid(inherited DelphiObject);
end;

procedure TPyDelphiColorGrid.SetDelphiObject(const Value: TColorGrid);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TColorGridRegistration.Create );
  Classes.RegisterClasses([TColorGrid]);
end.
