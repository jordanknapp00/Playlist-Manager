unit fManageBand_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,

  fMain_, DataStructs, DataModule, Vcl.ExtCtrls;

type
  TfManageBand = class(TForm)
    Label1: TLabel;
    luBands: TComboBox;
    cbFavorite: TCheckBox;
    Label2: TLabel;
    textBox: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
    btnApplyAlbums: TButton;
    btnApplySongs: TButton;
    luColor: TColorBox;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure luBandsChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);

    procedure DetermineNeedSave(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnApplyAlbumsClick(Sender: TObject);
    procedure btnApplySongsClick(Sender: TObject);
  private
    { Private declarations }
    oldSelection: String;
    oldCbSelection: Boolean;
    oldTbText: TStringList;
    needSave: Boolean;
  public
    { Public declarations }
  end;

var
  fManageBand: TfManageBand;

implementation

{$R *.dfm}

procedure TfManageBand.FormCreate(Sender: TObject);
var
  listOfBands: TStringList;
  bandAt: string;
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  //is there a better way to remove default text from a text box?
  textBox.Text := '';

  oldSelection := '';
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

procedure TfManageBand.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fMain.RefreshGrid;

  //don't know if this is needed, maybe add it to all other dialogs as wel
  Action := caFree;
  fManageBand := nil;
end;

procedure TfManageBand.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if needSave and (messageDlg('Your changes have not been saved. Continue?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes) then
    CanClose := false;
end;

procedure TfManageBand.luBandsChange(Sender: TObject);
begin
  if (oldSelection <> '') and needSave then
  begin
    if messageDlg('Your changes have not been saved. Continue?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes then
    begin
      luBands.ItemIndex := luBands.Items.IndexOf(oldSelection);
      Exit;
    end;
  end;

  oldSelection := luBands.Items[luBands.ItemIndex];

  cbFavorite.Checked := dm.bands[oldSelection].isFavorite;

  textBox.Clear;
  textBox.Lines := dm.bands[oldSelection].tags;

  luColor.Selected := dm.bands[oldSelection].color;

  needSave := false;
end;

procedure TfManageBand.btnSaveClick(Sender: TObject);
begin
  if not dm.bands.ContainsKey(oldSelection) then
  begin
    messageDlg('Please select a band.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;
  
  dm.bands[oldSelection].isFavorite := cbFavorite.Checked;
  dm.bands[oldSelection].color := luColor.Selected;
  dm.bands[oldSelection].tags.Clear;
  dm.bands[oldSelection].tags.Assign(textBox.Lines);

  if needSave then
    fMain.manageNeedSave := true;

  needSave := false;

  messageDlg('Saved.', mtInformation, [mbOk], 0, mbOk);
  luBands.DroppedDown := true;
end;

procedure TfManageBand.btnApplyAlbumsClick(Sender: TObject);
var
  albumAt: TAlbum;
begin
  if not dm.bands.ContainsKey(oldSelection) then
  begin
    messageDlg('Please select a band.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;
  
  if messageDlg('Apply these tags to ' + oldSelection + '''s ' +
        IntToStr(dm.bands[oldSelection].albums.Count) + ' albums?' + #13#10 +
        'Note: This will not apply to those albums'' songs.', mtConfirmation,
        [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;

  for albumAt in dm.bands[oldSelection].albums.Values do
    albumAt.AddTags(textBox.Lines);

  messageDlg('Done.', mtInformation, [mbOk], 0, mbOk);
end;

procedure TfManageBand.btnApplySongsClick(Sender: TObject);
var
  songCount: Integer;
  songAt: TSong;
  albumAt: TAlbum;
begin
  if not dm.bands.ContainsKey(oldSelection) then
  begin
    messageDlg('Please select a band.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;
  
  songCount := 0;
  for albumAt in dm.bands[oldSelection].albums.Values do
    songCount := songCount + albumAt.songs.Count;

  if messageDlg('Apply these tags to ' + oldSelection + '''s ' +
        IntToStr(songCount) + ' songs?' + #13#10 + 'Note: This will not apply ' +
        'to their ' + IntTOStr(dm.bands[oldSelection].albums.Count) + ' albums.',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
    Exit;

  for albumAt in dm.bands[oldSelection].albums.Values do
  begin
    for songAt in albumAt.songs.Values do
      songAt.AddTags(textBox.Lines);
  end;

  messageDlg('Done.', mtInformation, [mbOk], 0, mbOk);
end;

procedure TfManageBand.btnDeleteClick(Sender: TObject);
var
  bandAt: String;
begin
  if not dm.bands.ContainsKey(oldSelection) then
  begin
    messageDlg('Please select a band.', mtWarning, [mbOk], 0, mbOk);
    Exit;
  end;

  if messageDlg('Are you sure you want to delete ' + oldSelection + ' from the ' +
      'system?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    //we'll need to do some freeing at some point in the future
    dm.bands.Remove(oldSelection);

    needSave := false;
    oldSelection := '';

    //need to clear out the removed band from the lookup's list of items.
    //best way to do this seems to be constructing a new list without the old one
    luBands.Items.Clear;
    for bandAt in dm.GetSortedBands do
      luBands.Items.Add(bandAt);

    luBands.ItemIndex := -1;
    luBands.Text := '';
    luBands.DroppedDown := true;

    fMain.manageneedSave := true;
  end;
end;

procedure TfManageBand.DetermineNeedSave(Sender: TObject);
var
  band: TBand;
  total: Integer;
begin
  if oldSelection = '' then
    Exit;

  band := dm.bands[oldSelection];
  total := 0;

  if band.isFavorite <> cbFavorite.Checked then
    Inc(total);

  if textBox.Lines <> band.tags then
    Inc(total);

  if luColor.Selected <> band.color then
    Inc(total);

  //if any value has changed, need save. otherwise, don't need save
  needSave := total > 0;
end;

end.
