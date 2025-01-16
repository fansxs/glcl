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

unit WrapVclExtCtrls;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses, WrapVclControls,
  Windows, ExtCtrls, TypInfo, Rtti, WrapVclStdCtrls;

type
  TPyDelphiShape = class (TPyDelphiGraphicControl)
  private
    function  GetDelphiObject: TShape;
    procedure SetDelphiObject(const Value: TShape);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TShape read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiPaintBox = class (TPyDelphiGraphicControl)
  private
    function  GetDelphiObject: TPaintBox;
    procedure SetDelphiObject(const Value: TPaintBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TPaintBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiImage = class (TPyDelphiGraphicControl)
  private
    function  GetDelphiObject: TImage;
    procedure SetDelphiObject(const Value: TImage);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TImage read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiBevel = class (TPyDelphiGraphicControl)
  private
    function  GetDelphiObject: TBevel;
    procedure SetDelphiObject(const Value: TBevel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TBevel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTimer = class (TPyDelphiComponent)
  private
    function  GetDelphiObject: TTimer;
    procedure SetDelphiObject(const Value: TTimer);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TTimer read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiPanel = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TPanel;
    procedure SetDelphiObject(const Value: TPanel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomPanel = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TCustomPanel;
    procedure SetDelphiObject(const Value: TCustomPanel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomCategoryPanel = class (TPyDelphiCustomPanel)
  private
    function  GetDelphiObject: TCustomCategoryPanel;
    procedure SetDelphiObject(const Value: TCustomCategoryPanel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomCategoryPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCategoryPanel = class (TPyDelphiCustomCategoryPanel)
  private
    function  GetDelphiObject: TCategoryPanel;
    procedure SetDelphiObject(const Value: TCategoryPanel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCategoryPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomCategoryPanelGroup = class (TPyDelphiScrollingWinControl)
  private
    function GetDelphiObject: TCustomCategoryPanelGroup;
    procedure SetDelphiObject(const Value: TCustomCategoryPanelGroup);
  protected
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomCategoryPanelGroup read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCategoryPanelGroup = class (TPyDelphiCustomCategoryPanelGroup)
  private
    function GetDelphiObject: TCategoryPanelGroup;
    procedure SetDelphiObject(const Value: TCategoryPanelGroup);
  protected
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCategoryPanelGroup read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomGridPanel = class (TPyDelphiCustomPanel)
  private
    function  GetDelphiObject: TCustomGridPanel;
    procedure SetDelphiObject(const Value: TCustomGridPanel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomGridPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiGridPanel = class (TPyDelphiCustomGridPanel)
  private
    function  GetDelphiObject: TGridPanel;
    procedure SetDelphiObject(const Value: TGridPanel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TGridPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomFlowPanel = class (TPyDelphiCustomPanel)
  private
    function  GetDelphiObject: TCustomFlowPanel;
    procedure SetDelphiObject(const Value: TCustomFlowPanel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomFlowPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiFlowPanel = class (TPyDelphiCustomFlowPanel)
  private
    function  GetDelphiObject: TFlowPanel;
    procedure SetDelphiObject(const Value: TFlowPanel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TFlowPanel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiPage = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TPage;
    procedure SetDelphiObject(const Value: TPage);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TPage read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiNotebook = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TNotebook;
    procedure SetDelphiObject(const Value: TNotebook);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TNotebook read GetDelphiObject write SetDelphiObject;
  end;

  {$IFNDEF FPC}
  TPyDelphiHeader = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: THeader;
    procedure SetDelphiObject(const Value: THeader);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: THeader read GetDelphiObject write SetDelphiObject;
  end;
  {$ENDIF FPC}

  TPyDelphiRadioGroup = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TRadioGroup;
    procedure SetDelphiObject(const Value: TRadioGroup);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TRadioGroup read GetDelphiObject write SetDelphiObject;
  end;

  {$IFDEF FPC}
  TPyDelphiSplitter = class (TPyDelphiWinControl)
  {$ELSE FPC}
  TPyDelphiSplitter = class (TPyDelphiGraphicControl)
  {$ENDIF FPC}
  private
    function  GetDelphiObject: TSplitter;
    procedure SetDelphiObject(const Value: TSplitter);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TSplitter read GetDelphiObject write SetDelphiObject;
  end;

  {$IFNDEF FPC}
  TPyDelphiControlBar = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TControlBar;
    procedure SetDelphiObject(const Value: TControlBar);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TControlBar read GetDelphiObject write SetDelphiObject;
  end;
  {$ENDIF FPC}

  TPyDelphiBoundLabel = class (TPyDelphiControl)
  private
    function  GetDelphiObject: TBoundLabel;
    procedure SetDelphiObject(const Value: TBoundLabel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TBoundLabel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiLabeledEdit = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TLabeledEdit;
    procedure SetDelphiObject(const Value: TLabeledEdit);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TLabeledEdit read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomButtonedEdit = class (TPyDelphiCustomEdit)
  private
    function  GetDelphiObject: TCustomButtonedEdit;
    procedure SetDelphiObject(const Value: TCustomButtonedEdit);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomButtonedEdit read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiButtonedEdit = class (TPyDelphiCustomButtonedEdit)
  private
    function  GetDelphiObject: TButtonedEdit;
    procedure SetDelphiObject(const Value: TButtonedEdit);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TButtonedEdit read GetDelphiObject write SetDelphiObject;
  end;

  {$IFNDEF FPC}
  TPyDelphiColorBox = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TColorBox;
    procedure SetDelphiObject(const Value: TColorBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TColorBox read GetDelphiObject write SetDelphiObject;
  end;
  {$ENDIF FPC}

  TPyDelphiCustomColorListBox = class (TPyDelphiCustomListBox)
  private
    function  GetDelphiObject: TCustomColorListBox;
    procedure SetDelphiObject(const Value: TCustomColorListBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomColorListBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiColorListBox = class (TPyDelphiCustomColorListBox)
  private
    function  GetDelphiObject: TColorListBox;
    procedure SetDelphiObject(const Value: TColorListBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TColorListBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomTrayIcon = class (TPyDelphiComponent)
  private
    function  GetDelphiObject: TCustomTrayIcon;
    procedure SetDelphiObject(const Value: TCustomTrayIcon);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomTrayIcon read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTrayIcon = class (TPyDelphiCustomTrayIcon)
  private
    function  GetDelphiObject: TTrayIcon;
    procedure SetDelphiObject(const Value: TTrayIcon);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TTrayIcon read GetDelphiObject write SetDelphiObject;
  end;

  TSysLinkEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; const Link: string; LinkType: TSysLinkType);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

  TPyDelphiCustomLinkLabel = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TCustomLinkLabel;
    procedure SetDelphiObject(const Value: TCustomLinkLabel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomLinkLabel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiLinkLabel = class (TPyDelphiCustomLinkLabel)
  private
    function  GetDelphiObject: TLinkLabel;
    procedure SetDelphiObject(const Value: TLinkLabel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TLinkLabel read GetDelphiObject write SetDelphiObject;
  end;

  function SysLinkTypeToPython(const ASysLinkType: TSysLinkType): PPyObject;

implementation

{ Register the wrappers, the globals and the constants }
type
  TExtCtrlsRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TExtCtrlsRegistration }

procedure TExtCtrlsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('bfNone',  bfNone);
  APyDelphiWrapper.DefineVar('bfInfo',  bfInfo);
  APyDelphiWrapper.DefineVar('bfWarning',  bfWarning);
  APyDelphiWrapper.DefineVar('bfError',  bfError);

  APyDelphiWrapper.DefineVar('fsLeftRightTopBottom', 'fsLeftRightTopBottom');
  APyDelphiWrapper.DefineVar('fsRightLeftTopBottom', 'fsRightLeftTopBottom');
  APyDelphiWrapper.DefineVar('fsLeftRightBottomTop', 'fsLeftRightBottomTop');
  APyDelphiWrapper.DefineVar('fsRightLeftBottomTop', 'fsRightLeftBottomTop');
  APyDelphiWrapper.DefineVar('fsTopBottomLeftRight', 'fsTopBottomLeftRight');
  APyDelphiWrapper.DefineVar('fsBottomTopLeftRight', 'fsBottomTopLeftRight');
  APyDelphiWrapper.DefineVar('fsTopBottomRightLeft', 'fsTopBottomRightLeft');
  APyDelphiWrapper.DefineVar('fsBottomTopRightLeft', 'fsBottomTopRightLeft');

  APyDelphiWrapper.DefineVar('emAddRows', 'emAddRows');
  APyDelphiWrapper.DefineVar('emAddColumns', 'emAddColumns');
  APyDelphiWrapper.DefineVar('emFixedSize', 'emFixedSize');

  APyDelphiWrapper.DefineVar('sltURL', 'sltURL');
  APyDelphiWrapper.DefineVar('sltID', 'sltID');
end;

function TExtCtrlsRegistration.Name: string;
begin
  Result := 'ExtCtrls';
end;

procedure TExtCtrlsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiShape);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPaintBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiImage);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiBevel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTimer);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomCategoryPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCategoryPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomCategoryPanelGroup);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCategoryPanelGroup);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomGridPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiGridPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomFlowPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiFlowPanel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPage);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiNotebook);
  {$IFNDEF FPC}
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiHeader);
  {$ENDIF FPC}
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRadioGroup);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiSplitter);
  {$IFNDEF FPC}
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiControlBar);
  {$ENDIF FPC}
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiBoundLabel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiLabeledEdit);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomButtonedEdit);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiButtonedEdit);
  {$IFNDEF FPC}
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiColorBox);
  {$ENDIF FPC}
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomColorListBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiColorListBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomTrayIcon);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTrayIcon);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomLinkLabel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiLinkLabel);

  // Event handlers
  APyDelphiWrapper.EventHandlers.RegisterHandler(TSysLinkEventHandler);
