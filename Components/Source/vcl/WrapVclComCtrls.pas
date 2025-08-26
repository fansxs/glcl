
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

unit WrapVclComCtrls;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.TypInfo,
  Vcl.Controls,
  Vcl.ComCtrls,
  PythonEngine,
  WrapDelphi,
  WrapDelphiClasses,
  WrapVclControls,
  WrapVclStdCtrls,
  Vcl.ShellAnimations,
  Vcl.ToolWin,
  Vcl.TabNotBk,
  Vcl.FileCtrl,
  Winapi.RichEdit;

type
  TTabChangingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; var AllowChange: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;
    class function GetTypeInfo: PTypeInfo; override;
  end;

  TPyDelphiDateTimePicker = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TDateTimePicker;
    procedure SetDelphiObject(const Value: TDateTimePicker);
  public
    class function  DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TDateTimePicker read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTabSheet = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TTabSheet;
    procedure SetDelphiObject(const Value: TTabSheet);
  protected
    // Property Getters
    function Get_TabIndex( AContext: Pointer): PPyObject; cdecl;
    function Get_PageControl( AContext: Pointer): PPyObject; cdecl;
    // Property Setters
    function Set_PageControl( AValue: PPyObject; AContext: Pointer): integer; cdecl;
  public
    class function  DelphiObjectClass: TClass; override;
    class procedure RegisterGetSets( PythonType: TPythonType ); override;
    // Properties
    property DelphiObject: TTabSheet read GetDelphiObject write SetDelphiObject;
  end;

  {
    Access to the child pages of a TPageControl.Pages collection.
  }
  TPagesAccess = class(TContainerAccess)
  private
    function GetContainer: TPageControl;
  public
    function GetItem(AIndex: Integer): PPyObject; override;
    function GetSize: Integer; override;
    function IndexOf(AValue: PPyObject): Integer; override;

    class function ExpectedContainerClass: TClass; override;
    class function SupportsIndexOf: Boolean; override;
    class function Name: string; override;

    property Container: TPageControl read GetContainer;
  end;

  TPyDelphiPageControl = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TPageControl;
    procedure SetDelphiObject(const Value: TPageControl);
  protected
    // methods
    function  IndexOfTabAt_Wrapper(args: PPyObject): PPyObject; cdecl;
    function  GetHitTestInfoAt_Wrapper(args: PPyObject): PPyObject; cdecl;
    function  TabRect_Wrapper(args: PPyObject): PPyObject; cdecl;
    function  ScrollTabs_Wrapper(args: PPyObject): PPyObject; cdecl;
    function  FindNextPage_Wrapper(args: PPyObject): PPyObject; cdecl;
    function  SelectNextPage_Wrapper(args: PPyObject): PPyObject; cdecl;
    // Property Getters
    function Get_ActivePage( AContext: Pointer): PPyObject; cdecl;
    function Get_ActivePageIndex( AContext: Pointer): PPyObject; cdecl;
    function Get_Canvas( AContext: Pointer): PPyObject; cdecl;
    function Get_PageCount( AContext: Pointer): PPyObject; cdecl;
    function Get_Pages( AContext: Pointer): PPyObject; cdecl;
    function Get_RowCount( AContext: Pointer): PPyObject; cdecl;
    // Property Setters
    function Set_ActivePage( AValue: PPyObject; AContext: Pointer): integer; cdecl;
    function Set_ActivePageIndex( AValue: PPyObject; AContext: Pointer): integer; cdecl;
  public
    class function  DelphiObjectClass: TClass; override;
    class procedure RegisterGetSets( PythonType: TPythonType ); override;
    class procedure RegisterMethods( PythonType: TPythonType ); override;
    // Properties
    property DelphiObject: TPageControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTrackBar = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TTrackBar;
    procedure SetDelphiObject(const Value: TTrackBar);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TTrackBar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiProgressBar = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TProgressBar;
    procedure SetDelphiObject(const Value: TProgressBar);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TProgressBar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomUpDown = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TCustomUpDown;
    procedure SetDelphiObject(const Value: TCustomUpDown);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCustomUpDown read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiUpDown = class (TPyDelphiCustomUpDown)
  private
    function GetDelphiObject: TUpDown;
    procedure SetDelphiObject(const Value: TUpDown);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TUpDown read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomHotKey = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TCustomHotKey;
    procedure SetDelphiObject(const Value: TCustomHotKey);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCustomHotKey read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiHotKey = class (TPyDelphiCustomHotKey)
  private
    function GetDelphiObject: THotKey;
    procedure SetDelphiObject(const Value: THotKey);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: THotKey read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCommonCalendar = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TCommonCalendar;
    procedure SetDelphiObject(const Value: TCommonCalendar);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCommonCalendar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiMonthCalendar = class (TPyDelphiCommonCalendar)
  private
    function GetDelphiObject: TMonthCalendar;
    procedure SetDelphiObject(const Value: TMonthCalendar);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TMonthCalendar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomHeaderControl = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TCustomHeaderControl;
    procedure SetDelphiObject(const Value: TCustomHeaderControl);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCustomHeaderControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiHeaderControl = class (TPyDelphiCustomHeaderControl)
  private
    function GetDelphiObject: THeaderControl;
    procedure SetDelphiObject(const Value: THeaderControl);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: THeaderControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiToolWindow = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TToolWindow;
    procedure SetDelphiObject(const Value: TToolWindow);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TToolWindow read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCoolBar = class (TPyDelphiToolWindow)
  private
    function GetDelphiObject: TCoolBar;
    procedure SetDelphiObject(const Value: TCoolBar);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCoolBar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiAnimate = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TAnimate;
    procedure SetDelphiObject(const Value: TAnimate);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TAnimate read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiShellResources = class (TPyDelphiComponent)
  private
    function GetDelphiObject: TShellResources;
    procedure SetDelphiObject(const Value: TShellResources);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TShellResources read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiPageScroller = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TPageScroller;
    procedure SetDelphiObject(const Value: TPageScroller);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPageScroller read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomRichEdit = class (TPyDelphiCustomMemo)
  private
    function GetDelphiObject: TCustomRichEdit;
    procedure SetDelphiObject(const Value: TCustomRichEdit);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCustomRichEdit read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiRichEdit = class (TPyDelphiCustomRichEdit)
  private
    function GetDelphiObject: TRichEdit;
    procedure SetDelphiObject(const Value: TRichEdit);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRichEdit read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiComboBoxEx = class(TPyDelphiWinControl)
  private
    function GetDelphiObject: TComboBoxEx;
    procedure SetDelphiObject(const Value: TComboBoxEx);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TComboBoxEx read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiToolButton = class(TPyDelphiGraphicControl)
  private
    function GetDelphiObject: TToolButton;
    procedure SetDelphiObject(const Value: TToolButton);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TToolButton read GetDelphiObject
      write SetDelphiObject;
  end;

  TToolbarAccess = class(TContainerAccess)
  private
    function GetContainer: TToolbar;
  public
    function GetItem(AIndex: Integer): PPyObject; override;
    function GetSize: Integer; override;
    function IndexOf(AValue: PPyObject): Integer; override;
    class function ExpectedContainerClass: TClass; override;
    class function SupportsIndexOf: Boolean; override;
    class function Name: string; override;
    property Container: TToolbar read GetContainer;
  end;

  TPyDelphiToolbar = class(TPyDelphiWinControl)
  private
    function GetDelphiObject: TToolbar;
    procedure SetDelphiObject(const Value: TToolbar);
  protected
    function Get_ButtonCount(AContext: Pointer): PPyObject; cdecl;
    function Get_Buttons(AContext: Pointer): PPyObject; cdecl;
  public
    class function DelphiObjectClass: TClass; override;
    class procedure RegisterGetSets(PythonType: TPythonType); override;
    class function GetContainerAccessClass: TContainerAccessClass; override;

    property DelphiObject: TToolbar read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiCustomCustomTabControl = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TCustomTabControl;
    procedure SetDelphiObject(const Value: TCustomTabControl);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomTabControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomTabControl = class (TPyDelphiCustomCustomTabControl)
  private
    function GetDelphiObject: TTabControl;
    procedure SetDelphiObject(const Value: TTabControl);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TTabControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTabbedNotebook = class (TPyDelphiCustomCustomTabControl)
  private
    function GetDelphiObject: TTabbedNotebook;
    procedure SetDelphiObject(const Value: TTabbedNotebook);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TTabbedNotebook read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiFileListBox = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TFileListBox;
    procedure SetDelphiObject(const Value: TFileListBox);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TFileListBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiDriveComboBox = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TDriveComboBox;
    procedure SetDelphiObject(const Value: TDriveComboBox);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TDriveComboBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiDirectoryListBox = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TDirectoryListBox;
    procedure SetDelphiObject(const Value: TDirectoryListBox);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TDirectoryListBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiFilterComboBox = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TFilterComboBox;
    procedure SetDelphiObject(const Value: TFilterComboBox);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TFilterComboBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomStatusBar = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TCustomStatusBar;
    procedure SetDelphiObject(const Value: TCustomStatusBar);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomStatusBar read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiStatusBar = class (TPyDelphiCustomStatusBar)
  private
    function GetDelphiObject: TStatusBar;
    procedure SetDelphiObject(const Value: TStatusBar);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TStatusBar read GetDelphiObject write SetDelphiObject;
  end;

  //TTVChangingEvent
  TTVChangingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVChangedEvent
  TTVChangedEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Node: TTreeNode);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVEditingEvent
  TTVEditingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVEditedEvent
  TTVEditedEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Node: TTreeNode; var S: string);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVExpandingEvent
  TTVExpandingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVCollapsingEvent
  TTVCollapsingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVExpandedEvent
  TTVExpandedEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Node: TTreeNode);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVCompareEvent
  TTVCompareEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Node1, Node2: TTreeNode; Data: Integer; var Compare: Integer);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVHintEvent
  TTVHintEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; const Node: TTreeNode; var Hint: String);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVCustomDrawEvent
  TTVCustomDrawEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomTreeView; const ARect: TRect; var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVCustomDrawItemEvent
  TTVCustomDrawItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
      var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVAdvancedCustomDrawEvent
  TTVAdvancedCustomDrawEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomTreeView; const ARect: TRect; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVAdvancedCustomDrawItemEvent
  TTVAdvancedCustomDrawItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVCreateNodeClassEvent
  TTVCreateNodeClassEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TDragDropEvent
  TDragDropEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender, Source: TObject; X, Y: Integer);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TDragOverEvent
  TDragOverEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TEndDragEvent
  TEndDragEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender, Target: TObject; X, Y: Integer);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //StartDragEvent
  TStartDragEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; var DragObject: TDragObject);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

{$IFDEF DELPHI11_OR_HIGHER}
  //TTVCheckStateChangedEvent
  TTVCheckStateChangedEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomTreeView; Node: TTreeNode; CheckState: TNodeCheckState);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TTVCheckStateChangingEvent
  TTVCheckStateChangingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomTreeView; Node: TTreeNode;
      NewCheckState, OldCheckState: TNodeCheckState; var AllowChange: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;
{$ENDIF}

  TPyDelphiTreeNodes = class(TPyDelphiPersistent)
  private
    function GetDelphiObject: TTreeNodes;
    procedure SetDelphiObject(const Value: TTreeNodes);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TTreeNodes read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTreeNode = class(TPyDelphiPersistent)
  private
    function GetDelphiObject: TTreeNode;
    procedure SetDelphiObject(const Value: TTreeNode);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TTreeNode read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomTreeView = class(TPyDelphiWinControl)
  private
    function GetDelphiObject: TCustomTreeView;
    procedure SetDelphiObject(const Value: TCustomTreeView);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomTreeView read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiTreeView = class(TPyDelphiCustomTreeView)
  private
    function GetDelphiObject: TTreeView;
    procedure SetDelphiObject(const Value: TTreeView);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TTreeView read GetDelphiObject write SetDelphiObject;
  end;

  //TLVDeletedEvent
  TLVDeletedEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVEditingEvent
  TLVEditingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem; var AllowEdit: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVEditedEvent
  TLVEditedEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem; var S: string);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVChangeEvent
  TLVChangeEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem; Change: TItemChange);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVChangingEvent
  TLVChangingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem; Change: TItemChange;
      var AllowChange: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TUDClickEvent
  TUDClickEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Button: TUDBtnType);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TUDChangingEvent
  TUDChangingEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; var AllowChange: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TUDChangingEventEx
  TUDChangingEventExHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVColumnClickEvent
  TLVColumnClickEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Column: TListColumn);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVColumnRClickEvent
  TLVColumnRClickEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Column: TListColumn; Point: TPoint);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVCompareEvent
  TLVCompareEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item1, Item2: TListItem; Data: Integer;
      var Compare: Integer);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVNotifyEvent
  TLVNotifyEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVSelectItemEvent
  TLVSelectItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVCheckedItemEvent
  TLVCheckedItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVDrawItemEvent
  TLVDrawItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomListView; Item: TListItem;
      Rect: TRect; State: TOwnerDrawState);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVCustomDrawEvent
  TLVCustomDrawEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomListView; const ARect: TRect;
      var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVCustomDrawItemEvent
  TLVCustomDrawItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVCustomDrawSubItemEvent
  TLVCustomDrawSubItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVAdvancedCustomDrawEvent
  TLVAdvancedCustomDrawEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomListView; const ARect: TRect;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVAdvancedCustomDrawItemEvent
  TLVAdvancedCustomDrawItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVAdvancedCustomDrawSubItemEvent
  TLVAdvancedCustomDrawSubItemEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVOwnerDataEvent
  TLVOwnerDataEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVOwnerDataFindEvent
  TLVOwnerDataFindEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Find: TItemFind;
      const FindString: string; const FindPosition: TPoint; FindData: TCustomData;
      StartIndex: Integer; Direction: TSearchDirection; Wrap: Boolean;
      var Index: Integer);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVOwnerDataHintEvent
  TLVOwnerDataHintEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; StartIndex, EndIndex: Integer);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVOwnerDataStateChangeEvent
  TLVOwnerDataStateChangeEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; StartIndex,
      EndIndex: Integer; OldState, NewState: TItemStates);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVSubItemImageEvent
  TLVSubItemImageEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem; SubItem: Integer;
      var ImageIndex: Integer);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVInfoTipEvent
  TLVInfoTipEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Item: TListItem; var InfoTip: string);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  //TLVCreateItemClassEvent
  TLVCreateItemClassEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TCustomListView; var ItemClass: TListItemClass);
  public
    constructor Create(PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
      PropertyInfo: PPropInfo; Callable: PPyObject); override;

    class function GetTypeInfo: PTypeInfo; override;
  end;

  TPyDelphiListItems = class(TPyDelphiPersistent)
  private
    function GetDelphiObject: TListItems;
    procedure SetDelphiObject(const Value: TListItems);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TListItems read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiListItem = class(TPyDelphiPersistent)
  private
    function GetDelphiObject: TListItem;
    procedure SetDelphiObject(const Value: TListItem);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TListItem read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomListView = class(TPyDelphiCustomMultiListControl)
  private
    function GetDelphiObject: TCustomListView;
    procedure SetDelphiObject(const Value: TCustomListView);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TCustomListView read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiListView = class(TPyDelphiCustomListView)
  private
    function GetDelphiObject: TListView;
    procedure SetDelphiObject(const Value: TListView);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TListView read GetDelphiObject write SetDelphiObject;
  end;

{$IFDEF DELPHI11_OR_HIGHER}
  function NodeCheckStateToPython(const ANodeCheckState: TNodeCheckState): PPyObject;
{$ENDIF}

  function CustomDrawTargetToPython(const ACustomDrawTarget: TCustomDrawTarget): PPyObject;
  function CustomDrawStageToPython(const ACustomDrawStage: TCustomDrawStage): PPyObject;
  function CustomDrawStateToPython(const ACustomDrawState: TCustomDrawState): PPyObject;

  function ItemChangeToPython(const AItemChange: TItemChange): PPyObject;
  function ItemStateToPython(const AItemState: TItemState): PPyObject;
  function ItemStatesToPython(const AItemStates: TItemStates): PPyObject;
  function ItemFindToPython(const AItemFind: TItemFind): PPyObject;
  function SearchDirectionToPython(const ASearchDirection: TSearchDirection): PPyObject;

implementation

uses
  WrapDelphiTypes, WrapDelphiWindows,
  Vcl.ExtCtrls;

{ Register the wrappers, the globals and the constants }
type
  TComCtrlsRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{$IFDEF DELPHI11_OR_HIGHER}
function NodeCheckStateToPython(const ANodeCheckState: TNodeCheckState): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TNodeCheckState),
      Ord(ANodeCheckState)));
