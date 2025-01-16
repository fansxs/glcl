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

unit WrapVclTaskbar;

interface

uses
  Classes, WrapDelphi, WrapDelphiClasses, Vcl.Taskbar;

type

  TPyDelphiTaskbar = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TTaskbar;
    procedure SetDelphiObject(const Value: TTaskbar);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TTaskbar read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TTaskbarRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TTaskbarRegistration }

procedure TTaskbarRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TTaskbarRegistration.Name: string;
begin
  Result := 'Win32.Taskbar';
end;

procedure TTaskbarRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTaskbar);
end;

{ TPyDelphiTaskbar }

class function TPyDelphiTaskbar.DelphiObjectClass: TClass;
begin
  Result := TTaskbar;
end;

function TPyDelphiTaskbar.GetDelphiObject: TTaskbar;
begin
  Result := TTaskbar(inherited DelphiObject);
end;

procedure TPyDelphiTaskbar.SetDelphiObject(const Value: TTaskbar);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TTaskbarRegistration.Create );
  Classes.RegisterClasses([TTaskbar]);
end.
