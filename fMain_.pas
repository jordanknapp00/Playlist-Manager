unit fMain_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfMain = class(TForm)
    menuBar: TMainMenu;
    menuFile: TMenuItem;
    menuItemNew: TMenuItem;
    menuItemLoad: TMenuItem;
    menuItemSave: TMenuItem;
    menuItemSaveAs: TMenuItem;
    menuItemExit: TMenuItem;
    menuExport: TMenuItem;
    menuItemExportTXT: TMenuItem;
    menuItemExportCSV: TMenuItem;
    menuItemExportXLSX: TMenuItem;
    menuHelp: TMenuItem;
    menuItemHowToUse: TMenuItem;
    menuItemAbout: TMenuItem;
    btnQuery: TButton;
    btnAddBand: TButton;
    btnAddAlbum: TButton;
    btnAddSongs: TButton;
    btnDeleteBand: TButton;
    btnDeleteAlbum: TButton;
    btnDeleteSong: TButton;
    menuItemStats: TMenuItem;
    grid: TStringGrid;
    procedure btnAddBandClick(Sender: TObject);
    procedure btnAddAlbumClick(Sender: TObject);
    procedure btnAddSongsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menuItemStatsClick(Sender: TObject);
    procedure menuItemSaveAsClick(Sender: TObject);
    procedure menuItemLoadClick(Sender: TObject);
    procedure menuItemSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
  private
    { Private declarations }
    fileName: String;

    procedure HandleSave;
  public
    { Public declarations }
    procedure RefreshGrid;
  end;

var
  fMain: TfMain;

implementation

uses
  fAddBand_, fAddAlbum_, fAddSong_, DataModule, DataStructs;

{$R *.dfm}

procedure TfMain.FormCreate(Sender: TObject);
begin
  fileName := '';

  //set up the grid
  grid.Cells[0, 0] := 'Band';
  grid.Cells[1, 0] := 'Fav?';
  grid.Cells[2, 0] := 'Album';
  grid.Cells[3, 0] := 'Year';
  grid.Cells[4, 0] := 'Fav?';
  grid.Cells[5, 0] := 'Song';
  grid.Cells[6, 0] := 'Track No.';
  grid.Cells[7, 0] := 'Fav?';
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  //for whatever reason, DataModule initialization must be done in FormShow,
  //rather than FormCreate. I guess because the DM may not have been created at
  //this form's create time.
  dm.Init;
end;

//==============================================================================
//                                GRID METHODS
//==============================================================================

procedure TfMain.gridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
//  if ARow = 0 then
//  begin
//    grid.Font.Style := grid.Font.Style + [fsBold];
//  end
//  else
//  begin
//    grid.Font.Style := grid.Font.Style - [fsBold];
//  end;
end;

procedure TfMain.RefreshGrid;
var
  row: Integer;

  bandNameAt: String;
  bandAt: TBand;
  albumAt: TAlbum;
  songAt: TSong;
