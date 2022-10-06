object fAddAlbum: TfAddAlbum
  Left = 0
  Top = 0
  Caption = 'Add Album(s)'
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
    Left = 103
    Top = 8
    Width = 164
    Height = 13
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'Select a Band to Add Album(s) To:'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 110
    Height = 13
    Caption = 'Enter Album(s) to Add:'
  end
  object Label3: TLabel
    Left = 248
    Top = 72
    Width = 116
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Enter Years For Albums:'
  end
  object cbBands: TComboBox
    Left = 103
    Top = 27
    Width = 178
    Height = 21
    Anchors = [akTop]
    TabOrder = 0
    OnChange = cbBandsChange
  end
  object textBoxAlbums: TMemo
    Left = 8
    Top = 91
    Width = 217
    Height = 150
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'textBoxAlbums')
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object btnAddAlbum: TButton
    Left = 8
    Top = 256
    Width = 356
    Height = 31
    Anchors = [akLeft, akRight]
    Caption = 'Add Album(s)'
    TabOrder = 2
    OnClick = btnAddAlbumClick
  end
  object textBoxYears: TMemo
    Left = 248
    Top = 91
    Width = 116
    Height = 150
    Anchors = [akTop, akRight, akBottom]
    Lines.Strings = (
      'textBoxYears')
    ScrollBars = ssVertical
    TabOrder = 3
    WordWrap = False
  end
end
