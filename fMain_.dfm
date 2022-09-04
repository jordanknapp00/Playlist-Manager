object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Playlist Manager'
  ClientHeight = 525
  ClientWidth = 700
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menuBar
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    700
    525)
  PixelsPerInch = 96
  TextHeight = 13
  object btnQuery: TButton
    Left = 8
    Top = 430
    Width = 317
    Height = 87
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Query'
    TabOrder = 0
    ExplicitTop = 417
    ExplicitWidth = 217
  end
  object btnAddBand: TButton
    Left = 340
    Top = 428
    Width = 216
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Add Band(s)'
    TabOrder = 1
    OnClick = btnAddBandClick
    ExplicitLeft = 240
    ExplicitTop = 415
  end
  object btnAddAlbum: TButton
    Left = 340
    Top = 459
    Width = 216
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Add Album(s) from a Band'
    TabOrder = 2
    OnClick = btnAddAlbumClick
    ExplicitLeft = 240
    ExplicitTop = 453
  end
  object btnAddSongs: TButton
    Left = 340
    Top = 490
    Width = 216
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Add Song(s) from an Album'
    TabOrder = 3
    OnClick = btnAddSongsClick
    ExplicitLeft = 240
    ExplicitTop = 477
  end
  object btnDeleteBand: TButton
    Left = 572
    Top = 428
    Width = 120
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Delete Band(s)'
    TabOrder = 4
    ExplicitLeft = 472
    ExplicitTop = 415
  end
  object btnDeleteAlbum: TButton
    Left = 572
    Top = 459
    Width = 120
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Delete Album(s)'
    TabOrder = 5
    ExplicitLeft = 472
    ExplicitTop = 446
  end
  object btnDeleteSong: TButton
    Left = 572
    Top = 492
    Width = 120
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Delete Song(s)'
    TabOrder = 6
    ExplicitLeft = 472
    ExplicitTop = 486
  end
  object grid: TStringGrid
    Left = 8
    Top = 8
    Width = 684
    Height = 410
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 8
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnDrawCell = gridDrawCell
    ExplicitWidth = 584
    ExplicitHeight = 393
  end
  object menuBar: TMainMenu
    Left = 552
    Top = 80
    object menuFile: TMenuItem
      Caption = 'File'
      object menuItemNew: TMenuItem
        Caption = 'New'
      end
      object menuItemLoad: TMenuItem
        Caption = 'Load'
        OnClick = menuItemLoadClick
      end
      object menuItemSave: TMenuItem
        Caption = 'Save'
        OnClick = menuItemSaveClick
      end
      object menuItemSaveAs: TMenuItem
        Caption = 'Save As'
        OnClick = menuItemSaveAsClick
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
      object menuItemStats: TMenuItem
        Caption = 'Statistics'
        OnClick = menuItemStatsClick
      end
      object menuItemAbout: TMenuItem
        Caption = 'About'
      end
    end
  end
end