end;

function SysLinkTypeToPython(const ASysLinkType: TSysLinkType): PPyObject;
begin
  Result := GetPythonEngine.PyUnicodeFromString(
    TRttiEnumerationType.GetName<TSysLinkType>(ASysLinkType));
end;

{ TPyDelphiShape }

class function TPyDelphiShape.DelphiObjectClass: TClass;
begin
  Result := TShape;
end;

function TPyDelphiShape.GetDelphiObject: TShape;
begin
  Result := TShape(inherited DelphiObject);
end;

procedure TPyDelphiShape.SetDelphiObject(const Value: TShape);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiPaintBox }

class function TPyDelphiPaintBox.DelphiObjectClass: TClass;
begin
  Result := TPaintBox;
end;

function TPyDelphiPaintBox.GetDelphiObject: TPaintBox;
begin
  Result := TPaintBox(inherited DelphiObject);
end;

procedure TPyDelphiPaintBox.SetDelphiObject(const Value: TPaintBox);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiImage }

class function TPyDelphiImage.DelphiObjectClass: TClass;
begin
  Result := TImage;
end;

function TPyDelphiImage.GetDelphiObject: TImage;
begin
  Result := TImage(inherited DelphiObject);
end;

procedure TPyDelphiImage.SetDelphiObject(const Value: TImage);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiBevel }

