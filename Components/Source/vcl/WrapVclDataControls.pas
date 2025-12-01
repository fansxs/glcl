
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

unit WrapVclDataControls;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  WrapVclGrids, Vcl.DBGrids;

type

  TPyDelphiDBGrid = class (TPyDelphiCustomGrid)
  private
    function  GetDelphiObject: TDBGrid;
    procedure SetDelphiObject(const Value: TDBGrid);
  protected
    class function GetTypeName : string; override;
  public
    class function  DelphiObjectClass : TClass; override;
    // Properties
    property DelphiObject: TDBGrid read GetDelphiObject write SetDelphiObject;
  end;


implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TDataControlsRegistration = class(TRegisteredUnit)
  public
    function Name : string; override;
    procedure RegisterWrappers(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper : TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;


{ TDataControlsRegistration }
procedure TDataControlsRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TDataControlsRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('dgEditing', 'dgEditing');
  APyDelphiWrapper.DefineVar('dgAlwaysShowEditor', 'dgAlwaysShowEditor');
  APyDelphiWrapper.DefineVar('dgTitles', 'dgTitles');
  APyDelphiWrapper.DefineVar('dgIndicator', 'dgIndicator');
  APyDelphiWrapper.DefineVar('dgColumnResize', 'dgColumnResize');
  APyDelphiWrapper.DefineVar('dgColLines', 'dgColLines');
  APyDelphiWrapper.DefineVar('dgRowLines', 'dgRowLines');
  APyDelphiWrapper.DefineVar('dgTabs', 'dgTabs');
  APyDelphiWrapper.DefineVar('dgRowSelect', 'dgRowSelect');
  APyDelphiWrapper.DefineVar('dgAlwaysShowSelection', 'dgAlwaysShowSelection');
  APyDelphiWrapper.DefineVar('dgConfirmDelete', 'dgConfirmDelete');
  APyDelphiWrapper.DefineVar('dgCancelOnExit', 'dgCancelOnExit');
  APyDelphiWrapper.DefineVar('dgMultiSelect', 'dgMultiSelect');
  APyDelphiWrapper.DefineVar('dgTitleClick', 'dgTitleClick');
  APyDelphiWrapper.DefineVar('dgTitleHotTrack', 'dgTitleHotTrack');
  APyDelphiWrapper.DefineVar('dgThumbTracking', 'dgThumbTracking');

  // Rich Edit
  APyDelphiWrapper.DefineVar('atSelected', 'atSelected');
  APyDelphiWrapper.DefineVar('atDefaultText', 'atDefaultText');

  APyDelphiWrapper.DefineVar('sstNone', 'sstNone');
  APyDelphiWrapper.DefineVar('sstSubscript', 'sstSubscript');
  APyDelphiWrapper.DefineVar('sstSuperscript', 'sstSuperscript');

  APyDelphiWrapper.DefineVar('caBold', 'caBold');
  APyDelphiWrapper.DefineVar('caColor', 'caColor');
  APyDelphiWrapper.DefineVar('caFace', 'caFace');
  APyDelphiWrapper.DefineVar('caItalic', 'caItalic');
  APyDelphiWrapper.DefineVar('caSize', 'caSize');
  APyDelphiWrapper.DefineVar('caStrikeOut', 'caStrikeOut');
  APyDelphiWrapper.DefineVar('caUnderline', 'caUnderline');
  APyDelphiWrapper.DefineVar('caProtected', 'caProtected');
  APyDelphiWrapper.DefineVar('caBackColor', 'caBackColor');
  APyDelphiWrapper.DefineVar('caCharset', 'caCharset');
  APyDelphiWrapper.DefineVar('caDisabled', 'caDisabled');
  APyDelphiWrapper.DefineVar('caHidden', 'caHidden');
  APyDelphiWrapper.DefineVar('caLink', 'caLink');
  APyDelphiWrapper.DefineVar('caOffset', 'caOffset');
  APyDelphiWrapper.DefineVar('caRevAuthor', 'caRevAuthor');
  APyDelphiWrapper.DefineVar('caSubscript', 'caSubscript');
  APyDelphiWrapper.DefineVar('caWeight', 'caWeight');

  APyDelphiWrapper.DefineVar('nsNone', 'nsNone');
  APyDelphiWrapper.DefineVar('nsBullet', 'nsBullet');

  APyDelphiWrapper.DefineVar('cpaAlignment', 'cpaAlignment');
  APyDelphiWrapper.DefineVar('cpaNumbering', 'cpaNumbering');
  APyDelphiWrapper.DefineVar('cpaFirstIndent', 'cpaFirstIndent');
  APyDelphiWrapper.DefineVar('cpaLeftIndent', 'cpaLeftIndent');
  APyDelphiWrapper.DefineVar('cpaRightIndent', 'cpaRightIndent');
  APyDelphiWrapper.DefineVar('cpaTabStops', 'cpaTabStops');

  APyDelphiWrapper.DefineVar('stWholeWord', 'stWholeWord');
  APyDelphiWrapper.DefineVar('stMatchCase', 'stMatchCase');
end;

function TDataControlsRegistration.Name: string;
begin
  Result := 'DataControls';
end;

procedure TDataControlsRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDBGrid);
end;

{ TPyDelphiDBGrid }

class function TPyDelphiDBGrid.DelphiObjectClass: TClass;
begin
  Result := TDBGrid;
end;

function TPyDelphiDBGrid.GetDelphiObject: TDBGrid;
begin
  Result := TDBGrid(inherited DelphiObject);
end;

procedure TPyDelphiDBGrid.SetDelphiObject(const Value: TDBGrid);
begin
  inherited DelphiObject := Value;
end;

class function TPyDelphiDBGrid.GetTypeName : string;
begin
  Result := 'DBGrid';
end;

initialization
  RegisteredUnits.Add( TDataControlsRegistration.Create );
end.
