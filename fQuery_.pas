unit fQuery_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,

  System.Generics.Collections, System.StrUtils;

type
  TfQuery = class(TForm)
    btnLoadQuery: TButton;
    btnSaveQuery: TButton;
    pnlBands: TPanel;
    edBands: TMemo;
    Label1: TLabel;
    cbBandFav: TCheckBox;
    pnlAlbums: TPanel;
    edAlbums: TMemo;
    Label2: TLabel;
    edYear: TEdit;
    lblYear: TLabel;
    cbAlbumFav: TCheckBox;
    pnlSongs: TPanel;
    edSongs: TMemo;
    Label5: TLabel;
    edTrackNum: TEdit;
    lblTrackNum: TLabel;
    cbSongFav: TCheckBox;
    btnQuery: TButton;
    Label6: TLabel;
    edBandTags: TMemo;
    Label3: TLabel;
    edAlbumTags: TMemo;
    Label4: TLabel;
    edSongTags: TMemo;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function SearchText(ed: TMemo; Search: String): Boolean;
  public
    { Public declarations }
  end;

var
  fQuery: TfQuery;

implementation

uses
  fMain_, DataStructs, DataModule;

{$R *.dfm}

function TfQuery.SearchText(ed: TMemo; Search: string): Boolean;
begin
  Result := PosEx(Search, ed.Text, 1) > 0;
end;

procedure TfQuery.FormCreate(Sender: TObject);
begin
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);
end;

end.
