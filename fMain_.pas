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
    menuItemStats: TMenuItem;
    procedure btnAddBandClick(Sender: TObject);
    procedure btnAddAlbumClick(Sender: TObject);
    procedure btnAddSongsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menuItemStatsClick(Sender: TObject);
    procedure menuItemSaveAsClick(Sender: TObject);
    procedure menuItemLoadClick(Sender: TObject);
    procedure menuItemSaveClick(Sender: TObject);
  private
    { Private declarations }
    fileName: String;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

uses
  fAddBand_, fAddAlbum_, fAddSong_, DataModule;

{$R *.dfm}

procedure TfMain.FormShow(Sender: TObject);
begin
  dm.Init;

  fileName := '';
end;

//==============================================================================
//                            BUTTON CLICK METHODS
//==============================================================================

procedure TfMain.btnAddBandClick(Sender: TObject);
begin
  Application.CreateForm(TfAddBand, fAddBand);
  fAddBand.ShowModal;
end;

procedure TfMain.btnAddAlbumClick(Sender: TObject);
begin
  Application.CreateForm(TfAddAlbum, fAddAlbum);
  fAddAlbum.ShowModal;
end;

procedure TfMain.btnAddSongsClick(Sender: TObject);
begin
  Application.CreateForm(TfAddSong, fAddSong);
  fAddSong.ShowModal;
end;

//==============================================================================
//                          MENU ITEM CLICK METHODS
//==============================================================================

//=====  FILE MENU  =====

procedure TfMain.menuItemLoadClick(Sender: TObject);
begin
  //text
end;

procedure TfMain.menuItemSaveClick(Sender: TObject);
begin
  showMessage(dm.WriteJSON);
end;

procedure TfMain.menuItemSaveAsClick(Sender: TObject);
begin
  //text
end;

//=====  EXPORT MENU  =====

//=====  HELP MENU  =====

procedure TfMain.menuItemStatsClick(Sender: TObject);
begin
  showMessage(IntToStr(dm.bands.Count) + ' bands,' + #13#10 +
    IntToStr(dm.albums.Count) + ' albums, and' + #13#10 +
    IntToStr(dm.songs.Count) + ' songs.');
end;



end.
