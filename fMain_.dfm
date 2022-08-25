object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Playlist Manager'
  ClientHeight = 508
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menuBar
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 8
    Top = 8
    Width = 584
    Height = 401
    Columns = <
      item
        Caption = 'Band'
      end
      item
        Caption = 'Album'
      end
      item
        Caption = 'Song'
      end
      item
        Caption = 'Track No.'
      end
      item
        Caption = 'Year'
      end
      item
        Caption = 'Genre(s)'
      end
      item
        Caption = 'Favorite?'
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btnQuery: TButton
    Left = 8
    Top = 415
    Width = 217
    Height = 87
    Caption = 'Query'
    TabOrder = 1
  end
  object btnAddBand: TButton
    Left = 240
    Top = 415
    Width = 216
    Height = 25
    Caption = 'Add Band(s)'
    TabOrder = 2
    OnClick = btnAddBandClick
  end
  object btnAddAlbum: TButton
    Left = 240
    Top = 446
    Width = 216
    Height = 25
    Caption = 'Add Album(s) from a Band'
    TabOrder = 3
    OnClick = btnAddAlbumClick
  end
  object btnAddSongs: TButton
    Left = 240
    Top = 477
    Width = 216
    Height = 25
    Caption = 'Add Song(s) from an Album'
    TabOrder = 4
  end
  object btnDeleteBand: TButton
    Left = 472
    Top = 415
    Width = 120
    Height = 25
    Caption = 'Delete Band(s)'
    TabOrder = 5
  end
  object btnDeleteAlbum: TButton
    Left = 472
    Top = 446
    Width = 120
    Height = 25
    Caption = 'Delete Album(s)'
    TabOrder = 6
  end
  object btnDeleteSong: TButton
    Left = 472
    Top = 477
    Width = 120
    Height = 25
    Caption = 'Delete Song(s)'
    TabOrder = 7
  end
  object menuBar: TMainMenu
    Left = 560
    object menuFile: TMenuItem
      Caption = 'File'
      object menuItemNew: TMenuItem
        Caption = 'New'
      end
      object menuItemLoad: TMenuItem
        Caption = 'Load'
      end
      object menuItemSave: TMenuItem
        Caption = 'Save'
      end
      object menuItemSaveAs: TMenuItem
        Caption = 'Save As'
      end
      object menuItemExit: TMenuItem
        Caption = 'Exit'
      end
    end
    object menuExport: TMenuItem
      Caption = 'Export'
      object menuItemExportTXT: TMenuItem
        Caption = 'Export as .txt'
      end
      object menuItemExportCSV: TMenuItem
        Caption = 'Export as .csv'
      end
      object menuItemExportXLSX: TMenuItem
        Caption = 'Export as .xlsx'
      end
    end
    object menuHelp: TMenuItem
      Caption = 'Help'
      object menuItemHowToUse: TMenuItem
        Caption = 'How to Use This Program'
      end
      object menuItemAbout: TMenuItem
        Caption = 'About'
      end
    end
  end
end
