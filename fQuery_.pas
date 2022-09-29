unit fQuery_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,

  System.Generics.Collections, System.StrUtils, System.JSON, System.JSON.Writers;

type
  TfQuery = class(TForm)
    btnLoadQuery: TButton;
    btnSaveQuery: TButton;
    pnlBands: TPanel;
    edBands: TMemo;
    Label1: TLabel;
    cbBandFav: TCheckBox;
    pnlAlbums: TPanel;
    edAlbums: TMemo;
    Label2: TLabel;
    edYear: TEdit;
    lblYear: TLabel;
    cbAlbumFav: TCheckBox;
    pnlSongs: TPanel;
    edSongs: TMemo;
    Label5: TLabel;
    edTrackNum: TEdit;
    lblTrackNum: TLabel;
    cbSongFav: TCheckBox;
    btnQuery: TButton;
    Label6: TLabel;
    edBandTags: TMemo;
    Label3: TLabel;
    edAlbumTags: TMemo;
    Label4: TLabel;
    edSongTags: TMemo;
    Label7: TLabel;
    rgBandMatch: TRadioGroup;
    rgAlbumMatch: TRadioGroup;
    rgSongMatch: TRadioGroup;
    btnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveQueryClick(Sender: TObject);
    procedure btnLoadQueryClick(Sender: TObject);
  private
    { Private declarations }
    function SearchText(ed: TMemo; Search: String): Boolean; overload;
    function SearchText(ed: TMemo; Search: TStringList; matchAll: Boolean): Boolean; overload;
  public
    { Public declarations }
  end;

var
  fQuery: TfQuery;

implementation

uses
  fMain_, DataStructs, DataModule;

{$R *.dfm}

function TfQuery.SearchText(ed: TMemo; Search: string): Boolean;
begin
  Result := PosEx(Search, ed.Text, 1) > 0;
end;

function TfQuery.SearchText(ed: TMemo; Search: TStringList; matchAll: Boolean): Boolean;
var
  at: String;
begin
  if not matchAll then
  begin
    Result := PosEx(Search.Text, ed.Text, 1) > 0;
    Exit;
  end
  else
  begin
    //if we need to match all, easier to just loop
    for at in Search do
    begin
      if not SearchText(ed, at) then
      begin
        Result := false;
        Exit;
      end;
    end;
  end;

  Result := true;
end;

procedure TfQuery.FormCreate(Sender: TObject);
begin
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);
end;

procedure TfQuery.btnClearClick(Sender: TObject);
begin
  edBands.Clear;
  cbBandFav.Checked := false;
  edBandTags.Clear;

  edAlbums.Clear;
  cbAlbumFav.Checked := false;
  edAlbumTags.Clear;
  edYear.Clear;

  edSongs.Clear;
  cbSongFav.Checked := false;
  edSongTags.Clear;
  edTrackNum.Clear;
end;

procedure TfQuery.btnQueryClick(Sender: TObject);
var
  queriedSet: TDictionary<String, TBand>;
  toRemove, toRemove2, toRemove3: TStringList;

  bandAt, newBand: TBand;
  albumAt, newAlbum: TAlbum;
  songAt, newSong: TSong;
  at: String;
