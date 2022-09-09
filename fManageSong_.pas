unit fManageSong_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfManageSong = class(TForm)
    Label1: TLabel;
    cbBands: TComboBox;
    Label2: TLabel;
    cbAlbums: TComboBox;
    Label3: TLabel;
    cbSongs: TComboBox;
    cbFavorite: TCheckBox;
    Label4: TLabel;
    edTags: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
    Label5: TLabel;
    edTrackNo: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fManageSong: TfManageSong;

implementation

{$R *.dfm}

end.
