unit fAddSong_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,

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
    procedure btnAddSongsClick(Sender: TObject);
    procedure cbAlbumsChange(Sender: TObject);
  private
    { Private declarations }
    oldBandSelection, oldAlbumSelection: String;
  public
    { Public declarations }
  end;

var
  fAddSong: TfAddSong;

implementation

{$R *.dfm}

procedure TfAddSong.FormCreate(Sender: TObject);
var
  bandAt: String;
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  textBoxSongs.Text := '';
  textBoxTrackNums.Text := '';

  oldBandSelection := '';
  oldAlbumSelection := '';

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

procedure TfAddSong.cbBandsChange(Sender: TObject);
var
  albumAt: TAlbum;
  choice: Integer;
begin
  //we want to prompt the user as to whether they want to clear out what they've
  //entered upon selection of a new band, but only under a few conditions:
  // - if user has gone from selecting no band to a band, don't show the message.
  // - if the user has selected the same band they had already selected, don't
  //   show the message.
  // - if the user hasn't entered anything in both text boxes, don't show the
  //   message.
  if (oldBandSelection <> '') and (oldBandSelection <> cbBands.Items[cbBands.ItemIndex])
    and ((textBoxSongs.Lines.Count > 0) or (textBoxTrackNums.Lines.Count > 0)) then
  begin
    choice := messageDlg('Clear out what you''ve entered? Select ''Cancel'' if' +
      ' you want to keep the same band selected and clear nothing.',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbYes);

    if choice = mrYes then
    begin
      textBoxSongs.Clear;
      textBoxTrackNums.Clear
    end
    else if choice = mrCancel then
    begin
      cbBands.ItemIndex := cbBands.Items.IndexOf(oldBandSelection);
      Exit;
    end;
  end;

  oldBandSelection := cbBands.Items[cbBands.ItemIndex];

  //how handle the album lookup box.
  //first, clear it out entirely and add back in the N/A
  cbAlbums.Items.Clear;
  cbAlbums.ItemIndex := -1;
  cbAlbums.ClearSelection;
  cbAlbums.Text := '';
  cbAlbums.Items.Add('N/A');

  //put that band's albums in the album lookup box after sorting
  dm.SortAlbumsOfBand(oldBandSelection);
  for albumAt in dm.bands[oldBandSelection].albums do
  begin
    if albumAt.band = oldBandSelection then
      cbAlbums.Items.Add(albumAt.name);
  end;
end;

procedure TfAddSong.cbAlbumsChange(Sender: TObject);
var
  choice: Integer;
begin
  if (oldAlbumSelection <> '') and (oldAlbumSelection <> cbAlbums.Items[cbAlbums.ItemIndex])
    and ((textBoxSongs.Lines.Count > 0) or (textBoxTrackNums.Lines.Count > 0)) then
  begin
    choice := messageDlg('Clear out what you''ve entered? Select ''Cancel'' if' +
      ' you want to keep the same album selected and clear nothing.',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbYes);

    if choice = mrYes then
    begin
      textBoxSongs.Clear;
      textBoxTrackNums.Clear
    end
    else if choice = mrCancel then
    begin
      cbAlbums.ItemIndex := cbAlbums.Items.IndexOf(oldAlbumSelection);
      Exit;
    end;
  end;

  oldAlbumSelection := cbAlbums.Items[cbAlbums.ItemIndex];
end;

procedure TfAddSong.btnAddSongsClick(Sender: TObject);
begin
  if textBoxSongs.Lines.Count <> textBoxTrackNums.Lines.Count then
  begin
    showMessage('The number of songs entered does not match the number of ' +
      'numbers entered.');
    Exit;
  end;

  if cbBands.ItemIndex < 0 then
  begin
    showMessage('Please select a band. A song must have an associated band.');
    Exit;
  end;

  if cbAlbums.ItemIndex < 0 then
  begin
    showMessage('Please select an album, or ''N/A'' if you don''t want to ' +
      'enter albums.');
    Exit;
  end;
end;

end.
