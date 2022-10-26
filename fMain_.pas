unit fMain_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids, System.UITypes,

  System.Generics.Collections, System.Win.ComObj,

  DataStructs, Data.DB, Vcl.DBGrids, Datasnap.DBClient, JvExDBGrids, JvDBGrid,
  JvComponentBase, JvDBGridExport;

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
    menuItemAbout: TMenuItem;
    btnQuery: TButton;
    btnAddBand: TButton;
    btnAddAlbum: TButton;
    btnAddSongs: TButton;
    btnManageBand: TButton;
    btnManageAlbum: TButton;
    btnManageSongs: TButton;
    menuItemStats: TMenuItem;
    btnClear: TButton;
    saveDialog: TSaveDialog;
    openDialog: TOpenDialog;
    saveExportDialog: TSaveDialog;
    cds_: TClientDataSet;
    cds_band: TStringField;
    cds_band_fav: TBooleanField;
    cds_album: TStringField;
    cds_album_fav: TBooleanField;
    cds_year: TSmallintField;
    cds_song: TStringField;
    cds_song_fav: TBooleanField;
    cds_track_num: TSmallintField;
    ds: TDataSource;
    cds_band_color: TStringField;
    cds_album_color: TStringField;
    cds_song_color: TStringField;
    table: TJvDBGrid;
    csvExporter: TJvDBGridCSVExport;
    lblSorting: TLabel;
    edSortOrder: TMemo;
    btnResetSorting: TButton;
    procedure btnAddBandClick(Sender: TObject);
    procedure btnAddAlbumClick(Sender: TObject);
    procedure btnAddSongsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menuItemStatsClick(Sender: TObject);
    procedure menuItemSaveAsClick(Sender: TObject);
    procedure menuItemLoadClick(Sender: TObject);
    procedure menuItemSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    //procedure gridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
    //  State: TGridDrawState);
    procedure menuItemAboutClick(Sender: TObject);
    procedure menuItemNewClick(Sender: TObject);
    procedure menuItemExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnManageBandClick(Sender: TObject);
    procedure btnManageAlbumClick(Sender: TObject);
    procedure btnManageSongsClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure menuItemExportXLSXClick(Sender: TObject);
    procedure menuItemExportCSVClick(Sender: TObject);
    procedure menuItemExportTXTClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tableDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure tableCellClick(Column: TColumn);
    procedure tableTitleClick(Column: TColumn);
    procedure btnResetSortingClick(Sender: TObject);
    procedure edSortOrderClick(Sender: TObject);
  private
    { Private declarations }
    fileName: String;
    needSave: Boolean;

    procedure HandleSave;
    function AskToSave: Integer;

    //procedure ResizeGrid;
  public
    { Public declarations }
    manageNeedSave: Boolean;

    procedure RefreshGrid; overload;
    procedure RefreshGrid(bands: TDictionary<String, TBand>); overload;
  end;

var
  fMain: TfMain;

implementation

uses
  fAddBand_, fAddAlbum_, fAddSong_, DataModule, fManageBand_,
  fManageAlbum_, fManageSong_, fQuery_;

{$R *.dfm}

procedure TfMain.FormCreate(Sender: TObject);
begin
  fileName := 'Untitled';
  needSave := false;
  manageNeedSave := false;

  Caption := fileName + ' - Playlist Manager';

  cds_.CreateDataSet;
  cds_.Open;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  //for whatever reason, DataModule initialization must be done in FormShow,
  //rather than FormCreate. I guess because the DM may not have been created at
  //this form's create time.
  dm.Init;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  askToSaveResult: Integer;
begin
  CanClose := true;

  if needSave then
  begin
    askToSaveResult := AskToSave;

    if askToSaveResult = mrCancel then
    begin
      CanClose := false;
      Exit;
    end
    else if askToSaveResult = mrYes then
      menuItemSaveClick(nil) //this will check whether picking file is needed
    else if askToSaveResult = mrNo then
      needSave := false;
  end;
end;

procedure TfMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //detect ctrl-s to save
  if (Key = 83) and (Shift = [ssCtrl]) then
    menuItemSaveClick(nil);
end;

//==============================================================================
//                                GRID METHODS
//==============================================================================

procedure TfMain.RefreshGrid;
begin
  RefreshGrid(dm.bands);
