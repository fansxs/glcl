(**************************************************************************)
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

unit WrapVcldbGo;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses, Data.Win.ADODB, Data.DB;

type
  TPyDelphiADOConnection = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TADOConnection;
    procedure SetDelphiObject(const Value: TADOConnection);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TADOConnection read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiADOCommand = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TADOCommand;
    procedure SetDelphiObject(const Value: TADOCommand);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TADOCommand read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiADODataSet = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TADODataSet;
    procedure SetDelphiObject(const Value: TADODataSet);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TADODataSet read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiADOTable = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TADOTable;
    procedure SetDelphiObject(const Value: TADOTable);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TADOTable read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiADOQuery = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TADOQuery;
    procedure SetDelphiObject(const Value: TADOQuery);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TADOQuery read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiADOStoredProc = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TADOStoredProc;
    procedure SetDelphiObject(const Value: TADOStoredProc);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TADOStoredProc read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiRDSConnection = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRDSConnection;
    procedure SetDelphiObject(const Value: TRDSConnection);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRDSConnection read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TdbGoRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TdbGoRegistration }
procedure TdbGoRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TdbGoRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
//  APyDelphiWrapper.DefineVar('vpByDateTime', 'vpByDateTime');
//  APyDelphiWrapper.DefineVar('vpByNumber', 'vpByNumber');
end;

function TdbGoRegistration.Name: string;
begin
  Result := 'dbGo';
end;

procedure TdbGoRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiADOConnection);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiADOCommand);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiADODataSet);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiADOTable);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiADOQuery);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiADOStoredProc);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRDSConnection);
end;

{ TPyDelphiADOConnection }

class function TPyDelphiADOConnection.DelphiObjectClass: TClass;
begin
  Result := TADOConnection;
end;

function TPyDelphiADOConnection.GetDelphiObject: TADOConnection;
begin
  Result := TADOConnection(inherited DelphiObject);
end;

procedure TPyDelphiADOConnection.SetDelphiObject(const Value: TADOConnection);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiADOCommand }

class function TPyDelphiADOCommand.DelphiObjectClass: TClass;
begin
  Result := TADOCommand;
end;

function TPyDelphiADOCommand.GetDelphiObject: TADOCommand;
begin
  Result := TADOCommand(inherited DelphiObject);
end;

procedure TPyDelphiADOCommand.SetDelphiObject(const Value: TADOCommand);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiADODataSet }

class function TPyDelphiADODataSet.DelphiObjectClass: TClass;
begin
  Result := TADODataSet;
end;

function TPyDelphiADODataSet.GetDelphiObject: TADODataSet;
begin
  Result := TADODataSet(inherited DelphiObject);
end;

procedure TPyDelphiADODataSet.SetDelphiObject(const Value: TADODataSet);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiADOTable }

class function TPyDelphiADOTable.DelphiObjectClass: TClass;
begin
  Result := TADOTable;
end;

function TPyDelphiADOTable.GetDelphiObject: TADOTable;
begin
  Result := TADOTable(inherited DelphiObject);
end;

procedure TPyDelphiADOTable.SetDelphiObject(const Value: TADOTable);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiADOQuery }

class function TPyDelphiADOQuery.DelphiObjectClass: TClass;
begin
  Result := TADOQuery;
end;

function TPyDelphiADOQuery.GetDelphiObject: TADOQuery;
begin
  Result := TADOQuery(inherited DelphiObject);
end;

procedure TPyDelphiADOQuery.SetDelphiObject(const Value: TADOQuery);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiADOStoredProc }

class function TPyDelphiADOStoredProc.DelphiObjectClass: TClass;
begin
  Result := TADOStoredProc;
end;

function TPyDelphiADOStoredProc.GetDelphiObject: TADOStoredProc;
begin
  Result := TADOStoredProc(inherited DelphiObject);
end;

procedure TPyDelphiADOStoredProc.SetDelphiObject(const Value: TADOStoredProc);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRDSConnection }

class function TPyDelphiRDSConnection.DelphiObjectClass: TClass;
begin
  Result := TRDSConnection;
end;

function TPyDelphiRDSConnection.GetDelphiObject: TRDSConnection;
begin
  Result := TRDSConnection(inherited DelphiObject);
end;

procedure TPyDelphiRDSConnection.SetDelphiObject(const Value: TRDSConnection);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TdbGoRegistration.Create);

end.