end;
{$ENDIF}

function CustomDrawTargetToPython(const ACustomDrawTarget: TCustomDrawTarget): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TCustomDrawTarget),
      Ord(ACustomDrawTarget)));
end;

function CustomDrawStageToPython(const ACustomDrawStage: TCustomDrawStage): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TCustomDrawStage),
      Ord(ACustomDrawStage)));
end;

function CustomUDBtnTypeToPython(const AUDBtnType: TUDBtnType): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TUDBtnType),
      Ord(AUDBtnType)));
end;

function CustomUpDownDirectionToPython(const AUpDownDirection: TUpDownDirection): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TUpDownDirection),
      Ord(AUpDownDirection)));
end;

function CustomDrawStateToPython(const ACustomDrawState: TCustomDrawState): PPyObject;

  procedure Append(const AList: PPyObject; const AString: string);
  var
    LItem: PPyObject;
  begin
    with GetPythonEngine do begin
      LItem := PyUnicodeFromString(AString);
      PyList_Append(AList, LItem);
      Py_XDecRef(LItem);
    end;
  end;

var
  LCompType: PTypeInfo;
  LMin: integer;
  LMax: integer;
  LState: integer;
begin
  Result := GetPythonEngine().PyList_New(0);
  LCompType := GetTypeData(TypeInfo(TCustomDrawState)).CompType^;
  LMin := LCompType^.TypeData^.MinValue;
  LMax := LCompType^.TypeData^.MaxValue;
  for LState := LMin to LMax do
    Append(Result, GetEnumName(LCompType, LState));
end;

function DragStateToPython(const ADragState: TDragState): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TDragState),
      Ord(ADragState)));
end;

function ItemChangeToPython(const AItemChange: TItemChange): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TItemChange),
      Ord(AItemChange)));
end;

function ItemStateToPython(const AItemState: TItemState): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TItemState),
      Ord(AItemState)));
end;

function ItemStatesToPython(const AItemStates: TItemStates): PPyObject;

  procedure Append(const AList: PPyObject; const AItemState: TItemState);
  var
    LItem: PPyObject;
  begin
    with GetPythonEngine do begin
      LItem := ItemStateToPython(AItemState);
      PyList_Append(AList, LItem);
      Py_XDecRef(LItem);
    end;
  end;

var
  LItemState: TItemState;
begin
  Result := GetPythonEngine().PyList_New(0);
  for LItemState := Low(TItemState) to High(TItemState) do
    Append(Result, LItemState);
end;

function ItemFindToPython(const AItemFind: TItemFind): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TItemFind),
      Ord(AItemFind)));
end;

function SearchDirectionToPython(const ASearchDirection: TSearchDirection): PPyObject;
begin
  Result := GetPythonEngine().PyUnicodeFromString(
    System.TypInfo.GetEnumName(
      TypeInfo(TSearchDirection),
      Ord(ASearchDirection)));
end;

{ TComCtrlsRegistration }

