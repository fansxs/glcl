
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

unit WrapVclCategoryButtons;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.CategoryButtons, WrapDelphiClasses,
  System.TypInfo, PythonEngine, Vcl.ButtonGroup;

type
  TPyDelphiCollectionItem = class (TPyDelphiPersistent)
  private
    function  GetDelphiObject: TCollectionItem;
    procedure SetDelphiObject(const Value: TCollectionItem);
  protected
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCollectionItem read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiBaseItem = class (TPyDelphiCollectionItem)
  private
    function  GetDelphiObject: TBaseItem;
    procedure SetDelphiObject(const Value: TBaseItem);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TBaseItem read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiBaseButtonItem = class (TPyDelphiBaseItem)
  private
    function  GetDelphiObject: TBaseButtonItem;
    procedure SetDelphiObject(const Value: TBaseButtonItem);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TBaseButtonItem read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCategoryButtons = class (TPyDelphiCustomControl)
  private
    function  GetDelphiObject: TCategoryButtons;
    procedure SetDelphiObject(const Value: TCategoryButtons);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCategoryButtons read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TCategoryButtonsRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TCategoryButtonsRegistration }

procedure TCategoryButtonsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('bdsSelected', 'bdsSelected');
  APyDelphiWrapper.DefineVar('bdsHot', 'bdsHot');
  APyDelphiWrapper.DefineVar('bdsFocused', 'bdsFocused');
  APyDelphiWrapper.DefineVar('bdsDown', 'bdsDown');
  APyDelphiWrapper.DefineVar('bdsDragged', 'bdsDragged');
  APyDelphiWrapper.DefineVar('bdsInsertLeft', 'bdsInsertLeft');
  APyDelphiWrapper.DefineVar('bdsInsertTop', 'bdsInsertTop');
  APyDelphiWrapper.DefineVar('bdsInsertRight', 'bdsInsertRight');
  APyDelphiWrapper.DefineVar('bdsInsertBottom', 'bdsInsertBottom');
  APyDelphiWrapper.DefineVar('cbfVertical', 'cbfVertical');
  APyDelphiWrapper.DefineVar('cbfHorizontal', 'cbfHorizontal');
  APyDelphiWrapper.DefineVar('boAllowReorder', 'boAllowReorder');
  APyDelphiWrapper.DefineVar('boAllowCopyingButtons', 'boAllowCopyingButtons');
  APyDelphiWrapper.DefineVar('boFullSize', 'boFullSize');
  APyDelphiWrapper.DefineVar('boGradientFill', 'boGradientFill');
  APyDelphiWrapper.DefineVar('boShowCaptions', 'boShowCaptions');
  APyDelphiWrapper.DefineVar('boVerticalCategoryCaptions', 'boVerticalCategoryCaptions');
  APyDelphiWrapper.DefineVar('boBoldCaptions', 'boBoldCaptions');
  APyDelphiWrapper.DefineVar('boUsePlusMinus', 'boUsePlusMinus');
  APyDelphiWrapper.DefineVar('boCaptionOnlyBorder', 'boCaptionOnlyBorder');
end;

function TCategoryButtonsRegistration.Name: string;
begin
  Result := 'Additional.CategoryButtons';
end;

procedure TCategoryButtonsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCollectionItem);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiBaseItem);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiBaseButtonItem);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCategoryButtons);
end;

{ TPyDelphiCollectionItem }

class function TPyDelphiCollectionItem.DelphiObjectClass: TClass;
begin
  Result := TCollectionItem;
end;

function TPyDelphiCollectionItem.GetDelphiObject: TCollectionItem;
begin
  Result := TCollectionItem(inherited DelphiObject);
end;

procedure TPyDelphiCollectionItem.SetDelphiObject(const Value: TCollectionItem);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiBaseItem }

class function TPyDelphiBaseItem.DelphiObjectClass: TClass;
begin
  Result := TBaseItem;
end;

function TPyDelphiBaseItem.GetDelphiObject: TBaseItem;
begin
  Result := TBaseItem(inherited DelphiObject);
end;

procedure TPyDelphiBaseItem.SetDelphiObject(const Value: TBaseItem);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiBaseButtonItem }

class function TPyDelphiBaseButtonItem.DelphiObjectClass: TClass;
begin
  Result := TBaseButtonItem;
end;

function TPyDelphiBaseButtonItem.GetDelphiObject: TBaseButtonItem;
begin
  Result := TBaseButtonItem(inherited DelphiObject);
end;

procedure TPyDelphiBaseButtonItem.SetDelphiObject(const Value: TBaseButtonItem);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCategoryButtons }

class function TPyDelphiCategoryButtons.DelphiObjectClass: TClass;
begin
  Result := TCategoryButtons;
end;

function TPyDelphiCategoryButtons.GetDelphiObject: TCategoryButtons;
begin
  Result := TCategoryButtons(inherited DelphiObject);
end;

procedure TPyDelphiCategoryButtons.SetDelphiObject(const Value: TCategoryButtons);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TCategoryButtonsRegistration.Create );
  Classes.RegisterClasses([TCollectionItem, TBaseItem, TBaseButtonItem,
  TCategoryButtons]);
end.
