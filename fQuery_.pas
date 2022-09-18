unit fQuery_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfQuery = class(TForm)
    pnlSelectFrom: TPanel;
    cbBands: TCheckBox;
    cbAlbums: TCheckBox;
    cbSongs: TCheckBox;
    btnLoadQuery: TButton;
    btnSaveQuery: TButton;
    pnlBands: TPanel;
    edBands: TMemo;
    Label1: TLabel;
    cbBandFav: TCheckBox;
    pnlAlbums: TPanel;
    edAlbums: TMemo;
    Label2: TLabel;
    rgAlbumYear: TRadioGroup;
    edYears: TMemo;
    Label3: TLabel;
    edYear: TEdit;
    Label4: TLabel;
    cbAlbumFav: TCheckBox;
    pnlSongs: TPanel;
    edSongs: TMemo;
    Label5: TLabel;
    rgSongTrackNo: TRadioGroup;
    edSongTrackNums: TMemo;
    Label6: TLabel;
    edTrackNum: TEdit;
    Label7: TLabel;
    cbSongFav: TCheckBox;
    btnQuery: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fQuery: TfQuery;

implementation

{$R *.dfm}

end.
