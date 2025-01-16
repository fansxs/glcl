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

unit WrapVclSamplesGauges;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.Samples.Gauges;

type

  TPyDelphiGauge = class(TPyDelphiGraphicControl)
  private
    function GetDelphiObject: TGauge;
    procedure SetDelphiObject(const Value: TGauge);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TGauge read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TGaugeRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TGaugeRegistration }

procedure TGaugeRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TGaugeRegistration.Name: string;
begin
  Result := 'Samples.Gauge';
end;

procedure TGaugeRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiGauge);
end;

{ TPyDelphiGauge }

class function TPyDelphiGauge.DelphiObjectClass: TClass;
begin
  Result := TGauge;
end;

function TPyDelphiGauge.GetDelphiObject: TGauge;
begin
  Result := TGauge(inherited DelphiObject);
end;

procedure TPyDelphiGauge.SetDelphiObject(const Value: TGauge);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TGaugeRegistration.Create );
  Classes.RegisterClasses([TGauge]);
end.
