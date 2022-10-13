unit DataModule;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  System.Generics.Defaults, System.JSON, System.JSON.Writers,

  Vcl.Dialogs, Vcl.Graphics,

  DataStructs, fMain_;

type
  Tdm = class(TDataModule)
  private
    { Private declarations }
    numBands, numAlbums, numSongs: Integer;
  public
    { Public declarations }
    //all we strictly need is a dictionary bands. everything else can be
    //accessed from within
    bands: TDictionary<String, TBand>;

    property bandCount: Integer read numBands;
    property albumCount: Integer read numAlbums;
    property songCount: Integer read numSongs;

    procedure Init;
    procedure Clear;

    function AddBand(const bandName: String): Boolean;
    function AddAlbum(const albumName, bandName: String; const albumYear: Integer): Boolean;
    function AddSong(const songName, bandName, albumName: String; const trackNo: Integer): Boolean;

    function GetSortedBands: TStringList;
    function GetSortedQueriedBands(bands: TDictionary<String, TBand>): TStringList;

    function GetSortedAlbumsOfBand(bandName: String): TStringList;
    function GetSortedQueriedAlbumsOfBand(bands: TDictionary<String, TBand>; bandName: String): TStringList;

    function GetSortedSongsOfAlbum(bandName, albumName: String): TStringList;
    function GetSortedQueriedSongsOfAlbum(bands: TDictionary<String, TBand>; bandName, albumName: String): TStringList;

    function WriteJSON: String;
    function ReadJSON(toRead: String): Boolean;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.Init;
begin
  bands := TDictionary<String, TBand>.Create;

  fMain.RefreshGrid;
end;

procedure Tdm.Clear;
begin
  bands.Clear;

  numBands := 0;
  numAlbums := 0;
  numSongs := 0;
end;

function Tdm.AddBand(const bandName: string): Boolean;
var
  newBand: TBand;
begin
  Result := true;

  //there are no duplicate band names allowed
  if bands.ContainsKey(bandName) then
  begin
    Result := false;
    Exit;
  end;

  newBand := TBand.Create(bandName);
  bands.Add(bandName, newBand);

  Inc(numBands);

  fMain.RefreshGrid;
end;

function Tdm.AddAlbum(const albumName, bandName: string; const albumYear: Integer): Boolean;
var
  newAlbum: TAlbum;
begin
  Result := true;

  //no duplicate album names within the same band
  if bands[bandName].albums.ContainsKey(albumName) then
  begin
    Result := false;
    Exit;
  end;

  newAlbum := TAlbum.Create(albumName, bandName, albumYear);
  bands[bandName].albums.Add(albumName, newAlbum);

  Inc(numAlbums);

  fMain.RefreshGrid;
end;

function Tdm.AddSong(const songName, bandName, albumName: string; const trackNo: Integer): Boolean;
var
  newSong: TSong;
  album: TAlbum;
begin
  Result := true;

  //if the N/A album is selected, make sure it exists
  if (albumName = 'N/A') and (not bands[bandName].albums.ContainsKey('N/A')) then
    AddAlbum('N/A', bandName, 0);

  album := bands[bandName].albums[albumName];

  //no duplicate song names within the same album
  if album.songs.ContainsKey(songName) then
  begin
    Result := false;
    Exit;
  end;

  newSong := TSong.Create(songName, bandName, albumName, trackNo);
  album.songs.Add(songName, newSong);

  Inc(numSongs);

  fMain.RefreshGrid;
end;

function Tdm.GetSortedBands: TStringList;
begin
  Result := GetSortedQueriedBands(bands);
end;

function Tdm.GetSortedQueriedBands(bands: TDictionary<String, TBand>): TStringList;
var
  bandList: TList<TBand>;
  bandAt: TBand;
begin
  Result := TStringList.Create;
  bandList := TList<TBand>.Create;

  for bandAt in bands.Values do
    bandList.Add(bandAt);

  bandList.Sort(
    TComparer<TBand>.Construct(
      function(const left, right: TBand): Integer
      begin
        Result := CompareStr(left.name, right.name);
      end
    )
  );

  for bandAt in bandList do
    Result.Add(bandAt.name);
end;

