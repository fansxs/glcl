
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

unit WrapVclWinXPickers;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.WinXPickers;

type

  TPyDelphiBasePickerControl = class(TPyDelphiCustomControl)
  private
    function GetDelphiObject: TBasePickerControl;
    procedure SetDelphiObject(const Value: TBasePickerControl);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TBasePickerControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomDatePicker = class(TPyDelphiBasePickerControl)
  private
    function GetDelphiObject: TCustomDatePicker;
    procedure SetDelphiObject(const Value: TCustomDatePicker);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomDatePicker read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiDatePicker = class(TPyDelphiCustomDatePicker)
  private
    function GetDelphiObject: TDatePicker;
    procedure SetDelphiObject(const Value: TDatePicker);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TDatePicker read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomTimePicker = class(TPyDelphiBasePickerControl)
  private
    function GetDelphiObject: TCustomTimePicker;
    procedure SetDelphiObject(const Value: TCustomTimePicker);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomTimePicker read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTimePicker = class(TPyDelphiCustomTimePicker)
  private
    function GetDelphiObject: TTimePicker;
    procedure SetDelphiObject(const Value: TTimePicker);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TTimePicker read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TWinXPickersRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TWinXPickersRegistration }

procedure TWinXPickersRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TWinXPickersRegistration.Name: string;
begin
  Result := 'Win10.WinXCalendars';
end;

procedure TWinXPickersRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiBasePickerControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomDatePicker);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDatePicker);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomTimePicker);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTimePicker);
end;

{ TPyDelphiBasePickerControl }

class function TPyDelphiBasePickerControl.DelphiObjectClass: TClass;
begin
  Result := TBasePickerControl;
end;

function TPyDelphiBasePickerControl.GetDelphiObject: TBasePickerControl;
begin
  Result := TBasePickerControl(inherited DelphiObject);
end;

procedure TPyDelphiBasePickerControl.SetDelphiObject(const Value: TBasePickerControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomDatePicker }

class function TPyDelphiCustomDatePicker.DelphiObjectClass: TClass;
begin
  Result := TCustomDatePicker;
end;

function TPyDelphiCustomDatePicker.GetDelphiObject: TCustomDatePicker;
begin
  Result := TCustomDatePicker(inherited DelphiObject);
end;

procedure TPyDelphiCustomDatePicker.SetDelphiObject(const Value: TCustomDatePicker);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiDatePicker }

class function TPyDelphiDatePicker.DelphiObjectClass: TClass;
begin
  Result := TDatePicker;
end;

function TPyDelphiDatePicker.GetDelphiObject: TDatePicker;
begin
  Result := TDatePicker(inherited DelphiObject);
end;

procedure TPyDelphiDatePicker.SetDelphiObject(const Value: TDatePicker);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomTimePicker }

class function TPyDelphiCustomTimePicker.DelphiObjectClass: TClass;
begin
  Result := TCustomTimePicker;
end;

function TPyDelphiCustomTimePicker.GetDelphiObject: TCustomTimePicker;
begin
  Result := TCustomTimePicker(inherited DelphiObject);
end;

procedure TPyDelphiCustomTimePicker.SetDelphiObject(const Value: TCustomTimePicker);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiTimePicker }

class function TPyDelphiTimePicker.DelphiObjectClass: TClass;
begin
  Result := TTimePicker;
end;

function TPyDelphiTimePicker.GetDelphiObject: TTimePicker;
begin
  Result := TTimePicker(inherited DelphiObject);
end;

procedure TPyDelphiTimePicker.SetDelphiObject(const Value: TTimePicker);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TWinXPickersRegistration.Create );
  Classes.RegisterClasses([TDatePicker, TTimePicker]);
end.
