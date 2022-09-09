object fManageAlbum: TfManageAlbum
  Left = 0
  Top = 0
  Caption = 'Manage Albums'
  ClientHeight = 408
  ClientWidth = 257
  Color = clBtnFace
  Constraints.MinHeight = 447
  Constraints.MinWidth = 273
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    257
    408)
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
    Top = 216
    Width = 210
    Height = 13
    Anchors = [akTop]
    Caption = 'Enter Tags (put each one on its own line):'
  end
  object Label4: TLabel
    Left = 23
    Top = 176
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
  object ComboBox1: TComboBox
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
  object Memo1: TMemo
    Left = 23
    Top = 235
    Width = 210
    Height = 86
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object btnSave: TButton
    Left = 23
    Top = 344
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 4
  end
  object btnDelete: TButton
    Left = 23
    Top = 375
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Band'
    TabOrder = 5
  end
  object edYear: TEdit
    Left = 87
    Top = 173
    Width = 146
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
end
