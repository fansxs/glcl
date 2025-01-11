(**************************************************************************)
(*  This unit is part of the Python for Delphi (P4D) library              *)
(*  Project home: https://github.com/pyscripter/python4delphi             *)
(*                                                                        *)
(*  Project Maintainer:  PyScripter (pyscripter@gmail.com)                *)
(*  Original Authors:    Dr. Dietmar Budelsky (dbudelsky@web.de)          *)
(*                       Morgan Martinet (https://github.com/mmm-experts) *)
(*  Core developer:      Lucas Belo (lucas.belo@live.com)                 *)
(*  Contributors:        See contributors.md at project home              *)
(*                                                                        *)
(*  LICENCE and Copyright: MIT (see project home)                         *)
(**************************************************************************)

{$I ..\Definition.Inc}

unit WrapVclActnColorMaps;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.ActnMan, WrapVclComCtrls, Vcl.ActnCtrls,
  WrapDelphiClasses, WrapVclActnMan, Vcl.ActnColorMaps;

type

  TPyDelphiXPColorMap = class (TPyDelphiCustomActionBarColorMap)
  private
    function  GetDelphiObject: TXPColorMap;
    procedure SetDelphiObject(const Value: TXPColorMap);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TXPColorMap read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiStandardColorMap = class (TPyDelphiCustomActionBarColorMap)
  private
    function  GetDelphiObject: TStandardColorMap;
    procedure SetDelphiObject(const Value: TStandardColorMap);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TStandardColorMap read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTwilightColorMap = class (TPyDelphiCustomActionBarColorMap)
  private
    function  GetDelphiObject: TTwilightColorMap;
    procedure SetDelphiObject(const Value: TTwilightColorMap);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TTwilightColorMap read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TActnColorMapsRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TActnColorMapsRegistration }

procedure TActnColorMapsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('cXPFrameOuter', cXPFrameOuter);
  APyDelphiWrapper.DefineVar('cXPBtnFrameColor', cXPBtnFrameColor);
  APyDelphiWrapper.DefineVar('cXPSelectedColor', cXPSelectedColor);
end;

function TActnColorMapsRegistration.Name: string;
begin
  Result := 'Additional.ColorMaps';
end;

procedure TActnColorMapsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiXPColorMap);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiStandardColorMap);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTwilightColorMap);
end;

{ TPyDelphiXPColorMap }

class function TPyDelphiXPColorMap.DelphiObjectClass: TClass;
begin
  Result := TXPColorMap;
end;

function TPyDelphiXPColorMap.GetDelphiObject: TXPColorMap;
begin
  Result := TXPColorMap(inherited DelphiObject);
end;

procedure TPyDelphiXPColorMap.SetDelphiObject(const Value: TXPColorMap);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiStandardColorMap }

class function TPyDelphiStandardColorMap.DelphiObjectClass: TClass;
begin
  Result := TStandardColorMap;
end;

function TPyDelphiStandardColorMap.GetDelphiObject: TStandardColorMap;
begin
  Result := TStandardColorMap(inherited DelphiObject);
end;

procedure TPyDelphiStandardColorMap.SetDelphiObject(const Value: TStandardColorMap);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiTwilightColorMap }

class function TPyDelphiTwilightColorMap.DelphiObjectClass: TClass;
begin
  Result := TTwilightColorMap;
end;

function TPyDelphiTwilightColorMap.GetDelphiObject: TTwilightColorMap;
begin
  Result := TTwilightColorMap(inherited DelphiObject);
end;

procedure TPyDelphiTwilightColorMap.SetDelphiObject(const Value: TTwilightColorMap);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TActnColorMapsRegistration.Create );
  Classes.RegisterClasses([TXPColorMap, TStandardColorMap, TTwilightColorMap]);
end.