function Tdm.GetSortedAlbumsOfBand(bandName: String): TStringList;
begin
  Result := GetSortedQueriedAlbumsOfBand(bands, bandName);
end;

function Tdm.GetSortedQueriedAlbumsOfBand(bands: TDictionary<String, TBand>; bandName: String): TStringList;
var
  albumList: TList<TAlbum>;
  albumAt: TAlbum;
begin
  Result := TStringList.Create;
  albumList := TList<TAlbum>.Create;

  for albumAt in bands[bandName].albums.Values do
    albumList.Add(albumAt);

  albumList.Sort(
    TComparer<TAlbum>.Construct(
      function(const left, right: TAlbum): Integer
      begin
        if left.year < right.year then
          Result := -1
        else if left.year > right.year then
          Result := 1
        else
          Result := CompareStr(left.name, right.name);
      end
    )
  );

  for albumAt in albumList do
    Result.Add(albumAt.name);
end;

function Tdm.GetSortedSongsOfAlbum(bandName, albumName: String): TStringList;
begin
  Result := GetSortedQueriedSongsOfAlbum(bands, bandName, albumName);
end;

function Tdm.GetSortedQueriedSongsOfAlbum(bands: TDictionary<String, TBand>; bandName, albumName: String): TStringList;
var
  songList: TList<TSong>;
  songAt: TSong;
begin
  Result := TStringList.Create;
  songList := TList<TSong>.Create;

  for songAt in bands[bandName].albums[albumName].songs.Values do
    songList.Add(songAt);

  songList.Sort(
    TComparer<TSong>.Construct(
      function(const left, right: TSong): Integer
      begin
        if left.trackNo < right.trackNo then
          Result := -1
        else if left.trackNo > right.trackNo then
          Result := 1
        else
          Result := 0;
      end
    )
  );

  for songAt in songList do
    Result.Add(songAt.name);
end;

function Tdm.WriteJSON: String;
var
  writer: TJSONObjectWriter;

  bandAt: TBand;
  albumAt: TAlbum;
  songAt: TSong;
  tagAt: String;
begin
  writer := TJSONObjectWriter.Create;

  //list of bands first
  writer.WriteStartObject;
  writer.WritePropertyName('bands');
  writer.WriteStartArray;

  for bandAt in bands.Values do
  begin
    writer.WriteStartObject;

    writer.WritePropertyName('name');
    writer.WriteValue(bandAt.name);
    writer.WritePropertyName('isFavorite');
    writer.WriteValue(bandAt.isFavorite);
    writer.WritePropertyName('color');
    writer.WriteValue(bandAt.color);

    writer.WritePropertyName('tags');
    writer.WriteStartArray;

    for tagAt in bandAt.tags do
      writer.WriteValue(tagAt);

    writer.WriteEndArray;

    writer.WritePropertyName('albums');
    writer.WriteStartArray;

    //each band will have its list of albums
    for albumAt in bandAt.albums.Values do
    begin
      writer.WriteStartObject;

      writer.WritePropertyName('name');
      writer.WriteValue(albumAt.name);
      writer.WritePropertyName('year');
      writer.WriteValue(albumAt.year);
      writer.WritePropertyName('isFavorite');
      writer.WriteValue(albumAt.isFavorite);
      writer.WritePropertyName('color');
      writer.WriteValue(albumAt.color);

      writer.WritePropertyName('tags');
      writer.WriteStartArray;

      for tagAt in albumAt.tags do
        writer.WriteValue(tagAt);

      writer.WriteEndArray;

      writer.WritePropertyName('songs');
      writer.WriteStartArray;

      //each album has its list of songs
      for songAt in albumAt.songs.Values do
      begin
        writer.WriteStartObject;

        writer.WritePropertyName('name');
        writer.WriteValue(songAt.name);
        writer.WritePropertyName('trackNo');
        writer.WriteValue(songAt.trackNo);
        writer.WritePropertyName('isFavorite');
        writer.WriteValue(songAt.isFavorite);
        writer.WritePropertyName('color');
        writer.WriteValue(songAt.color);

        writer.WritePropertyName('tags');
        writer.WriteStartArray;

        for tagAt in songAt.tags do
          writer.WriteValue(tagAt);

        writer.WriteEndArray;

        writer.WriteEndObject;
      end;

      writer.WriteEndArray;
      writer.WriteEndObject;
    end;

    writer.WriteEndArray;
    writer.WriteEndObject;
  end;

  writer.WriteEndArray;
  writer.WriteEndObject;

  Result := writer.JSON.ToString;
