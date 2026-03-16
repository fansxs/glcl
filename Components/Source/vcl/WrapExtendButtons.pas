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

unit WrapExtendButtons;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses, PraButtonStyle,
  WrapVclControls;

type
  TPyDelphiPraButtonStyle = class(TPyDelphiGraphicControl)
  private
    function GetDelphiObject: TPraButtonStyle;
    procedure SetDelphiObject(const Value: TPraButtonStyle);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPraButtonStyle read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TExtendButtonsRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TExtendButtonsRegistration }
procedure TExtendButtonsRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TExtendButtonsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('paLeftJustify', 'paLeftJustify');
  APyDelphiWrapper.DefineVar('paCenter', 'paCenter');
  APyDelphiWrapper.DefineVar('plGraphicCenter', 'plGraphicCenter');
  APyDelphiWrapper.DefineVar('plGraphicBottom', 'plGraphicBottom');
  APyDelphiWrapper.DefineVar('plGraphicTop', 'plGraphicTop');
  APyDelphiWrapper.DefineVar('stRoundRect', 'stRoundRect');
  APyDelphiWrapper.DefineVar('stRectangle', 'stRectangle');
  APyDelphiWrapper.DefineVar('bsCustom', 'bsCustom');
  APyDelphiWrapper.DefineVar('bsPrimary', 'bsPrimary');
  APyDelphiWrapper.DefineVar('bsSecondary', 'bsSecondary');
  APyDelphiWrapper.DefineVar('bsSuccess', 'bsSuccess');
  APyDelphiWrapper.DefineVar('bsDanger', 'bsDanger');
  APyDelphiWrapper.DefineVar('bsWarning', 'bsWarning');
  APyDelphiWrapper.DefineVar('bsInfo', 'bsInfo');
  APyDelphiWrapper.DefineVar('bsLight', 'bsLight');
  APyDelphiWrapper.DefineVar('bsDark', 'bsDark');
  APyDelphiWrapper.DefineVar('tsNone', tsNone);
  APyDelphiWrapper.DefineVar('tsSave', tsSave);
  APyDelphiWrapper.DefineVar('tsCancel', tsCancel);
  APyDelphiWrapper.DefineVar('tsEdit', tsEdit);
  APyDelphiWrapper.DefineVar('tsDelete', tsDelete);
  APyDelphiWrapper.DefineVar('tsPrint', tsPrint);
  APyDelphiWrapper.DefineVar('tsGear', tsGear);
  APyDelphiWrapper.DefineVar('tsMenu', tsMenu);
  APyDelphiWrapper.DefineVar('tsHeart', tsHeart);
  APyDelphiWrapper.DefineVar('tsEmail', tsEmail);
  APyDelphiWrapper.DefineVar('tsInsert', tsInsert);
  APyDelphiWrapper.DefineVar('tsBack', tsBack);
  APyDelphiWrapper.DefineVar('tsClose', tsClose);
  APyDelphiWrapper.DefineVar('tsReport', tsReport);
end;

function TExtendButtonsRegistration.Name: string;
begin
  Result := 'ExtendButtons';
end;

procedure TExtendButtonsRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPraButtonStyle);
end;

{ TPyDelphiPraButtonStyle }

class function TPyDelphiPraButtonStyle.DelphiObjectClass: TClass;
begin
  Result := TPraButtonStyle;
end;

function TPyDelphiPraButtonStyle.GetDelphiObject: TPraButtonStyle;
begin
  Result := TPraButtonStyle(inherited DelphiObject);
end;

procedure TPyDelphiPraButtonStyle.SetDelphiObject(const Value: TPraButtonStyle);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TExtendButtonsRegistration.Create);

end.
