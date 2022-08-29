unit fAddAlbum_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,

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
    procedure btnAddAlbumClick(Sender: TObject);
    procedure cbBandsChange(Sender: TObject);
  private
    { Private declarations }
    oldSelection: String;
  public
    { Public declarations }
  end;

var
  fAddAlbum: TfAddAlbum;

implementation

{$R *.dfm}

procedure TfAddAlbum.cbBandsChange(Sender: TObject);
var
  choice: Integer;
begin
  //we want to prompt the user as to whether they want to clear out what they've
  //entered upon selection of a new band, but only under a few conditions:
  // - if user has gone from selecting no band to a band, don't show the message.
  // - if the user has selected the same band they had already selected, don't
  //   show the message.
  // - if the user hasn't entered anything in both text boxes, don't show the
  //   message.
  if (oldSelection <> '') and (oldSelection <> cbBands.Items[cbBands.ItemIndex])
    and ((textBoxAlbums.Lines.Count > 0) or (textBoxYears.Lines.Count > 0)) then
  begin
    choice := messageDlg('Clear out what you''ve entered? Select ''Cancel'' if' +
      ' you want to keep the same band selected and clear nothing.',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbYes);

    if choice = mrYes then
    begin
      textBoxAlbums.Clear;
      textBoxYears.Clear
    end
    else if choice = mrCancel then
    begin
      cbBands.ItemIndex := cbBands.Items.IndexOf(oldSelection);
      Exit;
    end;
  end;

  oldSelection := cbBands.Items[cbBands.ItemIndex];
end;

procedure TfAddAlbum.FormCreate(Sender: TObject);
var
  bandAt: String;
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  textBoxAlbums.Text := '';
  textBoxYears.Text := '';

  oldSelection := '';

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

procedure TfAddAlbum.btnAddAlbumClick(Sender: TObject);
var
  indexAt, count: Integer;
  albumAt, yearAt: String;
begin
  if textBoxAlbums.Lines.Count <> textBoxYears.Lines.Count then
  begin
    showMessage('The number of albums entered does not match the number of ' +
      ' years entered.');
    Exit;
  end;

  if cbBands.ItemIndex < 0 then
  begin
    showMessage('Please select a band. An album must have an associated band.');
    Exit;
  end;

  indexAt := 0;
  count := 0;

  for albumAt in textBoxAlbums.Lines do
  begin
    yearAt := textBoxYears.Lines[indexAt];

    if not dm.AddAlbum(albumAt, cbBands.Items[cbBands.ItemIndex], StrToInt(yearAt)) then
      showMessage('Album ' + albumAt + ' rejected, because it is a duplicate. ' +
        'Sorry, but at this time, we do not accept duplicate album names.')
    else
      Inc(count);

    Inc(indexAt);
  end;

  showMessage('Successfully added ' + IntToStr(count) + ' of ' +
    IntToStr(textBoxAlbums.Lines.Count) + ' entered albums for band ' +
    cbBands.Items[cbBands.ItemIndex] + '.');

  //rather than closing the dialog, simply clear the text boxes and open the
  //band lookup box so the user can easily select another band.
  textBoxYears.Clear;
  textBoxAlbums.Clear;
  cbBands.DroppedDown := true;
end;

end.