procedure TComCtrlsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('naAdd',  'naAdd');
  APyDelphiWrapper.DefineVar('naAddFirst',  'naAddFirst');
  APyDelphiWrapper.DefineVar('naAddChild',  'naAddChild');
  APyDelphiWrapper.DefineVar('naAddChildFirst',  'naAddChildFirst');
  APyDelphiWrapper.DefineVar('naInsert',  'naInsert');

  APyDelphiWrapper.DefineVar('ebLeft', 'ebLeft');
  APyDelphiWrapper.DefineVar('ebTop', 'ebTop');
  APyDelphiWrapper.DefineVar('ebRight', 'ebRight');
  APyDelphiWrapper.DefineVar('ebBottom', 'ebBottom');
  APyDelphiWrapper.DefineVar('esNone', 'esNone');
  APyDelphiWrapper.DefineVar('esRaised', 'esRaised');
  APyDelphiWrapper.DefineVar('esLowered', 'esLowered');

  APyDelphiWrapper.DefineVar('pbHorizontal', 'pbHorizontal');
  APyDelphiWrapper.DefineVar('pbVertical', 'pbVertical');
  APyDelphiWrapper.DefineVar('pbstNormal', 'pbstNormal');
  APyDelphiWrapper.DefineVar('pbstMarquee', 'pbstMarquee');
  APyDelphiWrapper.DefineVar('pbsNormal', 'pbsNormal');
  APyDelphiWrapper.DefineVar('pbsError', 'pbsError');
  APyDelphiWrapper.DefineVar('pbsPaused', 'pbsPaused');

  APyDelphiWrapper.DefineVar('udLeft', 'udLeft');
  APyDelphiWrapper.DefineVar('udRight', 'udRight');
  APyDelphiWrapper.DefineVar('udHorizontal', 'udHorizontal');
  APyDelphiWrapper.DefineVar('udVertical', 'udVertical');
  APyDelphiWrapper.DefineVar('btNext', 'btNext');
  APyDelphiWrapper.DefineVar('btPrev', 'btPrev');
  APyDelphiWrapper.DefineVar('updNone', 'updNone');
  APyDelphiWrapper.DefineVar('updUp', 'updUp');
  APyDelphiWrapper.DefineVar('updDown', 'updDown');

  APyDelphiWrapper.DefineVar('hkShift', 'hkShift');
  APyDelphiWrapper.DefineVar('hkCtrl', 'hkCtrl');
  APyDelphiWrapper.DefineVar('hkAlt', 'hkAlt');
  APyDelphiWrapper.DefineVar('hkExt', 'hkExt');
  APyDelphiWrapper.DefineVar('hcNone', 'hcNone');
  APyDelphiWrapper.DefineVar('hcShift', 'hcShift');
  APyDelphiWrapper.DefineVar('hcCtrl', 'hcCtrl');
  APyDelphiWrapper.DefineVar('hcAlt', 'hcAlt');
  APyDelphiWrapper.DefineVar('hcShiftCtrl', 'hcShiftCtrl');
  APyDelphiWrapper.DefineVar('hcShiftAlt', 'hcShiftAlt');
  APyDelphiWrapper.DefineVar('hcCtrlAlt', 'hcCtrlAlt');
  APyDelphiWrapper.DefineVar('hcShiftCtrlAlt', 'hcShiftCtrlAlt');

  APyDelphiWrapper.DefineVar('aviNone', 'aviNone');
  APyDelphiWrapper.DefineVar('aviFindFolder', 'aviFindFolder');
  APyDelphiWrapper.DefineVar('aviFindFile', 'aviFindFile');
  APyDelphiWrapper.DefineVar('aviFindComputer', 'aviFindComputer');
  APyDelphiWrapper.DefineVar('aviCopyFiles', 'aviCopyFiles');
  APyDelphiWrapper.DefineVar('aviCopyFile', 'aviCopyFile');
  APyDelphiWrapper.DefineVar('aviRecycleFile', 'aviRecycleFile');
  APyDelphiWrapper.DefineVar('aviEmptyRecycle', 'aviEmptyRecycle');
  APyDelphiWrapper.DefineVar('aviDeleteFile', 'aviDeleteFile');

  APyDelphiWrapper.DefineVar('hsText', 'hsText');
  APyDelphiWrapper.DefineVar('hsOwnerDraw', 'hsOwnerDraw');
  APyDelphiWrapper.DefineVar('tsTrackBegin', 'tsTrackBegin');
  APyDelphiWrapper.DefineVar('tsTrackMove', 'tsTrackMove');
  APyDelphiWrapper.DefineVar('tsTrackEnd', 'tsTrackEnd');
  APyDelphiWrapper.DefineVar('hsButtons', 'hsButtons');
  APyDelphiWrapper.DefineVar('hsFlat', 'hsFlat');

  APyDelphiWrapper.DefineVar('CN_BANDCHANGE', CN_BANDCHANGE);
  APyDelphiWrapper.DefineVar('bmNone', 'bmNone');
  APyDelphiWrapper.DefineVar('bmClick', 'bmClick');
  APyDelphiWrapper.DefineVar('bmDblClick', 'bmDblClick');

  APyDelphiWrapper.DefineVar('soHorizontal', 'soHorizontal');
  APyDelphiWrapper.DefineVar('soVertical', 'soVertical');
  APyDelphiWrapper.DefineVar('sbFirst', 'sbFirst');
  APyDelphiWrapper.DefineVar('sbLast', 'sbLast');
  APyDelphiWrapper.DefineVar('bsNormal', 'bsNormal');
  APyDelphiWrapper.DefineVar('bsInvisible', 'bsInvisible');
  APyDelphiWrapper.DefineVar('bsGrayed', 'bsGrayed');
  APyDelphiWrapper.DefineVar('bsDepressed', 'bsDepressed');
  APyDelphiWrapper.DefineVar('bsHot', 'bsHot');

  APyDelphiWrapper.DefineVar('csExDropDown', 'csExDropDown');
  APyDelphiWrapper.DefineVar('csExSimple', 'csExSimple');
  APyDelphiWrapper.DefineVar('csExDropDownList', 'csExDropDownList');
  APyDelphiWrapper.DefineVar('csExCaseSensitive', 'csExCaseSensitive');
  APyDelphiWrapper.DefineVar('csExNoEditImage', 'csExNoEditImage');
  APyDelphiWrapper.DefineVar('csExNoEditImageIndent', 'csExNoEditImageIndent');
  APyDelphiWrapper.DefineVar('csExNoSizeLimit', 'csExNoSizeLimit');
  APyDelphiWrapper.DefineVar('csExPathWordBreak', 'csExPathWordBreak');
  APyDelphiWrapper.DefineVar('acoAutoSuggest', 'acoAutoSuggest');
  APyDelphiWrapper.DefineVar('acoAutoAppend', 'acoAutoAppend');
  APyDelphiWrapper.DefineVar('acoSearch', 'acoSearch');
  APyDelphiWrapper.DefineVar('acoFilterPrefixes', 'acoFilterPrefixes');
  APyDelphiWrapper.DefineVar('acoUseTab', 'acoUseTab');
  APyDelphiWrapper.DefineVar('acoUpDownKeyDropsList', 'acoUpDownKeyDropsList');
  APyDelphiWrapper.DefineVar('acoRtlReading', 'acoRtlReading');

  APyDelphiWrapper.DefineVar('CM_TABFONTCHANGED', CM_TABFONTCHANGED);

  APyDelphiWrapper.DefineVar('ftReadOnly', 'ftReadOnly');
  APyDelphiWrapper.DefineVar('ftHidden', 'ftHidden');
  APyDelphiWrapper.DefineVar('ftSystem', 'ftSystem');
  APyDelphiWrapper.DefineVar('ftVolumeID', 'ftVolumeID');
  APyDelphiWrapper.DefineVar('ftDirectory', 'ftDirectory');
  APyDelphiWrapper.DefineVar('ftArchive', 'ftArchive');
  APyDelphiWrapper.DefineVar('ftNormal', 'ftNormal');
  APyDelphiWrapper.DefineVar('dtUnknown', 'dtUnknown');
  APyDelphiWrapper.DefineVar('dtNoDrive', 'dtNoDrive');
  APyDelphiWrapper.DefineVar('dtFloppy', 'dtFloppy');
  APyDelphiWrapper.DefineVar('dtFixed', 'dtFixed');
  APyDelphiWrapper.DefineVar('dtNetwork', 'dtNetwork');
  APyDelphiWrapper.DefineVar('dtCDROM', 'dtCDROM');
  APyDelphiWrapper.DefineVar('dtRAM', 'dtRAM');

  APyDelphiWrapper.DefineVar('tcLowerCase', 'tcLowerCase');
  APyDelphiWrapper.DefineVar('tcUpperCase', 'tcUpperCase');

  APyDelphiWrapper.DefineVar('stNone', 'stNone');
  APyDelphiWrapper.DefineVar('stData', 'stData');
  APyDelphiWrapper.DefineVar('stText', 'stText');
  APyDelphiWrapper.DefineVar('stBoth', 'stBoth');
  APyDelphiWrapper.DefineVar('msControlSelect', 'msControlSelect');
  APyDelphiWrapper.DefineVar('msShiftSelect', 'msShiftSelect');
  APyDelphiWrapper.DefineVar('msVisibleOnly', 'msVisibleOnly');
  APyDelphiWrapper.DefineVar('msSiblingOnly', 'msSiblingOnly');
  APyDelphiWrapper.DefineVar('csPartial', 'csPartial');
  APyDelphiWrapper.DefineVar('csDimmed', 'csDimmed');
  APyDelphiWrapper.DefineVar('csExclusion', 'csExclusion');

  APyDelphiWrapper.DefineVar('dtkDate', 'dtkDate');
  APyDelphiWrapper.DefineVar('dtkTime', 'dtkTime');
  APyDelphiWrapper.DefineVar('dtkDateTime', 'dtkDateTime');

  APyDelphiWrapper.DefineVar('vsIcon', 'vsIcon');
  APyDelphiWrapper.DefineVar('vsSmallIcon', 'vsSmallIcon');
  APyDelphiWrapper.DefineVar('vsList', 'vsList');
  APyDelphiWrapper.DefineVar('vsReport', 'vsReport');

  // RichEdit
  APyDelphiWrapper.DefineVar('cchTextLimitDefault', cchTextLimitDefault);
  APyDelphiWrapper.DefineVar('MSFTEDIT_CLASS', 'MSFTEDIT_CLASS');
  APyDelphiWrapper.DefineVar('RICHEDIT_CLASSA', 'RICHEDIT_CLASSA');
  APyDelphiWrapper.DefineVar('RICHEDIT_CLASSW', 'RICHEDIT_CLASSW');
  APyDelphiWrapper.DefineVar('RICHEDIT_CLASS', 'RICHEDIT_CLASS');
  APyDelphiWrapper.DefineVar('RICHEDIT_CLASS10A', 'RICHEDIT_CLASS10A');
  APyDelphiWrapper.DefineVar('EM_CANPASTE', EM_CANPASTE);
  APyDelphiWrapper.DefineVar('EM_DISPLAYBAND', EM_DISPLAYBAND);
  APyDelphiWrapper.DefineVar('EM_EXGETSEL', EM_EXGETSEL);
  APyDelphiWrapper.DefineVar('EM_EXLIMITTEXT', EM_EXLIMITTEXT);
  APyDelphiWrapper.DefineVar('EM_EXLINEFROMCHAR', EM_EXLINEFROMCHAR);
  APyDelphiWrapper.DefineVar('EM_EXSETSEL', EM_EXSETSEL);
  APyDelphiWrapper.DefineVar('EM_FINDTEXT', EM_FINDTEXT);
  APyDelphiWrapper.DefineVar('EM_FORMATRANGE', EM_FORMATRANGE);
  APyDelphiWrapper.DefineVar('EM_GETCHARFORMAT', EM_GETCHARFORMAT);
  APyDelphiWrapper.DefineVar('EM_GETEVENTMASK', EM_GETEVENTMASK);
  APyDelphiWrapper.DefineVar('EM_GETOLEINTERFACE', EM_GETOLEINTERFACE);
  APyDelphiWrapper.DefineVar('EM_GETPARAFORMAT', EM_GETPARAFORMAT);
  APyDelphiWrapper.DefineVar('EM_GETSELTEXT', EM_GETSELTEXT);
  APyDelphiWrapper.DefineVar('EM_HIDESELECTION', EM_HIDESELECTION);
  APyDelphiWrapper.DefineVar('EM_PASTESPECIAL', EM_PASTESPECIAL);
  APyDelphiWrapper.DefineVar('EM_REQUESTRESIZE', EM_REQUESTRESIZE);
  APyDelphiWrapper.DefineVar('EM_SELECTIONTYPE', EM_SELECTIONTYPE);
  APyDelphiWrapper.DefineVar('EM_SETBKGNDCOLOR', EM_SETBKGNDCOLOR);
  APyDelphiWrapper.DefineVar('EM_SETCHARFORMAT', EM_SETCHARFORMAT);
  APyDelphiWrapper.DefineVar('EM_SETEVENTMASK', EM_SETEVENTMASK);
  APyDelphiWrapper.DefineVar('EM_SETOLECALLBACK', EM_SETOLECALLBACK);
  APyDelphiWrapper.DefineVar('EM_SETPARAFORMAT', EM_SETPARAFORMAT);
  APyDelphiWrapper.DefineVar('EM_SETTARGETDEVICE', EM_SETTARGETDEVICE);
  APyDelphiWrapper.DefineVar('EM_STREAMIN', EM_STREAMIN);
  APyDelphiWrapper.DefineVar('EM_STREAMOUT', EM_STREAMOUT);
  APyDelphiWrapper.DefineVar('EM_GETTEXTRANGE', EM_GETTEXTRANGE);
  APyDelphiWrapper.DefineVar('EM_FINDWORDBREAK', EM_FINDWORDBREAK);
  APyDelphiWrapper.DefineVar('EM_SETOPTIONS', EM_SETOPTIONS);
  APyDelphiWrapper.DefineVar('EM_GETOPTIONS', EM_GETOPTIONS);
  APyDelphiWrapper.DefineVar('EM_FINDTEXTEX', EM_FINDTEXTEX);
  APyDelphiWrapper.DefineVar('EM_GETWORDBREAKPROCEX', EM_GETWORDBREAKPROCEX);
  APyDelphiWrapper.DefineVar('EM_SETWORDBREAKPROCEX', EM_SETWORDBREAKPROCEX);
  APyDelphiWrapper.DefineVar('EM_SETUNDOLIMIT', EM_SETUNDOLIMIT);
  APyDelphiWrapper.DefineVar('EM_REDO', EM_REDO);
  APyDelphiWrapper.DefineVar('EM_CANREDO', EM_CANREDO);
  APyDelphiWrapper.DefineVar('EM_GETUNDONAME', EM_GETUNDONAME);
  APyDelphiWrapper.DefineVar('EM_GETREDONAME', EM_GETREDONAME);
  APyDelphiWrapper.DefineVar('EM_STOPGROUPTYPING', EM_STOPGROUPTYPING);
  APyDelphiWrapper.DefineVar('EM_SETTEXTMODE', EM_SETTEXTMODE);
  APyDelphiWrapper.DefineVar('EM_GETTEXTMODE', EM_GETTEXTMODE);
  APyDelphiWrapper.DefineVar('TM_PLAINTEXT', TM_PLAINTEXT);
  APyDelphiWrapper.DefineVar('TM_RICHTEXT', TM_RICHTEXT);
  APyDelphiWrapper.DefineVar('TM_SINGLELEVELUNDO', TM_SINGLELEVELUNDO);
  APyDelphiWrapper.DefineVar('TM_MULTILEVELUNDO', TM_MULTILEVELUNDO);
  APyDelphiWrapper.DefineVar('TM_SINGLECODEPAGE', TM_SINGLECODEPAGE);
  APyDelphiWrapper.DefineVar('TM_MULTICODEPAGE', TM_MULTICODEPAGE);
  APyDelphiWrapper.DefineVar('EM_AUTOURLDETECT', EM_AUTOURLDETECT);
  APyDelphiWrapper.DefineVar('EM_GETAUTOURLDETECT', EM_GETAUTOURLDETECT);
  APyDelphiWrapper.DefineVar('EM_SETPALETTE', EM_SETPALETTE);
  APyDelphiWrapper.DefineVar('EM_GETTEXTEX', EM_GETTEXTEX);
  APyDelphiWrapper.DefineVar('EM_GETTEXTLENGTHEX', EM_GETTEXTLENGTHEX);
  APyDelphiWrapper.DefineVar('EM_SETPUNCTUATION', EM_SETPUNCTUATION);
  APyDelphiWrapper.DefineVar('EM_GETPUNCTUATION', EM_GETPUNCTUATION);
  APyDelphiWrapper.DefineVar('EM_SETWORDWRAPMODE', EM_SETWORDWRAPMODE);
  APyDelphiWrapper.DefineVar('EM_GETWORDWRAPMODE', EM_GETWORDWRAPMODE);
  APyDelphiWrapper.DefineVar('EM_SETIMECOLOR', EM_SETIMECOLOR);
  APyDelphiWrapper.DefineVar('EM_GETIMECOLOR', EM_GETIMECOLOR);
  APyDelphiWrapper.DefineVar('EM_SETIMEOPTIONS', EM_SETIMEOPTIONS);
  APyDelphiWrapper.DefineVar('EM_GETIMEOPTIONS', EM_GETIMEOPTIONS);
  APyDelphiWrapper.DefineVar('EM_CONVPOSITION', EM_CONVPOSITION);
  APyDelphiWrapper.DefineVar('EM_SETLANGOPTIONS', EM_SETLANGOPTIONS);
  APyDelphiWrapper.DefineVar('EM_GETLANGOPTIONS', EM_GETLANGOPTIONS);
  APyDelphiWrapper.DefineVar('EM_GETIMECOMPMODE', EM_GETIMECOMPMODE);
  APyDelphiWrapper.DefineVar('EM_FINDTEXTW', EM_FINDTEXTW);
  APyDelphiWrapper.DefineVar('EM_FINDTEXTEXW', EM_FINDTEXTEXW);
  APyDelphiWrapper.DefineVar('EM_RECONVERSION', EM_RECONVERSION);
  APyDelphiWrapper.DefineVar('EM_SETIMEMODEBIAS', EM_SETIMEMODEBIAS);
  APyDelphiWrapper.DefineVar('EM_GETIMEMODEBIAS', EM_GETIMEMODEBIAS);
  APyDelphiWrapper.DefineVar('EM_SETBIDIOPTIONS', EM_SETBIDIOPTIONS);
  APyDelphiWrapper.DefineVar('EM_GETBIDIOPTIONS', EM_GETBIDIOPTIONS);
  APyDelphiWrapper.DefineVar('EM_SETTYPOGRAPHYOPTIONS', EM_SETTYPOGRAPHYOPTIONS);
  APyDelphiWrapper.DefineVar('EM_GETTYPOGRAPHYOPTIONS', EM_GETTYPOGRAPHYOPTIONS);
  APyDelphiWrapper.DefineVar('EM_SETEDITSTYLE', EM_SETEDITSTYLE);
  APyDelphiWrapper.DefineVar('EM_GETEDITSTYLE', EM_GETEDITSTYLE);
  APyDelphiWrapper.DefineVar('EM_OUTLINE', EM_OUTLINE);
  APyDelphiWrapper.DefineVar('EM_GETSCROLLPOS', EM_GETSCROLLPOS);
  APyDelphiWrapper.DefineVar('EM_SETSCROLLPOS', EM_SETSCROLLPOS);
  APyDelphiWrapper.DefineVar('EM_SETFONTSIZE', EM_SETFONTSIZE);
  APyDelphiWrapper.DefineVar('EM_GETZOOM', EM_GETZOOM);
  APyDelphiWrapper.DefineVar('EM_SETZOOM', EM_SETZOOM);
  APyDelphiWrapper.DefineVar('EM_GETVIEWKIND', EM_GETVIEWKIND);
  APyDelphiWrapper.DefineVar('EM_SETVIEWKIND', EM_SETVIEWKIND);
  APyDelphiWrapper.DefineVar('EM_GETPAGE', EM_GETPAGE);
  APyDelphiWrapper.DefineVar('EM_SETPAGE', EM_SETPAGE);
  APyDelphiWrapper.DefineVar('EM_GETHYPHENATEINFO', EM_GETHYPHENATEINFO);
  APyDelphiWrapper.DefineVar('EM_SETHYPHENATEINFO', EM_SETHYPHENATEINFO);
  APyDelphiWrapper.DefineVar('EM_GETPAGEROTATE', EM_GETPAGEROTATE);
  APyDelphiWrapper.DefineVar('EM_SETPAGEROTATE', EM_SETPAGEROTATE);
  APyDelphiWrapper.DefineVar('EM_GETCTFMODEBIAS', EM_GETCTFMODEBIAS);
  APyDelphiWrapper.DefineVar('EM_SETCTFMODEBIAS', EM_SETCTFMODEBIAS);
  APyDelphiWrapper.DefineVar('EM_GETCTFOPENSTATUS', EM_GETCTFOPENSTATUS);
  APyDelphiWrapper.DefineVar('EM_SETCTFOPENSTATUS', EM_SETCTFOPENSTATUS);
  APyDelphiWrapper.DefineVar('EM_GETIMECOMPTEXT', EM_GETIMECOMPTEXT);
  APyDelphiWrapper.DefineVar('EM_ISIME', EM_ISIME);
  APyDelphiWrapper.DefineVar('EM_GETIMEPROPERTY', EM_GETIMEPROPERTY);
  APyDelphiWrapper.DefineVar('EM_GETQUERYRTFOBJ', EM_GETQUERYRTFOBJ);
  APyDelphiWrapper.DefineVar('EM_SETQUERYRTFOBJ', EM_SETQUERYRTFOBJ);
  APyDelphiWrapper.DefineVar('EPR_0', EPR_0);
  APyDelphiWrapper.DefineVar('EPR_270', EPR_270);
  APyDelphiWrapper.DefineVar('EPR_180', EPR_180);
  APyDelphiWrapper.DefineVar('EPR_90', EPR_90);
  APyDelphiWrapper.DefineVar('EPR_SE', EPR_SE);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_DEFAULT', CTFMODEBIAS_DEFAULT);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_FILENAME', CTFMODEBIAS_FILENAME);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_NAME', CTFMODEBIAS_NAME);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_READING', CTFMODEBIAS_READING);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_DATETIME', CTFMODEBIAS_DATETIME);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_CONVERSATION', CTFMODEBIAS_CONVERSATION);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_NUMERIC', CTFMODEBIAS_NUMERIC);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_HIRAGANA', CTFMODEBIAS_HIRAGANA);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_KATAKANA', CTFMODEBIAS_KATAKANA);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_HANGUL', CTFMODEBIAS_HANGUL);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_HALFWIDTHKATAKANA', CTFMODEBIAS_HALFWIDTHKATAKANA);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_FULLWIDTHALPHANUMERIC', CTFMODEBIAS_FULLWIDTHALPHANUMERIC);
  APyDelphiWrapper.DefineVar('CTFMODEBIAS_HALFWIDTHALPHANUMERIC', CTFMODEBIAS_HALFWIDTHALPHANUMERIC);
  APyDelphiWrapper.DefineVar('IMF_SMODE_PLAURALCLAUSE', IMF_SMODE_PLAURALCLAUSE);
  APyDelphiWrapper.DefineVar('IMF_SMODE_NONE', IMF_SMODE_NONE);
  APyDelphiWrapper.DefineVar('ICT_RESULTREADSTR', ICT_RESULTREADSTR);
  APyDelphiWrapper.DefineVar('EMO_EXIT', EMO_EXIT);
  APyDelphiWrapper.DefineVar('EMO_ENTER', EMO_ENTER);
  APyDelphiWrapper.DefineVar('EMO_PROMOTE', EMO_PROMOTE);
  APyDelphiWrapper.DefineVar('EMO_EXPAND', EMO_EXPAND);
  APyDelphiWrapper.DefineVar('EMO_MOVESELECTION', EMO_MOVESELECTION);
  APyDelphiWrapper.DefineVar('EMO_GETVIEWMODE', EMO_GETVIEWMODE);
  APyDelphiWrapper.DefineVar('EMO_EXPANDSELECTION', EMO_EXPANDSELECTION);
  APyDelphiWrapper.DefineVar('EMO_EXPANDDOCUMENT', EMO_EXPANDDOCUMENT);
  APyDelphiWrapper.DefineVar('VM_NORMAL', VM_NORMAL);
  APyDelphiWrapper.DefineVar('VM_OUTLINE', VM_OUTLINE);
  APyDelphiWrapper.DefineVar('VM_PAGE', VM_PAGE);
  APyDelphiWrapper.DefineVar('SES_EMULATESYSEDIT', SES_EMULATESYSEDIT);
  APyDelphiWrapper.DefineVar('SES_BEEPONMAXTEXT', SES_BEEPONMAXTEXT);
  APyDelphiWrapper.DefineVar('SES_EXTENDBACKCOLOR', SES_EXTENDBACKCOLOR);
  APyDelphiWrapper.DefineVar('SES_MAPCPS', SES_MAPCPS);
  APyDelphiWrapper.DefineVar('SES_HYPERLINKTOOLTIPS', SES_HYPERLINKTOOLTIPS);
  APyDelphiWrapper.DefineVar('SES_EMULATE10', SES_EMULATE10);
  APyDelphiWrapper.DefineVar('SES_DEFAULTLATINLIGA', SES_DEFAULTLATINLIGA);
  APyDelphiWrapper.DefineVar('SES_USECRLF', SES_USECRLF);
  APyDelphiWrapper.DefineVar('SES_NOFOCUSLINKNOTIFY', SES_NOFOCUSLINKNOTIFY);
  APyDelphiWrapper.DefineVar('SES_NOXLTSYMBOLRANGE', SES_NOXLTSYMBOLRANGE);
  APyDelphiWrapper.DefineVar('SES_USEAIMM', SES_USEAIMM);
  APyDelphiWrapper.DefineVar('SES_NOIME', SES_NOIME);
  APyDelphiWrapper.DefineVar('SES_ALLOWBEEPS', SES_ALLOWBEEPS);
  APyDelphiWrapper.DefineVar('SES_UPPERCASE', SES_UPPERCASE);
  APyDelphiWrapper.DefineVar('SES_LOWERCASE', SES_LOWERCASE);
  APyDelphiWrapper.DefineVar('SES_NOINPUTSEQUENCECHK', SES_NOINPUTSEQUENCECHK);
  APyDelphiWrapper.DefineVar('SES_BIDI', SES_BIDI);
  APyDelphiWrapper.DefineVar('SES_SCROLLONKILLFOCUS', SES_SCROLLONKILLFOCUS);
  APyDelphiWrapper.DefineVar('SES_XLTCRCRLFTOCR', SES_XLTCRCRLFTOCR);
  APyDelphiWrapper.DefineVar('SES_DRAFTMODE', SES_DRAFTMODE);
  APyDelphiWrapper.DefineVar('SES_USECTF', SES_USECTF);
  APyDelphiWrapper.DefineVar('SES_HIDEGRIDLINES', SES_HIDEGRIDLINES);
  APyDelphiWrapper.DefineVar('SES_USEATFONT', SES_USEATFONT);
  APyDelphiWrapper.DefineVar('SES_CUSTOMLOOK', SES_CUSTOMLOOK);
  APyDelphiWrapper.DefineVar('SES_LBSCROLLNOTIFY', SES_LBSCROLLNOTIFY);
  APyDelphiWrapper.DefineVar('SES_CTFALLOWEMBED', SES_CTFALLOWEMBED);
  APyDelphiWrapper.DefineVar('SES_CTFALLOWSMARTTAG', SES_CTFALLOWSMARTTAG);
  APyDelphiWrapper.DefineVar('SES_CTFALLOWPROOFING', SES_CTFALLOWPROOFING);
  APyDelphiWrapper.DefineVar('IMF_AUTOKEYBOARD', IMF_AUTOKEYBOARD);
  APyDelphiWrapper.DefineVar('IMF_AUTOFONT', IMF_AUTOFONT);
  APyDelphiWrapper.DefineVar('IMF_IMECANCELCOMPLETE', IMF_IMECANCELCOMPLETE);
  APyDelphiWrapper.DefineVar('IMF_IMEALWAYSSENDNOTIFY', IMF_IMEALWAYSSENDNOTIFY);
  APyDelphiWrapper.DefineVar('IMF_AUTOFONTSIZEADJUST', IMF_AUTOFONTSIZEADJUST);
  APyDelphiWrapper.DefineVar('IMF_UIFONTS', IMF_UIFONTS);
  APyDelphiWrapper.DefineVar('IMF_NOIMPLICITLANG', IMF_NOIMPLICITLANG);
  APyDelphiWrapper.DefineVar('IMF_DUALFONT', IMF_DUALFONT);
  APyDelphiWrapper.DefineVar('IMF_NOKBDLIDFIXUP', IMF_NOKBDLIDFIXUP);
  APyDelphiWrapper.DefineVar('IMF_NORTFFONTSUBSTITUTE', IMF_NORTFFONTSUBSTITUTE);
  APyDelphiWrapper.DefineVar('IMF_SPELLCHECKING', IMF_SPELLCHECKING);
  APyDelphiWrapper.DefineVar('IMF_TKBPREDICTION', IMF_TKBPREDICTION);
  APyDelphiWrapper.DefineVar('IMF_IMEUIINTEGRATION', IMF_IMEUIINTEGRATION);
  APyDelphiWrapper.DefineVar('ICM_NOTOPEN', ICM_NOTOPEN);
  APyDelphiWrapper.DefineVar('ICM_LEVEL3', ICM_LEVEL3);
  APyDelphiWrapper.DefineVar('ICM_LEVEL2', ICM_LEVEL2);
  APyDelphiWrapper.DefineVar('ICM_LEVEL2_5', ICM_LEVEL2_5);
  APyDelphiWrapper.DefineVar('ICM_LEVEL2_SUI', ICM_LEVEL2_SUI);
  APyDelphiWrapper.DefineVar('EN_MSGFILTER', EN_MSGFILTER);
  APyDelphiWrapper.DefineVar('EN_REQUESTRESIZE', EN_REQUESTRESIZE);
  APyDelphiWrapper.DefineVar('EN_SELCHANGE', EN_SELCHANGE);
  APyDelphiWrapper.DefineVar('EN_DROPFILES', EN_DROPFILES);
  APyDelphiWrapper.DefineVar('EN_PROTECTED', EN_PROTECTED);
  APyDelphiWrapper.DefineVar('EN_CORRECTTEXT', EN_CORRECTTEXT);
  APyDelphiWrapper.DefineVar('EN_STOPNOUNDO', EN_STOPNOUNDO);
  APyDelphiWrapper.DefineVar('EN_IMECHANGE', EN_IMECHANGE);
  APyDelphiWrapper.DefineVar('EN_SAVECLIPBOARD', EN_SAVECLIPBOARD);
  APyDelphiWrapper.DefineVar('EN_OLEOPFAILED', EN_OLEOPFAILED);
  APyDelphiWrapper.DefineVar('EN_OBJECTPOSITIONS', EN_OBJECTPOSITIONS);
  APyDelphiWrapper.DefineVar('EN_LINK', EN_LINK);
  APyDelphiWrapper.DefineVar('EN_DRAGDROPDONE', EN_DRAGDROPDONE);
  APyDelphiWrapper.DefineVar('ENM_NONE', ENM_NONE);
  APyDelphiWrapper.DefineVar('ENM_CHANGE', ENM_CHANGE);
  APyDelphiWrapper.DefineVar('ENM_UPDATE', ENM_UPDATE);
  APyDelphiWrapper.DefineVar('ENM_SCROLL', ENM_SCROLL);
  APyDelphiWrapper.DefineVar('ENM_KEYEVENTS', ENM_KEYEVENTS);
  APyDelphiWrapper.DefineVar('ENM_MOUSEEVENTS', ENM_MOUSEEVENTS);
  APyDelphiWrapper.DefineVar('ENM_REQUESTRESIZE', ENM_REQUESTRESIZE);
  APyDelphiWrapper.DefineVar('ENM_SELCHANGE', ENM_SELCHANGE);
  APyDelphiWrapper.DefineVar('ENM_DROPFILES', ENM_DROPFILES);
  APyDelphiWrapper.DefineVar('ENM_PROTECTED', ENM_PROTECTED);
  APyDelphiWrapper.DefineVar('ENM_CORRECTTEXT', ENM_CORRECTTEXT);
  APyDelphiWrapper.DefineVar('ENM_SCROLLEVENTS', ENM_SCROLLEVENTS);
  APyDelphiWrapper.DefineVar('ENM_DRAGDROPDONE', ENM_DRAGDROPDONE);
  APyDelphiWrapper.DefineVar('ENM_IMECHANGE', ENM_IMECHANGE);
  APyDelphiWrapper.DefineVar('ENM_LANGCHANGE', ENM_LANGCHANGE);
  APyDelphiWrapper.DefineVar('ENM_OBJECTPOSITIONS', ENM_OBJECTPOSITIONS);
  APyDelphiWrapper.DefineVar('ENM_LINK', ENM_LINK);
  APyDelphiWrapper.DefineVar('ES_SAVESEL', ES_SAVESEL);
  APyDelphiWrapper.DefineVar('ES_SUNKEN', ES_SUNKEN);
  APyDelphiWrapper.DefineVar('ES_DISABLENOSCROLL', ES_DISABLENOSCROLL);
  APyDelphiWrapper.DefineVar('ES_SELECTIONBAR', ES_SELECTIONBAR);
  APyDelphiWrapper.DefineVar('ES_NOOLEDRAGDROP', ES_NOOLEDRAGDROP);
  APyDelphiWrapper.DefineVar('ES_EX_NOCALLOLEINIT', ES_EX_NOCALLOLEINIT);
  APyDelphiWrapper.DefineVar('ES_VERTICAL', ES_VERTICAL);
  APyDelphiWrapper.DefineVar('ES_NOIME', ES_NOIME);
  APyDelphiWrapper.DefineVar('ES_SELFIME', ES_SELFIME);
  APyDelphiWrapper.DefineVar('ECO_AUTOWORDSELECTION', ECO_AUTOWORDSELECTION);
  APyDelphiWrapper.DefineVar('ECO_AUTOVSCROLL', ECO_AUTOVSCROLL);
  APyDelphiWrapper.DefineVar('ECO_AUTOHSCROLL', ECO_AUTOHSCROLL);
  APyDelphiWrapper.DefineVar('ECO_NOHIDESEL', ECO_NOHIDESEL);
  APyDelphiWrapper.DefineVar('ECO_READONLY', ECO_READONLY);
  APyDelphiWrapper.DefineVar('ECO_WANTRETURN', ECO_WANTRETURN);
  APyDelphiWrapper.DefineVar('ECO_SAVESEL', ECO_SAVESEL);
  APyDelphiWrapper.DefineVar('ECO_SELECTIONBAR', ECO_SELECTIONBAR);
  APyDelphiWrapper.DefineVar('ECO_VERTICAL', ECO_VERTICAL);
  APyDelphiWrapper.DefineVar('ECOOP_SET', ECOOP_SET);
  APyDelphiWrapper.DefineVar('ECOOP_OR', ECOOP_OR);
  APyDelphiWrapper.DefineVar('ECOOP_AND', ECOOP_AND);
  APyDelphiWrapper.DefineVar('ECOOP_XOR', ECOOP_XOR);
  APyDelphiWrapper.DefineVar('WB_CLASSIFY', WB_CLASSIFY);
  APyDelphiWrapper.DefineVar('WB_MOVEWORDLEFT', WB_MOVEWORDLEFT);
  APyDelphiWrapper.DefineVar('WB_MOVEWORDRIGHT', WB_MOVEWORDRIGHT);
  APyDelphiWrapper.DefineVar('WB_LEFTBREAK', WB_LEFTBREAK);
  APyDelphiWrapper.DefineVar('WB_RIGHTBREAK', WB_RIGHTBREAK);
  APyDelphiWrapper.DefineVar('WB_MOVEWORDPREV', WB_MOVEWORDPREV);
  APyDelphiWrapper.DefineVar('WB_MOVEWORDNEXT', WB_MOVEWORDNEXT);
  APyDelphiWrapper.DefineVar('WB_PREVBREAK', WB_PREVBREAK);
  APyDelphiWrapper.DefineVar('WB_NEXTBREAK', WB_NEXTBREAK);
  APyDelphiWrapper.DefineVar('PC_FOLLOWING', PC_FOLLOWING);
  APyDelphiWrapper.DefineVar('PC_LEADING', PC_LEADING);
  APyDelphiWrapper.DefineVar('PC_OVERFLOW', PC_OVERFLOW);
  APyDelphiWrapper.DefineVar('PC_DELIMITER', PC_DELIMITER);
  APyDelphiWrapper.DefineVar('WBF_WORDWRAP', WBF_WORDWRAP);
  APyDelphiWrapper.DefineVar('WBF_WORDBREAK', WBF_WORDBREAK);
  APyDelphiWrapper.DefineVar('WBF_OVERFLOW', WBF_OVERFLOW);
  APyDelphiWrapper.DefineVar('WBF_LEVEL1', WBF_LEVEL1);
  APyDelphiWrapper.DefineVar('WBF_LEVEL2', WBF_LEVEL2);
  APyDelphiWrapper.DefineVar('WBF_CUSTOM', WBF_CUSTOM);
  APyDelphiWrapper.DefineVar('IMF_FORCENONE', IMF_FORCENONE);
  APyDelphiWrapper.DefineVar('IMF_FORCEENABLE', IMF_FORCEENABLE);
  APyDelphiWrapper.DefineVar('IMF_FORCEDISABLE', IMF_FORCEDISABLE);
  APyDelphiWrapper.DefineVar('IMF_CLOSESTATUSWINDOW', IMF_CLOSESTATUSWINDOW);
  APyDelphiWrapper.DefineVar('IMF_VERTICAL', IMF_VERTICAL);
  APyDelphiWrapper.DefineVar('IMF_FORCEACTIVE', IMF_FORCEACTIVE);
  APyDelphiWrapper.DefineVar('IMF_FORCEINACTIVE', IMF_FORCEINACTIVE);
  APyDelphiWrapper.DefineVar('IMF_FORCEREMEMBER', IMF_FORCEREMEMBER);
  APyDelphiWrapper.DefineVar('IMF_MULTIPLEEDIT', IMF_MULTIPLEEDIT);
  APyDelphiWrapper.DefineVar('WBF_CLASS', WBF_CLASS);
  APyDelphiWrapper.DefineVar('WBF_ISWHITE', WBF_ISWHITE);
  APyDelphiWrapper.DefineVar('WBF_BREAKLINE', WBF_BREAKLINE);
  APyDelphiWrapper.DefineVar('WBF_BREAKAFTER', WBF_BREAKAFTER);
  APyDelphiWrapper.DefineVar('CFM_BOLD', CFM_BOLD);
  APyDelphiWrapper.DefineVar('CFM_ITALIC', CFM_ITALIC);
  APyDelphiWrapper.DefineVar('CFM_UNDERLINE', CFM_UNDERLINE);
  APyDelphiWrapper.DefineVar('CFM_STRIKEOUT', CFM_STRIKEOUT);
  APyDelphiWrapper.DefineVar('CFM_PROTECTED', CFM_PROTECTED);
  APyDelphiWrapper.DefineVar('CFM_LINK', CFM_LINK);