class function TPyDelphiBevel.DelphiObjectClass: TClass;
begin
  Result := TBevel;
end;

function TPyDelphiBevel.GetDelphiObject: TBevel;
begin
  Result := TBevel(inherited DelphiObject);
end;

procedure TPyDelphiBevel.SetDelphiObject(const Value: TBevel);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiTimer }

class function TPyDelphiTimer.DelphiObjectClass: TClass;
begin
  Result := TTimer;
end;

function TPyDelphiTimer.GetDelphiObject: TTimer;
begin
  Result := TTimer(inherited DelphiObject);
end;

procedure TPyDelphiTimer.SetDelphiObject(const Value: TTimer);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiPanel }

class function TPyDelphiPanel.DelphiObjectClass: TClass;
begin
  Result := TPanel;
end;

function TPyDelphiPanel.GetDelphiObject: TPanel;
begin
  Result := TPanel(inherited DelphiObject);
end;

procedure TPyDelphiPanel.SetDelphiObject(const Value: TPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomPanel }

class function TPyDelphiCustomPanel.DelphiObjectClass: TClass;
begin
  Result := TCustomPanel;
end;

function TPyDelphiCustomPanel.GetDelphiObject: TCustomPanel;
begin
  Result := TCustomPanel(inherited DelphiObject);
end;

procedure TPyDelphiCustomPanel.SetDelphiObject(const Value: TCustomPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomCategoryPanel }

