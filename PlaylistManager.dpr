program PlaylistManager;

uses
  Vcl.Forms,
  fMain_ in 'fMain_.pas' {fMain},
  DataStructs in 'DataStructs.pas',
  fAddBand_ in 'fAddBand_.pas' {fAddBand},
  fAddAlbum_ in 'fAddAlbum_.pas' {fAddAlbum};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
