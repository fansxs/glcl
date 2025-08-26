
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

unit WrapVclSamplesDirOutln;

interface

uses
  Classes, WrapDelphi, WrapVclGrids, Vcl.Samples.DirOutln;

type

  TPyDelphiDirectoryOutline = class(TPyDelphiCustomOutline)
  private
    function GetDelphiObject: TDirectoryOutline;
    procedure SetDelphiObject(const Value: TDirectoryOutline);
  public
    class function DelphiObjectClass: TClass; override;
    property DelphiObject: TDirectoryOutline read GetDelphiObject write SetDelphiObject;
  end;

implementation

{ Register the wrappers, the globals and the constants }
type
  TDirectoryOutlineRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
  end;

{ TDirectoryOutlineRegistration }

procedure TDirectoryOutlineRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('tcLowerCase', 'tcLowerCase');
  APyDelphiWrapper.DefineVar('tcUpperCase', 'tcUpperCase');
  APyDelphiWrapper.DefineVar('tcAsIs', 'tcAsIs');
end;

function TDirectoryOutlineRegistration.Name: string;
begin
  Result := 'Samples.DirectoryOutline';
end;

procedure TDirectoryOutlineRegistration.RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiDirectoryOutline);
end;

{ TPyDelphiDirectoryOutline }

class function TPyDelphiDirectoryOutline.DelphiObjectClass: TClass;
begin
  Result := TDirectoryOutline;
end;

function TPyDelphiDirectoryOutline.GetDelphiObject: TDirectoryOutline;
begin
  Result := TDirectoryOutline(inherited DelphiObject);
end;

procedure TPyDelphiDirectoryOutline.SetDelphiObject(const Value: TDirectoryOutline);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add( TDirectoryOutlineRegistration.Create );
  Classes.RegisterClasses([TDirectoryOutline]);
end.
