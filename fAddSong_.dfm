object fAddSong: TfAddSong
  Left = 0
  Top = 0
  Caption = 'Add Song(s)'
  ClientHeight = 295
  ClientWidth = 372
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
  object Label1: TLabel
    Left = 194
    Top = 8
    Width = 170
    Height = 13
    Alignment = taCenter
    Caption = 'Select an Album to Add Song(s) To:'
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
    Caption = 'Enter Track Numbers:'
  end
  object Label4: TLabel
    Left = 8
    Top = 8
    Width = 118
    Height = 13
    Alignment = taCenter
    Caption = 'Select a Band (optional):'
  end
  object cbAlbums: TComboBox
    Left = 194
    Top = 27
    Width = 170
    Height = 21
    TabOrder = 0
  end
  object textBoxSongs: TMemo
    Left = 8
    Top = 91
    Width = 217
    Height = 150
    Lines.Strings = (
      'textBoxAlbums')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object btnAddSongs: TButton
    Left = 8
    Top = 256
    Width = 356
    Height = 25
    Caption = 'Add Song(s)'
    TabOrder = 2
  end
  object textBoxTrackNums: TMemo
    Left = 248
    Top = 91
    Width = 116
    Height = 150
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
  end
end
