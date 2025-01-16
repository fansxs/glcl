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

unit WrapVclWinXCalendars;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.WinXCalendars;

type

  TPyDelphiCustomCalendarView = class(TPyDelphiCustomControl)
  private
    function GetDelphiObject: TCustomCalendarView;
    procedure SetDelphiObject(const Value: TCustomCalendarView);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomCalendarView read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCalendarView = class(TPyDelphiCustomCalendarView)
  private
    function GetDelphiObject: TCalendarView;
    procedure SetDelphiObject(const Value: TCalendarView);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCalendarView read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomCalendarPicker = class(TPyDelphiCustomControl)
  private
    function GetDelphiObject: TCustomCalendarPicker;
    procedure SetDelphiObject(const Value: TCustomCalendarPicker);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomCalendarPicker read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCalendarPicker = class(TPyDelphiCustomCalendarPicker)
  private
    function GetDelphiObject: TCalendarPicker;
    procedure SetDelphiObject(const Value: TCalendarPicker);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCalendarPicker read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TWinXCalendarsRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TWinXCalendarsRegistration }

procedure TWinXCalendarsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TWinXCalendarsRegistration.Name: string;
begin
  Result := 'Win10.WinXCalendars';
end;

procedure TWinXCalendarsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomCalendarView);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCalendarView);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomCalendarPicker);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCalendarPicker);
end;

{ TPyDelphiCustomCalendarView }

class function TPyDelphiCustomCalendarView.DelphiObjectClass: TClass;
begin
  Result := TCustomCalendarView;
end;

function TPyDelphiCustomCalendarView.GetDelphiObject: TCustomCalendarView;
begin
  Result := TCustomCalendarView(inherited DelphiObject);
end;

procedure TPyDelphiCustomCalendarView.SetDelphiObject(const Value: TCustomCalendarView);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCalendarView }

class function TPyDelphiCalendarView.DelphiObjectClass: TClass;
begin
  Result := TCalendarView;
end;

function TPyDelphiCalendarView.GetDelphiObject: TCalendarView;
begin
  Result := TCalendarView(inherited DelphiObject);
end;

procedure TPyDelphiCalendarView.SetDelphiObject(const Value: TCalendarView);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomCalendarPicker }

class function TPyDelphiCustomCalendarPicker.DelphiObjectClass: TClass;
begin
  Result := TCustomCalendarPicker;
end;

function TPyDelphiCustomCalendarPicker.GetDelphiObject: TCustomCalendarPicker;
begin
  Result := TCustomCalendarPicker(inherited DelphiObject);
end;

procedure TPyDelphiCustomCalendarPicker.SetDelphiObject(const Value: TCustomCalendarPicker);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCalendarPicker }

class function TPyDelphiCalendarPicker.DelphiObjectClass: TClass;
begin
  Result := TCalendarPicker;
end;

function TPyDelphiCalendarPicker.GetDelphiObject: TCalendarPicker;
begin
  Result := TCalendarPicker(inherited DelphiObject);
end;

procedure TPyDelphiCalendarPicker.SetDelphiObject(const Value: TCalendarPicker);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TWinXCalendarsRegistration.Create );
  Classes.RegisterClasses([TCalendarView, TCalendarPicker]);
end.