class function TPyDelphiCustomCategoryPanel.DelphiObjectClass: TClass;
begin
  Result := TCustomCategoryPanel;
end;

function TPyDelphiCustomCategoryPanel.GetDelphiObject: TCustomCategoryPanel;
begin
  Result := TCustomCategoryPanel(inherited DelphiObject);
end;

procedure TPyDelphiCustomCategoryPanel.SetDelphiObject(const Value: TCustomCategoryPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCategoryPanel }

class function TPyDelphiCategoryPanel.DelphiObjectClass: TClass;
begin
  Result := TCategoryPanel;
end;

function TPyDelphiCategoryPanel.GetDelphiObject: TCategoryPanel;
begin
  Result := TCategoryPanel(inherited DelphiObject);
end;

procedure TPyDelphiCategoryPanel.SetDelphiObject(const Value: TCategoryPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomCategoryPanelGroup }

class function TPyDelphiCustomCategoryPanelGroup.DelphiObjectClass: TClass;
begin
  Result := TCustomCategoryPanelGroup;
end;

function TPyDelphiCustomCategoryPanelGroup.GetDelphiObject: TCustomCategoryPanelGroup;
begin
  Result := TCustomCategoryPanelGroup(inherited DelphiObject);
end;

procedure TPyDelphiCustomCategoryPanelGroup.SetDelphiObject(const Value: TCustomCategoryPanelGroup);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCategoryPanelGroup }

class function TPyDelphiCategoryPanelGroup.DelphiObjectClass: TClass;
begin
  Result := TCategoryPanelGroup;
end;

function TPyDelphiCategoryPanelGroup.GetDelphiObject: TCategoryPanelGroup;
begin
  Result := TCategoryPanelGroup(inherited DelphiObject);
end;

procedure TPyDelphiCategoryPanelGroup.SetDelphiObject(const Value: TCategoryPanelGroup);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomGridPanel }

class function TPyDelphiCustomGridPanel.DelphiObjectClass: TClass;
begin
  Result := TCustomGridPanel;
end;

function TPyDelphiCustomGridPanel.GetDelphiObject: TCustomGridPanel;
begin
  Result := TCustomGridPanel(inherited DelphiObject);
end;

procedure TPyDelphiCustomGridPanel.SetDelphiObject(const Value: TCustomGridPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiGridPanel }

class function TPyDelphiGridPanel.DelphiObjectClass: TClass;
begin
  Result := TGridPanel;
end;

function TPyDelphiGridPanel.GetDelphiObject: TGridPanel;
begin
  Result := TGridPanel(inherited DelphiObject);
end;

procedure TPyDelphiGridPanel.SetDelphiObject(const Value: TGridPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomFlowPanel }

class function TPyDelphiCustomFlowPanel.DelphiObjectClass: TClass;
begin
  Result := TCustomFlowPanel;
end;

function TPyDelphiCustomFlowPanel.GetDelphiObject: TCustomFlowPanel;
begin
  Result := TCustomFlowPanel(inherited DelphiObject);
end;

procedure TPyDelphiCustomFlowPanel.SetDelphiObject(const Value: TCustomFlowPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiFlowPanel }

class function TPyDelphiFlowPanel.DelphiObjectClass: TClass;
begin
  Result := TFlowPanel;
end;

function TPyDelphiFlowPanel.GetDelphiObject: TFlowPanel;
begin
  Result := TFlowPanel(inherited DelphiObject);
end;

procedure TPyDelphiFlowPanel.SetDelphiObject(const Value: TFlowPanel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPage }

class function TPyDelphiPage.DelphiObjectClass: TClass;
begin
  Result := TPage;
end;

function TPyDelphiPage.GetDelphiObject: TPage;
begin
  Result := TPage(inherited DelphiObject);
end;

procedure TPyDelphiPage.SetDelphiObject(const Value: TPage);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiNotebook }

class function TPyDelphiNotebook.DelphiObjectClass: TClass;
begin
  Result := TNotebook;
end;

function TPyDelphiNotebook.GetDelphiObject: TNotebook;
begin
  Result := TNotebook(inherited DelphiObject);
end;

procedure TPyDelphiNotebook.SetDelphiObject(const Value: TNotebook);
begin
  inherited DelphiObject := Value;
