unit DataModule;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,

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

    procedure AddBand(const bandName: String);
    procedure AddAlbum(const albumName, bandName: String; const albumYear: Integer);
    procedure AddSong(const songName, genres, bandName, albumName: String; const trackNo: Integer);
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

procedure Tdm.AddBand(const bandName: string);
begin
  bandNames.Add(bandName);

  bands.Add(bandName, TBand.Create(bandName));
end;

procedure Tdm.AddAlbum(const albumName: string; const bandName: string; const albumYear: Integer);
begin
  albumNames.Add(albumName);

  albums.Add(albumName, TAlbum.Create(albumName, bandName, albumYear));
end;

procedure Tdm.AddSong(const songName: string; const genres: string; const bandName: string; const albumName: string; const trackNo: Integer);
begin
  songNames.Add(songName);

  songs.Add(songName, TSong.Create(songName, genres, bandName, albumName, trackNo));
end;

end.
