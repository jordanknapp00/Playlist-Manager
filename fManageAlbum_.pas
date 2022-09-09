unit fManageAlbum_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfManageAlbum = class(TForm)
    Label1: TLabel;
    cbBands: TComboBox;
    Label2: TLabel;
    ComboBox1: TComboBox;
    cbFavorite: TCheckBox;
    Label3: TLabel;
    Memo1: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
    Label4: TLabel;
    edYear: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fManageAlbum: TfManageAlbum;

implementation

{$R *.dfm}

end.
