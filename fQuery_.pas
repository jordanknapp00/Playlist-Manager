unit fQuery_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfQuery = class(TForm)
    pnlSelectFrom: TPanel;
    cbBands: TCheckBox;
    cbAlbums: TCheckBox;
    cbSongs: TCheckBox;
    btnLoadQuery: TButton;
    btnSaveQuery: TButton;
    pnlBands: TPanel;
    edBands: TMemo;
    Label1: TLabel;
    cbBandFav: TCheckBox;
    pnlAlbums: TPanel;
    edAlbums: TMemo;
    Label2: TLabel;
    rgAlbumYear: TRadioGroup;
    edYears: TMemo;
    lblYears: TLabel;
    edYear: TEdit;
    lblYear: TLabel;
    cbAlbumFav: TCheckBox;
    pnlSongs: TPanel;
    edSongs: TMemo;
    Label5: TLabel;
    rgSongTrackNo: TRadioGroup;
    edSongTrackNums: TMemo;
    lblTrackNums: TLabel;
    edTrackNum: TEdit;
    lblTrackNum: TLabel;
    cbSongFav: TCheckBox;
    btnQuery: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SelectChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fQuery: TfQuery;

implementation

uses
  fMain_;

{$R *.dfm}

procedure TfQuery.FormCreate(Sender: TObject);
begin
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);
end;

procedure TfQuery.SelectChange(Sender: TObject);
const
  ALBUM_TOP: Integer = 207;
  SONG_TOP: Integer = 383;
var
  nextHeight: Integer;
begin
  nextHeight := pnlBands.Top;

  //if bands checked, next panel goes below it. otherwise, next panel goes on
  //top of it
  if cbBands.Checked then
  begin
    pnlBands.Visible := true;
    nextHeight := nextHeight + pnlBands.Height + 6;
  end
  else
  begin
    pnlBands.Visible := false;
    nextHeight := pnlBands.Top;
  end;

  //if albums checked, next panel goes below it. otherwise, if bands is checked,
  //next album goes below bands. if neither is checked, next panel goes where
  //bands is
  if cbAlbums.Checked then
  begin
    pnlAlbums.Visible := true;
    pnlAlbums.top := nextHeight;
    nextHeight := nextHeight + pnlAlbums.Height + 6;
  end
  else
  begin
    pnlAlbums.Visible := false;
    pnlAlbums.top := ALBUM_TOP;

    if cbBands.Checked then
      nextHeight := pnlBands.Top + pnlBands.Height + 6
    else
      nextHeight := pnlBands.Top;
  end;

  //finally, either put songs where it goes or back where it started
  if cbSongs.Checked then
  begin
    pnlSongs.Visible := true;
    pnlSongs.top := nextHeight;
  end
  else
  begin
    pnlSongs.Visible := false;
    pnlSongs.Top := SONG_TOP;
  end;

  //if any one is checked, show the query button
  btnQuery.Visible := (cbBands.Checked) or (cbAlbums.checked) or (cbSongs.Checked);
end;

end.
