program bmp180;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'BMP180 sensor monitor';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