begin
  //the plan is basically to do eliminative searching. it may end up taking the
  //longest, but it's the easiest way to write this. start with ALL records.
  //whittle it down to just the favorite bands, then just the bands with a
  //certain name, then just the bands that contain certain tags.
  //
  //for the bands that are still remaining, go through the albums. again filter
  //out the non-favorites (if applicable), the ones whose names aren't listed,
  //whose year doesn't match, and who don't have the right tags. we should start
  //with the most specific (either year or favorite) and work our way out. tags
  //is most specific, so definitely do that one last. it will be time consuming
  //to compare however many tags were entered with every object's list of tags.
  //
  //finally, songs will repeat the same process one last time until we have our
  //final queried set. the one interesting aspect of this querying system is
  //that queries that return more records could very well be faster if there
  //are less conditions to check in terms of whittling down

  Screen.Cursor := crHourglass;

  queriedSet := TDictionary<String, TBand>.Create;

  //start by getting everything into our queried set. essentially copying the
  //dm.bands dictionary. all the subdictionaries are contained within.
  for bandAt in dm.bands.Values do
  begin
    newBand := TBand.Create(bandAt.name, bandAt.isFavorite);

    for albumAt in bandAt.albums.Values do
    begin
      newAlbum := TAlbum.Create(albumAt.name, newBand.name, albumAt.year, albumAt.isFavorite);

      for songAt in albumAt.songs.Values do
      begin
        newSong := TSong.Create(songAt.name, newAlbum.name, newBand.name, songAt.trackNo, songAt.isFavorite);

        newAlbum.songs.Add(newSong.name, newSong);
      end;

      newBand.albums.Add(newAlbum.name, newAlbum);
    end;

    queriedSet.Add(newBand.name, newBand);
  end;

  toRemove := TStringList.Create;

  //okay, queriedSet now has EVERYTHING. let's start by eliminating bands that
  //are not favorites, if applicable
  for bandAt in queriedSet.Values do
  begin
    //eliminate bands that are not favorites, if applicable
    if cbBandFav.Checked and not bandAt.isFavorite then
      toRemove.Add(bandAt.name);

    //if edBands is not empty, make sure the band name exists in it
    if (edBands.Text <> '') and not SearchText(edBands, bandAt.name) then
      toRemove.Add(bandAt.name);

    //if edBandTags is not empty, then compare tags based on the value of rgBandMatch
    if (edBandTags.Text <> '') and not SearchText(edBandTags, bandAt.tags, rgBandMatch.ItemIndex = 0) then
      toRemove.Add(bandAt.name);
  end;

  for at in toRemove do
    queriedSet.Remove(at);

  toRemove.Clear;

  toRemove2 := TStringList.Create;

  for bandAt in queriedSet.Values do
  begin
    for albumAt in bandAt.albums.Values do
    begin
      //eliminate albums that are not favorites, if applicable
      if cbAlbumFav.Checked and not albumAt.isFavorite then
        toRemove.Add(albumAt.name);

      //eliminate albums without matching year, if applicable
      if (edYear.Text <> '') and (albumAt.year <> StrToInt(edYear.Text)) then
        toRemove.Add(albumAt.name);

      if (edAlbums.Text <> '') and not SearchText(edAlbums, albumAt.name) then
        toRemove.Add(albumAt.name);

      if (edAlbumTags.Text <> '') and not SearchText(edAlbumTags, albumAt.tags, rgAlbumMatch.ItemIndex = 0) then
        toRemove.Add(albumAt.name);
    end;

    //eliminate everything in toRemove from this band's albums
    for at in toRemove do
      bandAt.albums.Remove(at);

    //bands that no longer have any albums should be eliminated
    if bandAt.albums.Count = 0 then
      toRemove2.Add(bandAt.name);

    toRemove.Clear;
  end;

  for at in toRemove2 do
    queriedSet.Remove(at);

  toRemove2.Clear;

  toRemove3 := TStringList.Create;

  //repeat the process one more time
  for bandAt in queriedSet.values do
  begin
    for albumAt in bandAt.albums.Values do
    begin
      for songAt in albumAt.songs.Values do
      begin
        if cbSongFav.Checked and not songAt.isFavorite then
          toRemove.Add(songAt.name);

        if (edTrackNum.Text <> '') and (songAt.trackNo <> StrToInt(edTrackNum.Text)) then
          toRemove.Add(songAt.name);

        if (edSongs.Text <> '') and not SearchText(edSongs, songAt.name) then
          toRemove.Add(songAt.name);

        if (edSongTags.Text <> '') and not SearchText(edSongTags, songAt.tags, rgSongMatch.ItemIndex = 0) then
          toRemove.Add(songAt.name);
      end;

      for at in toRemove do
        albumAt.songs.Remove(at);

      //albums that no longer have any songs should be removed
      if albumAt.songs.Count = 0 then
        toRemove3.Add(albumAt.name);

      toRemove.Clear;
    end;

    for at in toRemove3 do
      bandAt.albums.Remove(at);

    toRemove3.clear;

    //and now bands that have no albums should also be removed again
    if bandAt.albums.Count = 0 then
      toRemove2.Add(bandAt.name);
  end;

  for at in toRemove2 do
    queriedSet.Remove(at);

  //free the various TStringLists
  toRemove.Free;
  toRemove2.Free;
  toRemove3.Free;

  Screen.Cursor := crDefault;

  fMain.RefreshGrid(queriedSet);
end;

procedure TfQuery.btnSaveQueryClick(Sender: TObject);
var
  writer: TJSONObjectWriter;
  at: String;

  toSave: TStringList;
  saveDialog: TSaveDialog;
