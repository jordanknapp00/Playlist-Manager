program PlaylistManager;

uses
  Vcl.Forms,
  fMain_ in 'fMain_.pas' {fMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