end;

procedure TfMain.RefreshGrid(bands: TDictionary<String, TBand>);
var
  bandAt: TBand;
  albumAt: TAlbum;
  songAt: TSong;
begin
  Screen.Cursor := crHourglass;

  cds_.EmptyDataSet;

  //insert everything into the ClientDataSet. in the future, we'll come up with
  //a solution better than literally resetting the whole CDS every time we want
  //to draw the grid. this is certainly going to make the program slower.
  for bandAt in bands.Values do
  begin
    for albumAt in bandAt.albums.Values do
    begin
      for songAt in albumAt.songs.Values do
      begin
        cds_.Insert;

        cds_band.AsString := bandAt.name;
        cds_band_fav.AsBoolean := bandAt.isFavorite;
        cds_band_color.AsString := ColorToString(bandAt.color);

        cds_album.AsString := albumAt.name;
        cds_album_fav.AsBoolean := albumAt.isFavorite;
        cds_year.AsInteger := albumAt.year;
        cds_album_color.AsString := ColorToString(albumAt.Color);

        cds_song.AsString := songAt.name;
        cds_song_fav.AsBoolean := songAt.isFavorite;
        cds_track_num.AsInteger := songAt.trackNo;
        cds_song_color.AsString := ColorToString(songAt.Color);

        cds_.Post;
      end;

      //insert blank stuff for song if this album has no songs
      if albumAt.songs.Count = 0 then
      begin
        cds_.Insert;

        cds_band.AsString := bandAt.name;
        cds_band_fav.AsBoolean := bandAt.isFavorite;
        cds_band_color.AsString := ColorToString(bandAt.color);

        cds_album.AsString := albumAt.name;
        cds_album_fav.AsBoolean := albumAt.isFavorite;
        cds_year.AsInteger := albumAt.year;
        cds_album_color.AsString := ColorToString(albumAt.Color);

        cds_song.AsString := '';
        cds_song_fav.AsBoolean := false;
        cds_track_num.AsInteger := 0;
        cds_song_color.AsString := 'clWhite';

        cds_.Post;
      end;
    end;

    //insert blank stuff for album and song if this band has no albums
    if bandAt.albums.Count = 0 then
    begin
      cds_.Insert;

      cds_band.AsString := bandAt.name;
      cds_band_fav.AsBoolean := bandAt.isFavorite;
      cds_band_color.AsString := ColorToString(bandAt.color);

      cds_album.AsString := '';
      cds_album_fav.AsBoolean := false;
      cds_year.AsInteger := 0;
      cds_album_color.AsString := 'clWhite';

      cds_song.AsString := '';
      cds_song_fav.AsBoolean := false;
      cds_track_num.AsInteger := 0;
      cds_song_color.AsString := 'clWhite';

      cds_.Post;
    end;
  end;

  cds_.First;

  Screen.Cursor := crDefault;
end;
procedure TfMain.tableCellClick(Column: TColumn);
var
  bandAt: TBand;
  albumAt: TAlbum;
  songAt: TSong;

  bandName, albumName, songName: String;
begin
  if Column.Index = 1 then
  begin
    bandAt := dm.bands[cds_band.AsString];
    bandAt.isFavorite := not bandAt.isFavorite;
  end
  else if Column.Index = 3 then
  begin
    albumAt := dm.bands[cds_band.AsString].albums[cds_album.AsString];
    albumAt.isFavorite := not albumAt.isFavorite;
  end
  else if Column.Index = 6 then
  begin
    songAt := dm.bands[cds_band.AsString].albums[cds_album.AsString].songs[cds_song.AsString];
    songAt.isFavorite := not songAt.isFavorite;
  end
  else
    Exit;

  //use this so we can return to the same record we were at before
  bandName := cds_band.AsString;
  albumName := cds_album.AsString;
  songName := cds_song.AsString;

  RefreshGrid;
  cds_.Locate('band;album;song', VarArrayOf([bandName, albumName, songName]), []);

  needSave := true;
  Caption := '* ' + ExtractFileName(fileName) + ' - Playlist Manager';
end;

