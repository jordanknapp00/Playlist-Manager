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
    Columns = <>
    TabOrder = 0
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
    Left = 376
    Top = 415
    Width = 216
    Height = 25
    Caption = 'Add Band'
    TabOrder = 2
  end
  object btnAddAlbum: TButton
    Left = 376
    Top = 446
    Width = 216
    Height = 25
    Caption = 'Add Album'
    TabOrder = 3
  end
  object btnAddSongs: TButton
    Left = 376
    Top = 477
    Width = 216
    Height = 25
    Caption = 'Add Song(s)'
    TabOrder = 4
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
