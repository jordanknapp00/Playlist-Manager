unit fQuery_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,

  System.Generics.Collections, System.StrUtils;

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
    procedure FormCreate(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
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

procedure TfQuery.btnQueryClick(Sender: TObject);
var
  queriedSet: TDictionary<String, TBand>;
  toRemove: TStringList;

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

    toRemove.Clear;
  end;

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

      toRemove.Clear;
    end;
  end;

  Screen.Cursor := crDefault;
end;

end.
