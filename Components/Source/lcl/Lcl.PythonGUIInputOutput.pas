(**************************************************************************)
(*  This unit is part of the Python for Delphi (P4D) library              *)
(*  Project home: https://github.com/pyscripter/python4delphi             *)
(*                                                                        *)
(*  Project Maintainer:  PyScripter (pyscripter@gmail.com)                *)
(*  Original Authors:    Dr. Dietmar Budelsky (dbudelsky@web.de)          *)
(*                       Morgan Martinet (https://github.com/mmm-experts) *)
(*  Core developer:      Lucas Belo (lucas.belo@live.com)                 *)
(*  Contributors:        See contributors.md at project home              *)
(*                                                                        *)
(*  LICENCE and Copyright: MIT (see project home)                         *)
(**************************************************************************)

{$I ..\Definition.Inc}
unit Lcl.PythonGUIInputOutput;

interface

uses
{$IFDEF MSWINDOWS}
  Windows, Messages,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PythonEngine;

{$IFDEF MSWINDOWS}
const
  WM_WriteOutput = WM_USER + 1;
{$ENDIF}

type
  {$IF not Defined(FPC) and (CompilerVersion >= 23)}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$IFEND}
  TPythonGUIInputOutput = class(TPythonInputOutput)
  private
    { Private declarations }
    FCustomMemo : TCustomMemo;
{$IFDEF MSWINDOWS}
    FWinHandle : HWND;
{$ENDIF}
  protected
    { Protected declarations }
{$IFDEF MSWINDOWS}
    procedure pyGUIOutputWndProc (var Message: TMessage);
{$ENDIF}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SendData( const Data : AnsiString ); override;
    function  ReceiveData : AnsiString; override;
    procedure SendUniData( const Data : UnicodeString ); override;
    function  ReceiveUniData : UnicodeString; override;
    procedure AddPendingWrite; override;
    procedure WriteOutput;
  public
    { Public declarations }
    constructor Create( AOwner : TComponent ); override;
    destructor  Destroy; override;

    procedure DisplayString( const str : string );

  published
    { Published declarations }
    property Output : TCustomMemo read FCustomMemo write FCustomMemo;
  end;

implementation

{$IFDEF FPC}
{$IFDEF MSWINDOWS}
Uses
  InterfaceBase;
{$ENDIF}
{$ENDIF}

{PROTECTED METHODS}

{------------------------------------------------------------------------------}
procedure TPythonGUIInputOutput.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if aComponent = fCustomMemo then
      fCustomMemo := nil;
end;

{------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
procedure TPythonGUIInputOutput.pyGUIOutputWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_WriteOutput : WriteOutput;
  end;{case}
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TPythonGUIInputOutput.SendData( const Data : AnsiString );
begin
  if Assigned(FOnSendData) then
    inherited
  else
    DisplayString( string(Data) );
end;

procedure TPythonGUIInputOutput.SendUniData(const Data: UnicodeString);
begin
  if Assigned(FOnSendUniData) then
    inherited
  else
    DisplayString( string(Data) );
end;

{------------------------------------------------------------------------------}
function  TPythonGUIInputOutput.ReceiveData : AnsiString;
Var
  S : string;
begin
  if Assigned( FOnReceiveData ) then
    Result := inherited ReceiveData
  else
  begin
    InputQuery( 'Query from Python', 'Enter text', S);
    Result := AnsiString(S);
  end;
end;

function TPythonGUIInputOutput.ReceiveUniData: UnicodeString;
Var
  S : string;
begin
  if Assigned( FOnReceiveUniData ) then
    Result := inherited ReceiveUniData
  else
  begin
    InputQuery( 'Query from Python', 'Enter text', S);
    Result := UnicodeString(S);
  end;
end;

{------------------------------------------------------------------------------}
procedure TPythonGUIInputOutput.AddPendingWrite;
begin
{$IFDEF MSWINDOWS}
  PostMessage( fWinHandle, WM_WriteOutput, 0, 0 );
{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TPythonGUIInputOutput.WriteOutput;
var
  S : string;
begin
  if FQueue.Count = 0 then
    Exit;

  Lock;
  try
    while FQueue.Count > 0 do
    begin
      S := FQueue.Strings[ 0 ];
      FQueue.Delete(0);
      DisplayString( S );
    end;
  finally
    Unlock;
  end;
end;

{PUBLIC METHODS}

{------------------------------------------------------------------------------}
constructor TPythonGUIInputOutput.Create( AOwner : TComponent );
begin
  inherited Create(AOwner);
{$IFDEF MSWINDOWS}
  // Create an internal window for use in delayed writes
  // This will allow writes from multiple threads to be queue up and
  // then written out to the associated TCustomMemo by the main UI thread.
  {$IFDEF FPC}
    fWinHandle := WidgetSet.AllocateHWnd(pyGUIOutputWndProc);
  {$ELSE}
    fWinHandle := Classes.AllocateHWnd(pyGUIOutputWndProc);
  {$ENDIF}
{$ENDIF}
   UnicodeIO := True;
end;

{------------------------------------------------------------------------------}
destructor TPythonGUIInputOutput.Destroy;
begin
{$IFDEF MSWINDOWS}
  // Destroy the internal window used for Delayed write operations
  {$IFDEF FPC}
    WidgetSet.DeallocateHWnd(fWinHandle);
  {$ELSE}
    Classes.DeallocateHWnd(fWinHandle);
  {$ENDIF}
{$ENDIF}
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
type
  TMyCustomMemo = class(TCustomMemo);

procedure TPythonGUIInputOutput.DisplayString( const str : string );
begin
  if Assigned(Output) then
  begin
    if TMyCustomMemo(Output).Lines.Count >= MaxLines then
      TMyCustomMemo(Output).Lines.Delete(0);
    TMyCustomMemo(Output).Lines.Add(str);
{$IFDEF MSWINDOWS}
    SendMessage( Output.Handle, em_ScrollCaret, 0, 0);
{$ENDIF}
  end;
end;

{------------------------------------------------------------------------------}

end.
