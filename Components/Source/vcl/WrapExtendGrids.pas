
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

unit WrapExtendGrids;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  WrapVclGrids, Edu_SGrid, Vcl.Grids, Ledger, WrapVclControls, NiceGrid,
  WrapVclExtCtrls, uSimpleBase, uSimpleGridP4D, uSimpleGrid;

type

  TPyDelphiLedgerGrid = class (TPyDelphiStringGrid)
  private
    function  GetDelphiObject: TLedgerGrid;
    procedure SetDelphiObject(const Value: TLedgerGrid);
  protected
    class function GetTypeName : string; override;
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TLedgerGrid read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiEduStringGrid = class (TPyDelphiStringGrid)
  private
    function  GetDelphiObject: TEduStringGrid;
    procedure SetDelphiObject(const Value: TEduStringGrid);
  protected
    class function GetTypeName : string; override;
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TEduStringGrid read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiNiceGrid = class(TPyDelphiCustomPanel)
  private
    function GetDelphiObject: TNiceGrid;
    procedure SetDelphiObject(const Value: TNiceGrid);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TNiceGrid read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiNiceGridSync = class(TPyDelphiCustomPanel)
  private
    function GetDelphiObject: TNiceGridSync;
    procedure SetDelphiObject(const Value: TNiceGridSync);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TNiceGridSync read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiSimpleGrid = class (TPyDelphiStringGrid)
  private
    function  GetDelphiObject: TSimpleGrid;
    procedure SetDelphiObject(const Value: TSimpleGrid);
  protected
    class function GetTypeName : string; override;
  public
    class function DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TSimpleGrid read GetDelphiObject write SetDelphiObject;
  end;

  TPyDelphiP4DParamGrid = class(TPyDelphiSimpleGrid)
  private
    function GetDelphiObject: TP4DParamGrid;
    procedure SetDelphiObject(const Value: TP4DParamGrid);
  protected
    class function GetTypeName : string; override;
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TP4DParamGrid read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiP4DListGrid = class(TPyDelphiSimpleGrid)
  private
    function GetDelphiObject: TP4DListGrid;
    procedure SetDelphiObject(const Value: TP4DListGrid);
  protected
    class function GetTypeName : string; override;
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TP4DListGrid read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TExtendGridsRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;


{ TExtendGridsRegistration }
procedure TExtendGridsRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TExtendGridsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('ssAutomatic', 'ssAutomatic');
  APyDelphiWrapper.DefineVar('ssAlphabetic', 'ssAlphabetic');
  APyDelphiWrapper.DefineVar('ssNumeric', 'ssNumeric');

  APyDelphiWrapper.DefineVar('sdAscending', 'sdAscending');
  APyDelphiWrapper.DefineVar('sdDescending', 'sdDescending');

  APyDelphiWrapper.DefineVar('cbNone', 'cbNone');
  APyDelphiWrapper.DefineVar('cbRaised', 'cbRaised');
  APyDelphiWrapper.DefineVar('cbLowered', 'cbLowered');
  APyDelphiWrapper.DefineVar('cbGrid3d', 'cbGrid3d');

  APyDelphiWrapper.DefineVar('haLeft', 'haLeft');
  APyDelphiWrapper.DefineVar('haCenter', 'haCenter');
  APyDelphiWrapper.DefineVar('haRight', 'haRight');
  APyDelphiWrapper.DefineVar('vaTop', 'vaTop');
  APyDelphiWrapper.DefineVar('vaCenter', 'vaCenter');
  APyDelphiWrapper.DefineVar('vaBottom', 'vaBottom');
  APyDelphiWrapper.DefineVar('gkNone', 'gkNone');
  APyDelphiWrapper.DefineVar('gkBlank', 'gkBlank');
  APyDelphiWrapper.DefineVar('gkPointer', 'gkPointer');
  APyDelphiWrapper.DefineVar('gkNumber', 'gkNumber');
  APyDelphiWrapper.DefineVar('gkString', 'gkString');
  APyDelphiWrapper.DefineVar('gtNone', 'gtNone');
  APyDelphiWrapper.DefineVar('gtLeftTop', 'gtLeftTop');
  APyDelphiWrapper.DefineVar('gtLeft', 'gtLeft');
  APyDelphiWrapper.DefineVar('gtTop', 'gtTop');
  APyDelphiWrapper.DefineVar('gtCell', 'gtCell');
  APyDelphiWrapper.DefineVar('gtColSizing', 'gtColSizing');
  APyDelphiWrapper.DefineVar('gtSmallBox', 'gtSmallBox');
  APyDelphiWrapper.DefineVar('gsNormal', 'gsNormal');
  APyDelphiWrapper.DefineVar('gsSelAll', 'gsSelAll');
  APyDelphiWrapper.DefineVar('gsSelRow', 'gsSelRow');
  APyDelphiWrapper.DefineVar('gsSelCol', 'gsSelCol');
  APyDelphiWrapper.DefineVar('gsCell', 'gsCell');
  APyDelphiWrapper.DefineVar('gsColSize', 'gsColSize');
  APyDelphiWrapper.DefineVar('gsBoxDrag', 'gsBoxDrag');

  APyDelphiWrapper.DefineVar('ckNone', 'ckNone');
  APyDelphiWrapper.DefineVar('ckCheckBox', 'ckCheckBox');
  APyDelphiWrapper.DefineVar('ckCombobox', 'ckCombobox');
  APyDelphiWrapper.DefineVar('ckOption', 'ckOption');
  APyDelphiWrapper.DefineVar('pkString', 'pkString');
  APyDelphiWrapper.DefineVar('pkInteger', 'pkInteger');
  APyDelphiWrapper.DefineVar('pkBoolean', 'pkBoolean');
  APyDelphiWrapper.DefineVar('pkDateTime', 'pkDateTime');
  APyDelphiWrapper.DefineVar('pkDate', 'pkDate');
  APyDelphiWrapper.DefineVar('pkTime', 'pkTime');
