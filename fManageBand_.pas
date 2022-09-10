unit fManageBand_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,

  fMain_, DataStructs, DataModule;

type
  TfManageBand = class(TForm)
    Label1: TLabel;
    cbBands: TComboBox;
    cbFavorite: TCheckBox;
    Label2: TLabel;
    textBox: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cbBandsChange(Sender: TObject);
    procedure cbFavoriteClick(Sender: TObject);
    procedure textBoxChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
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
      cbBands.Items.Add(bandAt);
    end;
  end;
end;

procedure TfManageBand.cbBandsChange(Sender: TObject);
var
  choice: Integer;
begin
  if (oldSelection <> '') and needSave then
  begin
    choice := messageDlg('Your changes have not been saved. Continue?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes);

    if choice <> mrYes then
    begin
      cbBands.ItemIndex := cbBands.Items.IndexOf(oldSelection);
      Exit;
    end;
  end;

  oldSelection := cbBands.Items[cbBands.ItemIndex];
  needSave := false;

  cbFavorite.Checked := dm.bands[oldSelection].isFavorite;

  textBox.Clear;
  textBox.Lines := dm.bands[oldSelection].tags;
end;

procedure TfManageBand.cbFavoriteClick(Sender: TObject);
begin
  needSave := true;
end;

procedure TfManageBand.textBoxChange(Sender: TObject);
begin
  needSave := true;
end;

procedure TfManageBand.btnSaveClick(Sender: TObject);
begin
  dm.bands[oldSelection].isFavorite := cbFavorite.Checked;
  dm.bands[oldSelection].tags.Clear;
  dm.bands[oldSelection].tags.Assign(textBox.Lines);

  messageDlg('Saved.', mtInformation, [mbOk], 0, mbOk);
  cbBands.DroppedDown := true;
end;

end.
