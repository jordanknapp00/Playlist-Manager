object fManageAlbum: TfManageAlbum
  Left = 0
  Top = 0
  Caption = 'Manage Albums'
  ClientHeight = 457
  ClientWidth = 257
  Color = clBtnFace
  Constraints.MinHeight = 496
  Constraints.MinWidth = 273
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    257
    457)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 23
    Top = 8
    Width = 210
    Height = 13
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'Select Band Whose Albums Will be Modified:'
  end
  object Label2: TLabel
    Left = 23
    Top = 64
    Width = 113
    Height = 13
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'Select Album to Modify:'
  end
  object Label3: TLabel
    Left = 23
    Top = 160
    Width = 201
    Height = 13
    Anchors = [akTop]
    Caption = 'Enter Tags (put each one on its own line):'
  end
  object Label4: TLabel
    Left = 23
    Top = 129
    Width = 26
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Year:'
  end
  object Label5: TLabel
    Left = 23
    Top = 331
    Width = 130
    Height = 13
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Select Color for this Album:'
  end
  object luBands: TComboBox
    Left = 23
    Top = 27
    Width = 210
    Height = 21
    Anchors = [akTop]
    TabOrder = 0
    OnChange = luBandsChange
  end
  object luAlbums: TComboBox
    Left = 23
    Top = 83
    Width = 210
    Height = 21
    Anchors = [akTop]
    TabOrder = 1
    OnChange = luAlbumsChange
  end
  object cbFavorite: TCheckBox
    Left = 120
    Top = 128
    Width = 113
    Height = 17
    Anchors = [akTop]
    Caption = 'Album is a favorite'
    TabOrder = 2
    OnClick = DetermineNeedSave
  end
  object textBox: TMemo
    Left = 23
    Top = 179
    Width = 210
    Height = 78
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
    WordWrap = False
    OnChange = DetermineNeedSave
  end
  object btnSave: TButton
    Left = 23
    Top = 391
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 4
    OnClick = btnSaveClick
    ExplicitTop = 335
  end
  object btnDelete: TButton
    Left = 23
    Top = 422
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Album'
    TabOrder = 5
    OnClick = btnDeleteClick
    ExplicitTop = 366
  end
  object edYear: TEdit
    Left = 55
    Top = 126
    Width = 59
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 6
  end
  object btnApplyBand: TButton
    Left = 23
    Top = 263
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Apply Tags to This Album'#39's Band'
    TabOrder = 7
    OnClick = btnApplyBandClick
  end
  object btnApplySong: TButton
    Left = 23
    Top = 294
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Apply Tags to All This Album'#39's Songs'
    TabOrder = 8
    OnClick = btnApplySongClick
  end
  object luColor: TColorBox
    Left = 23
    Top = 350
    Width = 201
    Height = 22
    DefaultColorColor = clWhite
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 9
    OnChange = DetermineNeedSave
  end
end
