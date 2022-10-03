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
  OnCloseQuery = FormCloseQuery
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
    Width = 265
    Height = 87
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Query'
    TabOrder = 0
    OnClick = btnQueryClick
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
  end
  object btnManageBand: TButton
    Left = 572
    Top = 428
    Width = 120
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Manage Bands'
    TabOrder = 4
    OnClick = btnManageBandClick
  end
  object btnManageAlbum: TButton
    Left = 572
    Top = 459
    Width = 120
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Manage Albums'
    TabOrder = 5
    OnClick = btnManageAlbumClick
  end
  object btnManageSongs: TButton
    Left = 572
    Top = 490
    Width = 120
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Manage Songs'
    TabOrder = 6
    OnClick = btnManageSongsClick
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
  end
  object btnClear: TButton
    Left = 279
    Top = 428
    Width = 54
    Height = 87
    Caption = 'Clear Queried Results / Refresh Table'
    TabOrder = 8
    WordWrap = True
    OnClick = btnClearClick
  end
  object menuBar: TMainMenu
    Left = 552
    Top = 80
    object menuFile: TMenuItem
      Caption = 'File'
      object menuItemNew: TMenuItem
        Caption = 'New'
        OnClick = menuItemNewClick
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
        OnClick = menuItemExitClick
      end
    end
    object menuExport: TMenuItem
      Caption = 'Export'
      object menuItemExportTXT: TMenuItem
        Caption = 'Export as .txt'
        OnClick = menuItemExportTXTClick
      end
      object menuItemExportCSV: TMenuItem
        Caption = 'Export as .csv'
        OnClick = menuItemExportCSVClick
      end
      object menuItemExportXLSX: TMenuItem
        Caption = 'Export as .xlsx'
        OnClick = menuItemExportXLSXClick
      end
    end
    object menuHelp: TMenuItem
      Caption = 'Help'
      object menuItemStats: TMenuItem
        Caption = 'Statistics'
        OnClick = menuItemStatsClick
      end
      object menuItemAbout: TMenuItem
        Caption = 'About'
        OnClick = menuItemAboutClick
      end
    end
  end
end
