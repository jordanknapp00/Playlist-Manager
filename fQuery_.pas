unit fQuery_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,

  System.Generics.Collections;

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
    edTrackNums: TMemo;
    lblTrackNums: TLabel;
    edTrackNum: TEdit;
    lblTrackNum: TLabel;
    cbSongFav: TCheckBox;
    btnQuery: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SelectChange(Sender: TObject);
    procedure rgAlbumYearClick(Sender: TObject);
    procedure rgSongTrackNoClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fQuery: TfQuery;

implementation

uses
  fMain_, DataStructs, DataModule;

{$R *.dfm}

procedure TfQuery.FormCreate(Sender: TObject);
begin
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  //put the year/years and track num/nums components on top of one another
  lblYear.Top := edYears.Top;
  edYear.Top := edYears.Top;

  lblTrackNum.Top := edTrackNums.Top;
  edTrackNum.Top := edTrackNums.Top;
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

procedure TfQuery.rgAlbumYearClick(Sender: TObject);
begin
  edYears.Visible := rgAlbumYear.ItemIndex = 2;
  lblYears.Visible := rgAlbumYear.ItemIndex = 2;
  edYear.Visible := rgAlbumYear.ItemIndex = 1;
  lblYear.Visible := rgAlbumYear.ItemIndex = 1;
end;

procedure TfQuery.rgSongTrackNoClick(Sender: TObject);
begin
  edTrackNums.Visible := rgSongTrackNo.ItemIndex = 2;
  lblTrackNums.Visible := rgSongTrackNo.ItemIndex = 2;
  edTrackNum.Visible := rgSongTrackNo.ItemIndex = 1;
  lblTrackNum.Visible := rgSongTrackNo.ItemIndex = 1;
end;

procedure TfQuery.btnQueryClick(Sender: TObject);
var
  //this list will contain the bands that are to be shown. each one will have a
  //list of albums to be shown, and each album will have a list of songs. if
  //albums and songs are not being shown, a single entry with name '' will be
  //used, that way nothing is displayed in the table
  selectedSet: TList<TBand>;

  emptyBand: TBand;
begin
  //we need some kind of way to get a set of all bands, albums, and songs to show.
  //what is the easiest way to do this?

  //could either create copies of objects that are to be shown. i.e. copy of a
  //band, then copy of each of its albums, and copy of each of their songs.
  //have that stored in a structure similar to what DataModule does. would make
  //freeing things fairly simple, but would use decent amount of memory in the
  //meantime. maybe not a big deal?

  //the alternative is to keep lists of each band, album, and song to show.
  //biggest problem is, how to deal with duplicate album and song names? do we
  //deal with that at all? I dunno... It actually depends a lot on the situation.
  //if no bands are being queried, then we don't have to worry about duplicate
  //album names. but if we're looking for a specific album by a specific band,
  //then we do. not an easy problem to solve, sounds like the former is a better
  //plan, even if it uses more memory.

  if cbBands.Checked then
  begin
    //add checked bands here
  end
  else
  begin
    emptyBand := TBand.Create('', false);

  end;
end;

end.
