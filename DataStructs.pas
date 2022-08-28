unit DataStructs;

interface

uses
  System.Generics.Collections, System.Generics.Defaults,

  Vcl.Dialogs;

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
    songName, songGenres, bandName, albumName: String;
    track, itemID: Integer;

  public
    isFavorite: Boolean;

    property name: String read songName;
    property genres: String read songGenres;
    property trackNo: Integer read track;
    property id: Integer read itemID;

    //relational properties
    property band: String read bandName;
    property album: String read albumName;

    constructor Create(const songName, songGenres, bandName, albumName: String; const trackNo: Integer);
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
    albumYear, itemID: Integer;

    songs: TList<TSong>;

  public
    isFavorite: Boolean;

    property name: String read albumName;
    property year: Integer read albumYear;
    property id: Integer read itemID;

    //relational property
    property band: String read bandName;

    constructor Create(const albumName, bandName: String; const albumYear: Integer);
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
    itemID: Integer;

    albums: TList<TAlbum>;

  public
    isFavorite: Boolean;

    property name: String read bandName;
    property id: Integer read itemID;

    constructor Create(const bandName: String);
  end;

//this is basically a static variable that we use to give everything a unique id.
//the {$J} compiler directive turns on writable constants. why should constants
//be writable? i dunno, then they're not really constants. but it lets us create
//an analog to static variables, so whatever
const
  {$J+}
  idCount: Integer = 0;
  {$J-}

implementation

//==============================================================================
//                                TSong Methods
//==============================================================================

constructor TSong.Create(const songName, songGenres, bandName, albumName: String; const trackNo: Integer);
begin
  self.songName := songName;
  self.songGenres := songGenres;
  self.track := trackNo;

  self.bandName := bandName;
  self.albumName := albumName;

  isFavorite := false;

  itemID := idCount;
  Inc(idCount);
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

  songs := TList<TSong>.Create();

  itemID := idCount;
  Inc(idCount);
end;

//==============================================================================
//                                TBand Methods
//==============================================================================

constructor TBand.Create(const bandName: String);
begin
  self.bandName := bandName;

  isFavorite := false;

  albums := TList<TAlbum>.Create;

  itemID := idCount;
  Inc(idCount);
end;

end.