end;


{$IFNDEF FPC}
{ TPyDelphiHeader }

class function TPyDelphiHeader.DelphiObjectClass: TClass;
begin
  Result := THeader;
end;

function TPyDelphiHeader.GetDelphiObject: THeader;
begin
  Result := THeader(inherited DelphiObject);
end;

procedure TPyDelphiHeader.SetDelphiObject(const Value: THeader);
begin
  inherited DelphiObject := Value;
end;
{$ENDIF FPC}


{ TPyDelphiRadioGroup }

class function TPyDelphiRadioGroup.DelphiObjectClass: TClass;
begin
  Result := TRadioGroup;
end;

function TPyDelphiRadioGroup.GetDelphiObject: TRadioGroup;
begin
  Result := TRadioGroup(inherited DelphiObject);
end;

procedure TPyDelphiRadioGroup.SetDelphiObject(const Value: TRadioGroup);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiSplitter }

class function TPyDelphiSplitter.DelphiObjectClass: TClass;
begin
  Result := TSplitter;
end;

function TPyDelphiSplitter.GetDelphiObject: TSplitter;
begin
  Result := TSplitter(inherited DelphiObject);
end;

procedure TPyDelphiSplitter.SetDelphiObject(const Value: TSplitter);
begin
  inherited DelphiObject := Value;
end;


{$IFNDEF FPC}
{ TPyDelphiControlBar }

class function TPyDelphiControlBar.DelphiObjectClass: TClass;
begin
  Result := TControlBar;
end;

function TPyDelphiControlBar.GetDelphiObject: TControlBar;
begin
  Result := TControlBar(inherited DelphiObject);
end;

procedure TPyDelphiControlBar.SetDelphiObject(const Value: TControlBar);
begin
  inherited DelphiObject := Value;
end;
{$ENDIF FPC}

{ TPyDelphiBoundLabel }

class function TPyDelphiBoundLabel.DelphiObjectClass: TClass;
begin
  Result := TBoundLabel;
end;

function TPyDelphiBoundLabel.GetDelphiObject: TBoundLabel;
begin
  Result := TBoundLabel(inherited DelphiObject);
end;

procedure TPyDelphiBoundLabel.SetDelphiObject(const Value: TBoundLabel);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiLabeledEdit }

class function TPyDelphiLabeledEdit.DelphiObjectClass: TClass;
begin
  Result := TLabeledEdit;
end;

function TPyDelphiLabeledEdit.GetDelphiObject: TLabeledEdit;
begin
  Result := TLabeledEdit(inherited DelphiObject);
end;

procedure TPyDelphiLabeledEdit.SetDelphiObject(const Value: TLabeledEdit);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomButtonedEdit }

class function TPyDelphiCustomButtonedEdit.DelphiObjectClass: TClass;
begin
  Result := TCustomButtonedEdit;
end;

function TPyDelphiCustomButtonedEdit.GetDelphiObject: TCustomButtonedEdit;
begin
  Result := TCustomButtonedEdit(inherited DelphiObject);
end;

procedure TPyDelphiCustomButtonedEdit.SetDelphiObject(const Value: TCustomButtonedEdit);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiButtonedEdit }

class function TPyDelphiButtonedEdit.DelphiObjectClass: TClass;
begin
  Result := TButtonedEdit;
end;

function TPyDelphiButtonedEdit.GetDelphiObject: TButtonedEdit;
begin
  Result := TButtonedEdit(inherited DelphiObject);
end;

procedure TPyDelphiButtonedEdit.SetDelphiObject(const Value: TButtonedEdit);
begin
  inherited DelphiObject := Value;
end;


{$IFNDEF FPC}
{ TPyDelphiColorBox }

class function TPyDelphiColorBox.DelphiObjectClass: TClass;
begin
  Result := TColorBox;
end;

function TPyDelphiColorBox.GetDelphiObject: TColorBox;
begin
  Result := TColorBox(inherited DelphiObject);
end;

procedure TPyDelphiColorBox.SetDelphiObject(const Value: TColorBox);
begin
  inherited DelphiObject := Value;
end;
{$ENDIF FPC}

{ TPyDelphiCustomColorListBox }

