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

unit WrapVclButtonGroup;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.ButtonGroup, WrapVclCategoryButtons,
  Vcl.CategoryButtons, WrapDelphiClasses;

type
  TPyDelphiGrpButtonItem = class (TPyDelphiBaseButtonItem)
  private
    function  GetDelphiObject: TGrpButtonItem;
    procedure SetDelphiObject(const Value: TGrpButtonItem);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TGrpButtonItem read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiButtonGroup = class (TPyDelphiCustomControl)
  private
    function  GetDelphiObject: TButtonGroup;
    procedure SetDelphiObject(const Value: TButtonGroup);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TButtonGroup read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TButtonGroupRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TButtonGroupRegistration }

procedure TButtonGroupRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('gboAllowReorder', 'gboAllowReorder');
  APyDelphiWrapper.DefineVar('gboFullSize', 'gboFullSize');
  APyDelphiWrapper.DefineVar('gboGroupStyle', 'gboGroupStyle');
  APyDelphiWrapper.DefineVar('gboShowCaptions', 'gboShowCaptions');
end;

function TButtonGroupRegistration.Name: string;
begin
  Result := 'Additional.ButtonGroup';
end;

procedure TButtonGroupRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiGrpButtonItem);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiButtonGroup);
end;

{ TPyDelphiGrpButtonItem }

class function TPyDelphiGrpButtonItem.DelphiObjectClass: TClass;
begin
  Result := TGrpButtonItem;
end;

function TPyDelphiGrpButtonItem.GetDelphiObject: TGrpButtonItem;
begin
  Result := TGrpButtonItem(inherited DelphiObject);
end;

procedure TPyDelphiGrpButtonItem.SetDelphiObject(const Value: TGrpButtonItem);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiButtonGroup }

class function TPyDelphiButtonGroup.DelphiObjectClass: TClass;
begin
  Result := TButtonGroup;
end;

function TPyDelphiButtonGroup.GetDelphiObject: TButtonGroup;
begin
  Result := TButtonGroup(inherited DelphiObject);
end;

procedure TPyDelphiButtonGroup.SetDelphiObject(const Value: TButtonGroup);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TButtonGroupRegistration.Create );
  Classes.RegisterClasses([TGrpButtonItem, TButtonGroup]);
end.
