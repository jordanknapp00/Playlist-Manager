unit fAddSong_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  fMain_, DataModule, DataStructs;

type
  TfAddSong = class(TForm)
    cbAlbums: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    textBoxSongs: TMemo;
    btnAddSongs: TButton;
    Label3: TLabel;
    textBoxTrackNums: TMemo;
    Label4: TLabel;
    cbBands: TComboBox;
    lblUseNA: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cbBandsChange(Sender: TObject);
  private
    { Private declarations }
    oldSelection: String;
  public
    { Public declarations }
  end;

var
  fAddSong: TfAddSong;

implementation

{$R *.dfm}

procedure TfAddSong.cbBandsChange(Sender: TObject);
var
  albumAt: TAlbum;
begin
  //we want to prompt the user as to whether they want to clear out what they've
  //entered upon selection of a new band, but only under a few conditions:
  // - if user has gone from selecting no band to a band, don't show the message.
  // - if the user has selected the same band they had already selected, don't
  //   show the message.
  // - if the user hasn't entered anything in both text boxes, don't show the
  //   message.
  if (oldSelection <> '') and (oldSelection <> cbBands.Items[cbBands.ItemIndex])
    and ((textBoxSongs.Lines.Count > 0) or (textBoxTrackNums.Lines.Count > 0)) then
  begin
    if messageDlg('Clear out what you''ve entered and select a new band?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      textBoxSongs.Clear;
      textBoxTrackNums.Clear
    end
    else
      cbBands.ItemIndex := cbBands.Items.IndexOf(oldSelection);
  end;

  oldSelection := cbBands.Items[cbBands.ItemIndex];

  //how handle the album lookup box.
  //first, clear it out entirely and add back in the N/A
  cbAlbums.Items.Clear;
  cbAlbums.ItemIndex := -1;
  cbAlbums.ClearSelection;
  cbAlbums.Text := '';
  cbAlbums.Items.Add('N/A');

  //put that band's albums in the album lookup box after sorting
  dm.SortAlbumsOfBand(oldSelection);
  for albumAt in dm.bands[oldSelection].albums do
  begin
    if albumAt.band = oldSelection then
      cbAlbums.Items.Add(albumAt.name);
  end;
end;

procedure TfAddSong.FormCreate(Sender: TObject);
var
  bandAt: String;
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  textBoxSongs.Text := '';
  textBoxTrackNums.Text := '';

  oldSelection := '';

  lblUseNA.Caption := 'Use N/A if you aren''t categorizing' + #13#10 +
    'by album.';

  //add list of bands to the dropdown after sorting, if there are any bands
  if dm.bandNames.Count > 0 then
  begin
    dm.bandNames.Sort;
    for bandAt in dm.bandNames do
    begin
      cbBands.Items.Add(bandAt);
    end;
  end;
end;

end.
