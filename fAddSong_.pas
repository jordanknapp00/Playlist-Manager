unit fAddSong_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  fMain_;

type
  TfAddSong = class(TForm)
    cbAlbums: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    textBoxSongs: TMemo;
    btnAddSongs: TButton;
    Label3: TLabel;
    textBoxTrackNums: TMemo;
    Label4: TLabel;
    cbBands: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAddSong: TfAddSong;

implementation

{$R *.dfm}

procedure TfAddSong.FormCreate(Sender: TObject);
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  textBoxSongs.Text := '';
  textBoxTrackNums.Text := '';
end;

end.
