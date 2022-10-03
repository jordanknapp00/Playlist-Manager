object fQuery: TfQuery
  Left = 0
  Top = 0
  Caption = 'Query'
  ClientHeight = 633
  ClientWidth = 481
  Color = clBtnFace
  Constraints.MinHeight = 672
  Constraints.MinWidth = 497
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    481
    633)
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 10
    Top = 8
    Width = 279
    Height = 26
    Anchors = [akLeft, akTop, akRight]
    Caption = 
      'Leave text fields blank to not use. i.e. Leave band names blank ' +
      'to select all bands.'
    WordWrap = True
  end
  object btnLoadQuery: TButton
    Left = 313
    Top = 8
    Width = 81
    Height = 49
    Anchors = [akTop, akRight]
    Caption = 'Load Query from File'
    TabOrder = 0
    WordWrap = True
    OnClick = btnLoadQueryClick
  end
  object btnSaveQuery: TButton
    Left = 400
    Top = 8
    Width = 73
    Height = 49
    Anchors = [akTop, akRight]
    Caption = 'Save Query to File'
    TabOrder = 1
    WordWrap = True
    OnClick = btnSaveQueryClick
  end
  object pnlBands: TPanel
    Left = 8
    Top = 63
    Width = 465
    Height = 138
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Bands'
    TabOrder = 2
    VerticalAlignment = taAlignTop
    DesignSize = (
      465
      138)
    object Label1: TLabel
      Left = 8
      Top = 29
      Width = 92
      Height = 13
      Caption = 'Enter Band Names:'
    end
    object Label3: TLabel
      Left = 319
      Top = 29
      Width = 83
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Enter Band Tags:'
    end
    object edBands: TMemo
      Left = 8
      Top = 44
      Width = 185
      Height = 89
      Anchors = [akLeft, akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object cbBandFav: TCheckBox
      Left = 199
      Top = 44
      Width = 114
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Select only favorites'
      TabOrder = 1
    end
    object edBandTags: TMemo
      Left = 320
      Top = 44
      Width = 138
      Height = 89
      Anchors = [akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 2
    end
    object rgBandMatch: TRadioGroup
      Left = 199
      Top = 67
      Width = 115
      Height = 66
      Anchors = [akTop, akRight]
      Caption = 'Match ALL Tags?'
      ItemIndex = 0
      Items.Strings = (
        'Match All'
        'Match Only One')
      TabOrder = 3
    end
  end
  object pnlAlbums: TPanel
    Left = 8
    Top = 207
    Width = 465
    Height = 170
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Albums'
    TabOrder = 3
    VerticalAlignment = taAlignTop
    DesignSize = (
      465
      170)
    object Label2: TLabel
      Left = 8
      Top = 31
      Width = 97
      Height = 13
      Caption = 'Enter Album Names:'
    end
    object lblYear: TLabel
      Left = 201
      Top = 48
      Width = 55
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Enter Year:'
    end
    object Label4: TLabel
      Left = 319
      Top = 31
      Width = 88
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Enter Album Tags:'
    end
    object edAlbums: TMemo
      Left = 8
      Top = 46
      Width = 185
      Height = 115
      Anchors = [akLeft, akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object edYear: TEdit
      Left = 264
      Top = 45
      Width = 49
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object cbAlbumFav: TCheckBox
      Left = 199
      Top = 72
      Width = 121
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Select only favorites'
      TabOrder = 2
    end
    object edAlbumTags: TMemo
      Left = 319
      Top = 46
      Width = 139
      Height = 115
      Anchors = [akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 3
    end
    object rgAlbumMatch: TRadioGroup
      Left = 198
      Top = 95
      Width = 115
      Height = 66
      Anchors = [akTop, akRight]
      Caption = 'Match ALL Tags?'
      ItemIndex = 0
      Items.Strings = (
        'Match All'
        'Match Only One')
      TabOrder = 4
    end
    object cbNAalbums: TCheckBox
      Left = 320
      Top = 8
      Width = 122
      Height = 17
      Caption = 'Include "N/A" albums'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object pnlSongs: TPanel
    Left = 8
    Top = 383
    Width = 465
    Height = 178
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Songs'
    TabOrder = 4
    VerticalAlignment = taAlignTop
    DesignSize = (
      465
      178)
    object Label5: TLabel
      Left = 8
      Top = 29
      Width = 92
      Height = 13
      Caption = 'Enter Song Names:'
    end
    object lblTrackNum: TLabel
      Left = 199
      Top = 48
      Width = 75
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Enter Track No.'
    end
    object Label7: TLabel
      Left = 319
      Top = 29
      Width = 83
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Enter Song Tags:'
    end
    object edSongs: TMemo
      Left = 8
      Top = 44
      Width = 185
      Height = 125
      Anchors = [akLeft, akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object edTrackNum: TEdit
      Left = 280
      Top = 44
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object cbSongFav: TCheckBox
      Left = 199
      Top = 80
      Width = 121
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Select only favorites'
      TabOrder = 2
    end
    object edSongTags: TMemo
      Left = 319
      Top = 44
      Width = 139
      Height = 125
      Anchors = [akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 3
    end
    object rgSongMatch: TRadioGroup
      Left = 198
      Top = 103
      Width = 115
      Height = 66
      Anchors = [akTop, akRight]
      Caption = 'Match ALL Tags?'
      ItemIndex = 0
      Items.Strings = (
        'Match All'
        'Match Only One')
      TabOrder = 4
    end
  end
  object btnQuery: TButton
    Left = 8
    Top = 567
    Width = 465
    Height = 58
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Query!'
    TabOrder = 5
    OnClick = btnQueryClick
  end
  object btnClear: TButton
    Left = 8
    Top = 40
    Width = 299
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Clear all fields'
    TabOrder = 6
    OnClick = btnClearClick
  end
end
