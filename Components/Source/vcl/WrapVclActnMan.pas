
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

unit WrapVclActnMan;

interface

uses
  Classes, WrapDelphi, WrapVclControls, Vcl.ActnMan, WrapVclComCtrls, Vcl.ActnCtrls,
  WrapDelphiClasses;

type

  TPyDelphiCustomActionBar = class (TPyDelphiToolWindow)
  private
    function  GetDelphiObject: TCustomActionBar;
    procedure SetDelphiObject(const Value: TCustomActionBar);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomActionBar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomActionDockBar = class (TPyDelphiCustomActionBar)
  private
    function  GetDelphiObject: TCustomActionDockBar;
    procedure SetDelphiObject(const Value: TCustomActionDockBar);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomActionDockBar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomActionToolBar = class (TPyDelphiCustomActionDockBar)
  private
    function  GetDelphiObject: TCustomActionToolBar;
    procedure SetDelphiObject(const Value: TCustomActionToolBar);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomActionToolBar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiActionToolBar = class (TPyDelphiCustomActionToolBar)
  private
    function  GetDelphiObject: TActionToolBar;
    procedure SetDelphiObject(const Value: TActionToolBar);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TActionToolBar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomActionBarColorMap = class (TPyDelphiComponent)
  private
    function  GetDelphiObject: TCustomActionBarColorMap;
    procedure SetDelphiObject(const Value: TCustomActionBarColorMap);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomActionBarColorMap read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TActnManRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TActnManRegistration }

procedure TActnManRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('boLeftToRight', 'boLeftToRight');
  APyDelphiWrapper.DefineVar('boRightToLeft', 'boRightToLeft');
  APyDelphiWrapper.DefineVar('boTopToBottom', 'boTopToBottom');
  APyDelphiWrapper.DefineVar('boBottomToTop', 'boBottomToTop');
  APyDelphiWrapper.DefineVar('beLeft', 'beLeft');
  APyDelphiWrapper.DefineVar('beRight', 'beRight');
  APyDelphiWrapper.DefineVar('beEither', 'beEither');
end;

function TActnManRegistration.Name: string;
begin
  Result := 'Additional.ActionToolBar';
end;

procedure TActnManRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomActionBar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomActionDockBar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomActionToolBar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiActionToolBar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomActionBarColorMap);
end;

{ TPyDelphiCustomActionBar }

class function TPyDelphiCustomActionBar.DelphiObjectClass: TClass;
begin
  Result := TCustomActionBar;
end;

function TPyDelphiCustomActionBar.GetDelphiObject: TCustomActionBar;
begin
  Result := TCustomActionBar(inherited DelphiObject);
end;

procedure TPyDelphiCustomActionBar.SetDelphiObject(const Value: TCustomActionBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomActionDockBar }

class function TPyDelphiCustomActionDockBar.DelphiObjectClass: TClass;
begin
  Result := TCustomActionDockBar;
end;

function TPyDelphiCustomActionDockBar.GetDelphiObject: TCustomActionDockBar;
begin
  Result := TCustomActionDockBar(inherited DelphiObject);
end;

procedure TPyDelphiCustomActionDockBar.SetDelphiObject(const Value: TCustomActionDockBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomActionToolBar }

class function TPyDelphiCustomActionToolBar.DelphiObjectClass: TClass;
begin
  Result := TCustomActionToolBar;
end;

function TPyDelphiCustomActionToolBar.GetDelphiObject: TCustomActionToolBar;
begin
  Result := TCustomActionToolBar(inherited DelphiObject);
end;

procedure TPyDelphiCustomActionToolBar.SetDelphiObject(const Value: TCustomActionToolBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiActionToolBar }

class function TPyDelphiActionToolBar.DelphiObjectClass: TClass;
begin
  Result := TActionToolBar;
end;

function TPyDelphiActionToolBar.GetDelphiObject: TActionToolBar;
begin
  Result := TActionToolBar(inherited DelphiObject);
end;

procedure TPyDelphiActionToolBar.SetDelphiObject(const Value: TActionToolBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomActionBarColorMap }

class function TPyDelphiCustomActionBarColorMap.DelphiObjectClass: TClass;
begin
  Result := TCustomActionBarColorMap;
end;

function TPyDelphiCustomActionBarColorMap.GetDelphiObject: TCustomActionBarColorMap;
begin
  Result := TCustomActionBarColorMap(inherited DelphiObject);
end;

procedure TPyDelphiCustomActionBarColorMap.SetDelphiObject(const Value: TCustomActionBarColorMap);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TActnManRegistration.Create );
  Classes.RegisterClasses([TActionToolBar]);
end.