begin
  for row := 1 to grid.RowCount - 1 do
    grid.Rows[row].Clear;

  grid.RowCount := 1;
  row := 1;

  //dont bother if there are no bands
  if dm.bandNames.Count = 0 then
    Exit;

  for bandNameAt in dm.bandNames do
  begin
    bandAt := dm.bands[bandNameAt];

    //if there are no albums (and thus no songs, print out the band now)
    if bandAt.albums.Count = 0 then
    begin
      grid.Cells[0, row] := bandNameAt;

      if bandAt.isFavorite then
        grid.Cells[1, row] := 'Y'
      else
        grid.Cells[1, row] := 'N';

      grid.RowCount := grid.RowCount + 1;
      Inc(row);
    end;

    for albumAt in bandAt.albums do
    begin
      //if there are no songs, print the album. if we reached this point, the
      //band also has not been printed
      if albumAt.songs.Count = 0 then
      begin
        grid.Cells[0, row] := bandNameAt;

        if bandAt.isFavorite then
          grid.Cells[1, row] := 'Y'
        else
          grid.Cells[1, row] := 'N';

        grid.Cells[2, row] := albumAt.name;
        grid.Cells[3, row] := albumAt.year.ToString;

        if albumAt.isFavorite then
          grid.Cells[4, row] := 'Y'
        else
          grid.Cells[4, row] := 'N';

        grid.RowCount := grid.RowCount + 1;
        Inc(row);
      end;

      for songAt in albumAt.songs do
      begin
        //print everything if we make it to the songs loop
        grid.Cells[0, row] := bandNameAt;

        if bandAt.isFavorite then
          grid.Cells[1, row] := 'Y'
        else
          grid.Cells[1, row] := 'N';

        grid.Cells[2, row] := albumAt.name;
        grid.Cells[3, row] := albumAt.year.ToString;

        if albumAt.isFavorite then
          grid.Cells[4, row] := 'Y'
        else
          grid.Cells[4, row] := 'N';

        grid.Cells[5, row] := songAt.name;
        grid.Cells[6, row] := songAt.trackNo.ToString;

        if songAt.isFavorite then
          grid.Cells[7, row] := 'Y'
        else
          grid.Cells[7, row] := 'N';

        grid.RowCount := grid.RowCount + 1;
        Inc(row);
      end;
    end;
  end;
end;

//==============================================================================
//                            BUTTON CLICK METHODS
//==============================================================================

procedure TfMain.btnAddBandClick(Sender: TObject);
begin
  Application.CreateForm(TfAddBand, fAddBand);
  fAddBand.ShowModal;
end;

procedure TfMain.btnAddAlbumClick(Sender: TObject);
begin
  Application.CreateForm(TfAddAlbum, fAddAlbum);
  fAddAlbum.ShowModal;
end;

procedure TfMain.btnAddSongsClick(Sender: TObject);
begin
  Application.CreateForm(TfAddSong, fAddSong);
  fAddSong.ShowModal;
end;

//==============================================================================
//                          MENU ITEM CLICK METHODS
//==============================================================================

//=====  FILE MENU  =====

procedure TfMain.menuItemLoadClick(Sender: TObject);
var
  dialog: TOpenDialog;
  loadList: TStringList;
  loadText: String;
begin
  dialog := TOpenDialog.Create(self);
  dialog.InitialDir := GetCurrentDir;
  dialog.Filter := 'JSON Files (*.json)|*.json';
  dialog.DefaultExt := 'json';
  dialog.FilterIndex := 1;

  if dialog.Execute then
  begin
    fileName := dialog.Files[0];
  end;

  dialog.Free;

  loadList := TStringList.Create;
  loadList.LoadFromFile(fileName);
  loadText := loadList.Text;
  dm.ReadJSON(loadText);

  loadList.Free;
end;

procedure TfMain.menuItemSaveClick(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  //basic save system for now, no worries about overwriting or whatever
  dialog := TSaveDialog.Create(self);
  dialog.InitialDir := GetCurrentDir;
  dialog.Filter := 'JSON Files (*.json)|*.json';
  dialog.DefaultExt := 'json';
  dialog.FilterIndex := 1;

  if dialog.Execute then
  begin
    fileName := dialog.Files[0];
    HandleSave;
  end;

  dialog.Free;
end;

procedure TfMain.menuItemSaveAsClick(Sender: TObject);
begin
  //text
end;

procedure TfMain.HandleSave;
var
  saveText: String;
  saveList: TStringList;
begin
  saveText := dm.WriteJSON;
  saveList := TStringList.Create;
  saveList.Add(saveText);

  saveList.SaveToFile(fileName);
  saveList.Free;
end;

//=====  EXPORT MENU  =====

//=====  HELP MENU  =====

procedure TfMain.menuItemStatsClick(Sender: TObject);
begin
  showMessage(IntToStr(dm.bands.Count) + ' bands,' + #13#10 +
    IntToStr(dm.albums.Count) + ' albums, and' + #13#10 +
    IntToStr(dm.songs.Count) + ' songs.');
end;

end.
