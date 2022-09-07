unit DataModule;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  System.Generics.Defaults, System.JSON, System.JSON.Writers,

  Vcl.Dialogs,

  DataStructs, fMain_;

type
  Tdm = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    //keep lists of names for easy sorting and inserting into lookup boxes
    bandNames: TList<String>;
    albumNames: TList<String>;
    songNames: TList<String>;

    //all we strictly need is a list of bands. albums and songs can be accessed
    //from within
    bands: TDictionary<String, TBand>;
    albums: TDictionary<String, TAlbum>;
    songs: TDictionary<String, TSong>;

    procedure Init;

    function AddBand(const bandName: String): Boolean;
    function AddAlbum(const albumName, bandName: String; const albumYear: Integer): Boolean;
    function AddSong(const songName, bandName, albumName: String; const trackNo: Integer): Boolean;

    procedure SortAlbumsOfBand(bandName: String);
    procedure SortSongsOfAlbum(albumName: String);

    function WriteJSON: String;
    procedure ReadJSON(toRead: String);
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.Init;
begin
  bandNames := TList<String>.Create;
  albumNames := TList<String>.Create;
  songNames := TList<String>.Create;

  bands := TDictionary<String, TBand>.Create;
  albums := TDictionary<String, TAlbum>.Create;
  songs := TDictionary<String, TSong>.Create;

  fMain.RefreshGrid;
end;

function Tdm.AddBand(const bandName: string): Boolean;
var
  newBand: TBand;
begin
  Result := true;

  if bandNames.Contains(bandName) then
  begin
    Result := false;
    Exit;
  end;

  newBand := TBand.Create(bandName);

  bandNames.Add(bandName);
  bands.Add(bandName, newBand);

  fMain.RefreshGrid;
end;

function Tdm.AddAlbum(const albumName, bandName: string; const albumYear: Integer): Boolean;
var
  newAlbum: TAlbum;
begin
  Result := true;

  if albumNames.Contains(albumName) then
  begin
    Result := false;
    Exit;
  end;

  albumNames.Add(albumName);

  newAlbum := TAlbum.Create(albumName, bandName, albumYear);
  albums.Add(albumName, newAlbum);

  //also add this album to the band's list of albums
  bands[bandName].albums.Add(newAlbum);

  fMain.RefreshGrid;
end;

function Tdm.AddSong(const songName, bandName, albumName: string; const trackNo: Integer): Boolean;
var
  newSong: TSong;
begin
  Result := true;

  if songNames.Contains(songName) then
  begin
    Result := false;
    Exit;
  end;

  songNames.Add(songName);

  newSong := TSong.Create(songName, bandName, albumName, trackNo);
  songs.Add(songName, newSong);

  //also add this song to the album's list of songs
  albums[albumName].songs.Add(newSong);

  fMain.RefreshGrid;
end;