//  APyDelphiWrapper.DefineVar('CFM_SIZE', CFM_SIZE);
  APyDelphiWrapper.DefineVar('CFM_COLOR', CFM_COLOR);
  APyDelphiWrapper.DefineVar('CFM_FACE', CFM_FACE);
  APyDelphiWrapper.DefineVar('CFM_OFFSET', CFM_OFFSET);
  APyDelphiWrapper.DefineVar('CFM_CHARSET', CFM_CHARSET);
  APyDelphiWrapper.DefineVar('CFE_BOLD', CFE_BOLD);
  APyDelphiWrapper.DefineVar('CFE_ITALIC', CFE_ITALIC);
  APyDelphiWrapper.DefineVar('CFE_UNDERLINE', CFE_UNDERLINE);
  APyDelphiWrapper.DefineVar('CFE_STRIKEOUT', CFE_STRIKEOUT);
  APyDelphiWrapper.DefineVar('CFE_PROTECTED', CFE_PROTECTED);
  APyDelphiWrapper.DefineVar('CFE_LINK', CFE_LINK);
  APyDelphiWrapper.DefineVar('CFE_AUTOCOLOR', CFE_AUTOCOLOR);
  APyDelphiWrapper.DefineVar('yHeightCharPtsMost', yHeightCharPtsMost);
  APyDelphiWrapper.DefineVar('SCF_SELECTION', SCF_SELECTION);
  APyDelphiWrapper.DefineVar('SCF_WORD', SCF_WORD);
  APyDelphiWrapper.DefineVar('SCF_DEFAULT', SCF_DEFAULT);
  APyDelphiWrapper.DefineVar('SCF_ALL', SCF_ALL);
  APyDelphiWrapper.DefineVar('SCF_USEUIRULES', SCF_USEUIRULES);
  APyDelphiWrapper.DefineVar('SF_TEXT', SF_TEXT);
  APyDelphiWrapper.DefineVar('SF_RTF', SF_RTF);
  APyDelphiWrapper.DefineVar('SF_RTFNOOBJS', SF_RTFNOOBJS);
  APyDelphiWrapper.DefineVar('SF_TEXTIZED', SF_TEXTIZED);
  APyDelphiWrapper.DefineVar('SF_UNICODE', SF_UNICODE);
  APyDelphiWrapper.DefineVar('SFF_SELECTION', SFF_SELECTION);
  APyDelphiWrapper.DefineVar('SFF_PLAINRTF', SFF_PLAINRTF);
  APyDelphiWrapper.DefineVar('FT_MATCHCASE', FT_MATCHCASE);
  APyDelphiWrapper.DefineVar('FT_WHOLEWORD', FT_WHOLEWORD);
  APyDelphiWrapper.DefineVar('lDefaultTab', lDefaultTab);
//  APyDelphiWrapper.DefineVar('PFM_STARTINDENT', PFM_STARTINDENT);
//  APyDelphiWrapper.DefineVar('PFM_RIGHTINDENT', PFM_RIGHTINDENT);
//  APyDelphiWrapper.DefineVar('PFM_OFFSET', PFM_OFFSET);
//  APyDelphiWrapper.DefineVar('PFM_ALIGNMENT', PFM_ALIGNMENT);
//  APyDelphiWrapper.DefineVar('PFM_TABSTOPS', PFM_TABSTOPS);
//  APyDelphiWrapper.DefineVar('PFM_NUMBERING', PFM_NUMBERING);
//  APyDelphiWrapper.DefineVar('PFM_OFFSETINDENT', PFM_OFFSETINDENT);
  APyDelphiWrapper.DefineVar('PFN_BULLET', PFN_BULLET);
  APyDelphiWrapper.DefineVar('PFA_LEFT', PFA_LEFT);
  APyDelphiWrapper.DefineVar('PFA_RIGHT', PFA_RIGHT);
  APyDelphiWrapper.DefineVar('PFA_CENTER', PFA_CENTER);
//  APyDelphiWrapper.DefineVar('CFM_ALL', CFM_ALL);
  APyDelphiWrapper.DefineVar('CFM_SMALLCAPS', CFM_SMALLCAPS);
  APyDelphiWrapper.DefineVar('CFM_ALLCAPS', CFM_ALLCAPS);
  APyDelphiWrapper.DefineVar('CFM_HIDDEN', CFM_HIDDEN);
  APyDelphiWrapper.DefineVar('CFM_OUTLINE', CFM_OUTLINE);
  APyDelphiWrapper.DefineVar('CFM_SHADOW', CFM_SHADOW);
  APyDelphiWrapper.DefineVar('CFM_EMBOSS', CFM_EMBOSS);
  APyDelphiWrapper.DefineVar('CFM_IMPRINT', CFM_IMPRINT);
  APyDelphiWrapper.DefineVar('CFM_DISABLED', CFM_DISABLED);
  APyDelphiWrapper.DefineVar('CFM_REVISED', CFM_REVISED);
  APyDelphiWrapper.DefineVar('CFM_BACKCOLOR', CFM_BACKCOLOR);
  APyDelphiWrapper.DefineVar('CFM_COOKIE', CFM_COOKIE);
  APyDelphiWrapper.DefineVar('CFM_LCID', CFM_LCID);
  APyDelphiWrapper.DefineVar('CFM_UNDERLINETYPE', CFM_UNDERLINETYPE);
  APyDelphiWrapper.DefineVar('CFM_WEIGHT', CFM_WEIGHT);
  APyDelphiWrapper.DefineVar('CFM_SPACING', CFM_SPACING);
  APyDelphiWrapper.DefineVar('CFM_KERNING', CFM_KERNING);
  APyDelphiWrapper.DefineVar('CFM_STYLE', CFM_STYLE);
  APyDelphiWrapper.DefineVar('CFM_ANIMATION', CFM_ANIMATION);
  APyDelphiWrapper.DefineVar('CFM_REVAUTHOR', CFM_REVAUTHOR);
  APyDelphiWrapper.DefineVar('CFE_SUBSCRIPT', CFE_SUBSCRIPT);
  APyDelphiWrapper.DefineVar('CFE_SUPERSCRIPT', CFE_SUPERSCRIPT);
  APyDelphiWrapper.DefineVar('CFM_SUBSCRIPT', CFM_SUBSCRIPT);
  APyDelphiWrapper.DefineVar('CFM_SUPERSCRIPT', CFM_SUPERSCRIPT);
