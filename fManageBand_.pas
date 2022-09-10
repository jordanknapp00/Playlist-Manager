unit fManageBand_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,

  fMain_, DataStructs, DataModule;

type
  TfManageBand = class(TForm)
    Label1: TLabel;
    luBands: TComboBox;
    cbFavorite: TCheckBox;
    Label2: TLabel;
    textBox: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure luBandsChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);

    procedure DetermineNeedSave(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    oldSelection: String;
    oldCbSelection: Boolean;
    oldTbText: TStringList;
    needSave: Boolean;
  public
    { Public declarations }
  end;

var
  fManageBand: TfManageBand;

implementation

{$R *.dfm}

procedure TfManageBand.FormCreate(Sender: TObject);
var
  listOfBands: TStringList;
  bandAt: string;
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  //is there a better way to remove default text from a text box?
  textBox.Text := '';

  oldSelection := '';
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

procedure TfManageBand.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fMain.RefreshGrid;

  Action := caFree;
  fManageBand := nil;
end;

procedure TfManageBand.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if needSave and (messageDlg('Your changes have not been saved. Continue?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes) then
    CanClose := false;
end;

procedure TfManageBand.luBandsChange(Sender: TObject);
begin
  if (oldSelection <> '') and needSave then
  begin

    if messageDlg('Your changes have not been saved. Continue?',
        mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes then
    begin
      luBands.ItemIndex := luBands.Items.IndexOf(oldSelection);
      Exit;
    end;
  end;

  oldSelection := luBands.Items[luBands.ItemIndex];

  cbFavorite.Checked := dm.bands[oldSelection].isFavorite;

  textBox.Clear;
  textBox.Lines := dm.bands[oldSelection].tags;

  needSave := false;
end;

procedure TfManageBand.btnSaveClick(Sender: TObject);
begin
  dm.bands[oldSelection].isFavorite := cbFavorite.Checked;
  dm.bands[oldSelection].tags.Clear;
  dm.bands[oldSelection].tags.Assign(textBox.Lines);

  if needSave then
    fMain.manageNeedSave := true;

  needSave := false;

  messageDlg('Saved.', mtInformation, [mbOk], 0, mbOk);
  luBands.DroppedDown := true;
end;

procedure TfManageBand.btnDeleteClick(Sender: TObject);
begin
  if messageDlg('Are you sure you want to delete ' + oldSelection + ' from the ' +
      'system?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    //we'll need to do some freeing at some point in the future
    dm.bands.Remove(oldSelection);

    needSave := false;
    oldSelection := '';
    luBands.DroppedDown := true;
  end;
end;

procedure TfManageBand.DetermineNeedSave(Sender: TObject);
var
  band: TBand;
  total: Integer;
begin
  if oldSelection = '' then
    Exit;

  band := dm.bands[oldSelection];
  total := 0;

  if band.isFavorite <> cbFavorite.Checked then
    Inc(total);

  if textBox.Lines <> band.tags then
    Inc(total);

  //if any value has changed, need save. otherwise, don't need save
  needSave := total > 0;
end;

end.
