
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

unit WrapVclJumpList;

interface

uses
  Classes, WrapDelphi, WrapDelphiClasses, Vcl.JumpList;

type

  TPyDelphiCustomJumpList = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TCustomJumpList;
    procedure SetDelphiObject(const Value: TCustomJumpList);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomJumpList read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiJumpList = class(TPyDelphiCustomJumpList)
  private
    function GetDelphiObject: TJumpList;
    procedure SetDelphiObject(const Value: TJumpList);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TJumpList read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TJumpListRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TJumpListRegistration }

procedure TJumpListRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TJumpListRegistration.Name: string;
begin
  Result := 'Win32.JumpList';
end;

procedure TJumpListRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomJumpList);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiJumpList);
end;

{ TPyDelphiCustomJumpList }

class function TPyDelphiCustomJumpList.DelphiObjectClass: TClass;
begin
  Result := TCustomJumpList;
end;

function TPyDelphiCustomJumpList.GetDelphiObject: TCustomJumpList;
begin
  Result := TCustomJumpList(inherited DelphiObject);
end;

procedure TPyDelphiCustomJumpList.SetDelphiObject(const Value: TCustomJumpList);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiJumpList }

class function TPyDelphiJumpList.DelphiObjectClass: TClass;
begin
  Result := TJumpList;
end;

function TPyDelphiJumpList.GetDelphiObject: TJumpList;
begin
  Result := TJumpList(inherited DelphiObject);
end;

procedure TPyDelphiJumpList.SetDelphiObject(const Value: TJumpList);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TJumpListRegistration.Create );
  Classes.RegisterClasses([TJumpList]);
end.
