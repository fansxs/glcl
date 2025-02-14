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

unit WrapVclControls;

interface

uses
  System.Classes,
  System.SysUtils,
  System.TypInfo,
  System.Types,
  Vcl.Controls,
  PythonEngine,
  WrapDelphi,
  WrapDelphiClasses,
  WrapVclImgList,
  Vcl.Forms;

type
  {
     PyObject wrapping TControl
     Exposes methods Show, Hide, BringToFront, SendToBack, Update, SetBounds
     Exposes property Parent
  }
  TPyDelphiControl = class (TPyDelphiComponent)
  private
    function  GetDelphiObject: TControl;
    procedure SetDelphiObject(const Value: TControl);
  protected
    // Exposed Methods
    function BringToFront_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ClientToScreen_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Hide_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Invalidate_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Repaint_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function ScreenToClient_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SendToBack_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function SetBounds_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Show_Wrapper(args : PPyObject) : PPyObject; cdecl;
    function Update_Wrapper(args : PPyObject) : PPyObject; cdecl;
    // Property Getters
    function Get_Parent( AContext : Pointer) : PPyObject; cdecl;
    // Property Setters
    function Set_Parent( AValue : PPyObject; AContext : Pointer) : integer; cdecl;
  public
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TControl read GetDelphiObject write SetDelphiObject;
  end;

  {
    Access to the child controls of a TWinControl.Controls collection.
  }
  TControlsAccess = class(TContainerAccess)
  private
    function GetContainer: TWinControl;
  public
    function GetItem(AIndex : Integer) : PPyObject; override;
    function GetSize : Integer; override;
    function IndexOf(AValue : PPyObject) : Integer; override;

    class function ExpectedContainerClass : TClass; override;
    class function SupportsIndexOf : Boolean; override;
    class function Name : string; override;

    property Container : TWinControl read GetContainer;
  end;

  {
     PyObject wrapping TWinControl
     Exposes methods CanFocus, Focus
     Exposes properties Controls, ControlCount, Focused, Handle,
                        HandleAllocated, ParentWindow, Showing
  }
  TPyDelphiWinControl = class (TPyDelphiControl)
  private
    function  GetDelphiObject: TWinControl;
    procedure SetDelphiObject(const Value: TWinControl);
  protected
    // Exposed Methods
    function CanFocus_Wrapper(args: PPyObject): PPyObject; cdecl;
    function SetFocus_Wrapper(args: PPyObject): PPyObject; cdecl;
    // Property Getters
    function Get_ControlCount( AContext : Pointer) : PPyObject; cdecl;
    function Get_Controls( AContext : Pointer) : PPyObject; cdecl;
    function Get_Focused( AContext : Pointer) : PPyObject; cdecl;
    function Get_Handle( AContext : Pointer) : PPyObject; cdecl;
    function Get_HandleAllocated( AContext : Pointer) : PPyObject; cdecl;
    function Get_ParentWindow( AContext : Pointer) : PPyObject; cdecl;
    function Get_Showing( AContext : Pointer) : PPyObject; cdecl;
  public
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TWinControl read GetDelphiObject write SetDelphiObject;
  end;

  {
     PyObject wrapping TGraphicControl
  }
  TPyDelphiGraphicControl = class (TPyDelphiControl)
  private
    function  GetDelphiObject: TGraphicControl;
    procedure SetDelphiObject(const Value: TGraphicControl);
  protected
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TGraphicControl read GetDelphiObject write SetDelphiObject;
  end;

  {
     PyObject wrapping TCustomControl
  }
  TPyDelphiCustomControl = class (TPyDelphiControl)
  private
    function  GetDelphiObject: TCustomControl;
    procedure SetDelphiObject(const Value: TCustomControl);
  protected
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiScrollingWinControl = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TScrollingWinControl;
    procedure SetDelphiObject(const Value: TScrollingWinControl);
  protected
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TScrollingWinControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiScrollBox = class (TPyDelphiScrollingWinControl)
  private
    function GetDelphiObject: TScrollBox;
    procedure SetDelphiObject(const Value: TScrollBox);
  protected
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TScrollBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomListControl = class (TPyDelphiWinControl)
  private
    function GetDelphiObject: TCustomListControl;
    procedure SetDelphiObject(const Value: TCustomListControl);
  protected
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomListControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomMultiListControl = class (TPyDelphiCustomListControl)
  private
    function GetDelphiObject: TCustomMultiSelectListControl;
    procedure SetDelphiObject(const Value: TCustomMultiSelectListControl);
  protected
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomMultiSelectListControl read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomHint = class (TPyDelphiComponent)
  private
    function GetDelphiObject: TCustomHint;
    procedure SetDelphiObject(const Value: TCustomHint);
  protected
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TCustomHint read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiBalloonHint = class (TPyDelphiCustomHint)
  private
    function GetDelphiObject: TBalloonHint;
    procedure SetDelphiObject(const Value: TBalloonHint);
  protected
  public
    class function DelphiObjectClass : TClass; override;
    property DelphiObject: TBalloonHint read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiDragImageList = class (TPyDelphiCustomImageList)
  private
    function  GetDelphiObject: TDragImageList;
    procedure SetDelphiObject(const Value: TDragImageList);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TDragImageList read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiImageList = class (TPyDelphiDragImageList)
  private
    function  GetDelphiObject: TImageList;
    procedure SetDelphiObject(const Value: TImageList);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TImageList read GetDelphiObject write SetDelphiObject;
  end;

  { TKeyPressEvent wrapper }
  TKeyPressEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; var Key : Char);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

  { TKeyEvent wrapper }
  TKeyEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; var Key : Word; Shift: TShiftState);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;
  
  { TMouseEvent wrapper }
  TMouseEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

  { TMouseMoveEvent wrapper }
  TMouseMoveEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Shift: TShiftState; X: Integer; Y: Integer);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

  { TMouseWheelEvent wrapper }
  TMouseWheelEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

    { TMouseWheelUpDownEvent wrapper }
  TMouseWheelUpDownEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

  TContextPopupEventHandler = class(TEventHandler)
  protected
    procedure DoEvent(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  public
    constructor Create(PyDelphiWrapper : TPyDelphiWrapper; Component : TObject;
      PropertyInfo : PPropInfo; Callable : PPyObject); override;
    class function GetTypeInfo : PTypeInfo; override;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TControlsRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TControlsRegistration }

