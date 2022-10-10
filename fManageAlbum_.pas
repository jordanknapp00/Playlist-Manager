unit fManageAlbum_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,

  fMain_, DataStructs, DataModule, Vcl.ExtCtrls;

type
  TfManageAlbum = class(TForm)
    Label1: TLabel;
    luBands: TComboBox;
    Label2: TLabel;
    luAlbums: TComboBox;
    cbFavorite: TCheckBox;
    Label3: TLabel;
    textBox: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
    Label4: TLabel;
    edYear: TEdit;
    btnApplyBand: TButton;
    btnApplySong: TButton;
    Label5: TLabel;
    luColor: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure luBandsChange(Sender: TObject);
    procedure luAlbumsChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnApplyBandClick(Sender: TObject);
    procedure btnApplySongClick(Sender: TObject);
    procedure DetermineNeedSave(Sender: TObject);
  private
    { Private declarations }
    oldBandSelection, oldAlbumSelection: String;
    oldCbSelection, needSave: Boolean;
    oldTbText: TStringList;
  public
    { Public declarations }
  end;

var
  fManageAlbum: TfManageAlbum;

implementation

{$R *.dfm}

procedure TfManageAlbum.FormCreate(Sender: TObject);
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

procedure TfManageAlbum.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if needSave and (messageDlg('Your changes have not been saved. Continue?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes) then
    CanClose := false;
end;

procedure TfManageAlbum.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fMain.RefreshGrid;

  //don't know if this is needed, maybe add it to all other dialogs as wel
  Action := caFree;
  fManageAlbum := nil;
end;

procedure TfManageAlbum.luBandsChange(Sender: TObject);
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

  //also clear out all the controls
  cbFavorite.Checked := false;
  edYear.Clear;
  textBox.Clear;

  oldAlbumSelection := '';
  needSave := false;
end;

procedure TfManageAlbum.luAlbumsChange(Sender: TObject);
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

  cbFavorite.Checked := dm.bands[oldBandSelection].albums[oldAlbumSelection].isFavorite;

  luColor.Selected := dm.bands[oldBandSelection].albums[oldAlbumSelection].color;

  textBox.Clear;
  textBox.Lines := dm.bands[oldBandSelection].albums[oldAlbumSelection].tags;

  edYear.Clear;
  edYear.Text := IntToStr(dm.bands[oldBandSelection].albums[oldAlbumSelection].year);

  needSave := false;
end;

procedure TfManageAlbum.btnDeleteClick(Sender: TObject);
var
  albumAt: String;
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

  if messageDlg('Are you sure you want to delete ' + oldAlbumSelection + ' from the ' +
      'system?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    //we'll need to do some freeing at some point in the future
    dm.bands[oldBandSelection].albums.Remove(oldAlbumSelection);

    needSave := false;
    oldAlbumSelection := '';

    //need to clear out the removed album from the lookup's list of items.
    //best way to do this seems to be constructing a new list without the old one
    luAlbums.Items.Clear;
    luAlbums.Items.Add('N/A');
    for albumAt in dm.GetSortedAlbumsOfBand(oldBandSelection) do
      luAlbums.Items.Add(albumAt);

    luAlbums.ItemIndex := -1;
    luAlbums.Text := '';
    luAlbums.DroppedDown := true;

    fMain.manageneedSave := true;
  end;
end;

procedure TfManageAlbum.btnSaveClick(Sender: TObject);
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

  dm.bands[oldBandSelection].albums[oldAlbumSelection].isFavorite := cbFavorite.Checked;
  dm.bands[oldBandSelection].albums[oldAlbumSelection].color := luColor.Selected;
  dm.bands[oldBandSelection].albums[oldAlbumSelection].tags.Clear;
  dm.bands[oldBandSelection].albums[oldAlbumSelection].tags.Assign(textBox.Lines);

  if needSave then
    fMain.manageNeedSave := true;

  needSave := false;

  messageDlg('Saved.', mtInformation, [mbOk], 0, mbOk);
  luAlbums.DroppedDown := true;
end;

procedure TfManageAlbum.DetermineNeedSave(Sender: TObject);
var
  album: TAlbum;
  total: Integer;
begin
  if (oldBandSelection = '') or (oldAlbumSelection = '') then
    Exit;

  album := dm.bands[oldBandSelection].albums[oldAlbumSelection];
  total := 0;

  if album.isFavorite <> cbFavorite.Checked then
    Inc(total);

  if textBox.Lines <> album.tags then
    Inc(total);

  if luColor.Selected <> album.color then
    Inc(total);

  //if any value has changed, need save. otherwise, don't need save
  needSave := total > 0;
end;

procedure TfManageAlbum.btnApplyBandClick(Sender: TObject);
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

  if messageDlg('Apply these tags to ' + oldBandSelection + '?' + #13#10 +
        'Note: This will not apply to any of that band''s songs.', mtConfirmation,
        [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;

  dm.bands[oldBandSelection].AddTags(textBox.Lines);

  messageDlg('Done.', mtInformation, [mbOk], 0, mbOk);
end;

procedure TfManageAlbum.btnApplySongClick(Sender: TObject);
var
  songAt: TSong;
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

  if messageDlg('Apply these tags to ' + oldAlbumSelection + '''s ' +
        IntToStr(dm.bands[oldBandSelection].albums[oldAlbumSelection].songs.Count)
        + ' songs?' + #13#10, mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;

  for songAt in dm.bands[oldBandSelection].albums[oldAlbumSelection].songs.Values do
    songAt.AddTags(textBox.Lines);

  messageDlg('Done.', mtInformation, [mbOk], 0, mbOk);
end;

end.
