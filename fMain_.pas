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

    procedure HandleSave;
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
var
  dialog: TOpenDialog;
  loadList: TStringList;
  loadText: String;
begin
  dialog := TOpenDialog.Create(self);
  dialog.InitialDir := GetCurrentDir;
  dialog.Filter := 'JSON Files (*.json)|*.json';
  dialog.DefaultExt := 'json';
  dialog.FilterIndex := 1;

  if dialog.Execute then
  begin
    fileName := dialog.Files[0];
  end;

  dialog.Free;

  loadList := TStringList.Create;
  loadList.LoadFromFile(fileName);
  loadText := loadList.Text;
  dm.ReadJSON(loadText);

  loadList.Free;
end;

procedure TfMain.menuItemSaveClick(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  //basic save system for now, no worries about overwriting or whatever
  dialog := TSaveDialog.Create(self);
  dialog.InitialDir := GetCurrentDir;
  dialog.Filter := 'JSON Files (*.json)|*.json';
  dialog.DefaultExt := 'json';
  dialog.FilterIndex := 1;

  if dialog.Execute then
  begin
    fileName := dialog.Files[0];
    HandleSave;
  end;

  dialog.Free;
end;

procedure TfMain.menuItemSaveAsClick(Sender: TObject);
begin
  //text
end;

procedure TfMain.HandleSave;
var
  saveText: String;
  saveList: TStringList;
begin
  saveText := dm.WriteJSON;
  saveList := TStringList.Create;
  saveList.Add(saveText);

  saveList.SaveToFile(fileName);
  saveList.Free;
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
