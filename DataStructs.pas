unit DataStructs;

interface

uses
  System.Generics.Collections;

type
  {
  TSong class represents a song. A song is the most granular unit, representing
  what is actually stored in the playlist. The other classes are meant to make
  songs more easily classifiable.

  A song has a name, a list of genres (all of which are stored in a string), and
  a track number (used for sorting in the table).

  As with all classes for this program, there is also a boolean to designate it
  as a favorite.
  }
  TSong = class
  private
    songName, songGenres: String;
    track, itemID: Integer;

  public
    isFavorite: Boolean;

    property name: String read songName;
    property genres: String read songGenres;
    property trackNo: Integer read track;
    property id: Integer read itemID;

    constructor Create(songName, songGenres: String; trackNo: Integer);
  end;

  {
  TAlbum class represents an album. An album is the middleman between bands and
  songs. A band has a list of albums, while an album has a list of songs.

  An album has a name and a year that it came out, along with the aforementioned
  list of songs. And of course, albums can be designated as favorites as well.
  }
  TAlbum = class
  private
    albumName: String;
    albumYear, itemID: Integer;

    songs: TList<TSong>;

  public
    isFavorite: Boolean;

    property name: String read albumName;
    property year: Integer read albumYear;
    property id: Integer read itemID;

    constructor Create(albumName: String; albumYear: Integer);
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

    constructor Create(bandName: String);
  end;

implementation

//==============================================================================
//                                TSong Methods
//==============================================================================

constructor TSong.Create(songName, songGenres: String; trackNo: Integer);
begin
  self.songName := songName;
  self.songGenres := songGenres;
  self.track := trackNo;

  isFavorite := false;
end;

//==============================================================================
//                                TAlbum Methods
//==============================================================================

constructor TAlbum.Create(albumName: String; albumYear: Integer);
begin
  self.albumName := albumName;
  self.albumYear := albumYear;

  isFavorite := false;

  songs := TList<TSong>.Create();
end;

//==============================================================================
//                                TBand Methods
//==============================================================================

constructor TBand.Create(bandName: String);
begin
  self.bandName := bandName;

  isFavorite := false;

  albums := TList<TAlbum>.Create;
end;

end.