procedure TfMain.tableDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if cds_.RecordCount = 0 then
    Exit;

  with table do
  begin
    with Canvas.Brush do
    begin
      if DataCol = 0 then
      Canvas.Brush.Color := StringToColor(cds_band_color.AsString)
      else if DataCol = 2 then
        Canvas.Brush.Color := StringToColor(cds_album_color.AsString)
      else if DataCol = 5 then
        Canvas.Brush.Color := StringToColor(cds_song_color.AsString);

      case Color of
        clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clGray,
        clBlue, clMedGray:
          Canvas.Font.Color := clWhite;
        else
          Canvas.Font.Color := clBlack;
      end;
    end;

    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfMain.tableTitleClick(Column: TColumn);
var
  oldIndices: TStringList;
  newIndex, at, first, rest: String;
begin
  //get a list of the old indices, easy to do since they're semicolon-delimited
  oldIndices := TStringList.Create;
  oldIndices.Delimiter := ';';
  oldIndices.DelimitedText := cds_.indexFieldNames;

  //build the new index string, starting with the column that was clicked on
  newIndex := Column.FieldName;

  edSortOrder.Clear;

  //capitalize the first letter and remove underscores so the stuff in the text
  //box looks a bit nicer
  first := Copy(Column.FieldName, 1, 1);
  first := UpperCase(first);
  rest := Copy(Column.FieldName, 2, Column.Fieldname.Length - 1);
  rest := StringReplace(rest, '_', ' ', [rfReplaceAll]);

  edSortOrder.Lines.Add(first + rest);

  //do the same as above but with the remaining index fields, being sure to skip
  //the one that was clicked on. this ensures that the order stays consistent,
  //allowing you to specify exactly how the fields should be ordered
  for at in oldIndices do
  begin
    if at <> Column.FieldName then
    begin
      newIndex := newIndex + ';' + at;

      first := Copy(at, 1, 1);
      first := UpperCase(first);
      rest := Copy(at, 2, at.Length - 1);
      rest := StringReplace(rest, '_', ' ', [rfReplaceAll]);
      edSortOrder.Lines.Add(first + rest);
    end;
  end;

  cds_.IndexFieldNames := newIndex;
end;

//==============================================================================
//                            BUTTON CLICK METHODS
//==============================================================================

procedure TfMain.btnAddBandClick(Sender: TObject);
var
  oldSize: Integer;
begin
  //if the number of bands increases, saving will be necessary
  oldSize := dm.bandCount;

  Application.CreateForm(TfAddBand, fAddBand);
  fAddBand.ShowModal;

  if dm.bandCount > oldSize then
  begin
    needSave := true;
    Caption := '* ' + ExtractFileName(fileName) + ' - Playlist Manager';
  end;
end;

procedure TfMain.btnAddAlbumClick(Sender: TObject);
var
  oldSize: Integer;
begin
  oldSize := dm.albumCount;

  Application.CreateForm(TfAddAlbum, fAddAlbum);
  fAddAlbum.ShowModal;

  if dm.albumCount > oldSize then
  begin
    needSave := true;
    Caption := '* ' + ExtractFileName(fileName) + ' - Playlist Manager';
  end;
end;

procedure TfMain.btnAddSongsClick(Sender: TObject);
var
  oldSize: Integer;
begin
  oldSize := dm.songCount;

  Application.CreateForm(TfAddSong, fAddSong);
  fAddSong.ShowModal;

  if dm.songCount > oldSize then
  begin
    needSave := true;
    Caption := '* ' + ExtractFileName(fileName) + ' - Playlist Manager';
  end;
end;

procedure TfMain.btnManageBandClick(Sender: TObject);
begin
  Application.CreateForm(TfManageBand, fManageBand);
  fManageBand.ShowModal;

  if manageNeedSave then
  begin
    needSave := true;
    Caption := '* ' + ExtractFileName(fileName) + ' - Playlist Manager';
  end;
end;

procedure TfMain.btnManageAlbumClick(Sender: TObject);
begin
  Application.CreateForm(TfManageAlbum, fManageAlbum);
  fManageAlbum.ShowModal;

  if manageNeedSave then
  begin
    needSave := true;
    Caption := '* ' + ExtractFileName(fileName) + ' - Playlist Manager';
  end;
end;

procedure TfMain.btnManageSongsClick(Sender: TObject);
begin
  Application.CreateForm(TfManageSong, fManageSong);
  fManageSong.ShowModal;

  if manageNeedSave then
  begin
    needSave := true;
    Caption := '* ' + ExtractFileName(fileName) + ' - Playlist Manager';
  end;
