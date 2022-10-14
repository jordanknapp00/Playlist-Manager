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
  KeyPreview = True
  Menu = menuBar
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
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
  object btnClear: TButton
    Left = 279
    Top = 430
    Width = 54
    Height = 87
    Anchors = [akRight, akBottom]
    Caption = 'Clear Queried Results / Refresh Table'
    TabOrder = 7
    WordWrap = True
    OnClick = btnClearClick
  end
  object table: TDBGrid
    Left = 8
    Top = 10
    Width = 684
    Height = 414
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'band'
        Title.Alignment = taCenter
        Title.Caption = 'Band'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold, fsUnderline]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'band_fav'
        Title.Alignment = taCenter
        Title.Caption = 'Fav?'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold, fsUnderline]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'album'
        Title.Alignment = taCenter
        Title.Caption = 'Album'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold, fsUnderline]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'album_fav'
        Title.Alignment = taCenter
        Title.Caption = 'Fav?'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold, fsUnderline]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'year'
        Title.Alignment = taCenter
        Title.Caption = 'Year'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold, fsUnderline]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'song'
        Title.Alignment = taCenter
        Title.Caption = 'Song'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold, fsUnderline]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'song_fav'
        Title.Alignment = taCenter
        Title.Caption = 'Fav?'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold, fsUnderline]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'track_num'
        Title.Alignment = taCenter
        Title.Caption = 'Track No.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold, fsUnderline]
        Visible = True
      end>
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
  object saveDialog: TSaveDialog
    DefaultExt = 'json'
    Filter = 'JSON files (*.json)|*.json'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save As'
    Left = 552
    Top = 216
  end
  object openDialog: TOpenDialog
    DefaultExt = 'json'
    Filter = 'JSON files (*.json)|*.json'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Open'
    Left = 584
    Top = 296
  end
  object saveExportDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save As'
    Left = 504
    Top = 312
  end
  object cds_: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'band;year;album;track_num;song'
    Params = <>
    Left = 240
    Top = 192
    object cds_band: TStringField
      FieldName = 'band'
      Size = 50
    end
    object cds_band_fav: TBooleanField
      FieldName = 'band_fav'
    end
    object cds_album: TStringField
      FieldName = 'album'
      Size = 50
    end
    object cds_album_fav: TBooleanField
      FieldName = 'album_fav'
    end
    object cds_year: TSmallintField
      FieldName = 'year'
    end
    object cds_song: TStringField
      FieldName = 'song'
      Size = 50
    end
    object cds_song_fav: TBooleanField
      FieldName = 'song_fav'
    end
    object cds_track_num: TSmallintField
      FieldName = 'track_num'
    end
  end
  object ds: TDataSource
    DataSet = cds_
    Left = 184
    Top = 280
  end
end
