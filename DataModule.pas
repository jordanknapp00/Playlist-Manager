unit DataModule;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  System.Generics.Defaults, System.JSON, System.JSON.Writers,

  Vcl.Dialogs,

  DataStructs;

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

    //also have dictionaries for easy access to data
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
  obj: TJSONObject;
  val: TJSONValue;
begin
  try
    obj := TJSONObject.Create;
    val := TJSONObject.ParseJSONValue(toRead);

    val := (val as TJSONObject).Get('bands').JSONValue;
  except
    on Exception do
    begin
      showMessage('Something went wrong when loading a file. Oops.');
    end;
  end;

  val.Free;
  obj.Free;
end;

end.