procedure TControlsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  // TModalResult values
  APyDelphiWrapper.DefineVar('mrNone',      mrNone);
  APyDelphiWrapper.DefineVar('mrOk',        mrOk);
  APyDelphiWrapper.DefineVar('mrCancel',    mrCancel);
  APyDelphiWrapper.DefineVar('mrAbort',     mrAbort);
  APyDelphiWrapper.DefineVar('mrRetry',     mrRetry);
  APyDelphiWrapper.DefineVar('mrIgnore',    mrIgnore);
  APyDelphiWrapper.DefineVar('mrYes',       mrYes);
  APyDelphiWrapper.DefineVar('mrNo',        mrNo);
  APyDelphiWrapper.DefineVar('mrAll',       mrAll);
  APyDelphiWrapper.DefineVar('mrNoToAll',   mrNoToAll);
  APyDelphiWrapper.DefineVar('mrYesToAll',  mrYesToAll);

  APyDelphiWrapper.DefineVar('bsNone', 'bsNone');
  APyDelphiWrapper.DefineVar('bsSingle', 'bsSingle');
  APyDelphiWrapper.DefineVar('bsSizeable', 'bsSizeable');
  APyDelphiWrapper.DefineVar('bsDialog', 'bsDialog');
  APyDelphiWrapper.DefineVar('bsToolWindow', 'bsToolWindow');
  APyDelphiWrapper.DefineVar('bsSizeToolWin', 'bsSizeToolWin');

  APyDelphiWrapper.DefineVar('alNone', 'alNone');
  APyDelphiWrapper.DefineVar('alTop', 'alTop');
  APyDelphiWrapper.DefineVar('alBottom', 'alBottom');
  APyDelphiWrapper.DefineVar('alLeft', 'alLeft');
  APyDelphiWrapper.DefineVar('alRight', 'alRight');
  APyDelphiWrapper.DefineVar('alClient', 'alClient');
  APyDelphiWrapper.DefineVar('alCustom', 'alCustom');

  APyDelphiWrapper.DefineVar('mbLeft', mbLeft);
  APyDelphiWrapper.DefineVar('mbRight',mbRight);
  APyDelphiWrapper.DefineVar('mbMiddle',mbMiddle);
