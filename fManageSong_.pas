unit fManageSong_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,

  fMain_, DataStructs, DataModule, Vcl.ExtCtrls;

type
  TfManageSong = class(TForm)
    Label1: TLabel;
    luBands: TComboBox;
    Label2: TLabel;
    luAlbums: TComboBox;
    Label3: TLabel;
    luSongs: TComboBox;
    cbFavorite: TCheckBox;
    Label4: TLabel;
    textBox: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
    Label5: TLabel;
    edTrackNo: TEdit;
    btnApplyAlbum: TButton;
    btnApplyBand: TButton;
    Label6: TLabel;
    luColor: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure luBandsChange(Sender: TObject);
    procedure luAlbumsChange(Sender: TObject);
    procedure luSongsChange(Sender: TObject);
    procedure DetermineNeedSave(Sender: TObject);
    procedure btnApplyAlbumClick(Sender: TObject);
    procedure btnApplyBandClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    oldBandSelection, oldAlbumSelection, oldSongSelection: String;
    oldCbSelection, needSave: Boolean;
    oldTbText: TStringList;
  public
    { Public declarations }
  end;

var
  fManageSong: TfManageSong;

implementation

{$R *.dfm}

procedure TfManageSong.FormCreate(Sender: TObject);
var
  listOfBands: TStringList;
  bandAt: string;
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  //is there a better way to remove default text from a text box?
  textBox.Text := '';

  oldBandSelection := '';
  oldAlbumSelection := '';
  oldSongSelection := '';
  oldCbSelection := false;
  oldTbText := TStringList.Create;
  needSave := false;

  //add list of bands to the dropdown after sorting, if there are any bands
  if dm.bandCount > 0 then
  begin
    listOfBands := dm.GetSortedBands;

    for bandAt in listOfBands do
    begin
      luBands.Items.Add(bandAt);
    end;
  end;
end;

procedure TfManageSong.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if needSave and (messageDlg('Your changes have not been saved. Continue?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes) then
    CanClose := false;
end;

procedure TfManageSong.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fMain.RefreshGrid;

  //don't know if this is needed, maybe add it to all other dialogs as wel
  Action := caFree;
  fManageSong := nil;
end;

procedure TfManageSong.luBandsChange(Sender: TObject);
var
  albumList: TStringList;
  albumAt: String;
begin
  if (oldBandSelection <> '') and needSave then
  begin
    if messageDlg('Your changes have not been saved. Continue?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes then
    begin
      luBands.ItemIndex := luBands.Items.IndexOf(oldBandSelection);
      Exit;
    end;
  end;

  //somewhat confusing, i guess oldBandSelection is now the CURRENT selection
  oldBandSelection := luBands.Items[luBands.ItemIndex];
  oldAlbumSelection := '';
  oldSongSelection := '';

  //how handle the album lookup box.
  //first, clear it out entirely and add back in the N/A
  luAlbums.Items.Clear;
  luAlbums.ItemIndex := -1;
  luAlbums.ClearSelection;
  luAlbums.Text := '';
  luAlbums.Items.Add('N/A');

  //put that band's albums in the album lookup box after sorting
  albumList := dm.GetSortedAlbumsOfBand(oldBandSelection);
  for albumAt in albumList do
  begin
    luAlbums.Items.Add(albumAt);
  end;

  //clear out the songs lookup while we're at it
  luSongs.Items.Clear;
  luSongs.ItemIndex := -1;
  luSongs.ClearSelection;
  luSongs.Text := '';

  //also clear out all the controls
  cbFavorite.Checked := false;
  edTrackNo.Clear;
  textBox.Clear;

  oldAlbumSelection := '';
  oldSongSelection := '';
  needSave := false;
end;

procedure TfManageSong.luAlbumsChange(Sender: TObject);
var
  songList: TStringList;
  songAt: String;
begin
  if (oldAlbumSelection <> '') and needSave then
  begin
    if messageDlg('Your changes have not been saved. Continue?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes then
    begin
      luAlbums.ItemIndex := luAlbums.Items.IndexOf(oldAlbumSelection);
      Exit;
    end;
  end;

  oldAlbumSelection := luAlbums.Items[luAlbums.ItemIndex];
  oldSongSelection := '';

  //put all this album's songs in the luSongs dropdown
  luSongs.Clear;
  luSongs.ItemIndex := -1;
  luSongs.ClearSelection;
  luSongs.Text := '';

  songList := dm.GetSortedSongsOfAlbum(oldBandSelection, oldAlbumSelection);
  for songAt in songList do
    luSongs.Items.Add(songAt);

  //clear out the controls again
  cbFavorite.Checked := false;
  textBox.Clear;
  edTrackNo.Clear;

  oldSongSelection := '';
  needSave := false;
end;

procedure TfManageSong.luSongsChange(Sender: TObject);
begin
  if (oldSongSelection <> '') and needSave then
  begin
    if messageDlg('Your changes have not been saved. Continue?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes then
    begin
      luSongs.ItemIndex := luSongs.Items.IndexOf(oldSongSelection);
      Exit;
    end;
  end;

  oldSongSelection := luSongs.Items[luSongs.ItemIndex];

  cbFavorite.Checked := dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].isFavorite;

  luColor.Selected := dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].color;

  textBox.Clear;
  textBox.Lines := dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].tags;

  edTrackNo.Clear;
  edTrackNo.Text := IntToStr(dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].trackNo);

  needSave := false;
end;

procedure TfManageSong.DetermineNeedSave(Sender: TObject);
var
  song: TSong;
  total: Integer;
begin
  if (oldBandSelection = '') or (oldAlbumSelection = '') or (oldSongSelection = '') then
    Exit;

  song := dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection];
  total := 0;

  if song.isFavorite <> cbFavorite.Checked then
    Inc(total);

  if textBox.Lines <> song.tags then
    Inc(total);

  if (edTrackNo.Text <> '') and (StrToInt(edTrackNo.Text) <> song.trackNo) then
    Inc(total);

  if luColor.Selected <> song.color then
    Inc(total);

  //if any value has changed, need save. otherwise, don't need save
  needSave := total > 0;