//  APyDelphiWrapper.DefineVar('CFM_EFFECTS2', CFM_EFFECTS2);
//  APyDelphiWrapper.DefineVar('CFM_ALL2', CFM_ALL2);
  APyDelphiWrapper.DefineVar('CFE_SMALLCAPS', CFE_SMALLCAPS);
  APyDelphiWrapper.DefineVar('CFE_ALLCAPS', CFE_ALLCAPS);
  APyDelphiWrapper.DefineVar('CFE_HIDDEN', CFE_HIDDEN);
  APyDelphiWrapper.DefineVar('CFE_OUTLINE', CFE_OUTLINE);
  APyDelphiWrapper.DefineVar('CFE_SHADOW', CFE_SHADOW);
  APyDelphiWrapper.DefineVar('CFE_EMBOSS', CFE_EMBOSS);
  APyDelphiWrapper.DefineVar('CFE_IMPRINT', CFE_IMPRINT);
  APyDelphiWrapper.DefineVar('CFE_DISABLED', CFE_DISABLED);
  APyDelphiWrapper.DefineVar('CFE_REVISED', CFE_REVISED);
  APyDelphiWrapper.DefineVar('CFE_AUTOBACKCOLOR', CFE_AUTOBACKCOLOR);
  APyDelphiWrapper.DefineVar('CFU_CF1UNDERLINE', CFU_CF1UNDERLINE);
  APyDelphiWrapper.DefineVar('CFU_INVERT', CFU_INVERT);
  APyDelphiWrapper.DefineVar('CFU_UNDERLINEDOTTED', CFU_UNDERLINEDOTTED);
  APyDelphiWrapper.DefineVar('CFU_UNDERLINEDOUBLE', CFU_UNDERLINEDOUBLE);
  APyDelphiWrapper.DefineVar('CFU_UNDERLINEWORD', CFU_UNDERLINEWORD);
  APyDelphiWrapper.DefineVar('CFU_UNDERLINE', CFU_UNDERLINE);
  APyDelphiWrapper.DefineVar('CFU_UNDERLINENONE', CFU_UNDERLINENONE);
  APyDelphiWrapper.DefineVar('PFM_SPACEBEFORE', PFM_SPACEBEFORE);
  APyDelphiWrapper.DefineVar('PFM_SPACEAFTER', PFM_SPACEAFTER);
  APyDelphiWrapper.DefineVar('PFM_LINESPACING', PFM_LINESPACING);
  APyDelphiWrapper.DefineVar('PFM_STYLE', PFM_STYLE);
  APyDelphiWrapper.DefineVar('PFM_BORDER', PFM_BORDER);
  APyDelphiWrapper.DefineVar('PFM_SHADING', PFM_SHADING);
  APyDelphiWrapper.DefineVar('PFM_NUMBERINGSTYLE', PFM_NUMBERINGSTYLE);
  APyDelphiWrapper.DefineVar('PFM_NUMBERINGTAB', PFM_NUMBERINGTAB);
  APyDelphiWrapper.DefineVar('PFM_NUMBERINGSTART', PFM_NUMBERINGSTART);
  APyDelphiWrapper.DefineVar('PFM_RTLPARA', PFM_RTLPARA);
  APyDelphiWrapper.DefineVar('PFM_KEEP', PFM_KEEP);
  APyDelphiWrapper.DefineVar('PFM_KEEPNEXT', PFM_KEEPNEXT);
  APyDelphiWrapper.DefineVar('PFM_PAGEBREAKBEFORE', PFM_PAGEBREAKBEFORE);
  APyDelphiWrapper.DefineVar('PFM_NOLINENUMBER', PFM_NOLINENUMBER);
  APyDelphiWrapper.DefineVar('PFM_NOWIDOWCONTROL', PFM_NOWIDOWCONTROL);
  APyDelphiWrapper.DefineVar('PFM_DONOTHYPHEN', PFM_DONOTHYPHEN);
  APyDelphiWrapper.DefineVar('PFM_SIDEBYSIDE', PFM_SIDEBYSIDE);
  APyDelphiWrapper.DefineVar('PFM_TABLE', PFM_TABLE);
  APyDelphiWrapper.DefineVar('PFM_TEXTWRAPPINGBREAK', PFM_TEXTWRAPPINGBREAK);
  APyDelphiWrapper.DefineVar('PFM_TABLEROWDELIMITER', PFM_TABLEROWDELIMITER);
  APyDelphiWrapper.DefineVar('PFM_COLLAPSED', PFM_COLLAPSED);
  APyDelphiWrapper.DefineVar('PFM_OUTLINELEVEL', PFM_OUTLINELEVEL);
  APyDelphiWrapper.DefineVar('PFM_BOX', PFM_BOX);
//  APyDelphiWrapper.DefineVar('PFM_ALL', PFM_ALL);
  APyDelphiWrapper.DefineVar('PFM_EFFECTS', PFM_EFFECTS);
//  APyDelphiWrapper.DefineVar('PFM_ALL2', PFM_ALL2);
  APyDelphiWrapper.DefineVar('PFE_RTLPARA', PFE_RTLPARA);
  APyDelphiWrapper.DefineVar('PFE_KEEP', PFE_KEEP);
  APyDelphiWrapper.DefineVar('PFE_KEEPNEXT', PFE_KEEPNEXT);
  APyDelphiWrapper.DefineVar('PFE_PAGEBREAKBEFORE', PFE_PAGEBREAKBEFORE);
  APyDelphiWrapper.DefineVar('PFE_NOLINENUMBER', PFE_NOLINENUMBER);
  APyDelphiWrapper.DefineVar('PFE_NOWIDOWCONTROL', PFE_NOWIDOWCONTROL);
  APyDelphiWrapper.DefineVar('PFE_DONOTHYPHEN', PFE_DONOTHYPHEN);
  APyDelphiWrapper.DefineVar('PFE_SIDEBYSIDE', PFE_SIDEBYSIDE);
  APyDelphiWrapper.DefineVar('PFE_TABLEROW', PFE_TABLEROW);
  APyDelphiWrapper.DefineVar('PFE_TABLECELLEND', PFE_TABLECELLEND);
  APyDelphiWrapper.DefineVar('PFE_TABLECELL', PFE_TABLECELL);
  APyDelphiWrapper.DefineVar('PFA_JUSTIFY', PFA_JUSTIFY);
  APyDelphiWrapper.DefineVar('SEL_EMPTY', SEL_EMPTY);
  APyDelphiWrapper.DefineVar('SEL_TEXT', SEL_TEXT);
  APyDelphiWrapper.DefineVar('SEL_OBJECT', SEL_OBJECT);
  APyDelphiWrapper.DefineVar('SEL_MULTICHAR', SEL_MULTICHAR);
  APyDelphiWrapper.DefineVar('SEL_MULTIOBJECT', SEL_MULTIOBJECT);
  APyDelphiWrapper.DefineVar('GCM_RIGHTMOUSEDROP', GCM_RIGHTMOUSEDROP);
  APyDelphiWrapper.DefineVar('CF_RTFNOOBJS', CF_RTFNOOBJS);
  APyDelphiWrapper.DefineVar('CF_RETEXTOBJ', CF_RETEXTOBJ);
  APyDelphiWrapper.DefineVar('UID_UNKNOWN', 'UID_UNKNOWN');
  APyDelphiWrapper.DefineVar('UID_TYPING', 'UID_TYPING');
  APyDelphiWrapper.DefineVar('UID_DELETE', 'UID_DELETE');
  APyDelphiWrapper.DefineVar('UID_DRAGDROP', 'UID_DRAGDROP');
  APyDelphiWrapper.DefineVar('UID_CUT', 'UID_CUT');
  APyDelphiWrapper.DefineVar('UID_PASTE', 'UID_PASTE');
  APyDelphiWrapper.DefineVar('GT_DEFAULT', GT_DEFAULT);
  APyDelphiWrapper.DefineVar('GT_USECRLF', GT_USECRLF);
  APyDelphiWrapper.DefineVar('GT_SELECTION', GT_SELECTION);
  APyDelphiWrapper.DefineVar('GT_RAWTEXT', GT_RAWTEXT);
  APyDelphiWrapper.DefineVar('GT_NOHIDDENTEXT', GT_NOHIDDENTEXT);
  APyDelphiWrapper.DefineVar('GTL_DEFAULT', GTL_DEFAULT);
  APyDelphiWrapper.DefineVar('GTL_USECRLF', GTL_USECRLF);
  APyDelphiWrapper.DefineVar('GTL_PRECISE', GTL_PRECISE);
  APyDelphiWrapper.DefineVar('GTL_CLOSE', GTL_CLOSE);
  APyDelphiWrapper.DefineVar('GTL_NUMCHARS', GTL_NUMCHARS);
  APyDelphiWrapper.DefineVar('GTL_NUMBYTES', GTL_NUMBYTES);
  APyDelphiWrapper.DefineVar('WCH_EMBEDDING', WCH_EMBEDDING);
end;

function TComCtrlsRegistration.Name: string;
begin
  Result := 'ComCtrls';
end;

procedure TComCtrlsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDateTimePicker);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPageControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTabSheet);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTrackBar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiProgressBar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomUpDown);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiUpDown);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomHotKey);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiHotKey);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCommonCalendar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiMonthCalendar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomHeaderControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiHeaderControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiToolWindow);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCoolBar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiAnimate);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiShellResources);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPageScroller);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomRichEdit);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRichEdit);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiComboBoxEx);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiToolButton);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiToolbar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomCustomTabControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomTabControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTabbedNotebook);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiFileListBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDriveComboBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDirectoryListBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiFilterComboBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomStatusBar);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiStatusBar);

  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTreeNodes);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTreeNode);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomTreeView);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTreeView);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiListItems);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiListItem);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomListView);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiListView);

  APyDelphiWrapper.EventHandlers.RegisterHandler(TTabChangingEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVChangingEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVChangedEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVEditingEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVEditedEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVExpandingEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVCollapsingEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVExpandedEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVCompareEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVHintEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVCustomDrawEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVCustomDrawItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVAdvancedCustomDrawEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVAdvancedCustomDrawItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVCreateNodeClassEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TDragDropEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TDragOverEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TEndDragEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TStartDragEventHandler);
{$IFDEF DELPHI11_OR_HIGHER}
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVCheckStateChangedEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TTVCheckStateChangingEventHandler);
{$ENDIF}

  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVDeletedEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVEditingEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVEditedEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVChangeEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVChangingEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVColumnClickEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVColumnRClickEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVCompareEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVNotifyEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVSelectItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVCheckedItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVDrawItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVCustomDrawEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVCustomDrawItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVCustomDrawSubItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVAdvancedCustomDrawEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVAdvancedCustomDrawItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVAdvancedCustomDrawSubItemEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVOwnerDataEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVOwnerDataFindEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVOwnerDataHintEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVOwnerDataStateChangeEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVSubItemImageEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVInfoTipEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TLVCreateItemClassEventHandler);

  APyDelphiWrapper.EventHandlers.RegisterHandler(TUDClickEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TUDChangingEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TUDChangingEventExHandler);
end;


{ TPyDelphiDateTimePicker }

class function TPyDelphiDateTimePicker.DelphiObjectClass: TClass;
begin
  Result := TDateTimePicker;
end;

function TPyDelphiDateTimePicker.GetDelphiObject: TDateTimePicker;
begin
  Result := TDateTimePicker(inherited DelphiObject);
end;

procedure TPyDelphiDateTimePicker.SetDelphiObject(const Value: TDateTimePicker);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPageControl }

class function TPyDelphiPageControl.DelphiObjectClass: TClass;
begin
  Result := TPageControl;
end;

function TPyDelphiPageControl.FindNextPage_Wrapper(
  args: PPyObject): PPyObject;
//  function FindNextPage(CurPage: TTabSheet; GoForward, CheckTabVisible: Boolean): TTabSheet;
var
  _CurPage: TObject;
  _pCurPage: PPyObject;
  _pGoForward, _pCheckTabVisible: PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'OOO:FindNextPage',@_pCurPage, @_pGoForward, @_pCheckTabVisible ) <> 0 then begin
      if CheckObjAttribute(_pCurPage, 'CurPage', TTabSheet, _CurPage) then
        Result := Wrap( DelphiObject.FindNextPage(TTabSheet(_CurPage), PyObject_IsTrue(_pGoForward)<>0, PyObject_IsTrue(_pCheckTabVisible)<>0) )
      else
        Result := nil;
    end else
      Result := nil;
  end;
end;

function TPyDelphiPageControl.GetDelphiObject: TPageControl;
begin
  Result := TPageControl(inherited DelphiObject);
end;

function TPyDelphiPageControl.GetHitTestInfoAt_Wrapper(
  args: PPyObject): PPyObject;

  procedure AppendString(const AText : string);
  var
    _text : PPyObject;
  begin
    with GetPythonEngine do
    begin
      _text := PyUnicodeFromString(AText);
      PyList_Append(Result, _text);
      Py_DecRef(_text);
    end;
  end;

var
  x, y: Integer;
  _result : THitTests;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'ii:GetHitTestInfoAt',@x, @y ) <> 0 then begin
      _result := DelphiObject.GetHitTestInfoAt(x, y);
      Result := PyList_New(0);
      if htAbove in _result then
        AppendString('htAbove');
      if htBelow in _result then
        AppendString('htBelow');
      if htNowhere in _result then
        AppendString('htNowhere');
      if htOnItem in _result then
        AppendString('htOnItem');
      if htOnButton in _result then
        AppendString('htOnButton');
      if htOnIcon in _result then
        AppendString('htOnIcon');
      if htOnIndent in _result then
        AppendString('htOnIndent');
      if htOnLabel in _result then
        AppendString('htOnLabel');
      if htOnRight in _result then
        AppendString('htOnRight');
      if htOnStateIcon in _result then
        AppendString('htOnStateIcon');
      if htToLeft in _result then
        AppendString('htToLeft');
      if htToRight in _result then
        AppendString('htToRight');
    end else
      Result := nil;
  end;
end;

function TPyDelphiPageControl.Get_ActivePage(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.ActivePage);
end;

function TPyDelphiPageControl.Get_ActivePageIndex(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.ActivePageIndex);
end;

function TPyDelphiPageControl.Get_Canvas(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.Canvas);
end;

function TPyDelphiPageControl.Get_PageCount(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.PageCount);
end;

function TPyDelphiPageControl.Get_Pages(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Self.PyDelphiWrapper.DefaultContainerType.CreateInstance;
  with PythonToDelphi(Result) as TPyDelphiContainer do
    Setup(Self.PyDelphiWrapper, TPagesAccess.Create(Self.PyDelphiWrapper, Self.DelphiObject));
end;

function TPyDelphiPageControl.Get_RowCount(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.RowCount);
end;

function TPyDelphiPageControl.IndexOfTabAt_Wrapper(
  args: PPyObject): PPyObject;
var
  x, y: Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'ii:IndexOfTabAt',@x, @y ) <> 0 then begin
      Result := VariantAsPyObject( DelphiObject.IndexOfTabAt(x, y) );
    end else
      Result := nil;
  end;
end;

class procedure TPyDelphiPageControl.RegisterGetSets(
  PythonType: TPythonType);
begin
  PythonType.AddGetSet('ActivePage', @TPyDelphiPageControl.Get_ActivePage, @TPyDelphiPageControl.Set_ActivePage,
        'Specifies the page currently displayed by the page control.', nil);
  PythonType.AddGetSet('ActivePageIndex', @TPyDelphiPageControl.Get_ActivePageIndex, @TPyDelphiPageControl.Set_ActivePageIndex,
        'Specifies the page currently displayed by the page control.', nil);
  PythonType.AddGetSet('Canvas', @TPyDelphiPageControl.Get_Canvas, nil,
        'Gives access to the tab control canvas.', nil);
  PythonType.AddGetSet('PageCount', @TPyDelphiPageControl.Get_PageCount, nil,
        'Indicates the number of pages in the TPageControl object.', nil);
  PythonType.AddGetSet('Pages', @TPyDelphiPageControl.Get_Pages, nil,
        'Lists all the pages in the TPageControl.', nil);
  PythonType.AddGetSet('RowCount', @TPyDelphiPageControl.Get_RowCount, nil,
        '', nil);
end;

class procedure TPyDelphiPageControl.RegisterMethods(
  PythonType: TPythonType);
begin
  PythonType.AddMethod('IndexOfTabAt', @TPyDelphiPageControl.IndexOfTabAt_Wrapper,
    PAnsiChar('TPageControl.IndexOfTabAt()'#10 +
    'Indicates the index of the tab at a specified point.'));
  PythonType.AddMethod('GetHitTestInfoAt', @TPyDelphiPageControl.GetHitTestInfoAt_Wrapper,
    PAnsiChar('TPageControl.GetHitTestInfoAt()'#10 +
    'Returns information about the location of a point relative to the client area of the tab control.'));
  PythonType.AddMethod('TabRect', @TPyDelphiPageControl.TabRect_Wrapper,
    PAnsiChar('TPageControl.TabRect()'#10 +
    'Returns the bounding rectangle for a specified tab.'));
  PythonType.AddMethod('ScrollTabs', @TPyDelphiPageControl.ScrollTabs_Wrapper,
    PAnsiChar('TPageControl.ScrollTabs()'#10 +
    'Scrolls the tabs that are visible when the tab control is not multi-line.'));
  PythonType.AddMethod('FindNextPage', @TPyDelphiPageControl.FindNextPage_Wrapper,
    PAnsiChar('TPageControl.FindNextPage()'#10 +
    'Returns the next page in the page control before or after a specified page.'));
  PythonType.AddMethod('SelectNextPage', @TPyDelphiPageControl.SelectNextPage_Wrapper,
    PAnsiChar('TPageControl.SelectNextPage()'#10 +
    'Changes the ActivePage to the first visible page that is before or after the currently active page.'));
