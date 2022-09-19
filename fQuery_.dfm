object fQuery: TfQuery
  Left = 0
  Top = 0
  Caption = 'Query'
  ClientHeight = 633
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSelectFrom: TPanel
    Left = 8
    Top = 8
    Width = 185
    Height = 49
    Alignment = taLeftJustify
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
    Caption = 'Load Query from File'
    TabOrder = 1
    WordWrap = True
  end
  object btnSaveQuery: TButton
    Left = 343
    Top = 8
    Width = 130
    Height = 49
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
    Caption = '  Bands'
    TabOrder = 3
    VerticalAlignment = taAlignTop
    Visible = False
    object Label1: TLabel
      Left = 8
      Top = 25
      Width = 92
      Height = 13
      Caption = 'Enter Band Names:'
    end
    object edBands: TMemo
      Left = 8
      Top = 40
      Width = 185
      Height = 89
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object cbBandFav: TCheckBox
      Left = 199
      Top = 40
      Width = 122
      Height = 17
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
    Caption = '  Albums'
    TabOrder = 4
    VerticalAlignment = taAlignTop
    Visible = False
    object Label2: TLabel
      Left = 8
      Top = 27
      Width = 97
      Height = 13
      Caption = 'Enter Album Names:'
    end
    object lblYears: TLabel
      Left = 327
      Top = 10
      Width = 130
      Height = 30
      Caption = 'Enter Years for Corresponding Albums:'
      Visible = False
      WordWrap = True
    end
    object lblYear: TLabel
      Left = 327
      Top = 146
      Width = 55
      Height = 13
      Caption = 'Enter Year:'
      Visible = False
    end
    object edAlbums: TMemo
      Left = 8
      Top = 46
      Width = 185
      Height = 91
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object rgAlbumYear: TRadioGroup
      Left = 216
      Top = 32
      Width = 105
      Height = 108
      Caption = 'Query Years By'
      ItemIndex = 0
      Items.Strings = (
        'Don'#39't query by year'
        'Single year'
        'Enter year for each album')
      TabOrder = 1
      WordWrap = True
    end
    object edYears: TMemo
      Left = 327
      Top = 40
      Width = 130
      Height = 97
      TabOrder = 2
      Visible = False
    end
    object edYear: TEdit
      Left = 388
      Top = 143
      Width = 42
      Height = 21
      TabOrder = 3
      Visible = False
    end
    object cbAlbumFav: TCheckBox
      Left = 8
      Top = 143
      Width = 121
      Height = 17
      Caption = 'Select only favorites'
      TabOrder = 4
    end
  end
  object pnlSongs: TPanel
    Left = 8
    Top = 383
    Width = 465
    Height = 178
    Alignment = taLeftJustify
    Caption = '  Songs'
    TabOrder = 5
    VerticalAlignment = taAlignTop
    Visible = False
    object Label5: TLabel
      Left = 8
      Top = 25
      Width = 92
      Height = 13
      Caption = 'Enter Song Names:'
    end
    object lblTrackNums: TLabel
      Left = 352
      Top = 8
      Width = 104
      Height = 39
      Caption = 'Enter Track Nums for Corresponding Songs:'
      Visible = False
      WordWrap = True
    end
    object lblTrackNum: TLabel
      Left = 343
      Top = 146
      Width = 75
      Height = 13
      Caption = 'Enter Track No.'
      Visible = False
    end
    object edSongs: TMemo
      Left = 8
      Top = 44
      Width = 185
      Height = 93
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object rgSongTrackNo: TRadioGroup
      Left = 216
      Top = 40
      Width = 130
      Height = 97
      Caption = 'Query Track No. By'
      ItemIndex = 0
      Items.Strings = (
        'Don'#39't query by track no.'
        'Single track no.'
        'Enter track no. for each song')
      TabOrder = 1
      WordWrap = True
    end
    object edSongTrackNums: TMemo
      Left = 352
      Top = 48
      Width = 105
      Height = 89
      TabOrder = 2
      Visible = False
    end
    object edTrackNum: TEdit
      Left = 424
      Top = 143
      Width = 33
      Height = 21
      TabOrder = 3
      Visible = False
    end
    object cbSongFav: TCheckBox
      Left = 8
      Top = 145
      Width = 121
      Height = 17
      Caption = 'Select only favorites'
      TabOrder = 4
    end
  end
  object btnQuery: TButton
    Left = 8
    Top = 567
    Width = 465
    Height = 58
    Caption = 'Query!'
    TabOrder = 6
    Visible = False
  end
end
