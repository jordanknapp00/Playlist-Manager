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
  bandList: TStringList;
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
  if dm.bandCount > 0 then
  begin
    bandList := dm.GetSortedBands;

    for bandAt in bandList do
    begin
      cbBands.Items.Add(bandAt);
    end;
  end;
end;

procedure TfAddSong.cbBandsChange(Sender: TObject);
var
  albumList: TStringList;
  albumAt: String;
  choice: Integer;
begin
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

  //somewhat confusing, i guess oldBandSelection is now the CURRENT selection
  oldBandSelection := cbBands.Items[cbBands.ItemIndex];

  //how handle the album lookup box.
  //first, clear it out entirely and add back in the N/A
  cbAlbums.Items.Clear;
  cbAlbums.ItemIndex := -1;
  cbAlbums.ClearSelection;
  cbAlbums.Text := '';
  cbAlbums.Items.Add('N/A');

  //put that band's albums in the album lookup box after sorting
  albumList := dm.GetSortedAlbumsOfBand(oldBandSelection);
  for albumAt in albumList do
  begin
    cbAlbums.Items.Add(albumAt);
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
var
  indexAt, count: Integer;
  songAt, trackNumAt: String;
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

  indexAt := 0;
  count := 0;

  for songAt in textBoxSongs.Lines do
  begin
    trackNumAt := textBoxTrackNums.Lines[indexAt];

    if not dm.AddSong(songAt, cbBands.Items[cbBands.ItemIndex],
      cbAlbums.Items[cbAlbums.ItemIndex], StrToInt(trackNumAt)) then
      showMessage('Song ' + songAt + ' rejected. We don''t allow duplicates?')
    else
      Inc(count);

    Inc(indexAt);
  end;

  showMessage('Successfully added ' + IntToStr(count) + ' of ' +
    IntToStr(textBoxSongs.Lines.Count) + ' entered songs for band ' +
    cbBands.Items[cbBands.ItemIndex] + ', album ' + cbAlbums.Items[cbAlbums.ItemIndex] + '.');

  textBoxSongs.Clear;
  textBoxTrackNums.Clear;
  cbAlbums.DroppedDown := true;
end;

end.
