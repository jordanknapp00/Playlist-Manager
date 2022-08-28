unit DataModule;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  System.Generics.Defaults,

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
    function AddSong(const songName, genres, bandName, albumName: String; const trackNo: Integer): Boolean;

    procedure SortAlbumsOfBand(bandName: String);
    procedure SortSongsOfAlbum(albumName: String);
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
begin
  Result := true;

  if bandNames.Contains(bandName) then
  begin
    Result := false;
    Exit;
  end;

  bandNames.Add(bandName);
  bands.Add(bandName, TBand.Create(bandName));
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

function Tdm.AddSong(const songName, genres, bandName, albumName: string; const trackNo: Integer): Boolean;
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
  songs.Add(songName, TSong.Create(songName, genres, bandName, albumName, trackNo));
end;

procedure Tdm.SortAlbumsOfBand(bandName: String);
begin
  bands[bandName].albums.Sort(
    TComparer<TAlbum>.Construct(
      function(const left, right: TAlbum): Integer
      begin
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

end.
