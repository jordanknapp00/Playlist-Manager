program PlaylistManager;

uses
  Vcl.Forms,
  fMain_ in 'fMain_.pas' {fMain},
  DataStructs in 'DataStructs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
