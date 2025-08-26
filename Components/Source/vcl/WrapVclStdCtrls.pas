
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

unit WrapVclStdCtrls;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  WrapVclControls, Windows, StdCtrls, Vcl.Mask, Vcl.CheckLst, WrapDelphiTypes;

type
  TPyDelphiButton = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TButton;
    procedure SetDelphiObject(const Value: TButton);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TButton read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCheckBox = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TCheckBox;
    procedure SetDelphiObject(const Value: TCheckBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCheckBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiComboBox = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TComboBox;
    procedure SetDelphiObject(const Value: TComboBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TComboBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomEdit = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TCustomEdit;
    procedure SetDelphiObject(const Value: TCustomEdit);
  protected
    // Property Getters
    function Get_SelStart( AContext : Pointer) : PPyObject; cdecl;
    // Property Setters
    function Set_SelStart( AValue : PPyObject; AContext : Pointer) : integer; cdecl;
  public
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TCustomEdit read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiEdit = class (TPyDelphiCustomEdit)
  private
    function  GetDelphiObject: TEdit;
    procedure SetDelphiObject(const Value: TEdit);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TEdit read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomMaskEdit = class (TPyDelphiCustomEdit)
  private
    function  GetDelphiObject: TCustomMaskEdit;
    procedure SetDelphiObject(const Value: TCustomMaskEdit);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomMaskEdit read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiMaskEdit = class (TPyDelphiCustomMaskEdit)
  private
    function  GetDelphiObject: TMaskEdit;
    procedure SetDelphiObject(const Value: TMaskEdit);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TMaskEdit read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomMemo = class (TPyDelphiCustomEdit)
  private
    function  GetDelphiObject: TCustomMemo;
    procedure SetDelphiObject(const Value: TCustomMemo);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomMemo read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiMemo = class (TPyDelphiCustomMemo)
  private
    function  GetDelphiObject: TMemo;
    procedure SetDelphiObject(const Value: TMemo);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TMemo read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiGroupBox = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TGroupBox;
    procedure SetDelphiObject(const Value: TGroupBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TGroupBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiLabel = class (TPyDelphiControl)
  private
    function  GetDelphiObject: TLabel;
    procedure SetDelphiObject(const Value: TLabel);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TLabel read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomListBox = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TCustomListBox;
    procedure SetDelphiObject(const Value: TCustomListBox);
  protected
    // Property Getters
    function Get_ItemIndex( AContext : Pointer) : PPyObject; cdecl;
    // Property Setters
    function Set_ItemIndex( AValue : PPyObject; AContext : Pointer) : integer; cdecl;
  public
    function ItemAtPos_Wrapper(args: PPyObject): PPyObject;
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TCustomListBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCustomCheckListBox = class (TPyDelphiCustomListBox)
  private
    function  GetDelphiObject: TCustomCheckListBox;
    procedure SetDelphiObject(const Value: TCustomCheckListBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCustomCheckListBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiCheckListBox = class (TPyDelphiCustomCheckListBox)
  private
    function  GetDelphiObject: TCheckListBox;
    procedure SetDelphiObject(const Value: TCheckListBox);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TCheckListBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiListBox = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TListBox;
    procedure SetDelphiObject(const Value: TListBox);
  protected
    // Property Getters
    function Get_ItemIndex( AContext : Pointer) : PPyObject; cdecl;
    // Property Setters
    function Set_ItemIndex( AValue : PPyObject; AContext : Pointer) : integer; cdecl;
  public
    class function  DelphiObjectClass : TClass; override;
    class procedure RegisterGetSets( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TListBox read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiRadioButton = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TRadioButton;
    procedure SetDelphiObject(const Value: TRadioButton);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TRadioButton read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiStaticText = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TStaticText;
    procedure SetDelphiObject(const Value: TStaticText);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TStaticText read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiScrollBar = class (TPyDelphiWinControl)
  private
    function  GetDelphiObject: TScrollBar;
    procedure SetDelphiObject(const Value: TScrollBar);
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TScrollBar read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TStdCtrlsRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

{ TStdCtrlsRegistration }

procedure TStdCtrlsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('msMasked', 'msMasked');
  APyDelphiWrapper.DefineVar('msReEnter', 'msReEnter');
  APyDelphiWrapper.DefineVar('msDBSetText', 'msDBSetText');

  APyDelphiWrapper.DefineVar('ssNone', ssNone);
  APyDelphiWrapper.DefineVar('ssHorizontal', ssHorizontal);
  APyDelphiWrapper.DefineVar('ssVertical', ssVertical);
  APyDelphiWrapper.DefineVar('ssBoth', ssBoth);

  APyDelphiWrapper.DefineVar('ecNormal', ecNormal);
  APyDelphiWrapper.DefineVar('ecUpperCase', ecNormal);
  APyDelphiWrapper.DefineVar('ecLowerCase', ecNormal);

  APyDelphiWrapper.DefineVar('cbUnchecked', 'cbUnchecked');
  APyDelphiWrapper.DefineVar('cbChecked', 'cbChecked');
  APyDelphiWrapper.DefineVar('cbGrayed', 'cbGrayed');
end;

function TStdCtrlsRegistration.Name: string;
begin
  Result := 'StdCtrls';
end;

procedure TStdCtrlsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiButton);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCheckBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiComboBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomEdit);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiEdit);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomMaskEdit);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiMaskEdit);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomMemo);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiMemo);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiGroupBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiLabel);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomListBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomCheckListBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCheckListBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiListBox);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRadioButton);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiStaticText);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiScrollBar);
end;