end;

function TControlsRegistration.Name: string;
begin
  Result := 'Controls';
end;

procedure TControlsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiWinControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiScrollingWinControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiScrollBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomListControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomMultiListControl);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomHint);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiBalloonHint);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDragImageList);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiImageList);

  APyDelphiWrapper.EventHandlers.RegisterHandler(TKeyPressEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TKeyEventHandler);

  APyDelphiWrapper.EventHandlers.RegisterHandler(TMouseEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TMouseMoveEventHandler);

  APyDelphiWrapper.EventHandlers.RegisterHandler(TMouseWheelEventHandler);
  APyDelphiWrapper.EventHandlers.RegisterHandler(TMouseWheelUpDownEventHandler);

  APyDelphiWrapper.EventHandlers.RegisterHandler(TContextPopupEventHandler);
end;

{ TPyDelphiControl }

function TPyDelphiControl.BringToFront_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':BringToFront') <> 0 then begin
      DelphiObject.BringToFront;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiControl.ClientToScreen_Wrapper(
  args: PPyObject): PPyObject;
var
  p : TPoint;
  pt : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'O:ClientToScreen',@pt ) <> 0 then begin
      if CheckPointAttribute(pt, 'point', p) then
        Result := WrapPoint(PyDelphiWrapper, DelphiObject.ClientToScreen(p))
      else
        Result := nil;
    end else
      Result := nil;
  end;
end;

class function TPyDelphiControl.DelphiObjectClass: TClass;
begin
  Result := TControl;
end;

function TPyDelphiControl.GetDelphiObject: TControl;
begin
  Result := TControl(inherited DelphiObject);
end;

