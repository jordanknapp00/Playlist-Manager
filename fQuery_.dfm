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
  object pnlSelectFrom: TPanel
    Left = 8
    Top = 8
    Width = 185
    Height = 49
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Select'
    TabOrder = 0
    VerticalAlignment = taAlignTop
    object cbBands: TCheckBox
      Left = 8
      Top = 24
      Width = 49
      Height = 17
      Caption = 'Bands'
      TabOrder = 0
      OnClick = SelectChange
    end
    object cbAlbums: TCheckBox
      Left = 63
      Top = 24
      Width = 66
      Height = 17
      Caption = 'Albums'
      TabOrder = 1
      OnClick = SelectChange
    end
    object cbSongs: TCheckBox
      Left = 127
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Songs'
      TabOrder = 2
      OnClick = SelectChange
    end
  end
  object btnLoadQuery: TButton
    Left = 207
    Top = 8
    Width = 130
    Height = 49
    Anchors = [akTop, akRight]
    Caption = 'Load Query from File'
    TabOrder = 1
    WordWrap = True
  end
  object btnSaveQuery: TButton
    Left = 343
    Top = 8
    Width = 130
    Height = 49
    Anchors = [akTop, akRight]
    Caption = 'Save Query to File'
    TabOrder = 2
    WordWrap = True
  end
  object pnlBands: TPanel
    Left = 8
    Top = 63
    Width = 465
    Height = 138
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Bands'
    TabOrder = 3
    VerticalAlignment = taAlignTop
    Visible = False
    DesignSize = (
      465
      138)
    object Label1: TLabel
      Left = 8
      Top = 25
      Width = 92
      Height = 13
      Caption = 'Enter Band Names:'
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
      Top = 40
      Width = 122
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Select only favorites'
      TabOrder = 1
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
    TabOrder = 4
    VerticalAlignment = taAlignTop
    Visible = False
    DesignSize = (
      465
      170)
    object Label2: TLabel
      Left = 8
      Top = 27
      Width = 97
      Height = 13
      Caption = 'Enter Album Names:'
    end
    object lblYear: TLabel
      Left = 346
      Top = 49
      Width = 55
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Enter Year:'
      Visible = False
    end
    object Label3: TLabel
      Left = 199
      Top = 106
      Width = 125
      Height = 44
      Caption = 
        'Whether albums queried must match both album name AND year, or j' +
        'ust one OR the other.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object edAlbums: TMemo
      Left = 8
      Top = 46
      Width = 185
      Height = 91
      Anchors = [akLeft, akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object rgAlbumYear: TRadioGroup
      Left = 199
      Top = 40
      Width = 130
      Height = 60
      Anchors = [akTop, akRight]
      Caption = 'Name (And/Or) Year'
      ItemIndex = 0
      Items.Strings = (
        'AND'
        'OR')
      TabOrder = 1
      WordWrap = True
      OnClick = rgAlbumYearClick
    end
    object edYear: TEdit
      Left = 407
      Top = 46
      Width = 49
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      Visible = False
    end
    object cbAlbumFav: TCheckBox
      Left = 8
      Top = 143
      Width = 121
      Height = 17
      Caption = 'Select only favorites'
      TabOrder = 3
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
    TabOrder = 5
    VerticalAlignment = taAlignTop
    Visible = False
    DesignSize = (
      465
      178)
    object Label5: TLabel
      Left = 8
      Top = 25
      Width = 92
      Height = 13
      Caption = 'Enter Song Names:'
    end
    object lblTrackNum: TLabel
      Left = 343
      Top = 47
      Width = 75
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Enter Track No.'
      Visible = False
    end
    object Label4: TLabel
      Left = 207
      Top = 111
      Width = 130
      Height = 34
      Caption = 
        'Whether songs queried must match both song name AND year, or jus' +
        't one OR the other.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object edSongs: TMemo
      Left = 8
      Top = 44
      Width = 185
      Height = 101
      Anchors = [akLeft, akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object rgSongTrackNo: TRadioGroup
      Left = 207
      Top = 43
      Width = 130
      Height = 62
      Anchors = [akTop, akRight]
      Caption = 'Name (And/Or) Track'
      ItemIndex = 0
      Items.Strings = (
        'AND'
        'OR')
      TabOrder = 1
      WordWrap = True
      OnClick = rgSongTrackNoClick
    end
    object edTrackNum: TEdit
      Left = 423
      Top = 44
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      Visible = False
    end
    object cbSongFav: TCheckBox
      Left = 8
      Top = 151
      Width = 121
      Height = 17
      Caption = 'Select only favorites'
      TabOrder = 3
    end
  end
  object btnQuery: TButton
    Left = 8
    Top = 567
    Width = 465
    Height = 58
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Query!'
    TabOrder = 6
    Visible = False
    OnClick = btnQueryClick
  end
end