end;

function TPyDelphiPageControl.ScrollTabs_Wrapper(
  args: PPyObject): PPyObject;
var
  delta: Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'i:ScrollTabs',@delta ) <> 0 then begin
      DelphiObject.ScrollTabs(delta);
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiPageControl.SelectNextPage_Wrapper(
  args: PPyObject): PPyObject;
// procedure SelectNextPage(GoForward: Boolean; CheckTabVisible: Boolean = True);
var
  _pGoForward, _pCheckTabVisible: PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'OO:SelectNextPage',@_pGoForward, @_pCheckTabVisible ) <> 0 then begin
      DelphiObject.SelectNextPage(PyObject_IsTrue(_pGoForward)<>0, PyObject_IsTrue(_pCheckTabVisible)<>0);
      Result := ReturnNone;
    end else
      Result := nil;
  end;

end;

procedure TPyDelphiPageControl.SetDelphiObject(const Value: TPageControl);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiPageControl.Set_ActivePage(AValue: PPyObject;
  AContext: Pointer): integer;
var
  _object : TObject;
begin
  Adjust(@Self);
  if CheckObjAttribute(AValue, 'ActivePage', TTabSheet, _object) then
  begin
    Self.DelphiObject.ActivePage := TTabSheet(_object);
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiPageControl.Set_ActivePageIndex(AValue: PPyObject;
  AContext: Pointer): integer;
var
  _value : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'ActivePageIndex', _value) then
  begin
    DelphiObject.ActivePageIndex := _value;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiPageControl.TabRect_Wrapper(args: PPyObject): PPyObject;
var
  idx: Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  if GetPythonEngine.PyArg_ParseTuple( args, 'i:TabRect',@idx ) <> 0 then begin
    Result := WrapRect(PyDelphiWrapper, DelphiObject.TabRect(idx));
  end else
    Result := nil;
end;

{ TPyDelphiTabSheet }

class function TPyDelphiTabSheet.DelphiObjectClass: TClass;
begin
  Result := TTabSheet;
end;

function TPyDelphiTabSheet.GetDelphiObject: TTabSheet;
begin
  Result := TTabSheet(inherited DelphiObject);
end;

function TPyDelphiTabSheet.Get_PageControl(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.PageControl);
end;

function TPyDelphiTabSheet.Get_TabIndex(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.TabIndex);
end;

class procedure TPyDelphiTabSheet.RegisterGetSets(PythonType: TPythonType);
begin
  inherited;
  PythonType.AddGetSet('TabIndex', @TPyDelphiTabSheet.Get_TabIndex, nil,
        'Indicates the position of the tab sheet in the set of visible tabs in a TPageControl object.', nil);
  PythonType.AddGetSet('PageControl', @TPyDelphiTabSheet.Get_PageControl, @TPyDelphiTabSheet.Set_PageControl,
        'Indicates the page control object that contains the tab sheet.', nil);
end;

procedure TPyDelphiTabSheet.SetDelphiObject(const Value: TTabSheet);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiTabSheet.Set_PageControl(AValue: PPyObject;
  AContext: Pointer): integer;
var
  _object : TObject;
begin
  Adjust(@Self);
  if CheckObjAttribute(AValue, 'PageControl', TPageControl, _object) then
  begin
    Self.DelphiObject.PageControl := TPageControl(_object);
    Result := 0;
  end
  else
    Result := -1;
end;

{ TPagesAccess }

class function TPagesAccess.ExpectedContainerClass: TClass;
begin
  Result := TPageControl;
end;

function TPagesAccess.GetContainer: TPageControl;
begin
  Result := TPageControl(inherited Container);
end;

function TPagesAccess.GetItem(AIndex: Integer): PPyObject;
begin
  Result := Wrap( Container.Pages[AIndex] );
end;

function TPagesAccess.GetSize: Integer;
begin
  Result := Container.PageCount;
end;

function TPagesAccess.IndexOf(AValue: PPyObject): Integer;
var
  i : Integer;
  S : string;
  _obj : TPyObject;
  _value : TObject;
  _ctrl : TTabSheet;
begin
  Result := -1;
  with GetPythonEngine do
  begin
    if PyUnicode_Check(AValue) then
    begin
      S := PyUnicodeAsString(AValue);
      for i := 0 to Container.PageCount-1 do
        if SameText( Container.Pages[i].Name, S) then
        begin
          Result := i;
          Break;
        end;
    end
    else if IsDelphiObject(AValue) then
    begin
      _obj := PythonToDelphi(AValue);
      if _obj is TPyDelphiObject then
      begin
        _value := TPyDelphiObject(_obj).DelphiObject;
        if _value is TTabSheet then
        begin
          _ctrl := TTabSheet(_value);
          for i := 0 to Container.PageCount-1 do
            if Container.Pages[i] = _ctrl then
            begin
              Result := i;
              Break;
            end;
        end;
      end;
    end;
  end;
end;

class function TPagesAccess.Name: string;
begin
  Result := 'Pages';
end;

class function TPagesAccess.SupportsIndexOf: Boolean;
begin
  Result := True;
end;

{ TTabChangingEventHandler }

constructor TTabChangingEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTabChangingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

procedure TTabChangingEventHandler.DoEvent(Sender: TObject;
  var AllowChange: Boolean);
Var
  PyObject, PyTuple, PyResult, PyAllowChange: PPyObject;
  _varParam : TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyAllowChange := CreateVarParam(PyDelphiWrapper, AllowChange);
      _varParam := PythonToDelphi(PyAllowChange) as TPyDelphiVarParameter;
      PyTuple := PyTuple_New(2);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, PyAllowChange);
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);
          AllowChange := PyObject_IsTrue(_varParam.Value) = 1;
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TTabChangingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTabChangingEvent);
end;

{ TPyDelphiTrackBar }

class function TPyDelphiTrackBar.DelphiObjectClass: TClass;
begin
  Result := TTrackBar;
end;

function TPyDelphiTrackBar.GetDelphiObject: TTrackBar;
begin
  Result := TTrackBar(inherited DelphiObject);
end;

procedure TPyDelphiTrackBar.SetDelphiObject(const Value: TTrackBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiProgressBar }

class function TPyDelphiProgressBar.DelphiObjectClass: TClass;
begin
  Result := TProgressBar;
end;

function TPyDelphiProgressBar.GetDelphiObject: TProgressBar;
begin
  Result := TProgressBar(inherited DelphiObject);
end;

procedure TPyDelphiProgressBar.SetDelphiObject(const Value: TProgressBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomUpDown }

class function TPyDelphiCustomUpDown.DelphiObjectClass: TClass;
begin
  Result := TCustomUpDown;
end;

function TPyDelphiCustomUpDown.GetDelphiObject: TCustomUpDown;
begin
  Result := TCustomUpDown(inherited DelphiObject);
end;

procedure TPyDelphiCustomUpDown.SetDelphiObject(const Value: TCustomUpDown);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiUpDown }

class function TPyDelphiUpDown.DelphiObjectClass: TClass;
begin
  Result := TUpDown;
end;

function TPyDelphiUpDown.GetDelphiObject: TUpDown;
begin
  Result := TUpDown(inherited DelphiObject);
end;

procedure TPyDelphiUpDown.SetDelphiObject(const Value: TUpDown);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomHotKey }

class function TPyDelphiCustomHotKey.DelphiObjectClass: TClass;
begin
  Result := TCustomHotKey;
end;

function TPyDelphiCustomHotKey.GetDelphiObject: TCustomHotKey;
begin
  Result := TCustomHotKey(inherited DelphiObject);
end;

procedure TPyDelphiCustomHotKey.SetDelphiObject(const Value: TCustomHotKey);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiHotKey }

class function TPyDelphiHotKey.DelphiObjectClass: TClass;
begin
  Result := THotKey;
end;

function TPyDelphiHotKey.GetDelphiObject: THotKey;
begin
  Result := THotKey(inherited DelphiObject);
end;

procedure TPyDelphiHotKey.SetDelphiObject(const Value: THotKey);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCommonCalendar }

class function TPyDelphiCommonCalendar.DelphiObjectClass: TClass;
begin
  Result := TCommonCalendar;
end;

function TPyDelphiCommonCalendar.GetDelphiObject: TCommonCalendar;
begin
  Result := TCommonCalendar(inherited DelphiObject);
end;

procedure TPyDelphiCommonCalendar.SetDelphiObject(const Value: TCommonCalendar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiMonthCalendar }

class function TPyDelphiMonthCalendar.DelphiObjectClass: TClass;
begin
  Result := TMonthCalendar;
end;

function TPyDelphiMonthCalendar.GetDelphiObject: TMonthCalendar;
begin
  Result := TMonthCalendar(inherited DelphiObject);
end;

procedure TPyDelphiMonthCalendar.SetDelphiObject(const Value: TMonthCalendar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomHeaderControl }

class function TPyDelphiCustomHeaderControl.DelphiObjectClass: TClass;
begin
  Result := TCustomHeaderControl;
end;

function TPyDelphiCustomHeaderControl.GetDelphiObject: TCustomHeaderControl;
begin
  Result := TCustomHeaderControl(inherited DelphiObject);
end;

procedure TPyDelphiCustomHeaderControl.SetDelphiObject(const Value: TCustomHeaderControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiHeaderControl }

class function TPyDelphiHeaderControl.DelphiObjectClass: TClass;
begin
  Result := THeaderControl;
end;

function TPyDelphiHeaderControl.GetDelphiObject: THeaderControl;
begin
  Result := THeaderControl(inherited DelphiObject);
end;

procedure TPyDelphiHeaderControl.SetDelphiObject(const Value: THeaderControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiToolWindow }

class function TPyDelphiToolWindow.DelphiObjectClass: TClass;
begin
  Result := TToolWindow;
end;

function TPyDelphiToolWindow.GetDelphiObject: TToolWindow;
begin
  Result := TToolWindow(inherited DelphiObject);
end;

procedure TPyDelphiToolWindow.SetDelphiObject(const Value: TToolWindow);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCoolBar }

class function TPyDelphiCoolBar.DelphiObjectClass: TClass;
begin
  Result := TCoolBar;
end;

function TPyDelphiCoolBar.GetDelphiObject: TCoolBar;
begin
  Result := TCoolBar(inherited DelphiObject);
end;

procedure TPyDelphiCoolBar.SetDelphiObject(const Value: TCoolBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiAnimate }

class function TPyDelphiAnimate.DelphiObjectClass: TClass;
begin
  Result := TAnimate;
end;

function TPyDelphiAnimate.GetDelphiObject: TAnimate;
begin
  Result := TAnimate(inherited DelphiObject);
end;

procedure TPyDelphiAnimate.SetDelphiObject(const Value: TAnimate);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiShellResources }

class function TPyDelphiShellResources.DelphiObjectClass: TClass;
begin
  Result := TShellResources;
end;

function TPyDelphiShellResources.GetDelphiObject: TShellResources;
begin
  Result := TShellResources(inherited DelphiObject);
end;

procedure TPyDelphiShellResources.SetDelphiObject(const Value: TShellResources);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiShellResources }

class function TPyDelphiPageScroller.DelphiObjectClass: TClass;
begin
  Result := TPageScroller;
end;

function TPyDelphiPageScroller.GetDelphiObject: TPageScroller;
begin
  Result := TPageScroller(inherited DelphiObject);
end;

procedure TPyDelphiPageScroller.SetDelphiObject(const Value: TPageScroller);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRichEdit }

class function TPyDelphiRichEdit.DelphiObjectClass: TClass;
begin
  Result := TRichEdit;
end;

function TPyDelphiRichEdit.GetDelphiObject: TRichEdit;
begin
  Result := TRichEdit(inherited DelphiObject);
end;

procedure TPyDelphiRichEdit.SetDelphiObject(const Value: TRichEdit);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomRichEdit }

class function TPyDelphiCustomRichEdit.DelphiObjectClass: TClass;
begin
  Result := TCustomRichEdit;
end;

function TPyDelphiCustomRichEdit.GetDelphiObject: TCustomRichEdit;
begin
  Result := TCustomRichEdit(inherited DelphiObject);
end;

procedure TPyDelphiCustomRichEdit.SetDelphiObject(const Value: TCustomRichEdit);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiComboBoxEx }

class function TPyDelphiComboBoxEx.DelphiObjectClass: TClass;
begin
  Result := TComboBoxEx;
end;

function TPyDelphiComboBoxEx.GetDelphiObject: TComboBoxEx;
begin
  Result := TComboBoxEx(inherited DelphiObject);
end;

procedure TPyDelphiComboBoxEx.SetDelphiObject(const Value: TComboBoxEx);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiToolButton }

class function TPyDelphiToolButton.DelphiObjectClass: TClass;
begin
  Result := TToolButton;
end;

function TPyDelphiToolButton.GetDelphiObject: TToolButton;
begin
  Result := TToolButton(inherited DelphiObject);
end;

procedure TPyDelphiToolButton.SetDelphiObject(const Value: TToolButton);
begin
  inherited DelphiObject := Value;
end;

{ TToolbarAccess }

class function TToolbarAccess.ExpectedContainerClass: TClass;
begin
  Result := TToolbar;
end;

function TToolbarAccess.GetContainer: TToolbar;
begin
  Result := TToolbar(inherited Container);
end;

function TToolbarAccess.GetItem(AIndex: Integer): PPyObject;
begin
  Result := Wrap( Container.Buttons[AIndex] );
end;

function TToolbarAccess.GetSize: Integer;
begin
  Result := Container.ButtonCount;
end;

function TToolbarAccess.IndexOf(AValue: PPyObject): Integer;
var
  _obj: TPyObject;
  _item: TToolButton;
begin
  Result := -1;
  with GetPythonEngine do
  begin
    if IsDelphiObject(AValue) then
    begin
      _obj := PythonToDelphi(AValue);
      if (_obj is TPyDelphiObject) and
        (TPyDelphiObject(_obj).DelphiObject is TToolButton) then
      begin
        _item := TToolButton(TPyDelphiObject(_obj).DelphiObject);
        Result := _item.Index;
      end;
    end;
  end;
end;

class function TToolbarAccess.Name: string;
begin
  Result := 'Toolbar.Buttons'
end;

class function TToolbarAccess.SupportsIndexOf: Boolean;
begin
  Result := True;
end;

{ TPyDelphiToolbar }

class function TPyDelphiToolbar.DelphiObjectClass: TClass;
begin
  Result := TToolbar;
end;

class function TPyDelphiToolbar.GetContainerAccessClass: TContainerAccessClass;
begin
  Result := TToolbarAccess;
end;

function TPyDelphiToolbar.GetDelphiObject: TToolbar;
begin
  Result := TToolbar(inherited DelphiObject);
end;

function TPyDelphiToolbar.Get_Buttons(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := PyDelphiWrapper.DefaultContainerType.CreateInstance;
  with PythonToDelphi(Result) as TPyDelphiContainer do
    Setup(Self.PyDelphiWrapper, TToolbarAccess.Create(Self.PyDelphiWrapper,
      Self.DelphiObject));
end;

function TPyDelphiToolbar.Get_ButtonCount(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.ButtonCount);
end;

class procedure TPyDelphiToolbar.RegisterGetSets(PythonType: TPythonType);
begin
  with PythonType do
  begin
    AddGetSet('ButtonCount', @TPyDelphiToolbar.Get_ButtonCount, nil,
      'Indicates the number of buttons in the toolbar.', nil);
    AddGetSet('Actions', @TPyDelphiToolbar.Get_Buttons, nil,
      'Lists the buttons of the toolbar.', nil);
  end;
end;

procedure TPyDelphiToolbar.SetDelphiObject(const Value: TToolbar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomCustomTabControl }

class function TPyDelphiCustomCustomTabControl.DelphiObjectClass: TClass;
begin
  Result := TCustomTabControl;
end;

function TPyDelphiCustomCustomTabControl.GetDelphiObject: TCustomTabControl;
begin
  Result := TCustomTabControl(inherited DelphiObject);
end;

procedure TPyDelphiCustomCustomTabControl.SetDelphiObject(
  const Value: TCustomTabControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomTabControl }

class function TPyDelphiCustomTabControl.DelphiObjectClass: TClass;
begin
  Result := TTabControl;
end;

function TPyDelphiCustomTabControl.GetDelphiObject: TTabControl;
begin
  Result := TTabControl(inherited DelphiObject);
end;

procedure TPyDelphiCustomTabControl.SetDelphiObject(const Value: TTabControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiTabbedNotebook }

class function TPyDelphiTabbedNotebook.DelphiObjectClass: TClass;
begin
  Result := TTabbedNotebook;
end;

function TPyDelphiTabbedNotebook.GetDelphiObject: TTabbedNotebook;
begin
  Result := TTabbedNotebook(inherited DelphiObject);
end;

procedure TPyDelphiTabbedNotebook.SetDelphiObject(const Value: TTabbedNotebook);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiFileListBox }

