object fManageAlbum: TfManageAlbum
  Left = 0
  Top = 0
  Caption = 'Manage Albums'
  ClientHeight = 401
  ClientWidth = 257
  Color = clBtnFace
  Constraints.MinHeight = 440
  Constraints.MinWidth = 273
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    257
    401)
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
  object cbBands: TComboBox
    Left = 23
    Top = 27
    Width = 210
    Height = 21
    Anchors = [akTop]
    TabOrder = 0
  end
  object cbAlbums: TComboBox
    Left = 23
    Top = 83
    Width = 210
    Height = 21
    Anchors = [akTop]
    TabOrder = 1
  end
  object cbFavorite: TCheckBox
    Left = 120
    Top = 128
    Width = 113
    Height = 17
    Anchors = [akTop]
    Caption = 'Album is a favorite'
    TabOrder = 2
  end
  object edTags: TMemo
    Left = 23
    Top = 179
    Width = 210
    Height = 78
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object btnSave: TButton
    Left = 23
    Top = 335
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 4
    ExplicitTop = 315
  end
  object btnDelete: TButton
    Left = 23
    Top = 366
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Album'
    TabOrder = 5
    ExplicitTop = 346
  end
  object edYear: TEdit
    Left = 55
    Top = 126
    Width = 59
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object btnApplyBand: TButton
    Left = 23
    Top = 263
    Width = 210
    Height = 25
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Apply Tags to This Album'#39's Band'
    TabOrder = 7
  end
  object btnApplySong: TButton
    Left = 23
    Top = 294
    Width = 210
    Height = 25
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Apply Tags to All This Album'#39's Songs'
    TabOrder = 8
  end
end
