
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

unit WrapVclActnPopup;

interface

uses
  Classes, WrapDelphi, WrapVclMenus, Vcl.ActnPopup;

type

  TPyDelphiPopupActionBar = class(TPyDelphiPopupMenu)
  private
    function GetDelphiObject: TPopupActionBar;
    procedure SetDelphiObject(const Value: TPopupActionBar);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TPopupActionBar read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TActnPopupRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TActnPopupRegistration }

procedure TActnPopupRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

function TActnPopupRegistration.Name: string;
begin
  Result := 'Additional.PopupActionBar';
end;

procedure TActnPopupRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPopupActionBar);
end;

{ TPyDelphiPopupActionBar }

class function TPyDelphiPopupActionBar.DelphiObjectClass: TClass;
begin
  Result := TPopupActionBar;
end;

function TPyDelphiPopupActionBar.GetDelphiObject: TPopupActionBar;
begin
  Result := TPopupActionBar(inherited DelphiObject);
end;

procedure TPyDelphiPopupActionBar.SetDelphiObject(const Value: TPopupActionBar);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TActnPopupRegistration.Create );
  Classes.RegisterClasses([TPopupActionBar]);
end.
