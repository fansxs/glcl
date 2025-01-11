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

unit WrapVclWinXPanels;

interface

uses
  Classes, WrapDelphi, WrapVclExtCtrls, WrapVclControls, Vcl.WinXPanels;

type

  TPyDelphiCustomStackPanel = class(TPyDelphiCustomPanel)
  private
    function GetDelphiObject: TCustomStackPanel;
    procedure SetDelphiObject(const Value: TCustomStackPanel);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomStackPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiStackPanel = class(TPyDelphiCustomStackPanel)
  private
    function GetDelphiObject: TStackPanel;
    procedure SetDelphiObject(const Value: TStackPanel);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TStackPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomCardPanel = class(TPyDelphiCustomControl)
  private
    function GetDelphiObject: TCustomCardPanel;
    procedure SetDelphiObject(const Value: TCustomCardPanel);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomCardPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCardPanel = class(TPyDelphiCustomCardPanel)
  private
    function GetDelphiObject: TCardPanel;
    procedure SetDelphiObject(const Value: TCardPanel);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCardPanel read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TWinXPanelsRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TWinXPanelsRegistration }

procedure TWinXPanelsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('spoVertical', 'spoVertical');
  APyDelphiWrapper.DefineVar('spoHorizontal', 'spoHorizontal');

  APyDelphiWrapper.DefineVar('sphpDefault', 'sphpDefault');
  APyDelphiWrapper.DefineVar('sphpLeft', 'sphpLeft');
  APyDelphiWrapper.DefineVar('sphpCenter', 'sphpCenter');
  APyDelphiWrapper.DefineVar('sphpRight', 'sphpRight');
  APyDelphiWrapper.DefineVar('sphpFill', 'sphpFill');
  APyDelphiWrapper.DefineVar('spvpDefault', 'spvpDefault');
  APyDelphiWrapper.DefineVar('spvpTop', 'spvpTop');
  APyDelphiWrapper.DefineVar('spvpCenter', 'spvpCenter');
  APyDelphiWrapper.DefineVar('spvpBottom', 'spvpBottom');
  APyDelphiWrapper.DefineVar('spvpFill', 'spvpFill');
end;

function TWinXPanelsRegistration.Name: string;
begin
  Result := 'Win10.WinXPanels';
end;

procedure TWinXPanelsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomStackPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiStackPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomCardPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCardPanel);
end;

{ TPyDelphiCustomStackPanel }

class function TPyDelphiCustomStackPanel.DelphiObjectClass: TClass;
begin
  Result := TCustomStackPanel;
end;

function TPyDelphiCustomStackPanel.GetDelphiObject: TCustomStackPanel;
begin
  Result := TCustomStackPanel(inherited DelphiObject);
end;

procedure TPyDelphiCustomStackPanel.SetDelphiObject(const Value: TCustomStackPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiStackPanel }

class function TPyDelphiStackPanel.DelphiObjectClass: TClass;
begin
  Result := TStackPanel;
end;

function TPyDelphiStackPanel.GetDelphiObject: TStackPanel;
begin
  Result := TStackPanel(inherited DelphiObject);
end;

procedure TPyDelphiStackPanel.SetDelphiObject(const Value: TStackPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomCardPanel }

class function TPyDelphiCustomCardPanel.DelphiObjectClass: TClass;
begin
  Result := TCustomCardPanel;
end;

function TPyDelphiCustomCardPanel.GetDelphiObject: TCustomCardPanel;
begin
  Result := TCustomCardPanel(inherited DelphiObject);
end;

procedure TPyDelphiCustomCardPanel.SetDelphiObject(const Value: TCustomCardPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCardPanel }

class function TPyDelphiCardPanel.DelphiObjectClass: TClass;
begin
  Result := TCardPanel;
end;

function TPyDelphiCardPanel.GetDelphiObject: TCardPanel;
begin
  Result := TCardPanel(inherited DelphiObject);
end;

procedure TPyDelphiCardPanel.SetDelphiObject(const Value: TCardPanel);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TWinXPanelsRegistration.Create );
  Classes.RegisterClasses([TStackPanel, TCardPanel]);
end.
