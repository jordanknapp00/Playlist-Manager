unit fAddBand_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  fMain_, DataStructs;

type
  TfAddBand = class(TForm)
    lblAddBands: TLabel;
    textBox: TMemo;
    btnAddBands: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnAddBandsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAddBand: TfAddBand;

implementation

uses
  DataModule;

{$R *.dfm}

procedure TfAddBand.FormCreate(Sender: TObject);
begin
  //put this dialog in the exact middle of the main window
  Top := fMain.Top + Trunc(fMain.Height / 2) - Trunc(Height / 2);
  Left := fMain.Left + Trunc(fMain.Width / 2) - Trunc(Width / 2);

  //is there a better way to remove default text from a text box?
  textBox.Text := '';
end;

procedure TfAddBand.btnAddBandsClick(Sender: TObject);
var
  bandAt: String;
  count: Integer;
begin
  count := 0;

  for bandAt in textBox.Lines do
  begin
    //ignore duplicate bands
    if not dm.bandNames.Contains(bandAt) then
    begin
      dm.AddBand(bandAt);
      Inc(count);
    end
    else
      showMessage('Band ' + bandAt + ' rejected, because it is a duplicate. ' +
        'Sorry, but at this time, we do not allow duplicate band names.');
  end;

  showMessage('Successfully added ' + IntToStr(count) + ' of ' +
    IntToStr(textBox.Lines.Count) + ' entered bands.');

  fAddBand.Close;
end;

end.