class function TPyDelphiFileListBox.DelphiObjectClass: TClass;
begin
  Result := TFileListBox;
end;

function TPyDelphiFileListBox.GetDelphiObject: TFileListBox;
begin
  Result := TFileListBox(inherited DelphiObject);
end;

procedure TPyDelphiFileListBox.SetDelphiObject(const Value: TFileListBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiDriveComboBox }

class function TPyDelphiDriveComboBox.DelphiObjectClass: TClass;
begin
  Result := TDriveComboBox;
end;

function TPyDelphiDriveComboBox.GetDelphiObject: TDriveComboBox;
begin
  Result := TDriveComboBox(inherited DelphiObject);
end;

procedure TPyDelphiDriveComboBox.SetDelphiObject(const Value: TDriveComboBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiDirectoryListBox }

class function TPyDelphiDirectoryListBox.DelphiObjectClass: TClass;
begin
  Result := TDirectoryListBox;
end;

function TPyDelphiDirectoryListBox.GetDelphiObject: TDirectoryListBox;
begin
  Result := TDirectoryListBox(inherited DelphiObject);
end;

procedure TPyDelphiDirectoryListBox.SetDelphiObject(const Value: TDirectoryListBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiFilterComboBox }

class function TPyDelphiFilterComboBox.DelphiObjectClass: TClass;
begin
  Result := TFilterComboBox;
end;

function TPyDelphiFilterComboBox.GetDelphiObject: TFilterComboBox;
begin
  Result := TFilterComboBox(inherited DelphiObject);
end;

procedure TPyDelphiFilterComboBox.SetDelphiObject(const Value: TFilterComboBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomStatusBar }

class function TPyDelphiCustomStatusBar.DelphiObjectClass: TClass;
begin
  Result := TCustomStatusBar;
end;

function TPyDelphiCustomStatusBar.GetDelphiObject: TCustomStatusBar;
begin
  Result := TCustomStatusBar(inherited DelphiObject);
end;

procedure TPyDelphiCustomStatusBar.SetDelphiObject(
  const Value: TCustomStatusBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiStatusBar }

class function TPyDelphiStatusBar.DelphiObjectClass: TClass;
begin
  Result := TStatusBar;
end;

function TPyDelphiStatusBar.GetDelphiObject: TStatusBar;
begin
  Result := TStatusBar(inherited DelphiObject);
end;

procedure TPyDelphiStatusBar.SetDelphiObject(const Value: TStatusBar);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiTreeNodes }

class function TPyDelphiTreeNodes.DelphiObjectClass: TClass;
begin
  Result := TTreeNodes;
end;

function TPyDelphiTreeNodes.GetDelphiObject: TTreeNodes;
begin
  Result := TTreeNodes(inherited DelphiObject);
end;

procedure TPyDelphiTreeNodes.SetDelphiObject(const Value: TTreeNodes);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiTreeNode }

class function TPyDelphiTreeNode.DelphiObjectClass: TClass;
begin
  Result := TTreeNode;
end;

function TPyDelphiTreeNode.GetDelphiObject: TTreeNode;
begin
  Result := TTreeNode(inherited DelphiObject);
end;

procedure TPyDelphiTreeNode.SetDelphiObject(const Value: TTreeNode);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomTreeView }

class function TPyDelphiCustomTreeView.DelphiObjectClass: TClass;
begin
  Result := TCustomTreeView;
end;

function TPyDelphiCustomTreeView.GetDelphiObject: TCustomTreeView;
begin
  Result := TCustomTreeView(inherited DelphiObject);
end;

procedure TPyDelphiCustomTreeView.SetDelphiObject(const Value: TCustomTreeView);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiTreeView }

class function TPyDelphiTreeView.DelphiObjectClass: TClass;
begin
  Result := TTreeView;
end;

function TPyDelphiTreeView.GetDelphiObject: TTreeView;
begin
  Result := TTreeView(inherited DelphiObject);
end;

procedure TPyDelphiTreeView.SetDelphiObject(const Value: TTreeView);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiListItems }

class function TPyDelphiListItems.DelphiObjectClass: TClass;
begin
  Result := TListItems;
end;

function TPyDelphiListItems.GetDelphiObject: TListItems;
begin
  Result := TListItems(inherited DelphiObject);
end;

procedure TPyDelphiListItems.SetDelphiObject(const Value: TListItems);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiListItem }

class function TPyDelphiListItem.DelphiObjectClass: TClass;
begin
  Result := TListItem;
end;

function TPyDelphiListItem.GetDelphiObject: TListItem;
begin
  Result := TListItem(inherited DelphiObject);
end;

procedure TPyDelphiListItem.SetDelphiObject(const Value: TListItem);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomListView }

class function TPyDelphiCustomListView.DelphiObjectClass: TClass;
begin
  Result := TCustomListView;
end;

function TPyDelphiCustomListView.GetDelphiObject: TCustomListView;
begin
  Result := TCustomListView(inherited DelphiObject);
end;

procedure TPyDelphiCustomListView.SetDelphiObject(const Value: TCustomListView);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiListView }

class function TPyDelphiListView.DelphiObjectClass: TClass;
begin
  Result := TListView;
end;

function TPyDelphiListView.GetDelphiObject: TListView;
begin
  Result := TListView(inherited DelphiObject);
end;

procedure TPyDelphiListView.SetDelphiObject(const Value: TListView);
begin
  inherited DelphiObject := Value;
end;

{ TTVChangingEventHandler }

constructor TTVChangingEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVChangingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVChangingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVChangingEvent);
end;

procedure TTVChangingEventHandler.DoEvent(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyAllowChange: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyAllowChange := CreateVarParam(PyDelphiWrapper, AllowChange);
      LVarParam := PythonToDelphi(LPyAllowChange) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, LPyAllowChange);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowChange := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVChangedEventHandler }

constructor TTVChangedEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVChangedEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVChangedEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVChangedEvent);
end;

procedure TTVChangedEventHandler.DoEvent(Sender: TObject; Node: TTreeNode);
var
  LPyObject, LPyNode, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVEditingEventHandler }

constructor TTVEditingEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVEditingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVEditingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVEditingEvent);
end;

procedure TTVEditingEventHandler.DoEvent(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyAllowEdit: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyAllowEdit := CreateVarParam(PyDelphiWrapper, AllowEdit);
      LVarParam := PythonToDelphi(LPyAllowEdit) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, LPyAllowEdit);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowEdit := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVEditedEventHandler }

constructor TTVEditedEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVEditedEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVEditedEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVEditedEvent);
end;

procedure TTVEditedEventHandler.DoEvent(Sender: TObject; Node: TTreeNode;
  var S: string);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyS: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyS := CreateVarParam(PyDelphiWrapper, S);
      LVarParam := PythonToDelphi(LPyS) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, LPyS);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          S := PyObjectAsString(LVarParam.Value);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVExpandingEventHandler }

constructor TTVExpandingEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVExpandingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVExpandingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVExpandingEvent);
end;

procedure TTVExpandingEventHandler.DoEvent(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyAllowExpansion: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyAllowExpansion := CreateVarParam(PyDelphiWrapper, AllowExpansion);
      LVarParam := PythonToDelphi(LPyAllowExpansion) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, LPyAllowExpansion);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowExpansion := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVCollapsingEventHandler }

constructor TTVCollapsingEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVCollapsingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVCollapsingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVCollapsingEvent);
end;

procedure TTVCollapsingEventHandler.DoEvent(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyAllowCollapse: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyAllowCollapse := CreateVarParam(PyDelphiWrapper, AllowCollapse);
      LVarParam := PythonToDelphi(LPyAllowCollapse) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, LPyAllowCollapse);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowCollapse := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVExpandedEventHandler }

constructor TTVExpandedEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVExpandedEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVExpandedEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVExpandedEvent);
end;

procedure TTVExpandedEventHandler.DoEvent(Sender: TObject; Node: TTreeNode);
var
  LPyObject, LPyNode, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVCompareEventHandler }

constructor TTVCompareEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVCompareEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVCompareEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVCompareEvent);
end;

procedure TTVCompareEventHandler.DoEvent(Sender: TObject; Node1, Node2: TTreeNode;
  Data: Integer; var Compare: Integer);
var
  LPyObject, LPyNode1, LPyNode2, LPyTuple, LPyResult, LPyCompare: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode1 := PyDelphiWrapper.Wrap(Node1);
      LPyNode2 := PyDelphiWrapper.Wrap(Node2);
      LPyCompare := CreateVarParam(PyDelphiWrapper, Compare);
      LVarParam := PythonToDelphi(LPyCompare) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(5);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode1);
      PyTuple_SetItem(LPyTuple, 2, LPyNode2);
      PyTuple_SetItem(LPyTuple, 3, PyLong_FromLong(Data));
      PyTuple_SetItem(LPyTuple, 4, LPyCompare);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          Compare := PyLong_AsLong(LVarParam.Value);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVHintEventHandler }

constructor TTVHintEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVHintEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVHintEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVHintEvent);
end;

procedure TTVHintEventHandler.DoEvent(Sender: TObject; const Node: TTreeNode;
  var Hint: String);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyHint: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyHint := CreateVarParam(PyDelphiWrapper, Hint);
      LVarParam := PythonToDelphi(LPyHint) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, LPyHint);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          Hint := PyObjectAsString(LVarParam.Value);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVCustomDrawEventHandler }

constructor TTVCustomDrawEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVCustomDrawEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVCustomDrawEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVCustomDrawEvent);
end;

procedure TTVCustomDrawEventHandler.DoEvent(Sender: TCustomTreeView;
  const ARect: TRect; var DefaultDraw: Boolean);
var
  LPyObject, LPyRect, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyRect := WrapRect(PyDelphiWrapper, ARect);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarParam := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyRect);
      PyTuple_SetItem(LPyTuple, 2, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVCustomDrawItemEventHandler }

constructor TTVCustomDrawItemEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVCustomDrawItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVCustomDrawItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVCustomDrawItemEvent);
end;

procedure TTVCustomDrawItemEventHandler.DoEvent(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarParam := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, CustomDrawStateToPython(State));
      PyTuple_SetItem(LPyTuple, 3, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVAdvancedCustomDrawEventHandler }

constructor TTVAdvancedCustomDrawEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVAdvancedCustomDrawEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVAdvancedCustomDrawEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVAdvancedCustomDrawEvent);
end;

procedure TTVAdvancedCustomDrawEventHandler.DoEvent(Sender: TCustomTreeView;
  const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  LPyObject, LPyRect, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyRect := WrapRect(PyDelphiWrapper, ARect);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarParam := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyRect);
      PyTuple_SetItem(LPyTuple, 2, CustomDrawStageToPython(Stage));
      PyTuple_SetItem(LPyTuple, 3, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVAdvancedCustomDrawItemEventHandler }

constructor TTVAdvancedCustomDrawItemEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVAdvancedCustomDrawItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVAdvancedCustomDrawItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVAdvancedCustomDrawItemEvent);
end;

procedure TTVAdvancedCustomDrawItemEventHandler.DoEvent(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyPaintImages, LPyDefaultDraw: PPyObject;
  LVarPaintImages, LVarDefaultDraw: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyPaintImages := CreateVarParam(PyDelphiWrapper, PaintImages);
      LVarPaintImages := PythonToDelphi(LPyPaintImages) as TPyDelphiVarParameter;
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarDefaultDraw := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(6);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, CustomDrawStateToPython(State));
      PyTuple_SetItem(LPyTuple, 3, CustomDrawStageToPython(Stage));
      PyTuple_SetItem(LPyTuple, 4, LPyPaintImages);
      PyTuple_SetItem(LPyTuple, 5, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          PaintImages := PyObject_IsTrue(LVarPaintImages.Value) = 1;
          DefaultDraw := PyObject_IsTrue(LVarDefaultDraw.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVCreateNodeClassEventHandler }

constructor TTVCreateNodeClassEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVCreateNodeClassEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVCreateNodeClassEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVCreateNodeClassEvent);
end;

procedure TTVCreateNodeClassEventHandler.DoEvent(Sender: TCustomTreeView;
  var NodeClass: TTreeNodeClass);
var
  LPyObject, LPyTuple, LPyResult, LPyNodeClass: PPyObject;
  LVarParam: TPyDelphiVarParameter;
  ErrMsg: string;
  LClass: TClass;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNodeClass := CreateVarParam(PyDelphiWrapper, NodeClass);
      LVarParam := PythonToDelphi(LPyNodeClass) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNodeClass);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);

          if not ValidateClassRef(LVarParam.Value, TTreeNode, LClass, ErrMsg) then
          begin
            InvalidArguments('OnCreateNode', ErrMsg);
            Exit;
          end;

          NodeClass := TTreeNodeClass(LClass);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TDragDropEventHandler }

constructor TDragDropEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TDragDropEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TDragDropEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TDragDropEvent);
end;

procedure TDragDropEventHandler.DoEvent(Sender, Source: TObject; X, Y: Integer);
var
  LPyObject, LPySource, LPyResult, LPyTuple: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPySource := PyDelphiWrapper.Wrap(Source);
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPySource);
      PyTuple_SetItem(LPyTuple, 2, PyLong_FromLong(X));
      PyTuple_SetItem(LPyTuple, 3, PyLong_FromLong(Y));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TDragOverEventHandler }

constructor TDragOverEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TDragOverEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TDragOverEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TDragOverEvent);
end;

procedure TDragOverEventHandler.DoEvent(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  LPyObject, LPySource, LPyTuple, LPyResult, LPyAccept: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPySource := PyDelphiWrapper.Wrap(Source);
      LPyAccept := CreateVarParam(PyDelphiWrapper, Accept);
      LVarParam := PythonToDelphi(LPyAccept) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(6);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPySource);
      PyTuple_SetItem(LPyTuple, 2, PyLong_FromLong(X));
      PyTuple_SetItem(LPyTuple, 3, PyLong_FromLong(Y));
      PyTuple_SetItem(LPyTuple, 4, DragStateToPython(State));
      PyTuple_SetItem(LPyTuple, 5, LPyAccept);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          Accept := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TEndDragEventHandler }

constructor TEndDragEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TEndDragEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TEndDragEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TEndDragEvent);
end;

procedure TEndDragEventHandler.DoEvent(Sender, Target: TObject; X, Y: Integer);
var
  LPyObject, LPyTarget, LPyResult, LPyTuple: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyTarget := PyDelphiWrapper.Wrap(Target);
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyTarget);
      PyTuple_SetItem(LPyTuple, 2, PyLong_FromLong(X));
      PyTuple_SetItem(LPyTuple, 3, PyLong_FromLong(Y));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TStartDragEventHandler }

constructor TStartDragEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TStartDragEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TStartDragEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TStartDragEvent);
end;

procedure TStartDragEventHandler.DoEvent(Sender: TObject;
  var DragObject: TDragObject);
var
  LPyObject, LPyTuple, LPyResult, LPyDragObject: PPyObject;
  LVarParam: TPyDelphiVarParameter;
  LClass: TClass;
  ErrMsg: string;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyDragObject := CreateVarParam(PyDelphiWrapper, DragObject);
      LVarParam := PythonToDelphi(LPyDragObject) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyDragObject);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);

          if not ValidateClassRef(LVarParam.Value, TDragObject, LClass, ErrMsg) then
          begin
            InvalidArguments('OnStartDrag', ErrMsg);
            Exit;
          end;

          DragObject := TDragObject(LClass);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{$IFDEF DELPHI11_OR_HIGHER}
{ TTVCheckStateChangedEventHandler }

constructor TTVCheckStateChangedEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVCheckStateChangedEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVCheckStateChangedEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVCheckStateChangedEvent);
end;

procedure TTVCheckStateChangedEventHandler.DoEvent(Sender: TCustomTreeView;
  Node: TTreeNode; CheckState: TNodeCheckState);
var
  LPyObject, LPyNode, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, NodeCheckStateToPython(CheckState));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TTVCheckStateChangingEventHandler }

constructor TTVCheckStateChangingEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TTVCheckStateChangingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TTVCheckStateChangingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TTVCheckStateChangingEvent);
end;

procedure TTVCheckStateChangingEventHandler.DoEvent(Sender: TCustomTreeView;
  Node: TTreeNode; NewCheckState, OldCheckState: TNodeCheckState;
  var AllowChange: Boolean);
