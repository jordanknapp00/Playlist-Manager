object fAddSong: TfAddSong
  Left = 0
  Top = 0
  Caption = 'Add Song(s)'
  ClientHeight = 295
  ClientWidth = 372
  Color = clBtnFace
  Constraints.MinHeight = 334
  Constraints.MinWidth = 388
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    372
    295)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 192
    Top = 8
    Width = 129
    Height = 13
    Alignment = taCenter
    Anchors = [akTop, akRight]
    Caption = 'Select an Album (optional):'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 105
    Height = 13
    Caption = 'Enter Song(s) to Add:'
  end
  object Label3: TLabel
    Left = 248
    Top = 72
    Width = 104
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Enter Track Numbers:'
  end
  object Label4: TLabel
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Alignment = taCenter
    Caption = 'Select a Band:'
  end
  object lblUseNA: TLabel
    Left = 192
    Top = 48
    Width = 3
    Height = 13
    Anchors = [akTop, akRight]
  end
  object cbAlbums: TComboBox
    Left = 192
    Top = 27
    Width = 172
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 0
    OnChange = cbAlbumsChange
    Items.Strings = (
      'N/A')
  end
  object textBoxSongs: TMemo
    Left = 8
    Top = 91
    Width = 217
    Height = 150
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'textBoxAlbums')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object btnAddSongs: TButton
    Left = 8
    Top = 262
    Width = 356
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Add Song(s)'
    TabOrder = 2
    OnClick = btnAddSongsClick
  end
  object textBoxTrackNums: TMemo
    Left = 248
    Top = 91
    Width = 116
    Height = 150
    Anchors = [akTop, akRight, akBottom]
    Lines.Strings = (
      'textBoxYears')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object cbBands: TComboBox
    Left = 8
    Top = 27
    Width = 169
    Height = 21
    TabOrder = 4
    OnChange = cbBandsChange
  end
end
