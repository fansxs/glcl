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

unit WrapVclWinXCtrls;

interface

uses
  Vcl.WinXCtrls,
  {$IF DEFINED(DELPHI11_OR_HIGHER) or DEFINED(DELPHI10_4_2)}
  Vcl.NumberBox,
  {$IFEND DEFINED(DELPHI11_OR_HIGHER) or DEFINED(DELPHI10_4_2)}
  WrapVclControls, WrapVclStdCtrls, WrapVclExtCtrls;

type
  TPyDelphiCustomActivityIndicator = class (TPyDelphiCustomControl)
  private
    function GetDelphiObject: TCustomActivityIndicator;
    procedure SetDelphiObject(const Value: TCustomActivityIndicator);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomActivityIndicator read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiActivityIndicator = class (TPyDelphiCustomActivityIndicator)
  private
    function GetDelphiObject: TActivityIndicator;
    procedure SetDelphiObject(const Value: TActivityIndicator);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TActivityIndicator read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomCustomToggleSwitch = class (TPyDelphiCustomControl)
  private
    function GetDelphiObject: TCustomToggleSwitch;
    procedure SetDelphiObject(const Value: TCustomToggleSwitch);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomToggleSwitch read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiToggleSwitch = class (TPyDelphiCustomCustomToggleSwitch)
  private
    function GetDelphiObject: TToggleSwitch;
    procedure SetDelphiObject(const Value: TToggleSwitch);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TToggleSwitch read GetDelphiObject write SetDelphiObject;
  end;

  {$IF DEFINED(DELPHI11_OR_HIGHER) or DEFINED(DELPHI10_4_2)}
  TPyDelphiCustomNumberBox = class(TPyDelphiCustomEdit)
  private
    function GetDelphiObject: TCustomNumberBox;
    procedure SetDelphiObject(const Value: TCustomNumberBox);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomNumberBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiNumberBox = class(TPyDelphiCustomNumberBox)
  private
    function GetDelphiObject: TNumberBox;
    procedure SetDelphiObject(const Value: TNumberBox);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TNumberBox read GetDelphiObject write SetDelphiObject;
  end;
  {$IFEND DEFINED(DELPHI11_OR_HIGHER) or DEFINED(DELPHI10_4_2)}

  TPyDelphiSearchBox = class(TPyDelphiEdit)
  private
    function GetDelphiObject: TSearchBox;
    procedure SetDelphiObject(const Value: TSearchBox);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TSearchBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomRelativePanel = class(TPyDelphiCustomPanel)
  private
    function GetDelphiObject: TCustomRelativePanel;
    procedure SetDelphiObject(const Value: TCustomRelativePanel);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomRelativePanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiRelativePanel = class(TPyDelphiCustomRelativePanel)
  private
    function GetDelphiObject: TRelativePanel;
    procedure SetDelphiObject(const Value: TRelativePanel);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TRelativePanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomSplitView = class(TPyDelphiCustomPanel)
  private
    function GetDelphiObject: TCustomSplitView;
    procedure SetDelphiObject(const Value: TCustomSplitView);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomSplitView read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiSplitView = class(TPyDelphiCustomSplitView)
  private
    function GetDelphiObject: TSplitView;
    procedure SetDelphiObject(const Value: TSplitView);
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TSplitView read GetDelphiObject write SetDelphiObject;
  end;
implementation

uses
  WrapDelphi;

{ Register the wrappers, the globals and the constants }
type
  TWinXCtrlsRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TComCtrlsRegistration }

procedure TWinXCtrlsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('svmDocked', 'svmDocked');
  APyDelphiWrapper.DefineVar('svmOverlay', 'svmOverlay');
  APyDelphiWrapper.DefineVar('svcCollapse', 'svcCollapse');
  APyDelphiWrapper.DefineVar('svcCompact', 'svcCompact');
  APyDelphiWrapper.DefineVar('svpLeft', 'svpLeft');
  APyDelphiWrapper.DefineVar('svpRight', 'svpRight');
  APyDelphiWrapper.DefineVar('svsOpened', 'svsOpened');
  APyDelphiWrapper.DefineVar('svsOpening', 'svsOpening');
  APyDelphiWrapper.DefineVar('svsClosed', 'svsClosed');
  APyDelphiWrapper.DefineVar('svsClosing', 'svsClosing');

  APyDelphiWrapper.DefineVar('sbiText', 'sbiText');
  APyDelphiWrapper.DefineVar('sbiAudio', 'sbiAudio');

  APyDelphiWrapper.DefineVar('aicBlack', 'aicBlack');
  APyDelphiWrapper.DefineVar('aicWhite', 'aicWhite');
  APyDelphiWrapper.DefineVar('aisSmall', 'aisSmall');
  APyDelphiWrapper.DefineVar('aisMedium', 'aisMedium');
  APyDelphiWrapper.DefineVar('aisLarge', 'aisLarge');
  APyDelphiWrapper.DefineVar('aisXLarge', 'aisXLarge');
  APyDelphiWrapper.DefineVar('aitMomentumDots', 'aitMomentumDots');
  APyDelphiWrapper.DefineVar('aitRotatingSector', 'aitRotatingSector');
  APyDelphiWrapper.DefineVar('aitSectorRing', 'aitSectorRing');

  APyDelphiWrapper.DefineVar('tssOff', 'tssOff');
  APyDelphiWrapper.DefineVar('tssOn', 'tssOn');
end;

function TWinXCtrlsRegistration.Name: string;
begin
  Result := 'WinXCtrls';
end;