var
  LPyObject, LPyNode, LPyTuple, LPyResult, LPyAllowChange: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyNode := PyDelphiWrapper.Wrap(Node);
      LPyAllowChange := CreateVarParam(PyDelphiWrapper, AllowChange);
      LVarParam := PythonToDelphi(LPyAllowChange) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(5);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyNode);
      PyTuple_SetItem(LPyTuple, 2, NodeCheckStateToPython(NewCheckState));
      PyTuple_SetItem(LPyTuple, 3, NodeCheckStateToPython(OldCheckState));
      PyTuple_SetItem(LPyTuple, 4, LPyAllowChange);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowChange := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;
{$ENDIF}

{ TLVDeletedEventHandler }

constructor TLVDeletedEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVDeletedEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVDeletedEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVDeletedEvent);
end;

procedure TLVDeletedEventHandler.DoEvent(Sender: TObject; Item: TListItem);
var
  LPyObject, LPyItem, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVEditingEventHandler }

constructor TLVEditingEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVEditingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVEditingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVEditingEvent);
end;

procedure TLVEditingEventHandler.DoEvent(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
var
  LPyObject, LPyItem, LPyTuple, LPyResult, LPyAllowEdit: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyAllowEdit := CreateVarParam(PyDelphiWrapper, AllowEdit);
      LVarParam := PythonToDelphi(LPyAllowEdit) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, LPyAllowEdit);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowEdit := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVEditedEventHandler }

constructor TLVEditedEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVEditedEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVEditedEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVEditedEvent);
end;

procedure TLVEditedEventHandler.DoEvent(Sender: TObject; Item: TListItem;
  var S: string);
var
  LPyObject, LPyItem, LPyTuple, LPyResult, LPyS: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyS := CreateVarParam(PyDelphiWrapper, S);
      LVarParam := PythonToDelphi(LPyS) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, LPyS);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          S := PyObjectAsString(LVarParam.Value);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVChangeEventHandler }

constructor TLVChangeEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVChangeEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVChangeEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVChangeEvent);
end;

procedure TLVChangeEventHandler.DoEvent(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  LPyObject, LPyItem, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, ItemChangeToPython(Change));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVChangingEventHandler }

constructor TLVChangingEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVChangingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVChangingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVChangingEvent);
end;

procedure TLVChangingEventHandler.DoEvent(Sender: TObject; Item: TListItem;
  Change: TItemChange; var AllowChange: Boolean);
var
  LPyObject, LPyItem, LPyTuple, LPyResult, LPyAllowChange: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyAllowChange := CreateVarParam(PyDelphiWrapper, AllowChange);
      LVarParam := PythonToDelphi(LPyAllowChange) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, ItemChangeToPython(Change));
      PyTuple_SetItem(LPyTuple, 3, LPyAllowChange);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowChange := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVColumnClickEventHandler }

constructor TLVColumnClickEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVColumnClickEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVColumnClickEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVColumnClickEvent);
end;

procedure TLVColumnClickEventHandler.DoEvent(Sender: TObject;
  Column: TListColumn);
var
  LPyObject, LPyColumn, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyColumn := PyDelphiWrapper.Wrap(Column);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyColumn);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVColumnRClickEventHandler }

constructor TLVColumnRClickEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVColumnRClickEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVColumnRClickEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVColumnRClickEvent);
end;

procedure TLVColumnRClickEventHandler.DoEvent(Sender: TObject;
  Column: TListColumn; Point: TPoint);
var
  LPyObject, LPyColumn, LPyPoint, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyColumn := PyDelphiWrapper.Wrap(Column);
      LPyPoint := WrapPoint(PyDelphiWrapper, Point);
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyColumn);
      PyTuple_SetItem(LPyTuple, 2, LPyPoint);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVCompareEventHandler }

constructor TLVCompareEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVCompareEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVCompareEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVCompareEvent);
end;

procedure TLVCompareEventHandler.DoEvent(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  LPyObject, LPyItem1, LPyItem2, LPyTuple, LPyResult, LPyCompare: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem1 := PyDelphiWrapper.Wrap(Item1);
      LPyItem2 := PyDelphiWrapper.Wrap(Item2);
      LPyCompare := CreateVarParam(PyDelphiWrapper, Compare);
      LVarParam := PythonToDelphi(LPyCompare) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(5);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem1);
      PyTuple_SetItem(LPyTuple, 2, LPyItem2);
      PyTuple_SetItem(LPyTuple, 3, PyLong_FromLong(Data));
      PyTuple_SetItem(LPyTuple, 4, LPyCompare);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          Compare := PyLong_AsLong(LVarParam.Value);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVNotifyEventHandler }

constructor TLVNotifyEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVNotifyEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVNotifyEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVNotifyEvent);
end;

procedure TLVNotifyEventHandler.DoEvent(Sender: TObject; Item: TListItem);
var
  LPyObject, LPyItem, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVSelectItemEventHandler }

constructor TLVSelectItemEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVSelectItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVSelectItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVSelectItemEvent);
end;

procedure TLVSelectItemEventHandler.DoEvent(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  LPyObject, LPyItem, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, PyBool_FromLong(Ord(Selected)));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVCheckedItemEventHandler }

constructor TLVCheckedItemEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVCheckedItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVCheckedItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVCheckedItemEvent);
end;

procedure TLVCheckedItemEventHandler.DoEvent(Sender: TObject; Item: TListItem);
var
  LPyObject, LPyItem, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVDrawItemEventHandler }

constructor TLVDrawItemEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVDrawItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVDrawItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVDrawItemEvent);
end;

procedure TLVDrawItemEventHandler.DoEvent(Sender: TCustomListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState);
var
  LPyObject, LPyItem, LPyRect, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyRect := WrapRect(PyDelphiWrapper, Rect);
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, LPyRect);
      PyTuple_SetItem(LPyTuple, 3, OwnerDrawStateToPython(State));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVCustomDrawEventHandler }

constructor TLVCustomDrawEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVCustomDrawEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVCustomDrawEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVCustomDrawEvent);
end;

procedure TLVCustomDrawEventHandler.DoEvent(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
var
  LPyObject, LPyRect, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyRect := WrapRect(PyDelphiWrapper, ARect);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarParam := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyRect);
      PyTuple_SetItem(LPyTuple, 2, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVCustomDrawItemEventHandler }

constructor TLVCustomDrawItemEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVCustomDrawItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVCustomDrawItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVCustomDrawItemEvent);
end;

procedure TLVCustomDrawItemEventHandler.DoEvent(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  LPyObject, LPyItem, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarParam := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, CustomDrawStateToPython(State));
      PyTuple_SetItem(LPyTuple, 3, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVCustomDrawSubItemEventHandler }

constructor TLVCustomDrawSubItemEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVCustomDrawSubItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVCustomDrawSubItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVCustomDrawSubItemEvent);
end;

procedure TLVCustomDrawSubItemEventHandler.DoEvent(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  LPyObject, LPyItem, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarParam := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(5);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, PyLong_FromLong(SubItem));
      PyTuple_SetItem(LPyTuple, 3, CustomDrawStateToPython(State));
      PyTuple_SetItem(LPyTuple, 4, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVAdvancedCustomDrawEventHandler }

constructor TLVAdvancedCustomDrawEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVAdvancedCustomDrawEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVAdvancedCustomDrawEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVAdvancedCustomDrawEvent);
end;

procedure TLVAdvancedCustomDrawEventHandler.DoEvent(Sender: TCustomListView;
  const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  LPyObject, LPyRect, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyRect := WrapRect(PyDelphiWrapper, ARect);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarParam := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyRect);
      PyTuple_SetItem(LPyTuple, 2, CustomDrawStageToPython(Stage));
      PyTuple_SetItem(LPyTuple, 3, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVAdvancedCustomDrawItemEventHandler }

constructor TLVAdvancedCustomDrawItemEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVAdvancedCustomDrawItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVAdvancedCustomDrawItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVAdvancedCustomDrawItemEvent);
end;

procedure TLVAdvancedCustomDrawItemEventHandler.DoEvent(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
var
  LPyObject, LPyItem, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarDefaultDraw: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarDefaultDraw := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(5);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, CustomDrawStateToPython(State));
      PyTuple_SetItem(LPyTuple, 3, CustomDrawStageToPython(Stage));
      PyTuple_SetItem(LPyTuple, 4, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarDefaultDraw.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVAdvancedCustomDrawSubItemEventHandler }

constructor TLVAdvancedCustomDrawSubItemEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVAdvancedCustomDrawSubItemEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVAdvancedCustomDrawSubItemEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVAdvancedCustomDrawSubItemEvent);
end;

procedure TLVAdvancedCustomDrawSubItemEventHandler.DoEvent(
  Sender: TCustomListView; Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  LPyObject, LPyItem, LPyTuple, LPyResult, LPyDefaultDraw: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyDefaultDraw := CreateVarParam(PyDelphiWrapper, DefaultDraw);
      LVarParam := PythonToDelphi(LPyDefaultDraw) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(6);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, PyLong_FromLong(SubItem));
      PyTuple_SetItem(LPyTuple, 3, CustomDrawStateToPython(State));
      PyTuple_SetItem(LPyTuple, 4, CustomDrawStageToPython(Stage));
      PyTuple_SetItem(LPyTuple, 5, LPyDefaultDraw);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          DefaultDraw := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVOwnerDataEventHandler }

constructor TLVOwnerDataEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVOwnerDataEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVOwnerDataEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVOwnerDataEvent);
end;

procedure TLVOwnerDataEventHandler.DoEvent(Sender: TObject; Item: TListItem);
var
  LPyObject, LPyItem, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVOwnerDataFindEventHandler }

constructor TLVOwnerDataFindEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVOwnerDataFindEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVOwnerDataFindEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVOwnerDataFindEvent);
end;

procedure TLVOwnerDataFindEventHandler.DoEvent(Sender: TObject; Find: TItemFind;
  const FindString: string; const FindPosition: TPoint; FindData: TCustomData;
  StartIndex: Integer; Direction: TSearchDirection; Wrap: Boolean;
  var Index: Integer);
var
  LPyObject, LPyTuple, LPyResult, LPyIndex: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyIndex := CreateVarParam(PyDelphiWrapper, Index);
      LVarParam := PythonToDelphi(LPyIndex) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(9);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, ItemFindToPython(Find));
      PyTuple_SetItem(LPyTuple, 2, PyUnicodeFromString(FindString));
      PyTuple_SetItem(LPyTuple, 3, WrapPoint(PyDelphiWrapper, FindPosition));
      PyTuple_SetItem(LPyTuple, 4, PyLong_FromLong(NativeInt(FindData)));
      PyTuple_SetItem(LPyTuple, 5, PyLong_FromLong(StartIndex));
      PyTuple_SetItem(LPyTuple, 6, SearchDirectionToPython(Direction));
      PyTuple_SetItem(LPyTuple, 7, PyBool_FromLong(Ord(Wrap)));
      PyTuple_SetItem(LPyTuple, 8, LPyIndex);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          Index := PyLong_AsLong(LVarParam.Value);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVOwnerDataHintEventHandler }

constructor TLVOwnerDataHintEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVOwnerDataHintEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVOwnerDataHintEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVOwnerDataHintEvent);
end;

procedure TLVOwnerDataHintEventHandler.DoEvent(Sender: TObject; StartIndex,
  EndIndex: Integer);
var
  LPyObject, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, PyLong_FromLong(StartIndex));
      PyTuple_SetItem(LPyTuple, 2, PyLong_FromLong(EndIndex));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVOwnerDataStateChangeEventHandler }

constructor TLVOwnerDataStateChangeEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVOwnerDataStateChangeEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVOwnerDataStateChangeEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVOwnerDataStateChangeEvent);
end;

procedure TLVOwnerDataStateChangeEventHandler.DoEvent(Sender: TObject;
  StartIndex, EndIndex: Integer; OldState, NewState: TItemStates);
var
  LPyObject, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyTuple := PyTuple_New(5);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, PyLong_FromLong(StartIndex));
      PyTuple_SetItem(LPyTuple, 2, PyLong_FromLong(EndIndex));
      PyTuple_SetItem(LPyTuple, 3, ItemStatesToPython(OldState));
      PyTuple_SetItem(LPyTuple, 4, ItemStatesToPython(NewState));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVSubItemImageEventHandler }

constructor TLVSubItemImageEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVSubItemImageEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVSubItemImageEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVSubItemImageEvent);
end;

procedure TLVSubItemImageEventHandler.DoEvent(Sender: TObject; Item: TListItem;
  SubItem: Integer; var ImageIndex: Integer);
var
  LPyObject, LPyItem, LPySubItem, LPyTuple, LPyResult, LPyImageIndex: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPySubItem := PyLong_FromLong(SubItem);
      LPyImageIndex := CreateVarParam(PyDelphiWrapper, ImageIndex);
      LVarParam := PythonToDelphi(LPyImageIndex) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(4);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, LPySubItem);
      PyTuple_SetItem(LPyTuple, 3, LPyImageIndex);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          ImageIndex := PyLong_AsLong(LVarParam.Value);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVInfoTipEventHandler }

constructor TLVInfoTipEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVInfoTipEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVInfoTipEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVInfoTipEvent);
end;

procedure TLVInfoTipEventHandler.DoEvent(Sender: TObject; Item: TListItem;
  var InfoTip: string);
var
  LPyObject, LPyItem, LPyTuple, LPyResult, LPyInfoTip: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItem := PyDelphiWrapper.Wrap(Item);
      LPyInfoTip := CreateVarParam(PyDelphiWrapper, InfoTip);
      LVarParam := PythonToDelphi(LPyInfoTip) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItem);
      PyTuple_SetItem(LPyTuple, 2, LPyInfoTip);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          InfoTip := PyObjectAsString(LVarParam.Value);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TLVCreateItemClassEventHandler }

constructor TLVCreateItemClassEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TLVCreateItemClassEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TLVCreateItemClassEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TLVCreateItemClassEvent);
end;

procedure TLVCreateItemClassEventHandler.DoEvent(Sender: TCustomListView;
  var ItemClass: TListItemClass);
var
  LPyObject, LPyTuple, LPyResult, LPyItemClass: PPyObject;
  LVarParam: TPyDelphiVarParameter;
  LClass: TClass;
  ErrMsg: string;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyItemClass := CreateVarParam(PyDelphiWrapper, ItemClass);
      LVarParam := PythonToDelphi(LPyItemClass) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyItemClass);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);

          if not ValidateClassRef(LVarParam.Value, TListItem, LClass, ErrMsg) then
          begin
            InvalidArguments('OnCreateItem', ErrMsg);
            Exit;
          end;

          ItemClass := TListItemClass(LClass);
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TUDClickEventHandler }

constructor TUDClickEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TUDClickEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

procedure TUDClickEventHandler.DoEvent(Sender: TObject;
  Button: TUDBtnType);
var
  LPyObject, LPyButton, LPyTuple, LPyResult: PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, CustomUDBtnTypeToPython(Button));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then
          Py_DECREF(LPyResult);
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

class function TUDClickEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TUDClickEvent);
end;

{ TUDChangingEventHandler }

constructor TUDChangingEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TUDChangingEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

procedure TUDChangingEventHandler.DoEvent(Sender: TObject;
   var AllowChange: Boolean);
var
  LPyObject, LPyAllowChange, LPyTuple, LPyResult: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyAllowChange := CreateVarParam(PyDelphiWrapper, AllowChange);
      LVarParam := PythonToDelphi(LPyAllowChange) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyAllowChange);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowChange := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

class function TUDChangingEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TUDChangingEvent);
end;

{ TUDChangingEventExHandler }

constructor TUDChangingEventExHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod: TMethod;
begin
  inherited;
  LMethod.Code := @TUDChangingEventExHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

procedure TUDChangingEventExHandler.DoEvent(Sender: TObject;
   var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
var
  LPyObject, LPyAllowChange, LPyNewValue, LPyDirection, LPyTuple, LPyResult: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyAllowChange := CreateVarParam(PyDelphiWrapper, AllowChange);
      LVarParam := PythonToDelphi(LPyAllowChange) as TPyDelphiVarParameter;
      LPyNewValue := PyLong_FromLong(NewValue);
      LPyTuple := PyTuple_New(2);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyAllowChange);
      PyTuple_SetItem(LPyTuple, 2, LPyNewValue);
      PyTuple_SetItem(LPyTuple, 3, CustomUpDownDirectionToPython(Direction));
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          AllowChange := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

class function TUDChangingEventExHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TUDChangingEventEx);
end;

initialization
  RegisteredUnits.Add( TComCtrlsRegistration.Create );
  System.Classes.RegisterClasses([TDateTimePicker]);
end.