{ TPyDelphiButton }

class function TPyDelphiButton.DelphiObjectClass: TClass;
begin
  Result := TButton;
end;

function TPyDelphiButton.GetDelphiObject: TButton;
begin
  Result := TButton(inherited DelphiObject);
end;

procedure TPyDelphiButton.SetDelphiObject(const Value: TButton);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCheckBox }

class function TPyDelphiCheckBox.DelphiObjectClass: TClass;
begin
  Result := TCheckBox;
end;

function TPyDelphiCheckBox.GetDelphiObject: TCheckBox;
begin
  Result := TCheckBox(inherited DelphiObject);
end;

procedure TPyDelphiCheckBox.SetDelphiObject(const Value: TCheckBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiComboBox }

class function TPyDelphiComboBox.DelphiObjectClass: TClass;
begin
  Result := TComboBox;
end;

function TPyDelphiComboBox.GetDelphiObject: TComboBox;
begin
  Result := TComboBox(inherited DelphiObject);
end;

procedure TPyDelphiComboBox.SetDelphiObject(const Value: TComboBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiEdit }

class function TPyDelphiCustomEdit.DelphiObjectClass: TClass;
begin
  Result := TCustomEdit;
end;

function TPyDelphiCustomEdit.GetDelphiObject: TCustomEdit;
begin
  Result := TCustomEdit(inherited DelphiObject);
end;

procedure TPyDelphiCustomEdit.SetDelphiObject(const Value: TCustomEdit);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiCustomEdit.Get_SelStart(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.SelStart);
end;

function TPyDelphiCustomEdit.Set_SelStart(AValue: PPyObject; AContext: Pointer): integer;
var
  _SelStart : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'SelStart', _SelStart) then
  begin
    DelphiObject.SelStart := _SelStart;
    Result := 0;
  end
  else
    Result := -1;
end;

class procedure TPyDelphiCustomEdit.RegisterGetSets(PythonType: TPythonType);
begin
  inherited;
  with PythonType do
    begin
      AddGetSet('SelStart', @TPyDelphiCustomEdit.Get_SelStart, @TPyDelphiCustomEdit.Set_SelStart,
        'Returns/sets the position of the cursor.', nil);
    end;
end;

{ TPyDelphiEdit }

class function TPyDelphiEdit.DelphiObjectClass: TClass;
begin
  Result := TEdit;
end;

function TPyDelphiEdit.GetDelphiObject: TEdit;
begin
  Result := TEdit(inherited DelphiObject);
end;

