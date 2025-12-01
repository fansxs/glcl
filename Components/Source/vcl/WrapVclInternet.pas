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

unit WrapVclInternet;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  WrapVclControls, SHDocVw, System.Win.ScktComp;

type
  TPyDelphiWebBrowser = class(TPyDelphiWinControl)
  private
    function GetDelphiObject: TWebBrowser;
    procedure SetDelphiObject(const Value: TWebBrowser);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TWebBrowser read GetDelphiObject
      write SetDelphiObject;
  end;

  (*TPyDelphiClientSocket = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TClientSocket;
    procedure SetDelphiObject(const Value: TClientSocket);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TClientSocket read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiServerSocket = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TServerSocket;
    procedure SetDelphiObject(const Value: TServerSocket);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TServerSocket read GetDelphiObject
      write SetDelphiObject;
  end;*)

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TInternetRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TInternetRegistration }
procedure TInternetRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TInternetRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('IEOnly', 'IEOnly');
  APyDelphiWrapper.DefineVar('EdgeOnly', 'EdgeOnly');
  APyDelphiWrapper.DefineVar('EdgeIfAvailable', 'EdgeIfAvailable');
end;

function TInternetRegistration.Name: string;
begin
  Result := 'Internet';
end;

procedure TInternetRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiWebBrowser);
  //APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiClientSocket);
  //APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiServerSocket);
end;

{ TPyDelphiWebBrowser }

class function TPyDelphiWebBrowser.DelphiObjectClass: TClass;
begin
  Result := TWebBrowser;
end;

function TPyDelphiWebBrowser.GetDelphiObject: TWebBrowser;
begin
  Result := TWebBrowser(inherited DelphiObject);
end;

procedure TPyDelphiWebBrowser.SetDelphiObject(const Value: TWebBrowser);
begin
  inherited DelphiObject := Value;
end;
(*
{ TPyDelphiClientSocket }

class function TPyDelphiClientSocket.DelphiObjectClass: TClass;
begin
  Result := TClientSocket;
end;

function TPyDelphiClientSocket.GetDelphiObject: TClientSocket;
begin
  Result := TClientSocket(inherited DelphiObject);
end;

procedure TPyDelphiClientSocket.SetDelphiObject(const Value: TClientSocket);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiServerSocket }

class function TPyDelphiServerSocket.DelphiObjectClass: TClass;
begin
  Result := TServerSocket;
end;

function TPyDelphiServerSocket.GetDelphiObject: TServerSocket;
begin
  Result := TServerSocket(inherited DelphiObject);
end;

procedure TPyDelphiServerSocket.SetDelphiObject(const Value: TServerSocket);
begin
  inherited DelphiObject := Value;
end;
*)
initialization
  RegisteredUnits.Add(TInternetRegistration.Create);

end.
