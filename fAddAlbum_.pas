unit fAddAlbum_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  fMain_;

type
  TfAddAlbum = class(TForm)
    cbBands: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    textBoxAlbums: TMemo;
    Button1: TButton;
    Label3: TLabel;
    textBoxYears: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAddAlbum: TfAddAlbum;

implementation

{$R *.dfm}

procedure TfAddAlbum.FormCreate(Sender: TObject);
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  //is there a better way to remove default text from a text box?
  textBoxAlbums.Text := '';
  textBoxYears.Text := '';
end;

end.
