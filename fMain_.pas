unit fMain_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TfMain = class(TForm)
    ListView1: TListView;
    menuBar: TMainMenu;
    menuFile: TMenuItem;
    menuItemNew: TMenuItem;
    menuItemLoad: TMenuItem;
    menuItemSave: TMenuItem;
    menuItemSaveAs: TMenuItem;
    menuItemExit: TMenuItem;
    menuExport: TMenuItem;
    menuItemExportTXT: TMenuItem;
    menuItemExportCSV: TMenuItem;
    menuItemExportXLSX: TMenuItem;
    menuHelp: TMenuItem;
    menuItemHowToUse: TMenuItem;
    menuItemAbout: TMenuItem;
    btnQuery: TButton;
    btnAddBand: TButton;
    btnAddAlbum: TButton;
    btnAddSongs: TButton;
    btnDeleteBand: TButton;
    btnDeleteAlbum: TButton;
    btnDeleteSong: TButton;
    procedure btnAddBandClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

uses
  fAddBand_;

{$R *.dfm}

procedure TfMain.btnAddBandClick(Sender: TObject);
begin
  Application.CreateForm(TfAddBand, fAddBand);
  fAddBand.ShowModal;
end;

end.
