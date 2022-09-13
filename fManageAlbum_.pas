unit fManageAlbum_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,

  fMain_, DataStructs, DataModule;

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
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure luBandsChange(Sender: TObject);
    procedure luAlbumsChange(Sender: TObject);
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

  textBox.Clear;
  textBox.Lines := dm.bands[oldBandSelection].albums[oldAlbumSelection].tags;

  edYear.Clear;
  edYear.Text := IntToStr(dm.bands[oldBandSelection].albums[oldAlbumSelection].year);

  needSave := false;
end;

end.
