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

unit WrapReportMachine;

interface

uses
  Classes, SysUtils, PythonEngine, WrapDelphi, WrapDelphiClasses, WrapVclExtCtrls,
  RM_FormReport, RM_PDBGrid, RMD_Dbx,
  RMD_ADO, RMD_ReportExplorer, RM_Class, RM_DsgGridReport, RM_Designer,
  RM_e_Jpeg, RM_E_llPDF, RM_e_main, RM_e_htm, RM_e_Xls, RM_e_Tiff, RM_E_WMF,
  RM_e_emf, RM_e_Graphic, RM_e_bmp, RM_e_csv, RM_Common, RM_e_txt, Vcl.ExtCtrls,
  RM_Preview, RM_DialogCtls, RM_BarCode, RM_Cross, RM_AsBarView, RM_Diagonal,
  RM_ChineseMoneyMemo, RM_Ole, RM_CheckBox, RM_RichEdit, RM_AngLbl, RM_Dataset,
  RM_GridReport;

type
  TPyDelphiRMReport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMReport;
    procedure SetDelphiObject(const Value: TRMReport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMReport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMGridReport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMGridReport;
    procedure SetDelphiObject(const Value: TRMGridReport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMGridReport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMCompositeReport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMCompositeReport;
    procedure SetDelphiObject(const Value: TRMCompositeReport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMCompositeReport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMDBDataSet = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMDBDataSet;
    procedure SetDelphiObject(const Value: TRMDBDataSet);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMDBDataSet read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMUserDataset = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMUserDataset;
    procedure SetDelphiObject(const Value: TRMUserDataset);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMUserDataset read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMAngledLabelObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMAngledLabelObject;
    procedure SetDelphiObject(const Value: TRMAngledLabelObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMAngledLabelObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMRichObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMRichObject;
    procedure SetDelphiObject(const Value: TRMRichObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMRichObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMCheckBoxObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMCheckBoxObject;
    procedure SetDelphiObject(const Value: TRMCheckBoxObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMCheckBoxObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMOLEObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMOLEObject;
    procedure SetDelphiObject(const Value: TRMOLEObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMOLEObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMChineseMoneyObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMChineseMoneyObject;
    procedure SetDelphiObject(const Value: TRMChineseMoneyObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMChineseMoneyObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMDiagonalObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMDiagonalObject;
    procedure SetDelphiObject(const Value: TRMDiagonalObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMDiagonalObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMAsBarCodeObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMAsBarCodeObject;
    procedure SetDelphiObject(const Value: TRMAsBarCodeObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMAsBarCodeObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMCrossObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMCrossObject;
    procedure SetDelphiObject(const Value: TRMCrossObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMCrossObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMBarCodeObject = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMBarCodeObject;
    procedure SetDelphiObject(const Value: TRMBarCodeObject);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMBarCodeObject read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMDialogControls = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMDialogControls;
    procedure SetDelphiObject(const Value: TRMDialogControls);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMDialogControls read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMPreview = class(TPyDelphiPanel)
  private
    function GetDelphiObject: TRMPreview;
    procedure SetDelphiObject(const Value: TRMPreview);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMPreview read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMTextExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMTextExport;
    procedure SetDelphiObject(const Value: TRMTextExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMTextExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMCSVExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMCSVExport;
    procedure SetDelphiObject(const Value: TRMCSVExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMCSVExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMBMPExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMBMPExport;
    procedure SetDelphiObject(const Value: TRMBMPExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMBMPExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMEMFExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMEMFExport;
    procedure SetDelphiObject(const Value: TRMEMFExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMEMFExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMWMFExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMWMFExport;
    procedure SetDelphiObject(const Value: TRMWMFExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMWMFExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMTiffExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMTiffExport;
    procedure SetDelphiObject(const Value: TRMTiffExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMTiffExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMXLSExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMXLSExport;
    procedure SetDelphiObject(const Value: TRMXLSExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMXLSExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMHTMExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMHTMExport;
    procedure SetDelphiObject(const Value: TRMHTMExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMHTMExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMllPDFExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMllPDFExport;
    procedure SetDelphiObject(const Value: TRMllPDFExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMllPDFExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMJPEGExport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMJPEGExport;
    procedure SetDelphiObject(const Value: TRMJPEGExport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMJPEGExport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMDesigner = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMDesigner;
    procedure SetDelphiObject(const Value: TRMDesigner);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMDesigner read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMGridReportDesigner = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMGridReportDesigner;
    procedure SetDelphiObject(const Value: TRMGridReportDesigner);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMGridReportDesigner read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMDataDictionary = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMDataDictionary;
    procedure SetDelphiObject(const Value: TRMDataDictionary);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMDataDictionary read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMReportExplorer = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMReportExplorer;
    procedure SetDelphiObject(const Value: TRMReportExplorer);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMReportExplorer read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMDADOComponents = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMDADOComponents;
    procedure SetDelphiObject(const Value: TRMDADOComponents);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMDADOComponents read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMDDBXComponents = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMDDBXComponents;
    procedure SetDelphiObject(const Value: TRMDDBXComponents);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMDDBXComponents read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMFormReport = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMFormReport;
    procedure SetDelphiObject(const Value: TRMFormReport);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMFormReport read GetDelphiObject
      write SetDelphiObject;
  end;

type
  TPyDelphiRMPrintDBGrid = class(TPyDelphiComponent)
  private
    function GetDelphiObject: TRMPrintDBGrid;
    procedure SetDelphiObject(const Value: TRMPrintDBGrid);
  public
    class function DelphiObjectClass: TClass; override;
    // Properties
    property DelphiObject: TRMPrintDBGrid read GetDelphiObject
      write SetDelphiObject;
  end;

implementation

uses
  WrapDelphiTypes;

{ Register the wrappers, the globals and the constants }
type
  TRMReportRegistration = class(TRegisteredUnit)
  public
    function Name: string; override;
    procedure RegisterWrappers(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineVars(APyDelphiWrapper: TPyDelphiWrapper); override;
    procedure DefineFunctions(APyDelphiWrapper : TPyDelphiWrapper); override;
  end;

  { TRMReportRegistration }
procedure TRMReportRegistration.DefineFunctions(
  APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
end;

procedure TRMReportRegistration.DefineVars(APyDelphiWrapper: TPyDelphiWrapper);
begin
  inherited;
//  APyDelphiWrapper.DefineVar('vpByDateTime', 'vpByDateTime');
//  APyDelphiWrapper.DefineVar('vpByNumber', 'vpByNumber');
end;

function TRMReportRegistration.Name: string;
begin
  Result := 'RMReport';
end;

procedure TRMReportRegistration.RegisterWrappers(APyDelphiWrapper
  : TPyDelphiWrapper);
begin
  inherited;
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMReport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMGridReport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMCompositeReport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMDBDataSet);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMUserDataset);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMAngledLabelObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMRichObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMCheckBoxObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMOLEObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMChineseMoneyObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMDiagonalObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMAsBarCodeObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMCrossObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMBarCodeObject);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMDialogControls);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMPreview);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMTextExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMCSVExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMBMPExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMEMFExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMWMFExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMTiffExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMXLSExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMHTMExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMllPDFExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMJPEGExport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMDesigner);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMGridReportDesigner);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMDataDictionary);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMReportExplorer);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMDADOComponents);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMDDBXComponents);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMFormReport);
  APyDelphiWrapper.RegisterDelphiWrapper(TPyDelphiRMPrintDBGrid);
end;

{ TPyDelphiRMReport }

class function TPyDelphiRMReport.DelphiObjectClass: TClass;
begin
  Result := TRMReport;
end;

function TPyDelphiRMReport.GetDelphiObject: TRMReport;
begin
  Result := TRMReport(inherited DelphiObject);
end;

procedure TPyDelphiRMReport.SetDelphiObject(const Value: TRMReport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMGridReport }

class function TPyDelphiRMGridReport.DelphiObjectClass: TClass;
begin
  Result := TRMGridReport;
end;

function TPyDelphiRMGridReport.GetDelphiObject: TRMGridReport;
begin
  Result := TRMGridReport(inherited DelphiObject);
end;

procedure TPyDelphiRMGridReport.SetDelphiObject(const Value: TRMGridReport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMCompositeReport }

class function TPyDelphiRMCompositeReport.DelphiObjectClass: TClass;
begin
  Result := TRMCompositeReport;
end;

function TPyDelphiRMCompositeReport.GetDelphiObject: TRMCompositeReport;
begin
  Result := TRMCompositeReport(inherited DelphiObject);
end;

procedure TPyDelphiRMCompositeReport.SetDelphiObject(const Value: TRMCompositeReport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMDBDataSet }

class function TPyDelphiRMDBDataSet.DelphiObjectClass: TClass;
begin
  Result := TRMDBDataSet;
end;

function TPyDelphiRMDBDataSet.GetDelphiObject: TRMDBDataSet;
begin
  Result := TRMDBDataSet(inherited DelphiObject);
end;

procedure TPyDelphiRMDBDataSet.SetDelphiObject(const Value: TRMDBDataSet);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMUserDataset }

class function TPyDelphiRMUserDataset.DelphiObjectClass: TClass;
begin
  Result := TRMUserDataset;
end;

function TPyDelphiRMUserDataset.GetDelphiObject: TRMUserDataset;
begin
  Result := TRMUserDataset(inherited DelphiObject);
end;

procedure TPyDelphiRMUserDataset.SetDelphiObject(const Value: TRMUserDataset);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMAngledLabelObject }

class function TPyDelphiRMAngledLabelObject.DelphiObjectClass: TClass;
begin
  Result := TRMAngledLabelObject;
end;

function TPyDelphiRMAngledLabelObject.GetDelphiObject: TRMAngledLabelObject;
begin
  Result := TRMAngledLabelObject(inherited DelphiObject);
end;

procedure TPyDelphiRMAngledLabelObject.SetDelphiObject(const Value: TRMAngledLabelObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMRichObject }

class function TPyDelphiRMRichObject.DelphiObjectClass: TClass;
begin
  Result := TRMRichObject;
end;

function TPyDelphiRMRichObject.GetDelphiObject: TRMRichObject;
begin
  Result := TRMRichObject(inherited DelphiObject);
end;

procedure TPyDelphiRMRichObject.SetDelphiObject(const Value: TRMRichObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMCheckBoxObject }

class function TPyDelphiRMCheckBoxObject.DelphiObjectClass: TClass;
begin
  Result := TRMCheckBoxObject;
end;

function TPyDelphiRMCheckBoxObject.GetDelphiObject: TRMCheckBoxObject;
begin
  Result := TRMCheckBoxObject(inherited DelphiObject);
end;

procedure TPyDelphiRMCheckBoxObject.SetDelphiObject(const Value: TRMCheckBoxObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMOLEObject }

class function TPyDelphiRMOLEObject.DelphiObjectClass: TClass;
begin
  Result := TRMOLEObject;
end;

function TPyDelphiRMOLEObject.GetDelphiObject: TRMOLEObject;
begin
  Result := TRMOLEObject(inherited DelphiObject);
end;

procedure TPyDelphiRMOLEObject.SetDelphiObject(const Value: TRMOLEObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMChineseMoneyObject }

class function TPyDelphiRMChineseMoneyObject.DelphiObjectClass: TClass;
begin
  Result := TRMChineseMoneyObject;
end;

function TPyDelphiRMChineseMoneyObject.GetDelphiObject: TRMChineseMoneyObject;
begin
  Result := TRMChineseMoneyObject(inherited DelphiObject);
end;

procedure TPyDelphiRMChineseMoneyObject.SetDelphiObject(const Value: TRMChineseMoneyObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMDiagonalObject }

class function TPyDelphiRMDiagonalObject.DelphiObjectClass: TClass;
begin
  Result := TRMDiagonalObject;
end;

function TPyDelphiRMDiagonalObject.GetDelphiObject: TRMDiagonalObject;
begin
  Result := TRMDiagonalObject(inherited DelphiObject);
end;

procedure TPyDelphiRMDiagonalObject.SetDelphiObject(const Value: TRMDiagonalObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMAsBarCodeObject }

class function TPyDelphiRMAsBarCodeObject.DelphiObjectClass: TClass;
begin
  Result := TRMAsBarCodeObject;
end;

function TPyDelphiRMAsBarCodeObject.GetDelphiObject: TRMAsBarCodeObject;
begin
  Result := TRMAsBarCodeObject(inherited DelphiObject);
end;

procedure TPyDelphiRMAsBarCodeObject.SetDelphiObject(const Value: TRMAsBarCodeObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMCrossObject }

class function TPyDelphiRMCrossObject.DelphiObjectClass: TClass;
begin
  Result := TRMCrossObject;
end;

function TPyDelphiRMCrossObject.GetDelphiObject: TRMCrossObject;
begin
  Result := TRMCrossObject(inherited DelphiObject);
end;

procedure TPyDelphiRMCrossObject.SetDelphiObject(const Value: TRMCrossObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMBarCodeObject }

class function TPyDelphiRMBarCodeObject.DelphiObjectClass: TClass;
begin
  Result := TRMBarCodeObject;
end;

function TPyDelphiRMBarCodeObject.GetDelphiObject: TRMBarCodeObject;
begin
  Result := TRMBarCodeObject(inherited DelphiObject);
end;

procedure TPyDelphiRMBarCodeObject.SetDelphiObject(const Value: TRMBarCodeObject);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMDialogControls }

class function TPyDelphiRMDialogControls.DelphiObjectClass: TClass;
begin
  Result := TRMDialogControls;
end;

function TPyDelphiRMDialogControls.GetDelphiObject: TRMDialogControls;
begin
  Result := TRMDialogControls(inherited DelphiObject);
end;

procedure TPyDelphiRMDialogControls.SetDelphiObject(const Value: TRMDialogControls);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMPreview }

class function TPyDelphiRMPreview.DelphiObjectClass: TClass;
begin
  Result := TRMPreview;
end;

function TPyDelphiRMPreview.GetDelphiObject: TRMPreview;
begin
  Result := TRMPreview(inherited DelphiObject);
end;

procedure TPyDelphiRMPreview.SetDelphiObject(const Value: TRMPreview);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMTextExport }

class function TPyDelphiRMTextExport.DelphiObjectClass: TClass;
begin
  Result := TRMTextExport;
end;

function TPyDelphiRMTextExport.GetDelphiObject: TRMTextExport;
begin
  Result := TRMTextExport(inherited DelphiObject);
end;

procedure TPyDelphiRMTextExport.SetDelphiObject(const Value: TRMTextExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMCSVExport }

class function TPyDelphiRMCSVExport.DelphiObjectClass: TClass;
begin
  Result := TRMCSVExport;
end;

function TPyDelphiRMCSVExport.GetDelphiObject: TRMCSVExport;
begin
  Result := TRMCSVExport(inherited DelphiObject);
end;

procedure TPyDelphiRMCSVExport.SetDelphiObject(const Value: TRMCSVExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMBMPExport }

class function TPyDelphiRMBMPExport.DelphiObjectClass: TClass;
begin
  Result := TRMBMPExport;
end;

function TPyDelphiRMBMPExport.GetDelphiObject: TRMBMPExport;
begin
  Result := TRMBMPExport(inherited DelphiObject);
end;

procedure TPyDelphiRMBMPExport.SetDelphiObject(const Value: TRMBMPExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMEMFExport }

class function TPyDelphiRMEMFExport.DelphiObjectClass: TClass;
begin
  Result := TRMEMFExport;
end;

function TPyDelphiRMEMFExport.GetDelphiObject: TRMEMFExport;
begin
  Result := TRMEMFExport(inherited DelphiObject);
end;

procedure TPyDelphiRMEMFExport.SetDelphiObject(const Value: TRMEMFExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMWMFExport }

class function TPyDelphiRMWMFExport.DelphiObjectClass: TClass;
begin
  Result := TRMWMFExport;
end;

function TPyDelphiRMWMFExport.GetDelphiObject: TRMWMFExport;
begin
  Result := TRMWMFExport(inherited DelphiObject);
end;

procedure TPyDelphiRMWMFExport.SetDelphiObject(const Value: TRMWMFExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMTiffExport }

class function TPyDelphiRMTiffExport.DelphiObjectClass: TClass;
begin
  Result := TRMTiffExport;
end;

function TPyDelphiRMTiffExport.GetDelphiObject: TRMTiffExport;
begin
  Result := TRMTiffExport(inherited DelphiObject);
end;

procedure TPyDelphiRMTiffExport.SetDelphiObject(const Value: TRMTiffExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMXLSExport }

class function TPyDelphiRMXLSExport.DelphiObjectClass: TClass;
begin
  Result := TRMXLSExport;
end;

function TPyDelphiRMXLSExport.GetDelphiObject: TRMXLSExport;
begin
  Result := TRMXLSExport(inherited DelphiObject);
end;

procedure TPyDelphiRMXLSExport.SetDelphiObject(const Value: TRMXLSExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMHTMExport }

class function TPyDelphiRMHTMExport.DelphiObjectClass: TClass;
begin
  Result := TRMHTMExport;
end;

function TPyDelphiRMHTMExport.GetDelphiObject: TRMHTMExport;
begin
  Result := TRMHTMExport(inherited DelphiObject);
end;

procedure TPyDelphiRMHTMExport.SetDelphiObject(const Value: TRMHTMExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMllPDFExport }

class function TPyDelphiRMllPDFExport.DelphiObjectClass: TClass;
begin
  Result := TRMllPDFExport;
end;

function TPyDelphiRMllPDFExport.GetDelphiObject: TRMllPDFExport;
begin
  Result := TRMllPDFExport(inherited DelphiObject);
end;

procedure TPyDelphiRMllPDFExport.SetDelphiObject(const Value: TRMllPDFExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMJPEGExport }

class function TPyDelphiRMJPEGExport.DelphiObjectClass: TClass;
begin
  Result := TRMJPEGExport;
end;

function TPyDelphiRMJPEGExport.GetDelphiObject: TRMJPEGExport;
begin
  Result := TRMJPEGExport(inherited DelphiObject);
end;

procedure TPyDelphiRMJPEGExport.SetDelphiObject(const Value: TRMJPEGExport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMDesigner }

class function TPyDelphiRMDesigner.DelphiObjectClass: TClass;
begin
  Result := TRMDesigner;
end;

function TPyDelphiRMDesigner.GetDelphiObject: TRMDesigner;
begin
  Result := TRMDesigner(inherited DelphiObject);
end;

procedure TPyDelphiRMDesigner.SetDelphiObject(const Value: TRMDesigner);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMGridReportDesigner }

class function TPyDelphiRMGridReportDesigner.DelphiObjectClass: TClass;
begin
  Result := TRMGridReportDesigner;
end;

function TPyDelphiRMGridReportDesigner.GetDelphiObject: TRMGridReportDesigner;
begin
  Result := TRMGridReportDesigner(inherited DelphiObject);
end;

procedure TPyDelphiRMGridReportDesigner.SetDelphiObject(const Value: TRMGridReportDesigner);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMDataDictionary }

class function TPyDelphiRMDataDictionary.DelphiObjectClass: TClass;
begin
  Result := TRMDataDictionary;
end;

function TPyDelphiRMDataDictionary.GetDelphiObject: TRMDataDictionary;
begin
  Result := TRMDataDictionary(inherited DelphiObject);
end;

procedure TPyDelphiRMDataDictionary.SetDelphiObject(const Value: TRMDataDictionary);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMReportExplorer }

class function TPyDelphiRMReportExplorer.DelphiObjectClass: TClass;
begin
  Result := TRMReportExplorer;
end;

function TPyDelphiRMReportExplorer.GetDelphiObject: TRMReportExplorer;
begin
  Result := TRMReportExplorer(inherited DelphiObject);
end;

procedure TPyDelphiRMReportExplorer.SetDelphiObject(const Value: TRMReportExplorer);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMDADOComponents }

class function TPyDelphiRMDADOComponents.DelphiObjectClass: TClass;
begin
  Result := TRMDADOComponents;
end;

function TPyDelphiRMDADOComponents.GetDelphiObject: TRMDADOComponents;
begin
  Result := TRMDADOComponents(inherited DelphiObject);
end;

procedure TPyDelphiRMDADOComponents.SetDelphiObject(const Value: TRMDADOComponents);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMDDBXComponents }

class function TPyDelphiRMDDBXComponents.DelphiObjectClass: TClass;
begin
  Result := TRMDDBXComponents;
end;

function TPyDelphiRMDDBXComponents.GetDelphiObject: TRMDDBXComponents;
begin
  Result := TRMDDBXComponents(inherited DelphiObject);
end;

procedure TPyDelphiRMDDBXComponents.SetDelphiObject(const Value: TRMDDBXComponents);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMFormReport }

class function TPyDelphiRMFormReport.DelphiObjectClass: TClass;
begin
  Result := TRMFormReport;
end;

function TPyDelphiRMFormReport.GetDelphiObject: TRMFormReport;
begin
  Result := TRMFormReport(inherited DelphiObject);
end;

procedure TPyDelphiRMFormReport.SetDelphiObject(const Value: TRMFormReport);
begin
  inherited DelphiObject := Value;
end;

{ TPyDelphiRMPrintDBGrid }

class function TPyDelphiRMPrintDBGrid.DelphiObjectClass: TClass;
begin
  Result := TRMPrintDBGrid;
end;

function TPyDelphiRMPrintDBGrid.GetDelphiObject: TRMPrintDBGrid;
begin
  Result := TRMPrintDBGrid(inherited DelphiObject);
end;

procedure TPyDelphiRMPrintDBGrid.SetDelphiObject(const Value: TRMPrintDBGrid);
begin
  inherited DelphiObject := Value;
end;

initialization
  RegisteredUnits.Add(TRMReportRegistration.Create);

end.