procedure TPyDelphiEdit.SetDelphiObject(const Value: TEdit);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomMaskEdit }

class function TPyDelphiCustomMaskEdit.DelphiObjectClass: TClass;
begin
  Result := TCustomMaskEdit;
end;

function TPyDelphiCustomMaskEdit.GetDelphiObject: TCustomMaskEdit;
begin
  Result := TCustomMaskEdit(inherited DelphiObject);
end;

procedure TPyDelphiCustomMaskEdit.SetDelphiObject(const Value: TCustomMaskEdit);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiMaskEdit }

class function TPyDelphiMaskEdit.DelphiObjectClass: TClass;
begin
  Result := TMaskEdit;
end;

function TPyDelphiMaskEdit.GetDelphiObject: TMaskEdit;
begin
  Result := TMaskEdit(inherited DelphiObject);
end;

procedure TPyDelphiMaskEdit.SetDelphiObject(const Value: TMaskEdit);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomMemo }

class function TPyDelphiCustomMemo.DelphiObjectClass: TClass;
begin
  Result := TCustomMemo;
end;

function TPyDelphiCustomMemo.GetDelphiObject: TCustomMemo;
begin
  Result := TCustomMemo(inherited DelphiObject);
end;

procedure TPyDelphiCustomMemo.SetDelphiObject(const Value: TCustomMemo);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiMemo }

class function TPyDelphiMemo.DelphiObjectClass: TClass;
begin
  Result := TMemo;
end;

function TPyDelphiMemo.GetDelphiObject: TMemo;
begin
  Result := TMemo(inherited DelphiObject);
end;

procedure TPyDelphiMemo.SetDelphiObject(const Value: TMemo);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiGroupBox }

class function TPyDelphiGroupBox.DelphiObjectClass: TClass;
begin
  Result := TGroupBox;
end;

function TPyDelphiGroupBox.GetDelphiObject: TGroupBox;
begin
  Result := TGroupBox(inherited DelphiObject);
end;

procedure TPyDelphiGroupBox.SetDelphiObject(const Value: TGroupBox);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiLabel }

class function TPyDelphiLabel.DelphiObjectClass: TClass;
begin
  Result := TLabel;
end;

function TPyDelphiLabel.GetDelphiObject: TLabel;
begin
  Result := TLabel(inherited DelphiObject);
end;

procedure TPyDelphiLabel.SetDelphiObject(const Value: TLabel);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomListBox }

function TPyDelphiCustomListBox.ItemAtPos_Wrapper(args: PPyObject): PPyObject;
var
  Count: Integer;
  Existing: Boolean;
  _pt, _Existing : PPyObject;
  Pos: TPoint;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, 'OO:ItemAtPos', @_pt, @_Existing) <> 0 then
    begin
      if CheckPointAttribute(_pt, 'point', pos) and
        CheckBoolAttribute(_Existing, 'Existing', Existing) then
          Result := PyLong_FromLong(DelphiObject.ItemAtPos(pos, Existing));
    end
    else
      Result := PyLong_FromLong(-1);
  end;
end;

class function TPyDelphiCustomListBox.DelphiObjectClass: TClass;
begin
  Result := TCustomListBox;
end;

function TPyDelphiCustomListBox.GetDelphiObject: TCustomListBox;
begin
  Result := TCustomListBox(inherited DelphiObject);
end;

procedure TPyDelphiCustomListBox.SetDelphiObject(const Value: TCustomListBox);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiCustomListBox.Set_ItemIndex(AValue: PPyObject; AContext: Pointer): integer;
var
  _index : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'ItemIndex', _index) then
  begin
    DelphiObject.ItemIndex := _index;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiCustomListBox.Get_ItemIndex(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.ItemIndex);
end;

class procedure TPyDelphiCustomListBox.RegisterMethods(PythonType: TPythonType);
begin
  PythonType.AddMethod('ItemAtPos', @TPyDelphiCustomListBox.ItemAtPos_Wrapper,
    PAnsiChar('TControl.Show()'#10 +
    'Shows the wrapped Control'));
end;