function TPyDelphiControl.Get_Parent(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Wrap(DelphiObject.Parent);
end;

function TPyDelphiControl.Hide_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Hide') <> 0 then begin
      DelphiObject.Hide;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiControl.Invalidate_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Invalidate') <> 0 then begin
      DelphiObject.Invalidate;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

class procedure TPyDelphiControl.RegisterGetSets(PythonType: TPythonType);
begin
  PythonType.AddGetSet('Parent', @TPyDelphiControl.Get_Parent, @TPyDelphiControl.Set_Parent,
        'Returns/Sets the Control Parent', nil);
end;

class procedure TPyDelphiControl.RegisterMethods(PythonType: TPythonType);
begin
  PythonType.AddMethod('Show', @TPyDelphiControl.Show_Wrapper,
    PAnsiChar('TControl.Show()'#10 +
    'Shows the wrapped Control'));
  PythonType.AddMethod('Hide', @TPyDelphiControl.Hide_Wrapper,
    PAnsiChar('TControl.Hide()'#10 +
    'Hides the wrapped Control'));
  PythonType.AddMethod('BringToFront', @TPyDelphiControl.BringToFront_Wrapper,
    PAnsiChar('TControl.BringToFront()'#10 +
    'Puts the control in front of all other controls in its parent control.'));
  PythonType.AddMethod('SendToBack', @TPyDelphiControl.SendToBack_Wrapper,
    PAnsiChar('TControl.SendToBack()'#10 +
    'Puts a windowed control behind all other windowed controls, or puts a non-windowed control behind all other non-windowed controls.'));
  PythonType.AddMethod('Update', @TPyDelphiControl.Update_Wrapper,
    PAnsiChar('TControl.Update()'#10 +
    'Processes any pending paint messages immediately.'));
  PythonType.AddMethod('SetBounds', @TPyDelphiControl.SetBounds_Wrapper,
    PAnsiChar('TControl.SetBounds(Left, Top, Width, Height)'#10 +
    'Sets the Left, Top, Width, and Height properties all at once.'));
  PythonType.AddMethod('Invalidate', @TPyDelphiControl.Invalidate_Wrapper,
    PAnsiChar('TControl.Invalidate()'#10 +
    'Completely repaint control.'));
  PythonType.AddMethod('Repaint', @TPyDelphiControl.Repaint_Wrapper,
    PAnsiChar('TControl.Repaint()'#10 +
    'Forces the control to repaint its image on the screen. '));
  PythonType.AddMethod('ClientToScreen', @TPyDelphiControl.ClientToScreen_Wrapper,
    PAnsiChar('TControl.ClientToScreen()'#10 +
    'Translates a given point from client area coordinates to global screen coordinates.'));
  PythonType.AddMethod('ScreenToClient', @TPyDelphiControl.ScreenToClient_Wrapper,
    PAnsiChar('TControl.ScreenToClient()'#10 +
    'Converts the screen coordinates of a specified point on the screen to client coordinates.'));
end;

function TPyDelphiControl.Repaint_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Repaint') <> 0 then begin
      DelphiObject.Repaint;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiControl.ScreenToClient_Wrapper(
  args: PPyObject): PPyObject;
var
  p : TPoint;
  pt : PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  if GetPythonEngine.PyArg_ParseTuple( args, 'O:ScreenToClient',@pt ) <> 0 then begin
    if CheckPointAttribute(pt, 'point', p) then
      Result := WrapPoint(PyDelphiWrapper, DelphiObject.ScreenToClient(p))
    else
      Result := nil;
  end else
    Result := nil;
end;

function TPyDelphiControl.SendToBack_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':SendToBack') <> 0 then begin
      DelphiObject.SendToBack;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiControl.SetBounds_Wrapper(args: PPyObject): PPyObject;
var
  _left : Integer;
  _top : Integer;
  _width : Integer;
  _height : Integer;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'iiii:SetBounds',@_left, @_top, @_width, @_height ) <> 0 then begin
      DelphiObject.SetBounds(_left, _top, _width, _height);
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

procedure TPyDelphiControl.SetDelphiObject(const Value: TControl);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiControl.Set_Parent(AValue: PPyObject;
  AContext: Pointer): integer;
var
  _object : TObject;
begin
  Adjust(@Self);
  if CheckObjAttribute(AValue, 'Parent', TWinControl, _object) then
  begin
    Self.DelphiObject.Parent := TWinControl(_object);
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiControl.Show_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Show') <> 0 then begin
      DelphiObject.Show;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

function TPyDelphiControl.Update_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Update') <> 0 then begin
      DelphiObject.Update;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

{ TControlsAccess }

class function TControlsAccess.ExpectedContainerClass: TClass;
begin
  Result := TWinControl;
end;

function TControlsAccess.GetContainer: TWinControl;
begin
  Result := TWinControl(inherited Container);
end;

function TControlsAccess.GetItem(AIndex: Integer): PPyObject;
begin
  Result := Wrap( Container.Controls[AIndex] );
end;

function TControlsAccess.GetSize: Integer;
begin
  Result := Container.ControlCount;
end;

function TControlsAccess.IndexOf(AValue: PPyObject): Integer;
var
  i : Integer;
  S : string;
  _obj : TPyObject;
  _value : TObject;
  _ctrl : TControl;
begin
  Result := -1;
  with GetPythonEngine do
  begin
    if PyUnicode_Check(AValue) then
    begin
      S := PyUnicodeAsString(AValue);
      for i := 0 to Container.ControlCount-1 do
        if SameText( Container.Controls[i].Name, S) then
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
        if _value is TControl then
        begin
          _ctrl := TControl(_value);
          for i := 0 to Container.ControlCount-1 do
            if Container.Controls[i] = _ctrl then
            begin
              Result := i;
              Break;
            end;
        end;
      end;
    end;
  end;
end;

class function TControlsAccess.Name: string;
begin
  Result := 'Controls';