begin
  writer := TJSONObjectWriter.Create;

  writer.writeStartObject;

  //write band properties, starting with the list of bands
  writer.WritePropertyName('bands');
  writer.WriteStartArray;

  for at in edBands.Lines do
    writer.WriteValue(at);

  writer.WriteEndArray;

  //other band properties
  writer.WritePropertyName('bandFav');
  writer.WriteValue(cbBandFav.Checked);

  writer.WritePropertyName('matchBandTag');
  writer.WriteValue(rgBandMatch.ItemIndex);

  //finally, band tags
  writer.WritePropertyName('bandTags');
  writer.WriteStartArray;

  for at in edBandTags.Lines do
    writer.WriteValue(at);

  writer.WriteEndArray;

  //basically repeat the above process for album and song
  writer.WritePropertyName('albums');
  writer.WriteStartArray;

  for at in edAlbums.Lines do
    writer.WriteValue(at);

  writer.WriteEndArray;

  writer.WritePropertyName('albumFav');
  writer.WriteValue(cbAlbumFav.Checked);

  writer.WritePropertyName('albumYear');
  writer.WriteValue(edYear.Text);

  writer.WritePropertyName('matchAlbumTag');
  writer.WriteValue(rgAlbumMatch.ItemIndex);

  writer.WritePropertyName('albumTags');
  writer.WriteStartArray;

  for at in edAlbumTags.Lines do
    writer.WriteValue(at);

  writer.WriteEndArray;

  //and now songs
  writer.WritePropertyName('songs');
  writer.WriteStartArray;

  for at in edSongs.Lines do
    writer.WriteValue(at);

  writer.WriteEndArray;

  writer.WritePropertyName('songFav');
  writer.WriteValue(cbSongFav.checked);

  writer.WritePropertyName('songTrackNo');
  writer.Writevalue(edTrackNum.Text);

  writer.WritePropertyName('matchSongTag');
  writer.WriteValue(rgSongMatch.Itemindex);

  writer.WritePropertyName('songTags');
  writer.WriteStartArray;

  for at in edSongTags.Lines do
    writer.WriteValue(at);

  //all done!
  writer.WriteEndArray;
  writer.WriteEndObject;

  //put the text in a TStringList, which can be easily saved to a file
  toSave := TStringList.Create;
  toSave.Add(writer.JSON.toString);

  //have user select a file to save
  saveDialog := TSaveDialog.Create(self);

  saveDialog.Title := 'Select a location to save to';
  saveDialog.InitialDir := GetCurrentDir;
  saveDialog.Filter := 'JSON files (*.json)|*.json';
  saveDialog.DefaultExt := 'json';
  saveDialog.FilterIndex := 1;

  if saveDialog.Execute then
    toSave.SaveToFile(saveDialog.FileName);

  // Free up the dialog
  saveDialog.Free;
  toSave.Free;
  writer.Free;
end;

procedure TfQuery.btnLoadQueryClick(Sender: TObject);
var
  val: TJSONValue;
  currList: TJSONArray;
  at: TJSONValue;

  openDialog: TOpenDialog;
  fileName: String;
  loadList: TStringList;
  loadText: String;
begin
  openDialog := TOpenDialog.Create(self);

  openDialog.InitialDir := GetCurrentDir;
  openDialog.Filter := 'JSON Files (*.json)|*.json';
  openDialog.DefaultExt := 'json';
  openDialog.FilterIndex := 1;

  if openDialog.Execute then
  begin
    fileName := openDialog.Files[0];

    loadList := TStringList.Create;
    loadList.LoadFromFile(fileName);
    loadText := loadList.Text;
  end
  else
  begin
    openDialog.Free;
    Exit;
  end;

  //clear out the ui
  edBands.Clear;
  edBandTags.Clear;
  edAlbums.Clear;
  edAlbumTags.Clear;
  edYear.Clear;
  edSongs.Clear;
  edSongTags.Clear;
  edTrackNum.Clear;

  try
    //put the top-level JSON object into val
    val := TJSONObject.ParseJSONValue(loadText);

    currList := (val as TJSONObject).Get('bands').JSONValue as TJSONArray;

    for at in currList do
      edBands.Lines.Add(at.GetValue<String>);

    cbBandFav.Checked := (val as TJSONObject).GetValue<Boolean>('bandFav');
    rgBandMatch.ItemIndex := (val as TJSONObject).GetValue<Integer>('matchBandTag');

    currList := (val as TJSONObject).Get('bandTags').JSONValue as TJSONArray;

    for at in currList do
      edBandTags.Lines.Add(at.GetValue<String>);

    currList := (val as TJSONObject).Get('albums').JSONValue as TJSONArray;

    for at in currList do
      edAlbums.Lines.Add(at.GetValue<String>);

    cbAlbumFav.Checked := (val as TJSONObject).GetValue<Boolean>('albumFav');
    rgAlbumMatch.ItemIndex := (val as TJSONObject).GetValue<Integer>('matchAlbumTag');
    edYear.Text := (val as TJSONObject).GetValue<String>('albumYear');

    currList := (val as TJSONObject).Get('albumTags').JSONValue as TJSONArray;

    for at in currList do
      edAlbumTags.Lines.Add(at.GetValue<String>);

    currList := (val as TJSONObject).Get('songs').JSONValue as TJSONArray;

    for at in currList do
      edSongs.Lines.Add(at.GetValue<String>);

    cbSongFav.Checked := (val as TJSONObject).GetValue<Boolean>('songFav');
    rgSongMatch.ItemIndex := (val as TJSONObject).GetValue<Integer>('matchSongTag');
    edTrackNum.Text := (val as TJSONObject).GetValue<String>('songTrackNo');

    currList := (val as TJSONObject).Get('songTags').JSONValue as TJSONArray;

    for at in currList do
      edSongTags.Lines.Add(at.GetValue<String>);

//    at.Free;
//    currList.Free;
//    val.Free;
  except
    on E: Exception do
    begin
      showMessage('Error when processing file:' + #13#10 + E.ToString);
    end;
  end;
end;

end.
