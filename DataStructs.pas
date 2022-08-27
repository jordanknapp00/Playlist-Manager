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

    songComparer: IComparer<TSong>;
    function CompareFunc(const Left, Right: TSong): Integer;

  public
    isFavorite: Boolean;

    property name: String read songName;
    property genres: String read songGenres;
    property trackNo: Integer read track;
    property id: Integer read itemID;

    //relational properties
    property band: String read bandName;
    property album: String read albumName;

    property comparer: IComparer<TSong> read songComparer;

    constructor Create(songName, songGenres, bandName, albumName: String; trackNo: Integer);
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

    albumComparer: IComparer<TAlbum>;
    function CompareFunc(const Left, Right: TAlbum): Integer;

  public
    isFavorite: Boolean;

    property name: String read albumName;
    property year: Integer read albumYear;
    property id: Integer read itemID;

    property comparer: IComparer<TAlbum> read albumComparer;

    //relational property
    property band: String read bandName;

    constructor Create(albumName, bandName: String; albumYear: Integer);
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

    bandComparer: IComparer<TBand>;
    function CompareFunc(const Left, Right: TBand): Integer;

  public
    isFavorite: Boolean;

    property name: String read bandName;
    property id: Integer read itemID;

    property comparer: IComparer<TBand> read bandComparer;

    constructor Create(bandName: String);
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

constructor TSong.Create(songName, songGenres, bandName, albumName: String; trackNo: Integer);
begin
  self.songName := songName;
  self.songGenres := songGenres;
  self.track := trackNo;

  self.bandName := bandName;
  self.albumName := albumName;

  isFavorite := false;

  itemID := idCount;
  Inc(idCount);

  //define the comparer function for TSong
  songComparer := TComparer<TSong>.Construct(CompareFunc);
end;

//comparer function
function TSong.CompareFunc(const Left: TSong; const Right: TSong): Integer;
begin
  if Left.name < Right.name then
    Result := -1
  else if Left.name > Right.name then
    Result := 1
  //if left and right have the same name, check the album to decide
  else
  begin
    if Left.album < Right.album then
      Result := -1
    else if Left.album > Right.album then
      Result := 1
    else
    //if the album is the same too, now we check the band, which we know
    //cannot be a duplicate
    begin
      if Left.band < Right.band then
        Result := -1
      else
        Result := 1;
    end;
  end;
end;

//==============================================================================
//                                TAlbum Methods
//==============================================================================

constructor TAlbum.Create(albumName, bandName: String; albumYear: Integer);
begin
  self.albumName := albumName;
  self.albumYear := albumYear;

  self.bandName := bandName;

  isFavorite := false;

  songs := TList<TSong>.Create();

  itemID := idCount;
  Inc(idCount);

  //define comparer for album
  albumComparer := TComparer<TAlbum>.Construct(CompareFunc);
end;

function TAlbum.CompareFunc(const Left: TAlbum; const Right: TAlbum): Integer;
begin
  if Left.name < Right.name then
    Result := -1
  else if Left.name > Right.name then
    Result := 1
  //if left and right have the same name, check the band to decide, which we
  //know can't be a duplicate
  else
  begin
    if Left.band < Right.band then
      Result := -1
    else
      Result := 1;
  end;
end;

//==============================================================================
//                                TBand Methods
//==============================================================================

constructor TBand.Create(bandName: String);
begin
  self.bandName := bandName;

  isFavorite := false;

  albums := TList<TAlbum>.Create;

  itemID := idCount;
  Inc(idCount);

  bandComparer := TComparer<TBand>.Construct(CompareFunc);
end;

function TBand.CompareFunc(const Left: TBand; const Right: TBand): Integer;
begin
  if Left.name < Right.name then
    Result := -1
  else
    Result := 1;
end;

end.