end;

class function TControlsAccess.SupportsIndexOf: Boolean;
begin
  Result := True;
end;

{ TPyDelphiWinControl }

function TPyDelphiWinControl.CanFocus_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':CanFocus') <> 0 then begin
      Result := VariantAsPyObject(DelphiObject.CanFocus)
    end else
      Result := nil;
  end;
end;

class function TPyDelphiWinControl.DelphiObjectClass: TClass;
begin
  Result := TWinControl;
end;

function TPyDelphiWinControl.GetDelphiObject: TWinControl;
begin
  Result := TWinControl(inherited DelphiObject); 
end;

function TPyDelphiWinControl.Get_ControlCount(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.ControlCount);
end;

function TPyDelphiWinControl.Get_Controls(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := Self.PyDelphiWrapper.DefaultContainerType.CreateInstance;
  with PythonToDelphi(Result) as TPyDelphiContainer do
    Setup(Self.PyDelphiWrapper, TControlsAccess.Create(Self.PyDelphiWrapper, Self.DelphiObject));
end;

function TPyDelphiWinControl.Get_Focused(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.Focused);
end;

function TPyDelphiWinControl.Get_Handle(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.Handle);
end;

function TPyDelphiWinControl.Get_HandleAllocated(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.HandleAllocated);
end;

function TPyDelphiWinControl.Get_ParentWindow(
  AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.ParentWindow);
end;

function TPyDelphiWinControl.Get_Showing(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.Showing);
end;

class procedure TPyDelphiWinControl.RegisterGetSets(
  PythonType: TPythonType);
begin
  PythonType.AddGetSet('ControlCount', @TPyDelphiWinControl.Get_ControlCount, nil,
        'Returns the count of contained controls', nil);
  PythonType.AddGetSet('Controls', @TPyDelphiWinControl.Get_Controls, nil,
        'Returns an iterator over contained controls', nil);
  PythonType.AddGetSet('Focused', @TPyDelphiWinControl.Get_Focused, nil,
        'Determines whether the control has input focus.', nil);
  PythonType.AddGetSet('Handle', @TPyDelphiWinControl.Get_Handle, nil,
        'Provides access to the underlying Windows screen object for the control.', nil);
  PythonType.AddGetSet('HandleAllocated', @TPyDelphiWinControl.Get_HandleAllocated, nil,
        'Reports whether a screen object handle exists for the control.', nil);
  PythonType.AddGetSet('ParentWindow', @TPyDelphiWinControl.Get_ParentWindow, nil,
        'Reference to parent''s underlying control.', nil);
  PythonType.AddGetSet('Showing', @TPyDelphiWinControl.Get_Showing, nil,
        'Indicates whether the control is showing on the screen. ', nil);
end;

class procedure TPyDelphiWinControl.RegisterMethods(
  PythonType: TPythonType);
begin
  PythonType.AddMethod('CanFocus', @TPyDelphiWinControl.CanFocus_Wrapper,
    PAnsiChar('TWinControl.CanFocus()'#10 +
    'Indicates whether a control can receive focus. '));
  PythonType.AddMethod('SetFocus', @TPyDelphiWinControl.SetFocus_Wrapper,
    PAnsiChar('TWinControl.SetFocus()'#10 +
    'Gives the input focus to the control. '));
end;

procedure TPyDelphiWinControl.SetDelphiObject(const Value: TWinControl);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiWinControl.SetFocus_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':SetFocus') <> 0 then begin
      DelphiObject.SetFocus;
      Result := ReturnNone;
    end else
      Result := nil;
  end;
end;

{ TPyDelphiGraphicControl }

class function TPyDelphiGraphicControl.DelphiObjectClass: TClass;
begin
  Result := TGraphicControl;
end;

function TPyDelphiGraphicControl.GetDelphiObject: TGraphicControl;
begin
  Result := TGraphicControl(inherited DelphiObject);
end;

procedure TPyDelphiGraphicControl.SetDelphiObject(
  const Value: TGraphicControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomControl }

class function TPyDelphiCustomControl.DelphiObjectClass: TClass;
begin
  Result := TCustomControl;
end;

function TPyDelphiCustomControl.GetDelphiObject: TCustomControl;
begin
  Result := TCustomControl(inherited DelphiObject);
end;

procedure TPyDelphiCustomControl.SetDelphiObject(
  const Value: TCustomControl);
begin
  inherited DelphiObject := Value;
end;

{ TKeyPressEventHandler }

constructor TKeyPressEventHandler.Create(
  PyDelphiWrapper: TPyDelphiWrapper; Component: TObject;
  PropertyInfo: PPropInfo; Callable: PPyObject);
var
  Method : TMethod;
begin
  inherited;
  Method.Code := @TKeyPressEventHandler.DoEvent;
  Method.Data := Self;
  SetMethodProp(Component, PropertyInfo, Method);
end;

procedure TKeyPressEventHandler.DoEvent(Sender: TObject;
  var Key: Char);
Var
  PyObject, PyTuple, PyResult, PyKey : PPyObject;
  _varParam : TPyDelphiVarParameter;
  _key : string;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyKey := CreateVarParam(PyDelphiWrapper, Key);
      _varParam := PythonToDelphi(PyKey) as TPyDelphiVarParameter;
      PyTuple := PyTuple_New(2);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, PyKey);
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);
          if _varParam.Value = Py_None then
            Key := #0
          else if PyUnicode_Check(_varParam.Value) then
          begin
            _key := PyUnicodeAsString(_varParam.Value);
            if Length(_key) > 0 then
              Key := _key[1];
          end;
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TKeyPressEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TKeyPressEvent);
end;

{ TKeyEventHandler }

constructor TKeyEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  Method : TMethod;
begin
  inherited;
  Method.Code := @TKeyEventHandler.DoEvent;
  Method.Data := Self;
  SetMethodProp(Component, PropertyInfo, Method);
end;

procedure TKeyEventHandler.DoEvent(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  PyObject, PyTuple, PyResult, PyKey : PPyObject;
  _varParam : TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyKey := CreateVarParam(PyDelphiWrapper, Key);
      _varParam := PythonToDelphi(PyKey) as TPyDelphiVarParameter;
      PyTuple := PyTuple_New(3);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, PyKey);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 2, ShiftToPython(Shift));
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);
          if PyLong_Check(_varParam.Value) then
            Key := PyLong_AsLong(_varParam.Value);
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TKeyEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TKeyEvent);
end;

{ TMouseEventHandler }

constructor TMouseEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  Method : TMethod;
begin
  inherited;
  Method.Code := @TMouseEventHandler.DoEvent;
  Method.Data := Self;
  SetMethodProp(Component, PropertyInfo, Method);
end;

procedure TMouseEventHandler.DoEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
var
  PyObject, PyTuple, PyButton, PyX, PyY, PyResult : PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyButton := PyLong_FromLong(Ord(Button));
      PyX := PyLong_FromLong(X);
      PyY := PyLong_FromLong(Y);
      PyTuple := PyTuple_New(5);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, PyButton);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 2, ShiftToPython(Shift));
      GetPythonEngine.PyTuple_SetItem(PyTuple, 3, PyX);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 4, PyY);
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TMouseEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TMouseEvent);
end;

{ TMouseMoveEventHandler }

constructor TMouseMoveEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  Method : TMethod;
begin
  inherited;
  Method.Code := @TMouseMoveEventHandler.DoEvent;
  Method.Data := Self;
  SetMethodProp(Component, PropertyInfo, Method);
end;

procedure TMouseMoveEventHandler.DoEvent(Sender: TObject; Shift: TShiftState; X: Integer; Y: Integer);
var
  PyObject, PyTuple, PyX, PyY, PyResult : PPyObject;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyX := PyLong_FromLong(X);
      PyY := PyLong_FromLong(Y);
      PyTuple := PyTuple_New(4);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, ShiftToPython(Shift));
      GetPythonEngine.PyTuple_SetItem(PyTuple, 2, PyX);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 3, PyY);
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TMouseMoveEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TMouseMoveEvent);
end;