end;

procedure TfMain.btnQueryClick(Sender: TObject);
begin
  Application.CreateForm(TfQuery, fQuery);
  fQuery.Show;
end;

procedure TfMain.btnClearClick(Sender: TObject);
begin
  RefreshGrid;
end;

procedure TfMain.btnResetSortingClick(Sender: TObject);
begin
  //reset cds indices
  cds_.IndexFieldNames := 'band;year;album;track_num;song';

  //and the text box
  edSortOrder.Clear;
  with edSortOrder.Lines do
  begin
    Add('Band');
    Add('Year');
    Add('Album');
    Add('Track num');
    Add('Song');
  end;
end;

procedure TfMain.edSortOrderClick(Sender: TObject);
begin
  MessageDlg('Click on the column titles to change sorting.', mtInformation,
      [mbOk], 0, mbOk);
end;

//==============================================================================
//                          MENU ITEM CLICK METHODS
//==============================================================================

//=====  FILE MENU  =====

procedure TfMain.menuItemNewClick(Sender: TObject);
var
  askToSaveResult: Integer;
begin
  if needSave then
  begin
    askToSaveResult := AskToSave;

    if askToSaveResult = mrCancel then
      Exit
    else if askToSaveResult = mrYes then
      menuItemSaveClick(nil) //this will check whether picking file is needed
    else if askToSaveResult = mrNo then
      needSave := false;
  end;

  dm.Clear;

  fileName := 'Untitled';
  needSave := false;

  Caption := fileName + ' - Playlist Manager';

  RefreshGrid;
end;

procedure TfMain.menuItemLoadClick(Sender: TObject);
var
  loadList: TStringList;
  loadText: String;

  askToSaveResult: Integer;
begin
  if needSave then
  begin
    askToSaveResult := AskToSave;

    if askToSaveResult = mrCancel then
      Exit
    else if askToSaveResult = mrYes then
      menuItemSaveClick(nil) //this will check whether picking file is needed
    else if askToSaveResult = mrNo then
      needSave := false;
  end;

  with openDialog do
  begin
    if Execute then
      self.fileName := FileName
    else
      Exit;

    FileName := ''; //prevent selected file from showing up in dialog again
  end;

  //clear out everything that's currently loaded
  dm.Clear;

  loadList := TStringList.Create;
  loadList.LoadFromFile(fileName);
  loadText := loadList.Text;

  if not dm.ReadJSON(loadText) then
  begin
    dm.Clear;
    fileName := 'Untitled';
  end;

  loadList.Free;

  Caption := ExtractFileName(fileName) + ' - Playlist Manager';

  RefreshGrid;
end;

procedure TfMain.menuItemSaveClick(Sender: TObject);
begin
  if (fileName = 'Untitled') or (fileName = '') then
    menuItemSaveAsClick(nil)
  else
    HandleSave;
end;

procedure TfMain.menuItemSaveAsClick(Sender: TObject);
begin
  with saveDialog do
  begin
    if Execute then
      self.fileName := FileName
    else
      Exit;

    FileName := '';
  end;

  HandleSave;
end;

procedure TfMain.menuItemExitClick(Sender: TObject);
var
  askToSaveResult: Integer;
begin
  if needSave then
  begin
    askToSaveResult := AskToSave;

    if askToSaveResult = mrCancel then
      Exit
    else if askToSaveResult = mrYes then
      menuItemSaveClick(nil) //this will check whether picking file is needed
    else if askToSaveResult = mrNo then
    begin
      needSave := false;
      manageNeedSave := false;
    end;
  end;

  Application.Terminate;
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

  needSave := false;
  manageNeedSave := false;
  Caption := ExtractFileName(fileName) + ' - Playlist Manager';
end;

