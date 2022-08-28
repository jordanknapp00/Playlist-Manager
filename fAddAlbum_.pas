unit fAddAlbum_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  fMain_, DataStructs, DataModule;

type
  TfAddAlbum = class(TForm)
    cbBands: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    textBoxAlbums: TMemo;
    btnAddAlbum: TButton;
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
var
  bandAt: String;
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  textBoxAlbums.Text := '';
  textBoxYears.Text := '';

  //add list of bands to the dropdown after sorting, if there are any bands
  if dm.bands.Count > 0 then
  begin
    dm.bandNames.Sort;
    for bandAt in dm.bandNames do
    begin
      cbBands.Items.Add(bandAt);
    end;
  end;

end;

end.
