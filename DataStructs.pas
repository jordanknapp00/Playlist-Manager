unit DataStructs;

interface

uses
  System.Generics.Collections, System.Generics.Defaults, System.Classes;

type
  {
  TSong class represents a song. A song is the most granular unit, representing
  what is actually stored in the playlist. The other classes are meant to make
  songs more easily classifiable.

  A song has a name, a list of genres (all of which are stored in a string), and
  a track number (used for sorting in the table). There are also the associated
  band and album names, which allow songs to be narrowed down easily.

  As with all classes for this program, there is also a boolean to designate it
  as a favorite.
  }
  TSong = class
  private
    songName, bandName, albumName: String;
    track: Integer;

  public
    isFavorite: Boolean;
    tags: TStringList;

    property name: String read songName;
    property trackNo: Integer read track;

    //relational properties
    property band: String read bandName;
    property album: String read albumName;

    constructor Create(const songName, bandName, albumName: String; const trackNo: Integer); overload;
    constructor Create(const songName, bandName, albumName: String; const trackNo: Integer; const fav: Boolean); overload;

    procedure AddTags(toAdd: TStrings);
  end;

  {
  TAlbum class represents an album. An album is the middleman between bands and
  songs. A band has a list of albums, while an album has a list of songs.

  An album has a name and a year that it came out, along with the aforementioned
  list of songs. And of course, albums can be designated as favorites as well.

  Albums have an associated band as well, allowing an easy way to narrow down
  albums when querying.
  }
  TAlbum = class
  private
    albumName, bandName: String;
    albumYear: Integer;

  public
    isFavorite: Boolean;
    tags: TStringList;

    songs: TDictionary<String, TSong>;

    property name: String read albumName;
    property year: Integer read albumYear;

    //relational property
    property band: String read bandName;

    constructor Create(const albumName, bandName: String; const albumYear: Integer); overload;
    constructor Create(const albumName, bandName: String; const albumYear: Integer; const fav: Boolean); overload;

    procedure AddTags(toAdd: TStrings);
  end;

  {
  TBand is the most general of the classes for this program. It is the least
  granular, as any given band is likely to have a few albums and anywhere from
  a few to hundreds of songs.

  A band has a name and a list of albums, and can be designated as a favorite.
  }
  TBand = class
  private
    bandName: String;

  public
    isFavorite: Boolean;
    tags: TStringList;

    albums: TDictionary<String, TAlbum>;

    property name: String read bandName;

    constructor Create(const bandName: String); overload;
    constructor Create(const bandName: String; const fav: Boolean); overload;

    procedure AddTags(toAdd: TStrings);
  end;

implementation

//==============================================================================
//                                TSong Methods
//==============================================================================

//constructor without id
constructor TSong.Create(const songName, bandName, albumName: String; const trackNo: Integer);
begin
  self.songName := songName;
  self.track := trackNo;

  self.bandName := bandName;
  self.albumName := albumName;

  isFavorite := false;
  tags := TStringList.Create;
end;

//constructor with id and fav
constructor TSong.Create(const songName, bandName, albumName: string; const trackNo: Integer; const fav: Boolean);
begin
  self.songName := songName;
  self.track := trackNo;

  self.bandName := bandName;
  self.albumName := albumName;

  isFavorite := fav;
  tags := TStringList.Create;
end;

procedure TSong.AddTags(toAdd: TStrings);
var
  at: String;
begin
  for at in toAdd do
  begin
    if tags.IndexOf(at) = -1 then
      tags.Add(at);
  end;
end;

//==============================================================================
//                                TAlbum Methods
//==============================================================================

constructor TAlbum.Create(const albumName, bandName: String; const albumYear: Integer);
begin
  self.albumName := albumName;
  self.albumYear := albumYear;

  self.bandName := bandName;

  isFavorite := false;
  tags := TStringList.Create;

  songs := TDictionary<String, TSong>.Create;
end;

//constructor with id and fav
constructor TAlbum.Create(const albumName, bandName: String; const albumYear: Integer; const fav: Boolean);
begin
  self.albumName := albumName;
  self.albumYear := albumYear;

  self.bandName := bandName;

  isFavorite := fav;
  tags := TStringList.Create;

  songs := TDictionary<String, TSong>.Create;
end;

procedure TAlbum.AddTags(toAdd: TStrings);
var
  at: String;
begin
  for at in toAdd do
  begin
    if tags.IndexOf(at) = -1 then
      tags.Add(at);
  end;
end;

//==============================================================================
//                                TBand Methods
//==============================================================================

constructor TBand.Create(const bandName: String);
begin
  self.bandName := bandName;

  isFavorite := false;
  tags := TStringList.Create;

  albums := TDictionary<String, TAlbum>.Create;
end;

constructor TBand.Create(const bandName: String; const fav: Boolean);
begin
  self.bandName := bandName;

  isFavorite := fav;
  tags := TStringList.Create;

  albums := TDictionary<String, TAlbum>.Create;
end;

procedure TBand.AddTags(toAdd: TStrings);
var
  at: String;
begin
  for at in toAdd do
  begin
    if tags.IndexOf(at) = -1 then
      tags.Add(at);
  end;
end;

end.
