
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

unit WrapVclDialogs;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses,
  WrapVclControls, Windows, Dialogs, TypInfo, Winapi.ActiveX,
  Vcl.ExtDlgs;

type
  TPyDelphiOpenDialog = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TOpenDialog;
    procedure SetDelphiObject(const Value: TOpenDialog);
  protected
    // Exposed Methods
    function Execute_Wrapper(args: PPyObject): PPyObject; cdecl;
    // Property Getters
    function Get_filename(AContext: Pointer): PPyObject; cdecl;
  public
    class function DelphiObjectClass: TClass; override;
    class procedure RegisterGetSets(PythonType: TPythonType); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TOpenDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiCommonDialog = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TCommonDialog;
    procedure SetDelphiObject(const Value: TCommonDialog);
  protected
    // Exposed Methods
    function Execute_Wrapper(args: PPyObject): PPyObject; cdecl;
  public
    class function DelphiObjectClass: TClass; override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TCommonDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiFontDialog = class(TPyDelphiCommonDialog)
  private
    function GetDelphiObject: TFontDialog;
    procedure SetDelphiObject(const Value: TFontDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TFontDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiColorDialog = class(TPyDelphiCommonDialog)
  private
    function GetDelphiObject: TColorDialog;
    procedure SetDelphiObject(const Value: TColorDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TColorDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiPrintDialog = class(TPyDelphiCommonDialog)
  private
    function GetDelphiObject: TPrintDialog;
    procedure SetDelphiObject(const Value: TPrintDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPrintDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiPrinterSetupDialog = class(TPyDelphiCommonDialog)
  private
    function GetDelphiObject: TPrinterSetupDialog;
    procedure SetDelphiObject(const Value: TPrinterSetupDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPrinterSetupDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiFindDialog = class(TPyDelphiCommonDialog)
  private
    function GetDelphiObject: TFindDialog;
    procedure SetDelphiObject(const Value: TFindDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TFindDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiReplaceDialog = class(TPyDelphiCommonDialog)
  private
    function GetDelphiObject: TReplaceDialog;
    procedure SetDelphiObject(const Value: TReplaceDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TReplaceDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiPageSetupDialog = class(TPyDelphiCommonDialog)
  private
    function GetDelphiObject: TPageSetupDialog;
    procedure SetDelphiObject(const Value: TPageSetupDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TPageSetupDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiFileOpenDialog = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TFileOpenDialog;
    procedure SetDelphiObject(const Value: TFileOpenDialog);
  protected
    // Exposed Methods
    function Execute_Wrapper(args: PPyObject): PPyObject; cdecl;
    // Property Getters
    function Get_filename(AContext: Pointer): PPyObject; cdecl;
  public
    class function DelphiObjectClass: TClass; override;
    class procedure RegisterGetSets(PythonType: TPythonType); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TFileOpenDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiFileSaveDialog = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TFileSaveDialog;
    procedure SetDelphiObject(const Value: TFileSaveDialog);
  protected
    // Exposed Methods
    function Execute_Wrapper(args: PPyObject): PPyObject; cdecl;
    // Property Getters
    function Get_filename(AContext: Pointer): PPyObject; cdecl;
  public
    class function DelphiObjectClass: TClass; override;
    class procedure RegisterGetSets(PythonType: TPythonType); override;
    class procedure RegisterMethods( PythonType : TPythonType ); override;
    // Properties
    property DelphiObject: TFileSaveDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiSaveDialog = class(TPyDelphiOpenDialog)
  private
    function GetDelphiObject: TSaveDialog;
    procedure SetDelphiObject(const Value: TSaveDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TSaveDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiOpenPictureDialog = class(TPyDelphiOpenDialog)
  private
    function GetDelphiObject: TOpenPictureDialog;
    procedure SetDelphiObject(const Value: TOpenPictureDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TOpenPictureDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiSavePictureDialog = class(TPyDelphiOpenPictureDialog)
  private
    function GetDelphiObject: TSavePictureDialog;
    procedure SetDelphiObject(const Value: TSavePictureDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TSavePictureDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiOpenTextFileDialog = class(TPyDelphiOpenDialog)
  private
    function GetDelphiObject: TOpenTextFileDialog;
    procedure SetDelphiObject(const Value: TOpenTextFileDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TOpenTextFileDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiSaveTextFileDialog = class(TPyDelphiOpenTextFileDialog)
  private
    function GetDelphiObject: TSaveTextFileDialog;
    procedure SetDelphiObject(const Value: TSaveTextFileDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TSaveTextFileDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiCustomTaskDialog = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TCustomTaskDialog;
    procedure SetDelphiObject(const Value: TCustomTaskDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TCustomTaskDialog read GetDelphiObject
      write SetDelphiObject;
  end;

  TPyDelphiTaskDialog = class(TPyDelphiCustomTaskDialog)
  private
    function GetDelphiObject: TTaskDialog;
    procedure SetDelphiObject(const Value: TTaskDialog);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TTaskDialog read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Global Functions }
function ShowMessage_Wrapper(pself, args: PPyObject): PPyObject; cdecl;
var
  LPyMsg: PPyObject;
begin
  with GetPythonEngine do
  begin
    if PyArg_ParseTuple(args, 'O:ShowMessage', @LPyMsg) <> 0 then
    begin
      ShowMessage(PyObjectAsString(LPyMsg));
      Result := GetPythonEngine.ReturnNone;
    end else
      Result := nil;
  end;
end;

{ Register the wrappers, the globals and the constants }
type
  TDialogRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TDialogRegistration }
procedure TDialogRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterFunction(PAnsiChar('ShowMessage'), ShowMessage_Wrapper,
    PAnsiChar('ShowMessage_Wrapper()'#10 +
    'Show a custom message as a dialog box.'));
end;

procedure TDialogRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.DefineVar('tdiNone', 'tdiNone');
  APyDelphiWrapper.DefineVar('tdiWarning', 'tdiWarning');
  APyDelphiWrapper.DefineVar('tdiError', 'tdiError');
  APyDelphiWrapper.DefineVar('tdiInformation', 'tdiInformation');
  APyDelphiWrapper.DefineVar('tdiShield', 'tdiShield');

  APyDelphiWrapper.DefineVar('tcbOk', 'tcbOk');
  APyDelphiWrapper.DefineVar('tcbYes', 'tcbYes');
  APyDelphiWrapper.DefineVar('tcbNo', 'tcbNo');
  APyDelphiWrapper.DefineVar('tcbCancel', 'tcbCancel');
  APyDelphiWrapper.DefineVar('tcbRetry', 'tcbRetry');
  APyDelphiWrapper.DefineVar('tcbClose', 'tcbClose');

  APyDelphiWrapper.DefineVar('ofReadOnly', 'ofReadOnly');
  APyDelphiWrapper.DefineVar('ofOverwritePrompt', 'ofOverwritePrompt');
  APyDelphiWrapper.DefineVar('ofHideReadOnly', 'ofHideReadOnly');
  APyDelphiWrapper.DefineVar('ofNoChangeDir', 'ofNoChangeDir');
  APyDelphiWrapper.DefineVar('ofShowHelp', 'ofShowHelp');
  APyDelphiWrapper.DefineVar('ofNoValidate', 'ofNoValidate');
  APyDelphiWrapper.DefineVar('ofAllowMultiSelect', 'ofAllowMultiSelect');
  APyDelphiWrapper.DefineVar('ofExtensionDifferent', 'ofExtensionDifferent');
  APyDelphiWrapper.DefineVar('ofPathMustExist', 'ofPathMustExist');
  APyDelphiWrapper.DefineVar('ofFileMustExist', 'ofFileMustExist');
  APyDelphiWrapper.DefineVar('ofCreatePrompt', 'ofCreatePrompt');
  APyDelphiWrapper.DefineVar('ofShareAware', 'ofShareAware');
  APyDelphiWrapper.DefineVar('ofNoReadOnlyReturn', 'ofNoReadOnlyReturn');
  APyDelphiWrapper.DefineVar('ofNoTestFileCreate', 'ofNoTestFileCreate');
  APyDelphiWrapper.DefineVar('ofNoNetworkButton', 'ofNoNetworkButton');
  APyDelphiWrapper.DefineVar('ofNoLongNames', 'ofNoLongNames');
  APyDelphiWrapper.DefineVar('ofOldStyleDialog', 'ofOldStyleDialog');
  APyDelphiWrapper.DefineVar('ofNoDereferenceLinks', 'ofNoDereferenceLinks');
  APyDelphiWrapper.DefineVar('ofEnableIncludeNotify', 'ofEnableIncludeNotify');
  APyDelphiWrapper.DefineVar('ofEnableSizing', 'ofEnableSizing');
  APyDelphiWrapper.DefineVar('ofDontAddToRecent', 'ofDontAddToRecent');
  APyDelphiWrapper.DefineVar('ofForceShowHidden', 'ofForceShowHidden');
  APyDelphiWrapper.DefineVar('ofExNoPlacesBar', 'ofExNoPlacesBar');

  APyDelphiWrapper.DefineVar('prAllPages', 'prAllPages');
  APyDelphiWrapper.DefineVar('prSelection', 'prSelection');
  APyDelphiWrapper.DefineVar('prPageNums', 'prPageNums');

  APyDelphiWrapper.DefineVar('poPrintToFile', 'poPrintToFile');
  APyDelphiWrapper.DefineVar('poPageNums', 'poPageNums');
  APyDelphiWrapper.DefineVar('poSelection', 'poSelection');
  APyDelphiWrapper.DefineVar('poWarning', 'poWarning');
  APyDelphiWrapper.DefineVar('poHelp', 'poHelp');
  APyDelphiWrapper.DefineVar('poDisablePrintToFile', 'poDisablePrintToFile');

  APyDelphiWrapper.DefineVar('psoDefaultMinMargins', 'psoDefaultMinMargins');
  APyDelphiWrapper.DefineVar('psoDisableMargins', 'psoDisableMargins');
  APyDelphiWrapper.DefineVar('psoDisableOrientation', 'psoDisableOrientation');
  APyDelphiWrapper.DefineVar('psoDisablePagePainting', 'psoDisablePagePainting');
  APyDelphiWrapper.DefineVar('psoDisablePaper', 'psoDisablePaper');
  APyDelphiWrapper.DefineVar('psoDisablePrinter', 'psoDisablePrinter');
  APyDelphiWrapper.DefineVar('psoMargins', 'psoMargins');
  APyDelphiWrapper.DefineVar('psoMinMargins', 'psoMinMargins');
  APyDelphiWrapper.DefineVar('psoShowHelp', 'psoShowHelp');
  APyDelphiWrapper.DefineVar('psoWarning', 'psoWarning');
  APyDelphiWrapper.DefineVar('psoNoNetworkButton', 'psoNoNetworkButton');

  APyDelphiWrapper.DefineVar('pkDotMatrix', 'pkDotMatrix');
  APyDelphiWrapper.DefineVar('pkHPPCL', 'pkHPPCL');

  APyDelphiWrapper.DefineVar('ptEnvelope', 'ptEnvelope');
  APyDelphiWrapper.DefineVar('ptPaper', 'ptPaper');

  APyDelphiWrapper.DefineVar('pmDefault', 'pmDefault');
  APyDelphiWrapper.DefineVar('pmMillimeters', 'pmMillimeters');
  APyDelphiWrapper.DefineVar('pmInches', 'pmInches');

  APyDelphiWrapper.DefineVar('mtWarning', mtWarning);
  APyDelphiWrapper.DefineVar('mtError', mtError);
  APyDelphiWrapper.DefineVar('mtInformation', mtInformation);
  APyDelphiWrapper.DefineVar('mtConfirmation', mtConfirmation);
  APyDelphiWrapper.DefineVar('mtCustom', 'mtCustom');

  APyDelphiWrapper.DefineVar('mbYes', mbYes);
  APyDelphiWrapper.DefineVar('mbNo', mbNo);
  APyDelphiWrapper.DefineVar('mbOK', mbOK);
  APyDelphiWrapper.DefineVar('mbCancel', mbCancel);
  APyDelphiWrapper.DefineVar('mbAbort', mbAbort);
  APyDelphiWrapper.DefineVar('mbRetry', mbRetry);
  APyDelphiWrapper.DefineVar('mbIgnore', mbIgnore);
  APyDelphiWrapper.DefineVar('mbAll', mbAll);
  APyDelphiWrapper.DefineVar('mbNoToAll', mbNoToAll);
  APyDelphiWrapper.DefineVar('mbYesToAll', mbYesToAll);
  APyDelphiWrapper.DefineVar('mbHelp', mbHelp);
  APyDelphiWrapper.DefineVar('mbClose', mbClose);

  APyDelphiWrapper.DefineVar('fdAnsiOnly', 'fdAnsiOnly');
  APyDelphiWrapper.DefineVar('fdTrueTypeOnly', 'fdTrueTypeOnly');
  APyDelphiWrapper.DefineVar('fdEffects', 'fdEffects');
  APyDelphiWrapper.DefineVar('fdFixedPitchOnly', 'fdFixedPitchOnly');
  APyDelphiWrapper.DefineVar('fdForceFontExist', 'fdForceFontExist');
  APyDelphiWrapper.DefineVar('fdNoFaceSel', 'fdNoFaceSel');
  APyDelphiWrapper.DefineVar('fdNoOEMFonts', 'fdNoOEMFonts');
  APyDelphiWrapper.DefineVar('fdNoSimulations', 'fdNoSimulations');
  APyDelphiWrapper.DefineVar('fdNoSizeSel', 'fdNoSizeSel');
  APyDelphiWrapper.DefineVar('fdNoStyleSel', 'fdNoStyleSel');
  APyDelphiWrapper.DefineVar('fdNoVectorFonts', 'fdNoVectorFonts');
  APyDelphiWrapper.DefineVar('fdShowHelp', 'fdShowHelp');
  APyDelphiWrapper.DefineVar('fdWysiwyg', 'fdWysiwyg');
  APyDelphiWrapper.DefineVar('fdLimitSize', 'fdLimitSize');
  APyDelphiWrapper.DefineVar('fdScalableOnly', 'fdScalableOnly');
  APyDelphiWrapper.DefineVar('fdApplyButton', 'fdApplyButton');
  APyDelphiWrapper.DefineVar('fdScreen', 'fdScreen');
  APyDelphiWrapper.DefineVar('fdPrinter', 'fdPrinter');
  APyDelphiWrapper.DefineVar('fdBoth', 'fdBoth');
  APyDelphiWrapper.DefineVar('cdFullOpen', 'cdFullOpen');
  APyDelphiWrapper.DefineVar('cdPreventFullOpen', 'cdPreventFullOpen');
  APyDelphiWrapper.DefineVar('cdShowHelp', 'cdShowHelp');
  APyDelphiWrapper.DefineVar('cdSolidColor', 'cdSolidColor');
  APyDelphiWrapper.DefineVar('cdAnyColor', 'cdAnyColor');
  APyDelphiWrapper.DefineVar('gkText', 'gkText');
  APyDelphiWrapper.DefineVar('gkHorizontalBar', 'gkHorizontalBar');
  APyDelphiWrapper.DefineVar('gkVerticalBar', 'gkVerticalBar');
  APyDelphiWrapper.DefineVar('gkPie', 'gkPie');
  APyDelphiWrapper.DefineVar('gkNeedle', 'gkNeedle');

  APyDelphiWrapper.DefineVar('tdiNone', tdiNone);
  APyDelphiWrapper.DefineVar('tdiWarning', tdiWarning);
  APyDelphiWrapper.DefineVar('tdiError', tdiError);
  APyDelphiWrapper.DefineVar('tdiInformation', tdiInformation);
  APyDelphiWrapper.DefineVar('tdiShield', tdiShield);
  APyDelphiWrapper.DefineVar('tfEnableHyperlinks', 'tfEnableHyperlinks');
  APyDelphiWrapper.DefineVar('tfUseHiconMain', 'tfUseHiconMain');
  APyDelphiWrapper.DefineVar('tfUseHiconFooter', 'tfUseHiconFooter');
  APyDelphiWrapper.DefineVar('tfAllowDialogCancellation', 'tfAllowDialogCancellation');
  APyDelphiWrapper.DefineVar('tfUseCommandLinks', 'tfUseCommandLinks');
  APyDelphiWrapper.DefineVar('tfUseCommandLinksNoIcon', 'tfUseCommandLinksNoIcon');
  APyDelphiWrapper.DefineVar('tfExpandFooterArea', 'tfExpandFooterArea');
  APyDelphiWrapper.DefineVar('tfExpandedByDefault', 'tfExpandedByDefault');
  APyDelphiWrapper.DefineVar('tfVerificationFlagChecked', 'tfVerificationFlagChecked');
  APyDelphiWrapper.DefineVar('tfShowProgressBar', 'tfShowProgressBar');
  APyDelphiWrapper.DefineVar('tfShowMarqueeProgressBar', 'tfShowMarqueeProgressBar');
  APyDelphiWrapper.DefineVar('tfCallbackTimer', 'tfCallbackTimer');
  APyDelphiWrapper.DefineVar('tfPositionRelativeToWindow', 'tfPositionRelativeToWindow');
  APyDelphiWrapper.DefineVar('tfRtlLayout', 'tfRtlLayout');
  APyDelphiWrapper.DefineVar('tfNoDefaultRadioButton', 'tfNoDefaultRadioButton');
  APyDelphiWrapper.DefineVar('tfCanBeMinimized', 'tfCanBeMinimized');
  APyDelphiWrapper.DefineVar('tfSizeToContent', 'tfSizeToContent');
  APyDelphiWrapper.DefineVar('tcbOk', 'tcbOk');
  APyDelphiWrapper.DefineVar('tcbYes', 'tcbYes');
  APyDelphiWrapper.DefineVar('tcbNo', 'tcbNo');
  APyDelphiWrapper.DefineVar('tcbCancel', 'tcbCancel');
  APyDelphiWrapper.DefineVar('tcbRetry', 'tcbRetry');
  APyDelphiWrapper.DefineVar('tcbClose', 'tcbClose');

  { TOpenDialog }
  APyDelphiWrapper.DefineVar('ofReadOnly', 'ofReadOnly');
  APyDelphiWrapper.DefineVar('ofOverwritePrompt', 'ofOverwritePrompt');
  APyDelphiWrapper.DefineVar('ofHideReadOnly', 'ofHideReadOnly');
  APyDelphiWrapper.DefineVar('ofNoChangeDir', 'ofNoChangeDir');
  APyDelphiWrapper.DefineVar('ofShowHelp', 'ofShowHelp');
  APyDelphiWrapper.DefineVar('ofNoValidate', 'ofNoValidate');
  APyDelphiWrapper.DefineVar('ofAllowMultiSelect', 'ofAllowMultiSelect');
  APyDelphiWrapper.DefineVar('ofExtensionDifferent', 'ofExtensionDifferent');
  APyDelphiWrapper.DefineVar('ofPathMustExist', 'ofPathMustExist');
  APyDelphiWrapper.DefineVar('ofFileMustExist', 'ofFileMustExist');
  APyDelphiWrapper.DefineVar('ofCreatePrompt', 'ofCreatePrompt');
  APyDelphiWrapper.DefineVar('ofShareAware', 'ofShareAware');
  APyDelphiWrapper.DefineVar('ofNoReadOnlyReturn', 'ofNoReadOnlyReturn');
  APyDelphiWrapper.DefineVar('ofNoTestFileCreate', 'ofNoTestFileCreate');
  APyDelphiWrapper.DefineVar('ofNoNetworkButton', 'ofNoNetworkButton');
  APyDelphiWrapper.DefineVar('ofNoLongNames', 'ofNoLongNames');
  APyDelphiWrapper.DefineVar('ofOldStyleDialog', 'ofOldStyleDialog');
  APyDelphiWrapper.DefineVar('ofNoDereferenceLinks', 'ofNoDereferenceLinks');
  APyDelphiWrapper.DefineVar('ofEnableIncludeNotify', 'ofEnableIncludeNotify');
  APyDelphiWrapper.DefineVar('ofEnableSizing', 'ofEnableSizing');
  APyDelphiWrapper.DefineVar('ofDontAddToRecent', 'ofDontAddToRecent');
  APyDelphiWrapper.DefineVar('ofForceShowHidden', 'ofForceShowHidden');
  APyDelphiWrapper.DefineVar('ofExNoPlacesBar', 'ofExNoPlacesBar');
  APyDelphiWrapper.DefineVar('Standard', 'Standard');
  APyDelphiWrapper.DefineVar('Directory', 'Directory');

  { TPrintDialog }
  APyDelphiWrapper.DefineVar('prAllPages', 'prAllPages');
  APyDelphiWrapper.DefineVar('prSelection', 'prSelection');
  APyDelphiWrapper.DefineVar('prPageNums', 'prPageNums');
  APyDelphiWrapper.DefineVar('poPrintToFile', 'poPrintToFile');
  APyDelphiWrapper.DefineVar('poPageNums', 'poPageNums');
  APyDelphiWrapper.DefineVar('poSelection', 'poSelection');
  APyDelphiWrapper.DefineVar('poWarning', 'poWarning');
  APyDelphiWrapper.DefineVar('poHelp', 'poHelp');
  APyDelphiWrapper.DefineVar('poDisablePrintToFile', 'poDisablePrintToFile');
  APyDelphiWrapper.DefineVar('psoDefaultMinMargins', 'psoDefaultMinMargins');
  APyDelphiWrapper.DefineVar('psoDisableMargins', 'psoDisableMargins');
  APyDelphiWrapper.DefineVar('psoDisableOrientation', 'psoDisableOrientation');
  APyDelphiWrapper.DefineVar('psoDisablePagePainting', 'psoDisablePagePainting');
  APyDelphiWrapper.DefineVar('psoDisablePaper', 'psoDisablePaper');
  APyDelphiWrapper.DefineVar('psoDisablePrinter', 'psoDisablePrinter');
  APyDelphiWrapper.DefineVar('psoMargins', 'psoMargins');
  APyDelphiWrapper.DefineVar('psoMinMargins', 'psoMinMargins');
  APyDelphiWrapper.DefineVar('psoShowHelp', 'psoShowHelp');
  APyDelphiWrapper.DefineVar('psoWarning', 'psoWarning');
  APyDelphiWrapper.DefineVar('psoNoNetworkButton', 'psoNoNetworkButton');
  APyDelphiWrapper.DefineVar('pkDotMatrix', 'pkDotMatrix');
  APyDelphiWrapper.DefineVar('pkHPPCL', 'pkHPPCL');
  APyDelphiWrapper.DefineVar('ptEnvelope', 'ptEnvelope');
  APyDelphiWrapper.DefineVar('ptPaper', 'ptPaper');
  APyDelphiWrapper.DefineVar('pmDefault', 'pmDefault');
  APyDelphiWrapper.DefineVar('pmMillimeters', 'pmMillimeters');
  APyDelphiWrapper.DefineVar('pmInches', 'pmInches');

  APyDelphiWrapper.DefineVar('mdiNone', 'mdiNone');
  APyDelphiWrapper.DefineVar('mdiWarning', 'mdiWarning');
  APyDelphiWrapper.DefineVar('mdiError', 'mdiError');
  APyDelphiWrapper.DefineVar('mdiInformation', 'mdiInformation');
  APyDelphiWrapper.DefineVar('mdiShield', 'mdiShield');
end;

function TDialogRegistration.Name: string;
begin
  Result := 'Dialog';
end;

procedure TDialogRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiOpenDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCommonDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiFileOpenDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiFileSaveDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiSaveDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiOpenPictureDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiSavePictureDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiOpenTextFileDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiSaveTextFileDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiFontDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiColorDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPrintDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPrinterSetupDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiFindDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiReplaceDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiPageSetupDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiCustomTaskDialog);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiTaskDialog);
end;

{ TPyDelphiOpenDialog }

class function TPyDelphiOpenDialog.DelphiObjectClass: TClass;
begin
  Result := TOpenDialog;
end;

function TPyDelphiOpenDialog.GetDelphiObject: TOpenDialog;
begin
  Result := TOpenDialog(inherited DelphiObject);
end;

function TPyDelphiOpenDialog.Execute_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Execute') <> 0 then
      Result := VariantAsPyObject(DelphiObject.Execute())
    else
      Result := nil;
  end;
end;

function TPyDelphiOpenDialog.Get_filename(AContext: Pointer): PPyObject;
begin
  Adjust(@self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.FileName);
end;

class procedure TPyDelphiOpenDialog.RegisterGetSets(PythonType: TPythonType);
begin
  PythonType.AddGetSet('FileName', @TPyDelphiOpenDialog.Get_filename,
    nil, '', nil);
end;

class procedure TPyDelphiOpenDialog.RegisterMethods(PythonType: TPythonType);
begin
  PythonType.AddMethod('Execute', @TPyDelphiOpenDialog.Execute_Wrapper,
    PAnsiChar('TOpenDialog.Execute()'#10 +
    'Displays the dialog'));
end;

procedure TPyDelphiOpenDialog.SetDelphiObject(const Value: TOpenDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCommonDialog }

class function TPyDelphiCommonDialog.DelphiObjectClass: TClass;
begin
  Result := TCommonDialog;
end;

function TPyDelphiCommonDialog.GetDelphiObject: TCommonDialog;
begin
  Result := TCommonDialog(inherited DelphiObject);
end;

function TPyDelphiCommonDialog.Execute_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Execute') <> 0 then
      Result := VariantAsPyObject(DelphiObject.Execute())
    else
      Result := nil;
  end;
end;

class procedure TPyDelphiCommonDialog.RegisterMethods(PythonType: TPythonType);
begin
  PythonType.AddMethod('Execute', @TPyDelphiCommonDialog.Execute_Wrapper,
    PAnsiChar('TCommonDialog.Execute()'#10 +
    'Displays the dialog'));
end;

procedure TPyDelphiCommonDialog.SetDelphiObject(const Value: TCommonDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiFontDialog }

class function TPyDelphiFontDialog.DelphiObjectClass: TClass;
begin
  Result := TFontDialog;
end;

function TPyDelphiFontDialog.GetDelphiObject: TFontDialog;
begin
  Result := TFontDialog(inherited DelphiObject);
end;

procedure TPyDelphiFontDialog.SetDelphiObject(const Value: TFontDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiColorDialog }

class function TPyDelphiColorDialog.DelphiObjectClass: TClass;
begin
  Result := TColorDialog;
end;

function TPyDelphiColorDialog.GetDelphiObject: TColorDialog;
begin
  Result := TColorDialog(inherited DelphiObject);
end;

procedure TPyDelphiColorDialog.SetDelphiObject(const Value: TColorDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPrintDialog }

class function TPyDelphiPrintDialog.DelphiObjectClass: TClass;
begin
  Result := TPrintDialog;
end;

function TPyDelphiPrintDialog.GetDelphiObject: TPrintDialog;
begin
  Result := TPrintDialog(inherited DelphiObject);
end;

procedure TPyDelphiPrintDialog.SetDelphiObject(const Value: TPrintDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPrinterSetupDialog }

class function TPyDelphiPrinterSetupDialog.DelphiObjectClass: TClass;
begin
  Result := TPrinterSetupDialog;
end;

function TPyDelphiPrinterSetupDialog.GetDelphiObject: TPrinterSetupDialog;
begin
  Result := TPrinterSetupDialog(inherited DelphiObject);
end;

procedure TPyDelphiPrinterSetupDialog.SetDelphiObject(const Value: TPrinterSetupDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiFindDialog }

class function TPyDelphiFindDialog.DelphiObjectClass: TClass;
begin
  Result := TFindDialog;
end;

function TPyDelphiFindDialog.GetDelphiObject: TFindDialog;
begin
  Result := TFindDialog(inherited DelphiObject);
end;

procedure TPyDelphiFindDialog.SetDelphiObject(const Value: TFindDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiReplaceDialog }

class function TPyDelphiReplaceDialog.DelphiObjectClass: TClass;
begin
  Result := TReplaceDialog;
end;

function TPyDelphiReplaceDialog.GetDelphiObject: TReplaceDialog;
begin
  Result := TReplaceDialog(inherited DelphiObject);
end;

procedure TPyDelphiReplaceDialog.SetDelphiObject(const Value: TReplaceDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiPageSetupDialog }

class function TPyDelphiPageSetupDialog.DelphiObjectClass: TClass;
begin
  Result := TPageSetupDialog;
end;

function TPyDelphiPageSetupDialog.GetDelphiObject: TPageSetupDialog;
begin
  Result := TPageSetupDialog(inherited DelphiObject);
end;

procedure TPyDelphiPageSetupDialog.SetDelphiObject(const Value: TPageSetupDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiFileOpenDialog }

class function TPyDelphiFileOpenDialog.DelphiObjectClass: TClass;
begin
  Result := TFileOpenDialog;
end;

function TPyDelphiFileOpenDialog.Execute_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Execute') <> 0 then
      Result := VariantAsPyObject(DelphiObject.Execute())
    else
      Result := nil;
  end;
end;

function TPyDelphiFileOpenDialog.GetDelphiObject: TFileOpenDialog;
begin
  Result := TFileOpenDialog(inherited DelphiObject);
end;

function TPyDelphiFileOpenDialog.Get_filename(AContext: Pointer): PPyObject;
begin
  Adjust(@self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.FileName);
end;

class procedure TPyDelphiFileOpenDialog.RegisterGetSets(
  PythonType: TPythonType);
begin
  PythonType.AddGetSet('FileName', @TPyDelphiFileOpenDialog.Get_filename,
    nil, '', nil);
end;

class procedure TPyDelphiFileOpenDialog.RegisterMethods(
  PythonType: TPythonType);
begin
  PythonType.AddMethod('Execute', @TPyDelphiFileOpenDialog.Execute_Wrapper,
    PAnsiChar('TFileOpenDialog.Execute()'#10 +
    'Displays the dialog'));
end;

procedure TPyDelphiFileOpenDialog.SetDelphiObject(const Value: TFileOpenDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiFileSaveDialog }

class function TPyDelphiFileSaveDialog.DelphiObjectClass: TClass;
begin
  Result := TFileSaveDialog;
end;

function TPyDelphiFileSaveDialog.Execute_Wrapper(args: PPyObject): PPyObject;
begin
  // We adjust the transmitted self argument
  Adjust(@Self);
  with GetPythonEngine do begin
    if PyArg_ParseTuple( args, ':Execute') <> 0 then
      Result := VariantAsPyObject(DelphiObject.Execute())
    else
      Result := nil;
  end;
end;

function TPyDelphiFileSaveDialog.GetDelphiObject: TFileSaveDialog;
begin
  Result := TFileSaveDialog(inherited DelphiObject);
end;

function TPyDelphiFileSaveDialog.Get_filename(AContext: Pointer): PPyObject;
begin
  Adjust(@self);
  Result := GetPythonEngine.VariantAsPyObject(DelphiObject.FileName);
end;

class procedure TPyDelphiFileSaveDialog.RegisterGetSets(
  PythonType: TPythonType);
begin
  PythonType.AddGetSet('FileName', @TPyDelphiFileSaveDialog.Get_filename,
    nil, '', nil);
end;

class procedure TPyDelphiFileSaveDialog.RegisterMethods(
  PythonType: TPythonType);
begin
  PythonType.AddMethod('Execute', @TPyDelphiFileSaveDialog.Execute_Wrapper,
    PAnsiChar('TFileSaveDialog.Execute()'#10 +
    'Displays the dialog'));
end;

procedure TPyDelphiFileSaveDialog.SetDelphiObject(const Value: TFileSaveDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiSaveDialog }

class function TPyDelphiSaveDialog.DelphiObjectClass: TClass;
begin
  Result := TSaveDialog;
end;

function TPyDelphiSaveDialog.GetDelphiObject: TSaveDialog;
begin
  Result := TSaveDialog(inherited DelphiObject);
end;

procedure TPyDelphiSaveDialog.SetDelphiObject(const Value: TSaveDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiOpenPictureDialog }

class function TPyDelphiOpenPictureDialog.DelphiObjectClass: TClass;
begin
  Result := TOpenPictureDialog;
end;

function TPyDelphiOpenPictureDialog.GetDelphiObject: TOpenPictureDialog;
begin
  Result := TOpenPictureDialog(inherited DelphiObject);
end;

procedure TPyDelphiOpenPictureDialog.SetDelphiObject(const Value: TOpenPictureDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiSavePictureDialog }

class function TPyDelphiSavePictureDialog.DelphiObjectClass: TClass;
begin
  Result := TSavePictureDialog;
end;

function TPyDelphiSavePictureDialog.GetDelphiObject: TSavePictureDialog;
begin
  Result := TSavePictureDialog(inherited DelphiObject);
end;

procedure TPyDelphiSavePictureDialog.SetDelphiObject(const Value: TSavePictureDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiOpenTextFileDialog }

class function TPyDelphiOpenTextFileDialog.DelphiObjectClass: TClass;
begin
  Result := TOpenTextFileDialog;
end;

function TPyDelphiOpenTextFileDialog.GetDelphiObject: TOpenTextFileDialog;
begin
  Result := TOpenTextFileDialog(inherited DelphiObject);
end;

procedure TPyDelphiOpenTextFileDialog.SetDelphiObject(const Value: TOpenTextFileDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiSaveTextFileDialog }

class function TPyDelphiSaveTextFileDialog.DelphiObjectClass: TClass;
begin
  Result := TSaveTextFileDialog;
end;

function TPyDelphiSaveTextFileDialog.GetDelphiObject: TSaveTextFileDialog;
begin
  Result := TSaveTextFileDialog(inherited DelphiObject);
end;

procedure TPyDelphiSaveTextFileDialog.SetDelphiObject(const Value: TSaveTextFileDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiCustomTaskDialog }

class function TPyDelphiCustomTaskDialog.DelphiObjectClass: TClass;
begin
  Result := TCustomTaskDialog;
end;

function TPyDelphiCustomTaskDialog.GetDelphiObject: TCustomTaskDialog;
begin
  Result := TCustomTaskDialog(inherited DelphiObject);
end;

procedure TPyDelphiCustomTaskDialog.SetDelphiObject(const Value: TCustomTaskDialog);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiTaskDialog }

class function TPyDelphiTaskDialog.DelphiObjectClass: TClass;
begin
  Result := TTaskDialog;
end;

function TPyDelphiTaskDialog.GetDelphiObject: TTaskDialog;
begin
  Result := TTaskDialog(inherited DelphiObject);
end;

procedure TPyDelphiTaskDialog.SetDelphiObject(const Value: TTaskDialog);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TDialogRegistration.Create);
  CoInitialize(nil);

finalization
  CoUninitialize();

end.
