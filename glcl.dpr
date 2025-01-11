library glcl;

uses
  SysUtils,
  Classes,
  uMain in 'uMain.pas';

{$I ..\..\Source\Definition.Inc}

exports
  // This must match the pattern "PyInit_[ProjectName]"
  // So if the project is named glcl then
  //   the export must be PyInit_glcl
  PyInit_glcl;

{$IFDEF MSWINDOWS}
{$E pyd}
{$ENDIF}

begin
end.

