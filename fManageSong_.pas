unit fManageSong_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  fMain_, DataStructs, DataModule;

type
  TfManageSong = class(TForm)
    Label1: TLabel;
    luBands: TComboBox;
    Label2: TLabel;
    luAlbums: TComboBox;
    Label3: TLabel;
    luSongs: TComboBox;
    cbFavorite: TCheckBox;
    Label4: TLabel;
    textBox: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
    Label5: TLabel;
    edTrackNo: TEdit;
    btnApplyAlbum: TButton;
    btnApplyBand: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    oldBandSelection, oldAlbumSelection, oldSongSelection: String;
    oldCbSelection, needSave: Boolean;
    oldTbText: TStringList;
  public
    { Public declarations }
  end;

var
  fManageSong: TfManageSong;

implementation

{$R *.dfm}

procedure TfManageSong.FormCreate(Sender: TObject);
var
  listOfBands: TStringList;
  bandAt: string;
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  //is there a better way to remove default text from a text box?
  textBox.Text := '';

  oldBandSelection := '';
  oldAlbumSelection := '';
  oldSongSelection := '';
  oldCbSelection := false;
  oldTbText := TStringList.Create;
  needSave := false;

  //add list of bands to the dropdown after sorting, if there are any bands
  if dm.bandCount > 0 then
  begin
    listOfBands := dm.GetSortedBands;

    for bandAt in listOfBands do
    begin
      luBands.Items.Add(bandAt);
    end;
  end;
end;

procedure TfManageSong.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if needSave and (messageDlg('Your changes have not been saved. Continue?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes) then
    CanClose := false;
end;

procedure TfManageSong.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fMain.RefreshGrid;

  //don't know if this is needed, maybe add it to all other dialogs as wel
  Action := caFree;
  fManageSong := nil;
end;

end.