{ TMouseWheelEventHandler }

constructor TMouseWheelEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  Method : TMethod;
begin
  inherited;
  Method.Code := @TMouseWheelEventHandler.DoEvent;
  Method.Data := Self;
  SetMethodProp(Component, PropertyInfo, Method);
end;

procedure TMouseWheelEventHandler.DoEvent(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  PyObject, PyTuple, PyWheelDelta, PyMousePos, PyHandled, PyResult : PPyObject;
  _varParam : TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyWheelDelta := PyLong_FromLong(WheelDelta);
      PyMousePos := WrapPoint(PyDelphiWrapper, MousePos);
      PyHandled := CreateVarParam(PyDelphiWrapper, Handled);
      _varParam := PythonToDelphi(PyHandled) as TPyDelphiVarParameter;
      PyTuple := PyTuple_New(5);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, ShiftToPython(Shift));
      GetPythonEngine.PyTuple_SetItem(PyTuple, 2, PyWheelDelta);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 3, PyMousePos);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 4, PyHandled);
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);

          Handled := PyObject_IsTrue(_varParam.Value) = 1;
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TMouseWheelEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TMouseWheelEvent);
end;

{ TMouseWheelUpDownEventHandler }

constructor TMouseWheelUpDownEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  Method : TMethod;
begin
  inherited;
  Method.Code := @TMouseWheelUpDownEventHandler.DoEvent;
  Method.Data := Self;
  SetMethodProp(Component, PropertyInfo, Method);
end;

procedure TMouseWheelUpDownEventHandler.DoEvent(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
var
  PyObject, PyTuple, PyWheelDelta, PyMousePos, PyHandled, PyResult : PPyObject;
  _varParam : TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK then
    with GetPythonEngine do begin
      PyObject := PyDelphiWrapper.Wrap(Sender);
      PyMousePos := WrapPoint(PyDelphiWrapper, MousePos);
      PyHandled := CreateVarParam(PyDelphiWrapper, Handled);
      _varParam := PythonToDelphi(PyHandled) as TPyDelphiVarParameter;
      PyTuple := PyTuple_New(4);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 0, PyObject);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 1, ShiftToPython(Shift));
      GetPythonEngine.PyTuple_SetItem(PyTuple, 2, PyMousePos);
      GetPythonEngine.PyTuple_SetItem(PyTuple, 3, PyHandled);
      try
        PyResult := PyObject_CallObject(Callable, PyTuple);
        if Assigned(PyResult) then
        begin
          Py_DECREF(PyResult);

          Handled := PyObject_IsTrue(_varParam.Value) = 1;
        end;
      finally
        Py_DECREF(PyTuple);
      end;
      CheckError;
    end;
end;

class function TMouseWheelUpDownEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TMouseWheelUpDownEvent);
end;

{ TPyDelphiScrollingWinControl }

class function TPyDelphiScrollingWinControl.DelphiObjectClass: TClass;
begin
  Result := TScrollingWinControl;
end;

function TPyDelphiScrollingWinControl.GetDelphiObject: TScrollingWinControl;
begin
  Result := TScrollingWinControl(inherited DelphiObject);
end;

procedure TPyDelphiScrollingWinControl.SetDelphiObject(
  const Value: TScrollingWinControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiScrollBox }

class function TPyDelphiScrollBox.DelphiObjectClass: TClass;
begin
  Result := TScrollBox;
end;

function TPyDelphiScrollBox.GetDelphiObject: TScrollBox;
begin
  Result := TScrollBox(inherited DelphiObject);
end;

procedure TPyDelphiScrollBox.SetDelphiObject(
  const Value: TScrollBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomListControl }

class function TPyDelphiCustomListControl.DelphiObjectClass: TClass;
begin
  Result := TCustomListControl;
end;

function TPyDelphiCustomListControl.GetDelphiObject: TCustomListControl;
begin
  Result := TCustomListControl(inherited DelphiObject);
end;

procedure TPyDelphiCustomListControl.SetDelphiObject(
  const Value: TCustomListControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomMultiListControl }

class function TPyDelphiCustomMultiListControl.DelphiObjectClass: TClass;
begin
  Result := TCustomMultiSelectListControl;
end;

function TPyDelphiCustomMultiListControl.GetDelphiObject: TCustomMultiSelectListControl;
begin
  Result := TCustomMultiSelectListControl(inherited DelphiObject);
end;

procedure TPyDelphiCustomMultiListControl.SetDelphiObject(
  const Value: TCustomMultiSelectListControl);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomHint }

class function TPyDelphiCustomHint.DelphiObjectClass: TClass;
begin
  Result := TCustomHint;
end;

function TPyDelphiCustomHint.GetDelphiObject: TCustomHint;
begin
  Result := TCustomHint(inherited DelphiObject);
end;

procedure TPyDelphiCustomHint.SetDelphiObject(const Value: TCustomHint);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiBalloonHint }

class function TPyDelphiBalloonHint.DelphiObjectClass: TClass;
begin
  Result := TBalloonHint;
end;

function TPyDelphiBalloonHint.GetDelphiObject: TBalloonHint;
begin
  Result := TBalloonHint(inherited DelphiObject);
end;

procedure TPyDelphiBalloonHint.SetDelphiObject(const Value: TBalloonHint);
begin
  inherited DelphiObject := Value;
end;

{ TContextPopupEventHandler }

constructor TContextPopupEventHandler.Create(PyDelphiWrapper: TPyDelphiWrapper;
  Component: TObject; PropertyInfo: PPropInfo; Callable: PPyObject);
var
  LMethod : TMethod;
begin
  inherited;
  LMethod.Code := @TContextPopupEventHandler.DoEvent;
  LMethod.Data := Self;
  SetMethodProp(Component, PropertyInfo, LMethod);
end;

class function TContextPopupEventHandler.GetTypeInfo: PTypeInfo;
begin
  Result := System.TypeInfo(TContextPopupEvent);
end;


procedure TContextPopupEventHandler.DoEvent(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  LPyObject, LPyMousePos, LPyTuple, LPyResult, LPyHandled: PPyObject;
  LVarParam: TPyDelphiVarParameter;
begin
  Assert(Assigned(PyDelphiWrapper));
  if Assigned(Callable) and PythonOK() then
    with GetPythonEngine() do begin
      LPyObject := PyDelphiWrapper.Wrap(Sender);
      LPyMousePos := WrapPoint(PyDelphiWrapper, MousePos);
      LPyHandled := CreateVarParam(PyDelphiWrapper, Handled);
      LVarParam := PythonToDelphi(LPyHandled) as TPyDelphiVarParameter;
      LPyTuple := PyTuple_New(3);
      PyTuple_SetItem(LPyTuple, 0, LPyObject);
      PyTuple_SetItem(LPyTuple, 1, LPyMousePos);
      PyTuple_SetItem(LPyTuple, 2, LPyHandled);
      try
        LPyResult := PyObject_CallObject(Callable, LPyTuple);
        if Assigned(LPyResult) then begin
          Py_DECREF(LPyResult);
          Handled := PyObject_IsTrue(LVarParam.Value) = 1;
        end;
      finally
        Py_DECREF(LPyTuple);
      end;
      CheckError();
    end;
end;

{ TPyDelphiDragImageList }

class function TPyDelphiDragImageList.DelphiObjectClass: TClass;
begin
  Result := TDragImageList;
end;

function TPyDelphiDragImageList.GetDelphiObject: TDragImageList;
begin
  Result := TDragImageList(inherited DelphiObject);
end;

procedure TPyDelphiDragImageList.SetDelphiObject(const Value: TDragImageList);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiImageList }

class function TPyDelphiImageList.DelphiObjectClass: TClass;
begin
  Result := TImageList;
end;

function TPyDelphiImageList.GetDelphiObject: TImageList;
begin
  Result := TImageList(inherited DelphiObject);
end;

procedure TPyDelphiImageList.SetDelphiObject(const Value: TImageList);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TControlsRegistration.Create);
end.