end;

function TExtendGridsRegistration.Name: string;
begin
  Result := 'ExtendGrids';
end;

procedure TExtendGridsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiLedgerGrid);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiEduStringGrid);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiNiceGrid);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiNiceGridSync);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiP4DParamGrid);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiP4DListGrid);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiSimpleGrid);
end;

{ TPyDelphiLedgerGrid }

class function TPyDelphiLedgerGrid.DelphiObjectClass: TClass;
begin
  Result := TLedgerGrid;
end;

function TPyDelphiLedgerGrid.GetDelphiObject: TLedgerGrid;
begin
  Result := TLedgerGrid(inherited DelphiObject);
end;

procedure TPyDelphiLedgerGrid.SetDelphiObject(const Value: TLedgerGrid);
begin
  inherited DelphiObject := Value;
end;

class function TPyDelphiLedgerGrid.GetTypeName : string;
begin
  Result := 'LedgerGrid';
end;

{ TPyDelphiEduStringGrid }

class function TPyDelphiEduStringGrid.DelphiObjectClass: TClass;
begin
  Result := TEduStringGrid;
end;

function TPyDelphiEduStringGrid.GetDelphiObject: TEduStringGrid;
begin
  Result := TEduStringGrid(inherited DelphiObject);
end;

procedure TPyDelphiEduStringGrid.SetDelphiObject(const Value: TEduStringGrid);
begin
  inherited DelphiObject := Value;
end;

class function TPyDelphiEduStringGrid.GetTypeName : string;
begin
  Result := 'EduStringGrid';
end;

{ TPyDelphiNiceGrid }

class function TPyDelphiNiceGrid.DelphiObjectClass: TClass;
begin
  Result := TNiceGrid;
end;

function TPyDelphiNiceGrid.GetDelphiObject: TNiceGrid;
begin
  Result := TNiceGrid(inherited DelphiObject);
end;

procedure TPyDelphiNiceGrid.SetDelphiObject(const Value: TNiceGrid);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiNiceGridSync }

class function TPyDelphiNiceGridSync.DelphiObjectClass: TClass;
begin
  Result := TNiceGridSync;
end;

function TPyDelphiNiceGridSync.GetDelphiObject: TNiceGridSync;
begin
  Result := TNiceGridSync(inherited DelphiObject);
end;

procedure TPyDelphiNiceGridSync.SetDelphiObject(const Value: TNiceGridSync);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiP4DParamGrid }

class function TPyDelphiP4DParamGrid.DelphiObjectClass: TClass;
begin
  Result := TP4DParamGrid;
end;

function TPyDelphiP4DParamGrid.GetDelphiObject: TP4DParamGrid;
begin
  Result := TP4DParamGrid(inherited DelphiObject);
end;

procedure TPyDelphiP4DParamGrid.SetDelphiObject(const Value: TP4DParamGrid);
begin
  inherited DelphiObject := Value;
end;

class function TPyDelphiP4DParamGrid.GetTypeName : string;
begin
  Result := 'P4DParamGrid';
end;

{ TPyDelphiP4DListGrid }

class function TPyDelphiP4DListGrid.DelphiObjectClass: TClass;
begin
  Result := TP4DListGrid;
end;

function TPyDelphiP4DListGrid.GetDelphiObject: TP4DListGrid;
begin
  Result := TP4DListGrid(inherited DelphiObject);
end;

procedure TPyDelphiP4DListGrid.SetDelphiObject(const Value: TP4DListGrid);
begin
  inherited DelphiObject := Value;
end;

class function TPyDelphiP4DListGrid.GetTypeName : string;
begin
  Result := 'P4DListGrid';
end;

{ TPyDelphiSimpleGrid }

class function TPyDelphiSimpleGrid.DelphiObjectClass: TClass;
begin
  Result := TSimpleGrid;
end;

function TPyDelphiSimpleGrid.GetDelphiObject: TSimpleGrid;
begin
  Result := TSimpleGrid(inherited DelphiObject);
end;

procedure TPyDelphiSimpleGrid.SetDelphiObject(const Value: TSimpleGrid);
begin
  inherited DelphiObject := Value;
end;

class function TPyDelphiSimpleGrid.GetTypeName : string;
begin
  Result := 'SimpleGrid';
end;

initialization
  RegisteredUnits.Add( TExtendGridsRegistration.Create );
end.