class procedure TPyDelphiCustomListBox.RegisterGetSets(PythonType: TPythonType);
begin
  inherited;
  with PythonType do
    begin
      AddGetSet('ItemIndex', @TPyDelphiCustomListBox.Get_ItemIndex, @TPyDelphiCustomListBox.Set_ItemIndex,
        'Indicates the position of the selected item.', nil);
    end;
end;

{ TPyDelphiCustomCheckListBox }

class function TPyDelphiCustomCheckListBox.DelphiObjectClass: TClass;
begin
  Result := TCustomCheckListBox;
end;

function TPyDelphiCustomCheckListBox.GetDelphiObject: TCustomCheckListBox;
begin
  Result := TCustomCheckListBox(inherited DelphiObject);
end;

procedure TPyDelphiCustomCheckListBox.SetDelphiObject(const Value: TCustomCheckListBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCheckListBox }

class function TPyDelphiCheckListBox.DelphiObjectClass: TClass;
begin
  Result := TCheckListBox;
end;

function TPyDelphiCheckListBox.GetDelphiObject: TCheckListBox;
begin
  Result := TCheckListBox(inherited DelphiObject);
end;

procedure TPyDelphiCheckListBox.SetDelphiObject(const Value: TCheckListBox);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiListBox }

class function TPyDelphiListBox.DelphiObjectClass: TClass;
begin
  Result := TListBox;
end;

function TPyDelphiListBox.GetDelphiObject: TListBox;
begin
  Result := TListBox(inherited DelphiObject);
end;

procedure TPyDelphiListBox.SetDelphiObject(const Value: TListBox);
begin
  inherited DelphiObject := Value;
end;

function TPyDelphiListBox.Set_ItemIndex(AValue: PPyObject; AContext: Pointer): integer;
var
  _index : Integer;
begin
  Adjust(@Self);
  if CheckIntAttribute(AValue, 'ItemIndex', _index) then
  begin
    DelphiObject.ItemIndex := _index;
    Result := 0;
  end
  else
    Result := -1;
end;

function TPyDelphiListBox.Get_ItemIndex(AContext: Pointer): PPyObject;
begin
  Adjust(@Self);
  Result := GetPythonEngine.PyLong_FromLong(DelphiObject.ItemIndex);
end;

class procedure TPyDelphiListBox.RegisterGetSets(PythonType: TPythonType);
begin
  inherited;
  with PythonType do
    begin
      AddGetSet('ItemIndex', @TPyDelphiListBox.Get_ItemIndex, @TPyDelphiListBox.Set_ItemIndex,
        'Indicates the position of the selected item.', nil);
    end;
end;


{ TPyDelphiRadioButton }

class function TPyDelphiRadioButton.DelphiObjectClass: TClass;
begin
  Result := TRadioButton;
end;

function TPyDelphiRadioButton.GetDelphiObject: TRadioButton;
begin
  Result := TRadioButton(inherited DelphiObject);
end;

procedure TPyDelphiRadioButton.SetDelphiObject(const Value: TRadioButton);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiStaticText }

class function TPyDelphiStaticText.DelphiObjectClass: TClass;
begin
  Result := TStaticText;
end;

function TPyDelphiStaticText.GetDelphiObject: TStaticText;
begin
  Result := TStaticText(inherited DelphiObject);
end;

procedure TPyDelphiStaticText.SetDelphiObject(const Value: TStaticText);
begin
  inherited DelphiObject := Value;
end;


{ TPyDelphiScrollBar }

class function TPyDelphiScrollBar.DelphiObjectClass: TClass;
begin
  Result := TScrollBar;
end;

function TPyDelphiScrollBar.GetDelphiObject: TScrollBar;
begin
  Result := TScrollBar(inherited DelphiObject);
end;

procedure TPyDelphiScrollBar.SetDelphiObject(const Value: TScrollBar);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TStdCtrlsRegistration.Create );
  Classes.RegisterClasses([TButton, TCheckBox, TComboBox, TEdit, TMemo, TGroupBox,
                           TLabel, TListBox, TRadioButton, TStaticText, TScrollBar]);
end.