class function TPyDelphiCustomColorListBox.DelphiObjectClass: TClass;
begin
  Result := TCustomColorListBox;
end;

function TPyDelphiCustomColorListBox.GetDelphiObject: TCustomColorListBox;
begin
  Result := TCustomColorListBox(inherited DelphiObject);
end;

procedure TPyDelphiCustomColorListBox.SetDelphiObject(const Value: TCustomColorListBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiColorListBox }

class function TPyDelphiColorListBox.DelphiObjectClass: TClass;
begin
  Result := TColorListBox;
end;

function TPyDelphiColorListBox.GetDelphiObject: TColorListBox;
begin
  Result := TColorListBox(inherited DelphiObject);
end;

procedure TPyDelphiColorListBox.SetDelphiObject(const Value: TColorListBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomTrayIcon }

class function TPyDelphiCustomTrayIcon.DelphiObjectClass: TClass;
begin
  Result := TCustomTrayIcon;
end;

function TPyDelphiCustomTrayIcon.GetDelphiObject: TCustomTrayIcon;
begin
  Result := TCustomTrayIcon(inherited DelphiObject);
end;

procedure TPyDelphiCustomTrayIcon.SetDelphiObject(const Value: TCustomTrayIcon);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiTrayIcon }

class function TPyDelphiTrayIcon.DelphiObjectClass: TClass;
begin
  Result := TTrayIcon;
end;

function TPyDelphiTrayIcon.GetDelphiObject: TTrayIcon;
begin
  Result := TTrayIcon(inherited DelphiObject);
end;

procedure TPyDelphiTrayIcon.SetDelphiObject(const Value: TTrayIcon);
begin
  inherited DelphiObject := Value;
end;

{ TSysLinkEventHandler }

constructor TSysLinkEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod : TMethod;
begin
  inherited;
  LMethod.Code := @TSysLinkEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

procedure TSysLinkEventHandler.DoEvent(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
var
  LPyTuple, LPySender, LPyLink, LPyLinkType, PyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      LPySender := PyDelphiWrapper.Wrap(Sender);
      LPyLink := PyUnicodeFromString(Link);
      LPyLinkType := SysLinkTypeToPython(LinkType);
      LPyTuple := PyTuple_New(3);
      GetPythonEngine.PyTuple_SetItem(LPyTuple, 0, LPySender);
      GetPythonEngine.PyTuple_SetItem(LPyTuple, 1, LPyLink);
      GetPythonEngine.PyTuple_SetItem(LPyTuple, 2, LPyLinkType);
      try
        PyResult := PyObject_CallObject(Callable, LPyTuple);
        Py_XDECREF(PyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError;
    end;
end;

class function TSysLinkEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TSysLinkEvent);
end;

{ TPyDelphiCustomLinkLabel }

class function TPyDelphiCustomLinkLabel.DelphiObjectClass: TClass;
begin
  Result := TCustomLinkLabel;
end;

function TPyDelphiCustomLinkLabel.GetDelphiObject: TCustomLinkLabel;
begin
  Result := TCustomLinkLabel(inherited DelphiObject);
end;

procedure TPyDelphiCustomLinkLabel.SetDelphiObject(
  const Value: TCustomLinkLabel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiLinkLabel }

class function TPyDelphiLinkLabel.DelphiObjectClass: TClass;
begin
  Result := TLinkLabel;
end;

function TPyDelphiLinkLabel.GetDelphiObject: TLinkLabel;
begin
  Result := TLinkLabel(inherited DelphiObject);
end;

procedure TPyDelphiLinkLabel.SetDelphiObject(const Value: TLinkLabel);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TExtCtrlsRegistration.Create );
  {$IFDEF FPC}
  Classes.RegisterClasses([TShape, TPaintBox, TImage, TBevel, TTimer, TPanel, TPage, TNotebook,
                           TRadioGroup, TSplitter, TBoundLabel, TLabeledEdit]);
  {$ELSE FPC}
  Classes.RegisterClasses([TShape, TPaintBox, TImage, TBevel, TTimer, TPanel, TPage, TNotebook, THeader,
                           TRadioGroup, TSplitter, TControlBar, TBoundLabel, TLabeledEdit, TColorBox]);
  {$ENDIF FPC}
end.
