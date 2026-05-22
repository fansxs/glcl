(**************************************************************************)
(*  This unit is part of the Python for Delphi (P4D) library              *)
(*  Project home: https://github.com/pyscripter/python4delphi             *)
(*                                                                        *)
(*  Project Maintainer:  PyScripter (pyscripter@gmail.com)                *)
(*  Original Authors:    Dr. Dietmar Budelsky (dbudelsky@web.de)          *)
(*                       Morgan Martinet (https://github.com/mmm-experts) *)
(*  Core developer:      Lucas Belo (lucas.belo@live.com)                 *)
(*  Core developer:      fansxs (admin@glsite.com)                        *)
(*  Contributors:        See contributors.md at project home              *)
(*                                                                        *)
(*  LICENCE and Copyright: MIT (see project home)                         *)
(**************************************************************************)

{$I ..\Definition.Inc}

unit WrapCharts;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  WrapVclExtCtrls, NiceChart, StockChart, WrapVclControls;

type
  TPyDelphiNiceChart = class(TPyDelphiCustomPanel)
  private
    function GetDelphiObject: TNiceChart;
    procedure SetDelphiObject(const Value: TNiceChart);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TNiceChart read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiStockChart = class(TPyDelphiCustomControl)
  private
    function GetDelphiObject: TStockChart;
    procedure SetDelphiObject(const Value: TStockChart);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TStockChart read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TChartsRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TChartsRegistration }
procedure TChartsRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TChartsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('skLine', 'skLine');
  APyDelphiWrapper.DefineVar('skSmooth', 'skSmooth');
  APyDelphiWrapper.DefineVar('skBar', 'skBar');
  APyDelphiWrapper.DefineVar('psCeil', 'psCeil');
  APyDelphiWrapper.DefineVar('psUp', 'psUp');
  APyDelphiWrapper.DefineVar('psEven', 'psEven');
  APyDelphiWrapper.DefineVar('psDown', 'psDown');
  APyDelphiWrapper.DefineVar('psFloor', 'psFloor');
  APyDelphiWrapper.DefineVar('psNonTrade', 'psNonTrade');
end;

function TChartsRegistration.Name: string;
begin
  Result := 'Charts';
end;

procedure TChartsRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiNiceChart);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiStockChart);
end;

{ TPyDelphiNiceChart }

class function TPyDelphiNiceChart.DelphiObjectClass: TClass;
begin
  Result := TNiceChart;
end;

function TPyDelphiNiceChart.GetDelphiObject: TNiceChart;
begin
  Result := TNiceChart(inherited DelphiObject);
end;

procedure TPyDelphiNiceChart.SetDelphiObject(const Value: TNiceChart);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiStockChart }

class function TPyDelphiStockChart.DelphiObjectClass: TClass;
begin
  Result := TStockChart;
end;

function TPyDelphiStockChart.GetDelphiObject: TStockChart;
begin
  Result := TStockChart(inherited DelphiObject);
end;

procedure TPyDelphiStockChart.SetDelphiObject(const Value: TStockChart);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TChartsRegistration.Create);

end.