end;

function Tdm.ReadJSON(toRead: string): Boolean;
var
  val: TJSONValue;
  bandList, albumList, songList, tagList: TJSONArray;
  bandAt, albumAt, songAt, tagAt: TJSONValue;

  newBand: TBand;
  newAlbum: TAlbum;
  newSong: TSong;

  newTags: TStringList;

  //vals for current band
  bandName: String;
  bandFav: Boolean;
  bandID: Integer;
  bandColor: TColor;

  //vals for current album
  albumName: String;
  albumYear: Integer;
  albumFav: Boolean;
  albumID: Integer;
  albumColor: TColor;

  //vals for current song
  songName: String;
  songTrack: Integer;
  songFav: Boolean;
  songID: Integer;
  songColor: TColor;
begin
  newTags := TStringList.Create;
  Result := true;

  try
    val := TJSONObject.ParseJSONValue(toRead);

    bandList := (val as TJSONObject).Get('bands').JSONValue as TJSONArray;

    for bandAt in bandList do
    begin
      bandName := bandAt.GetValue<String>('name');
      bandFav := bandAt.GetValue<Boolean>('isFavorite');
      bandColor := bandAt.GetValue<TColor>('color');

      //get the list of tags and iterate through it
      tagList := (bandAt as TJSONObject).Get('tags').JSONValue as TJSONArray;

      newTags.Clear;
      for tagAt in tagList do
        newTags.Add(tagAt.GetValue<String>);

      //create a new band using the values retrieved from json
      newBand := TBand.Create(bandName, bandFav, bandColor);
      newBand.AddTags(newTags);

      //get the list of albums and iterate through it, creating objects for each
      //of them, and their songs
      albumList := (bandAt as TJSONObject).Get('albums').JSONValue as TJSONArray;

      for albumAt in albumList do
      begin
        //same process as above, get the data from json
        albumName := albumAt.GetValue<String>('name');
        albumYear := albumAt.GetValue<Integer>('year');
        albumFav := albumAt.GetValue<Boolean>('isFavorite');
        albumColor := albumAt.GetValue<TColor>('color');

        tagList := (albumAt as TJSONObject).Get('tags').JSONValue as TJSONArray;

        newTags.Clear;
        for tagAt in tagList do
          newTags.Add(tagAt.GetValue<String>);

        //create the object
        newAlbum := TAlbum.Create(albumName, bandName, albumYear, albumFav, albumColor);
        newAlbum.AddTags(newTags);

        //then handle the inner list before adding object to the system
        songList := (albumAt as TJSonObject).Get('songs').JSONValue as TJSONArray;

        for songAt in songList do
        begin
          //get data from json
          songName := songAt.GetValue<String>('name');
          songTrack := songAt.GetValue<Integer>('trackNo');
          songFav := songAt.GetValue<Boolean>('isFavorite');
          songColor := songAt.GetValue<TColor>('color');

          tagList := (songAt as TJSONObject).Get('tags').JSONValue as TJSONArray;

          newTags.Clear;
          for tagAt in tagList do
            newTags.Add(tagAt.GetValue<String>);

          //create object
          newSong := TSong.Create(songName, bandName, albumName, songTrack, songFav, songColor);
          newSong.AddTags(newTags);

          //no further data beyond the song, so go ahead and add this song to
          //the system
          newAlbum.songs.Add(songName, newSong);
          Inc(numSongs);
        end;

        newBand.albums.Add(albumName, newAlbum);
        Inc(numAlbums);
      end;

      //once albums have all been added, the band can be added to the system
      bands.Add(bandName, newBand);
      Inc(numBands);
    end;
  except
    on E: Exception do
    begin
      Result := false;
      showMessage('Error when processing file:' + #13#10 + E.ToString);
    end;
  end;

  val.Free;
  newTags.Free;

  fMain.RefreshGrid;
end;

end.
