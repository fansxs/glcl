
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

unit WrapVclSamplesCalendar;

interface

uses
  Classes, WrapDelphi, WrapVclGrids, Vcl.Samples.Calendar;

type

  TPyDelphiCalendar = class(TPyDelphiCustomGrid)
  private
    function GetDelphiObject: TCalendar;
    procedure SetDelphiObject(const Value: TCalendar);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCalendar read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TCalendarRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TCalendarRegistration }

procedure TCalendarRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TCalendarRegistration.Name: string;
begin
  Result := 'Samples.Calendar';
end;

procedure TCalendarRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCalendar);
end;

{ TPyDelphiCalendar }

class function TPyDelphiCalendar.DelphiObjectClass: TClass;
begin
  Result := TCalendar;
end;

function TPyDelphiCalendar.GetDelphiObject: TCalendar;
begin
  Result := TCalendar(inherited DelphiObject);
end;

procedure TPyDelphiCalendar.SetDelphiObject(const Value: TCalendar);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TCalendarRegistration.Create );
  Classes.RegisterClasses([TCalendar]);
end.