procedure Tdm.SortAlbumsOfBand(bandName: String);
begin
  bands[bandName].albums.Sort(
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
end;

procedure Tdm.SortSongsOfAlbum(albumName: String);
begin
  albums[albumName].songs.Sort(
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
end;

function Tdm.WriteJSON: String;
var
  writer: TJSONObjectWriter;

  bandAt: TBand;
  albumAt: TAlbum;
  songAt: TSong;
begin
  writer := TJSONObjectWriter.Create;

  //list of bands first
  writer.WriteStartObject;
  writer.WritePropertyName('bands');
  writer.WriteStartArray;

  for bandAt in bands.Values do
  begin
    writer.WriteStartObject;

    writer.WritePropertyName('id');
    writer.WriteValue(bandAt.id);
    writer.WritePropertyName('name');
    writer.WriteValue(bandAt.name);
    writer.WritePropertyName('isFavorite');
    writer.WriteValue(bandAt.isFavorite);

    //showMessage(bandAt.name);

    writer.WritePropertyName('albums');
    writer.WriteStartArray;

    //each band will have its list of albums
    for albumAt in bandAt.albums do
    begin
      writer.WriteStartObject;

      writer.WritePropertyName('id');
      writer.WriteValue(albumAt.id);
      writer.WritePropertyName('name');
      writer.WriteValue(albumAt.name);
      writer.WritePropertyName('year');
      writer.WriteValue(albumAt.year);
      writer.WritePropertyName('isFavorite');
      writer.WriteValue(albumAt.isFavorite);

      writer.WritePropertyName('songs');
      writer.WriteStartArray;

      //each album has its list of songs
      for songAt in albumAt.songs do
      begin
        writer.WriteStartObject;

        writer.WritePropertyName('id');
        writer.WriteValue(songAt.id);
        writer.WritePropertyName('name');
        writer.WriteValue(songAt.name);
        writer.WritePropertyName('trackNo');
        writer.WriteValue(songAt.trackNo);
        writer.WritePropertyName('isFavorite');
        writer.WriteValue(songAt.isFavorite);

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

procedure Tdm.ReadJSON(toRead: string);
var
  val: TJSONValue;
  bandList, albumList, songList: TJSONArray;
  bandAt, albumAt, songAt: TJSONValue;

  newBand: TBand;
  newAlbum: TAlbum;
  newSong: TSong;

  //vals for current band
  bandName: String;
  bandFav: Boolean;
  bandID: Integer;

  //vals for current album
  albumName: String;
  albumYear: Integer;
  albumFav: Boolean;
  albumID: Integer;

  //vals for current song
  songName: String;
  songTrack: Integer;
  songFav: Boolean;
  songID: Integer;
begin
  try
    val := TJSONObject.ParseJSONValue(toRead);

    bandList := (val as TJSONObject).Get('bands').JSONValue as TJSONArray;

    for bandAt in bandList do
    begin
      bandName := bandAt.GetValue<String>('name');
      bandFav := bandAt.GetValue<Boolean>('isFavorite');
      bandID := bandAt.GetValue<Integer>('id');

      //create a new band using the values retrieved from json
      newBand := TBand.Create(bandName, bandID, bandFav);

      //get the list of albums and iterate through it, creating objects for each
      //of them, and their songs
      albumList := (bandAt as TJSONObject).Get('albums').JSONValue as TJSONArray;

      for albumAt in albumList do
      begin
        //same process as above, get the data from json
        albumName := albumAt.GetValue<String>('name');
        albumYear := albumAt.GetValue<Integer>('year');
        albumFav := albumAt.GetValue<Boolean>('isFavorite');
        albumID := albumAt.GetValue<Integer>('id');

        //create the object
        newAlbum := TAlbum.Create(albumName, bandName, albumYear, albumID, albumFav);

        //then handle the inner list before adding object to the system
        songList := (albumAt as TJSonObject).Get('songs').JSONValue as TJSONArray;

        for songAt in songList do
        begin
          //get data from json
          songName := songAt.GetValue<String>('name');
          songTrack := songAt.GetValue<Integer>('trackNo');
          songFav := songAt.GetValue<Boolean>('isFavorite');
          songID := songAt.GetValue<Integer>('id');

          //create object
          newSong := TSong.Create(songName, bandName, albumName, songTrack, songID, songFav);

          //no further data beyond the song, so go ahead and add this song to
          //the system
          newAlbum.songs.Add(newSong);
          songs.Add(songName, newSong);
        end;

        //add the album to the current band's list of albums, then add the song
        //to the dictionary of songs
        newBand.albums.Add(newAlbum);
        albums.Add(albumName, newAlbum);
      end;

      //once albums have all been added, the band can be added to the system
      bandNames.Add(bandName);
      bands.Add(bandName, newBand);
    end;
  except
    on E: Exception do
    begin
      showMessage('Error when processing file:' + #13#10 + E.ToString);
    end;
  end;

  val.Free;

  fMain.RefreshGrid;
end;

end.
