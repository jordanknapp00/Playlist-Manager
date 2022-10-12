unit fMain_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids, System.UITypes,

  System.Generics.Collections, System.Win.ComObj,

  DataStructs;

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
    grid: TStringGrid;
    btnClear: TButton;
    saveDialog: TSaveDialog;
    openDialog: TOpenDialog;
    saveExportDialog: TSaveDialog;
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
  private
    { Private declarations }
    fileName: String;
    needSave: Boolean;

    procedure HandleSave;
    function AskToSave: Integer;

    procedure ResizeGrid;
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

//==============================================================================
//                                GRID METHODS
//==============================================================================

procedure TfMain.gridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
var
  bandAt, albumAt, songAt, at: String;
begin
  //ignore first row entirely
  if ARow = 0 then
    Exit;

  with (Sender as TStringGrid) do
  begin
    //col 0 is bands
    if ACol = 0 then
    begin
      bandAt := Cells[ACol, ARow];

      if dm.bands.COntainsKey(bandAt) then
        Canvas.Brush.Color := dm.bands[bandAt].Color;

      at := bandAt;
    end
    //col 2 is albums
    else if ACol = 2 then
    begin
      bandAt := Cells[0, ARow];
      albumAt := Cells[ACol, ARow];

      if dm.bands.ContainsKey(bandAt) and dm.bands[bandAt].albums.ContainsKey(albumAt) then
        Canvas.Brush.Color := dm.bands[bandAt].albums[albumAt].color;

      at := albumAt;
    end
    //col 5 is songs
    else if ACol = 5 then
    begin
      bandAt := Cells[0, ARow];
      albumAt := Cells[2, ARow];
      songAt := Cells[ACol, ARow];

      if dm.bands.ContainsKey(bandAt) and dm.bands[bandAt].albums.ContainsKey(albumAt) and
          dm.bands[bandAt].albums[albumAt].songs.ContainsKey(songAt) then
        Canvas.Brush.Color := dm.bands[bandAt].albums[albumAt].songs[songAt].color;

      at := songAt;
    end
    //all other columns need to be explicitly set to black i guess
    else
    begin
      Canvas.Font.Color := clBlack;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 6, Rect.Top + 6, Cells[ACol, ARow]);

      Exit;
    end;

    //set invert text color depending on background color
    case Canvas.Brush.Color of
      clBlack, clNavy, clBlue, clBackground, clBtnText, clCaptionText, clGray, clGrayText,
      clHighlightText, clHotLight, clInactiveCaptionText, clInfoText, clMenuText,
      cl3DDkShadow, clWindowFrame, clWindowText:
        Canvas.Font.Color := clWhite;
      else
        Canvas.Font.Color := clBlack;
    end;

    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 6, Rect.Top + 6, at);
  end;
end;

procedure TfMain.RefreshGrid(bands: TDictionary<String, TBand>);
var
  row, selectedRow, selectedCol: Integer;

  bandNameAt, albumNameAt, songNameAt: String;
  bandAt: TBand;
  albumAt: TAlbum;
  songAt: TSong;
begin
  //keep track of the currently selected row and column, because it will reset
  //it otherwise
  selectedRow := grid.Row;
  selectedCol := grid.Col;

  for row := 1 to grid.RowCount - 1 do
    grid.Rows[row].Clear;

  grid.RowCount := 1;
  row := 1;

  //dont bother if there are no bands
  if bands.Keys.Count = 0 then
    Exit;

  for bandNameAt in dm.GetSortedQueriedBands(bands) do
  begin
    bandAt := bands[bandNameAt];

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

    for albumNameAt in dm.GetSortedQueriedAlbumsOfBand(bands, bandNameAt) do
    begin
      albumAt := bandAt.albums[albumNameAt];

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

      for songNameAt in dm.GetSortedQueriedSongsOfAlbum(bands, bandNameAt, albumNameAt) do
      begin
        songAt := albumAt.songs[songNameAt];

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

  ResizeGrid;

  //can only have fixed rows if there is more than one row. whatever
  grid.FixedRows := 1;

  //for some reason, trying this when the selected row is 0 (the fixed row)
  //causes problems. this works, so whatever. fixed rows are clearly annoying
  if (grid.Row <> selectedRow) and (selectedRow <> 0) then
    grid.Row := selectedRow;

  if (grid.Col <> selectedCol) and (selectedCol <> 0) then
    grid.Col := selectedCol;
end;

procedure TfMain.RefreshGrid;
begin
  RefreshGrid(dm.bands);
end;

procedure TfMain.ResizeGrid;
const
  MIN_CELL_WIDTH_REG: Integer = 10;
  MIN_CELL_WIDTH_SPECIAL: Integer = 20;
var
  col, row, cellWidth, toAdd, maxFound: Integer;
begin
  for col := 0 to grid.ColCount - 1 do
  begin
    maxFound := grid.Canvas.TextWidth(grid.Cells[col, 0]);

    //find the row with the largest width
    for row := 0 to grid.RowCount - 1 do
    begin
      cellWidth := grid.Canvas.TextWidth(grid.Cells[col, row]);

      if cellWidth > maxFound then
        maxFound := cellWidth;
    end;

    if (col = 0) or (col = 2) or (col = 5) then
      toAdd := MIN_CELL_WIDTH_SPECIAL
    else
      toAdd := MIN_CELL_WIDTH_REG;

    grid.ColWidths[col] := maxFound + toAdd;
  end;

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

  dm.bands.Clear;
//  dm.bandNames.Clear;
//  dm.albums.Clear;
//  dm.albumNames.Clear;
//  dm.songs.Clear;
//  dm.songNames.Clear;

  fileName := 'Untitled';
  needSave := false;

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

  loadList := TStringList.Create;
  loadList.LoadFromFile(fileName);
  loadText := loadList.Text;
  dm.ReadJSON(loadText);

  loadList.Free;

  Caption := ExtractFileName(fileName) + ' - Playlist Manager';
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

  fileData: TStringList;
  rowCount, row: Integer;
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

  fileData := TStringList.Create;
  rowCount := grid.RowCount;

  for row := 0 to rowCount do
    fileData.Add(grid.Rows[row].CommaText);

  fileData.SaveToFile(csvFileName);

  fileData.Free;
end;

procedure TfMain.menuItemExportXLSXClick(Sender: TObject);
var
  excelFileName: String;

  Excel, workBook, range: OLEVariant;
  arrData: Variant;
  rowCount, colCount, row, col: Integer;
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

  rowCount := grid.RowCount;
  colCount := grid.ColCount;

  arrData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);

  for row := 1 to rowCount do
  begin
    for col := 1 to colCount do
      arrData[row, col] := grid.Cells[col - 1, row - 1];
  end;

  Excel := CreateOLEObject('Excel.Application');
  workBook := Excel.Workbooks.Add;

  range := workBook.Worksheets[1].Range[workBook.WorkSheets[1].Cells[1, 1],
                              workBook.WorkSheets[1].Cells[RowCount, ColCount]];

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
  MessageDlg('Playlist Manager v1.0.1' + #13#10 + 'by Jordan Knapp',
    mtInformation, [mbOk], 0, mbOk);
end;

end.