end;

procedure TfManageSong.btnApplyAlbumClick(Sender: TObject);
begin
  if not dm.bands.ContainsKey(oldBandSelection) then
  begin
    messageDlg('Please select a band.', mtWarning, [mbok], 0, mbOk);
    Exit;
  end;

  if not dm.bands[oldBandSelection].albums.ContainsKey(oldAlbumSelection) then
  begin
    messageDlg('Please select an album.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  if not dm.bands[oldBandSelection].albums[oldAlbumSelection].songs.ContainsKey(oldSongSelection) then
  begin
    messageDlg('Please select a song.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  if messageDlg('Apply these tags to ' + oldAlbumSelection + '?' + #13#10 +
        'Note: This will not apply to the song''s band.', mtConfirmation,
        [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;

  dm.bands[oldBandSelection].albums[oldAlbumSelection].AddTags(textBox.Lines);

  messageDlg('Done.', mtInformation, [mbOk], 0, mbOk);
end;

procedure TfManageSong.btnApplyBandClick(Sender: TObject);
begin
  if not dm.bands.ContainsKey(oldBandSelection) then
  begin
    messageDlg('Please select a band.', mtWarning, [mbok], 0, mbOk);
    Exit;
  end;

  if not dm.bands[oldBandSelection].albums.ContainsKey(oldAlbumSelection) then
  begin
    messageDlg('Please select an album.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  if not dm.bands[oldBandSelection].albums[oldAlbumSelection].songs.ContainsKey(oldSongSelection) then
  begin
    messageDlg('Please select a song.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  if messageDlg('Apply these tags to ' + oldBandSelection + '?' + #13#10 +
        'Note: This will not apply to the song''s album.', mtConfirmation,
        [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;

  dm.bands[oldBandSelection].AddTags(textBox.Lines);

  messageDlg('Done.', mtInformation, [mbOk], 0, mbOk);
end;

procedure TfManageSong.btnSaveClick(Sender: TObject);
begin
  if not dm.bands.ContainsKey(oldBandSelection) then
  begin
    messageDlg('Please select a band.', mtWarning, [mbok], 0, mbOk);
    Exit;
  end;

  if not dm.bands[oldBandSelection].albums.ContainsKey(oldAlbumSelection) then
  begin
    messageDlg('Please select an album.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  if not dm.bands[oldBandSelection].albums[oldAlbumSelection].songs.ContainsKey(oldSongSelection) then
  begin
    messageDlg('Please select a song.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].isFavorite := cbFavorite.Checked;
  dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].color := luColor.Selected;
  dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].tags.Clear;
  dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].tags.Assign(textBox.Lines);
  //dm.bands[oldBandSelection].albums[oldAlbumSelection].songs[oldSongSelection].trackNo := StrToInt(edTrackNo.Text);

  if needSave then
    fMain.manageNeedSave := true;

  needSave := false;

  messageDlg('Saved.', mtInformation, [mbOk], 0, mbOk);
  luSongs.DroppedDown := true;
end;

procedure TfManageSong.btnDeleteClick(Sender: TObject);
var
  songAt: String;
begin
  if not dm.bands.ContainsKey(oldBandSelection) then
  begin
    messageDlg('Please select a band.', mtWarning, [mbok], 0, mbOk);
    Exit;
  end;

  if not dm.bands[oldBandSelection].albums.ContainsKey(oldAlbumSelection) then
  begin
    messageDlg('Please select an album.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  if not dm.bands[oldBandSelection].albums[oldAlbumSelection].songs.ContainsKey(oldSongSelection) then
  begin
    messageDlg('Please select a song.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  if messageDlg('Are you sure you want to delete ' + oldSongSelection + ' from the ' +
      'system?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    //we'll need to do some freeing at some point in the future
    dm.bands[oldBandSelection].albums[oldAlbumSelection].songs.Remove(oldSongSelection);

    needSave := false;
    oldSongSelection := '';

    //need to clear out the removed song from the lookup's list of items.
    //best way to do this seems to be constructing a new list without the old one
    luSongs.Items.Clear;
    for songAt in dm.GetSortedSongsOfAlbum(oldBandSelection, oldAlbumSelection) do
      luSongs.Items.Add(songAt);

    luSongs.ItemIndex := -1;
    luSongs.Text := '';
    luSongs.DroppedDown := true;

    fMain.manageneedSave := true;
  end;
end;

end.
