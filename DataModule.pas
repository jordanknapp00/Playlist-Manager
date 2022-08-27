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
    bands: TList<TBand>;
    albums: TList<TAlbum>;
    songs: TList<TSong>;

    procedure Init;

    function BandExists(bandName: String): Boolean;
    function AlbumExists(albumName: String): Boolean;
    function SongExists(songName: String): Boolean;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.Init;
begin
  bands := TList<TBand>.Create;
  albums := TList<TAlbum>.Create;
  songs := TList<TSong>.Create;
end;

function Tdm.BandExists(bandName: String): Boolean;
var
  bandAt: TBand;
begin
  Result := false;

  for bandAt in bands do
  begin
    if bandAt.name = bandName then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

function Tdm.AlbumExists(albumName: String): Boolean;
var
  albumAt: TAlbum;
begin
  Result := false;

  for albumAt in albums do
  begin
    if albumAt.name = albumName then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

function Tdm.SongExists(songName: String): Boolean;
var
  songAt: TSong;
begin
  Result := false;

  for songAt in songs do
  begin
    if songAt.name = songName then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

end.
