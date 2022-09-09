unit fManageBand_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfManageBand = class(TForm)
    Label1: TLabel;
    cbBands: TComboBox;
    cbFavorite: TCheckBox;
    Label2: TLabel;
    edTags: TMemo;
    btnSave: TButton;
    btnDelete: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fManageBand: TfManageBand;

implementation

{$R *.dfm}

end.
