object fManageAlbum: TfManageAlbum
  Left = 0
  Top = 0
  Caption = 'Manage Albums'
  ClientHeight = 381
  ClientWidth = 257
  Color = clBtnFace
  Constraints.MinHeight = 420
  Constraints.MinWidth = 273
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    257
    381)
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
    Width = 210
    Height = 13
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'Select Album to Modify:'
  end
  object Label3: TLabel
    Left = 23
    Top = 200
    Width = 210
    Height = 13
    Anchors = [akTop]
    Caption = 'Enter Tags (put each one on its own line):'
  end
  object Label4: TLabel
    Left = 23
    Top = 168
    Width = 58
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Album Year:'
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
    Left = 23
    Top = 136
    Width = 210
    Height = 17
    Anchors = [akTop]
    Caption = 'Album is a favorite'
    TabOrder = 2
  end
  object edTags: TMemo
    Left = 23
    Top = 219
    Width = 210
    Height = 78
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object btnSave: TButton
    Left = 23
    Top = 315
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 4
    ExplicitTop = 320
  end
  object btnDelete: TButton
    Left = 23
    Top = 346
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Album'
    TabOrder = 5
    ExplicitTop = 351
  end
  object edYear: TEdit
    Left = 87
    Top = 165
    Width = 146
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
end
