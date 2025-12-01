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

unit WrapVclDataAccess;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  Datasnap.Provider, Datasnap.DBClient, Data.DB;

type
  TPyDelphiDataSource = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TDataSource;
    procedure SetDelphiObject(const Value: TDataSource);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TDataSource read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiClientDataSet = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TClientDataSet;
    procedure SetDelphiObject(const Value: TClientDataSet);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TClientDataSet read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiDataSetProvider = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TDataSetProvider;
    procedure SetDelphiObject(const Value: TDataSetProvider);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TDataSetProvider read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes, MidasLib;

{ Register the wrappers, the globals and the constants }
type
  TDataAccessRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TDataAccessRegistration }
procedure TDataAccessRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TDataAccessRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('dfBinary', 'dfBinary');
  APyDelphiWrapper.DefineVar('dfXML', 'dfXML');
  APyDelphiWrapper.DefineVar('dfXMLUTF8', 'dfXMLUTF8');

  APyDelphiWrapper.DefineVar('raSkip', 'raSkip');
  APyDelphiWrapper.DefineVar('raAbort', 'raAbort');
  APyDelphiWrapper.DefineVar('raMerge', 'raMerge');
  APyDelphiWrapper.DefineVar('raCorrect', 'raCorrect');
  APyDelphiWrapper.DefineVar('raCancel', 'raCancel');
  APyDelphiWrapper.DefineVar('raRefresh', 'raRefresh');

  APyDelphiWrapper.DefineVar('doDisableInserts', 'doDisableInserts');
  APyDelphiWrapper.DefineVar('doDisableDeletes', 'doDisableDeletes');
  APyDelphiWrapper.DefineVar('doDisableEdits', 'doDisableEdits');
  APyDelphiWrapper.DefineVar('doNoResetCall', 'doNoResetCall');

  APyDelphiWrapper.DefineVar('foRecord', 'foRecord');
  APyDelphiWrapper.DefineVar('foBlobs', 'foBlobs');
  APyDelphiWrapper.DefineVar('foDetails', 'foDetails');

  APyDelphiWrapper.DefineVar('rrSkip', 'rrSkip');
  APyDelphiWrapper.DefineVar('rrAbort', 'rrAbort');
  APyDelphiWrapper.DefineVar('rrMerge', 'rrMerge');
  APyDelphiWrapper.DefineVar('rrApply', 'rrApply');
  APyDelphiWrapper.DefineVar('rrIgnore', 'rrIgnore');

  APyDelphiWrapper.DefineVar('ResetOption', ResetOption);
  APyDelphiWrapper.DefineVar('MetaDataOption', MetaDataOption);
  APyDelphiWrapper.DefineVar('XMLOption', XMLOption);
  APyDelphiWrapper.DefineVar('XMLUTF8Option', XMLUTF8Option);
end;

function TDataAccessRegistration.Name: string;
begin
  Result := 'DataAccess';
end;

procedure TDataAccessRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDataSource);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiClientDataSet);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDataSetProvider);
end;

{ TPyDelphiDataSource }

class function TPyDelphiDataSource.DelphiObjectClass: TClass;
begin
  Result := TDataSource;
end;

function TPyDelphiDataSource.GetDelphiObject: TDataSource;
begin
  Result := TDataSource(inherited DelphiObject);
end;

procedure TPyDelphiDataSource.SetDelphiObject(const Value: TDataSource);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiClientDataSet }

class function TPyDelphiClientDataSet.DelphiObjectClass: TClass;
begin
  Result := TClientDataSet;
end;

function TPyDelphiClientDataSet.GetDelphiObject: TClientDataSet;
begin
  Result := TClientDataSet(inherited DelphiObject);
end;

procedure TPyDelphiClientDataSet.SetDelphiObject(const Value: TClientDataSet);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiDataSetProvider }

class function TPyDelphiDataSetProvider.DelphiObjectClass: TClass;
begin
  Result := TDataSetProvider;
end;

function TPyDelphiDataSetProvider.GetDelphiObject: TDataSetProvider;
begin
  Result := TDataSetProvider(inherited DelphiObject);
end;

procedure TPyDelphiDataSetProvider.SetDelphiObject(const Value: TDataSetProvider);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TDataAccessRegistration.Create);

end.