function TfMain.AskToSave: Integer;
begin
  Result := messageDlg('Do you want to save changes to ' + #13#10 + fileName + '?',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbCancel);
end;

//=====  EXPORT MENU  =====

procedure TfMain.menuItemExportTXTClick(Sender: TObject);
var
  txtFileName: String;

  bandAt: TBand;
  albumAt: TAlbum;
  songAt: TSong;

  bandName, albumName, songName: String;
  fileData: TStringList;
begin
  with saveExportDialog do
  begin
    Filter := 'Text file (*.txt) | *.txt';
    DefaultExt := 'txt';
    FilterIndex := 1;

    if Execute then
      txtFileName := FileName
    else
      Exit;

    FileName := '';
  end;

  fileData := TStringList.Create;

  for bandAt in dm.bands.Values do
  begin
    bandName := bandAt.name;

    for albumAt in bandAt.albums.Values do
    begin
      albumName := albumAt.name;

      for songAt in albumAt.songs.Values do
      begin
        songName := songAt.name;

        //ignore the N/A album
        if albumName = 'N/A' then
          fileData.Add(songName + ' - ' + bandName)
        else
          fileData.Add(songName + ' - ' + bandName + ' - ' + albumName);
      end;
    end;
  end;

  fileData.SaveToFile(txtFileName);

  fileData.Free;
end;

procedure TfMain.menuItemExportCSVClick(Sender: TObject);
var
  csvFileName: String;
begin
  with saveExportDialog do
  begin
    Filter := 'Comma-Separated Values File (*.csv) | *.csv';
    DefaultExt := 'csv';
    FilterIndex := 1;

    if Execute then
      csvFileName := FileName
    else
      Exit;

    FileName := '';
  end;

  with csvExporter do
  begin
    FileName := csvFileName;
    ExportGrid;
  end;
end;

procedure TfMain.menuItemExportXLSXClick(Sender: TObject);
var
  excelFileName: String;

  Excel, workBook, range: OLEVariant;
  arrData: Variant;
  row: Integer;
begin
  with saveExportDialog do
  begin
    Filter := 'Excel Workbooks (*.xlsx) | *.xlsx';
    DefaultExt := 'xlsx';
    FilterIndex := 1;

    if Execute then
      excelFileName := FileName
    else
      Exit;

    FileName := '';
  end;

  //recordcount + 1 because of the header row
  arrData := VarArrayCreate([1, cds_.recordCount + 1, 1, 8], varVariant);

  with cds_ do
  begin
    First;

    //insert header data first
    arrData[1, 1] := 'Band';
    arrData[1, 2] := 'Fav?';
    arrData[1, 3] := 'Album';
    arrData[1, 4] := 'Fav?';
    arrData[1, 5] := 'Year';
    arrData[1, 6] := 'Song';
    arrData[1, 7] := 'Fav?';
    arrData[1, 8] := 'Track No';

    row := 2;

    while not eof do
    begin
      arrData[row, 1] := cds_band.AsString;
      arrData[row, 2] := cds_band_fav.AsBoolean;
      arrData[row, 3] := cds_album.AsString;
      arrData[row, 4] := cds_album_fav.AsBoolean;
      arrData[row, 5] := cds_year.AsInteger;
      arrData[row, 6] := cds_song.AsString;
      arrData[row, 7] := cds_song_fav.AsBoolean;
      arrData[row, 8] := cds_track_num.AsInteger;

      Next;
      Inc(row);
    end;

    First;
  end;

//  for row := 1 to cds_.RecordCount do
//  begin
//    for col := 1 to colCount do
//      arrData[row, col] := grid.Cells[col - 1, row - 1];
//  end;

  Excel := CreateOLEObject('Excel.Application');
  workBook := Excel.Workbooks.Add;

  range := workBook.Worksheets[1].Range[workBook.WorkSheets[1].Cells[1, 1],
                              workBook.WorkSheets[1].Cells[cds_.RecordCount, 8]];

  range.Value := arrData;

  Excel.Workbooks[1].SaveAs(excelFileName);
  Excel.Application.Quit;
end;

//=====  HELP MENU  =====

procedure TfMain.menuItemStatsClick(Sender: TObject);
begin
  showMessage(IntToStr(dm.bandCount) + ' bands,' + #13#10 +
    IntToStr(dm.albumCount) + ' albums, and' + #13#10 +
    IntToStr(dm.songCount) + ' songs.');
end;

procedure TfMain.menuItemAboutClick(Sender: TObject);
begin
  MessageDlg('Playlist Manager v1.2' + #13#10 + 'by Jordan Knapp',
    mtInformation, [mbOk], 0, mbOk);
end;

end.
