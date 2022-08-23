unit DataStructs;

interface

uses
  System.Generics.Collections;

type
  TSong = class
  private
    songName, songGenres: String;
    track: Integer;

  public
    isFavorite: Boolean;

    property name: String read songName;
    property genres: String read songGenres;
    property trackNo: Integer read track;

    constructor Create(songName, songGenres: String; trackNo: Integer);
  end;

  TAlbum = class
  private
    albumName: String;
    albumYear: Integer;

    songs: TList<TSong>;

  public
    isFavorite: Boolean;

    property name: String read albumName;
    property year: Integer read albumYear;

    constructor Create(albumName: String; albumYear: Integer);
  end;

  TBand = class
  private
    bandName: String;

    albums: TList<TAlbum>;

  public
    isFavorite: Boolean;

    property name: String read bandName;

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

  songs := TList<TSong>.Create;
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