procedure TWinXCtrlsRegistration.RegisterWrappers(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomActivityIndicator);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiActivityIndicator);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomCustomToggleSwitch);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiToggleSwitch);
  {$IF DEFINED(DELPHI11_OR_HIGHER) or DEFINED(DELPHI10_4_2)}
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomNumberBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiNumberBox);
  {$IFEND DEFINED(DELPHI11_OR_HIGHER) or DEFINED(DELPHI10_4_2)}
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiSearchBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomRelativePanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRelativePanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomSplitView);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiSplitView);
end;

{ TPyDelphiCustomActivityIndicator }

class function TPyDelphiCustomActivityIndicator.DelphiObjectClass: TClass;
begin
  Result := TCustomActivityIndicator;
end;

function TPyDelphiCustomActivityIndicator.GetDelphiObject: TCustomActivityIndicator;
begin
  Result := TCustomActivityIndicator(inherited DelphiObject);
end;

procedure TPyDelphiCustomActivityIndicator.SetDelphiObject(
  const Value: TCustomActivityIndicator);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiActivityIndicator }

class function TPyDelphiActivityIndicator.DelphiObjectClass: TClass;
begin
  Result := TActivityIndicator;
end;

function TPyDelphiActivityIndicator.GetDelphiObject: TActivityIndicator;
begin
  Result := TActivityIndicator(inherited DelphiObject);
end;

procedure TPyDelphiActivityIndicator.SetDelphiObject(
  const Value: TActivityIndicator);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomCustomToggleSwitch }

class function TPyDelphiCustomCustomToggleSwitch.DelphiObjectClass: TClass;
begin
  Result := TCustomToggleSwitch;
end;

function TPyDelphiCustomCustomToggleSwitch.GetDelphiObject: TCustomToggleSwitch;
begin
  Result := TCustomToggleSwitch(inherited DelphiObject);
end;

procedure TPyDelphiCustomCustomToggleSwitch.SetDelphiObject(
  const Value: TCustomToggleSwitch);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiToggleSwitch }

class function TPyDelphiToggleSwitch.DelphiObjectClass: TClass;
begin
  Result := TToggleSwitch;
end;

function TPyDelphiToggleSwitch.GetDelphiObject: TToggleSwitch;
begin
  Result := TToggleSwitch(inherited DelphiObject);
end;

procedure TPyDelphiToggleSwitch.SetDelphiObject(const Value: TToggleSwitch);
begin
  inherited DelphiObject := Value;
end;

{$IF DEFINED(DELPHI11_OR_HIGHER) or DEFINED(DELPHI10_4_2)}

{ TPyDelphiCustomNumberBox }

class function TPyDelphiCustomNumberBox.DelphiObjectClass: TClass;
begin
  Result := TCustomNumberBox;
end;

function TPyDelphiCustomNumberBox.GetDelphiObject: TCustomNumberBox;
begin
  Result := TCustomNumberBox(inherited DelphiObject);
end;

procedure TPyDelphiCustomNumberBox.SetDelphiObject(
  const Value: TCustomNumberBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiNumberBox }

class function TPyDelphiNumberBox.DelphiObjectClass: TClass;
begin
  Result := TNumberBox;
end;

function TPyDelphiNumberBox.GetDelphiObject: TNumberBox;
begin
  Result := TNumberBox(inherited DelphiObject);
end;

procedure TPyDelphiNumberBox.SetDelphiObject(const Value: TNumberBox);
begin
  inherited DelphiObject := Value;
end;

{$IFEND DEFINED(DELPHI11_OR_HIGHER) or DEFINED(DELPHI10_4_2)}

{ TPyDelphiSearchBox }

class function TPyDelphiSearchBox.DelphiObjectClass: TClass;
begin
  Result := TSearchBox;
end;

function TPyDelphiSearchBox.GetDelphiObject: TSearchBox;
begin
  Result := TSearchBox(inherited DelphiObject);
end;

procedure TPyDelphiSearchBox.SetDelphiObject(const Value: TSearchBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomRelativePanel }

class function TPyDelphiCustomRelativePanel.DelphiObjectClass: TClass;
begin
  Result := TCustomRelativePanel;
end;

function TPyDelphiCustomRelativePanel.GetDelphiObject: TCustomRelativePanel;
begin
  Result := TCustomRelativePanel(inherited DelphiObject);
end;

procedure TPyDelphiCustomRelativePanel.SetDelphiObject(const Value: TCustomRelativePanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRelativePanel }

class function TPyDelphiRelativePanel.DelphiObjectClass: TClass;
begin
  Result := TRelativePanel;
end;

function TPyDelphiRelativePanel.GetDelphiObject: TRelativePanel;
begin
  Result := TRelativePanel(inherited DelphiObject);
end;

procedure TPyDelphiRelativePanel.SetDelphiObject(const Value: TRelativePanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomSplitView }

class function TPyDelphiCustomSplitView.DelphiObjectClass: TClass;
begin
  Result := TCustomSplitView;
end;

function TPyDelphiCustomSplitView.GetDelphiObject: TCustomSplitView;
begin
  Result := TCustomSplitView(inherited DelphiObject);
end;

procedure TPyDelphiCustomSplitView.SetDelphiObject(const Value: TCustomSplitView);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiSplitView }

class function TPyDelphiSplitView.DelphiObjectClass: TClass;
begin
  Result := TSplitView;
end;

function TPyDelphiSplitView.GetDelphiObject: TSplitView;
begin
  Result := TSplitView(inherited DelphiObject);
end;

procedure TPyDelphiSplitView.SetDelphiObject(const Value: TSplitView);
begin
  inherited DelphiObject := Value;
end;
initialization
  RegisteredUnits.Add(TWinXCtrlsRegistration.Create());

end.
