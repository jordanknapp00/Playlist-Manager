object fManageSong: TfManageSong
  Left = 0
  Top = 0
  Caption = 'Manage Songs'
  ClientHeight = 441
  ClientWidth = 257
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 273
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    257
    441)
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
    Caption = 'Select Album Whose Songs Will be Modified:'
  end
  object Label3: TLabel
    Left = 23
    Top = 120
    Width = 210
    Height = 13
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'Select Song to Modify:'
  end
  object Label4: TLabel
    Left = 23
    Top = 256
    Width = 201
    Height = 13
    Anchors = [akTop]
    Caption = 'Enter Tags (put each one on its own line):'
  end
  object Label5: TLabel
    Left = 23
    Top = 224
    Width = 97
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Song Track Number:'
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
  object cbSongs: TComboBox
    Left = 23
    Top = 139
    Width = 210
    Height = 21
    Anchors = [akTop]
    TabOrder = 2
  end
  object cbFavorite: TCheckBox
    Left = 23
    Top = 198
    Width = 210
    Height = 17
    Anchors = [akTop]
    Caption = 'Song is a favorite'
    TabOrder = 3
  end
  object edTags: TMemo
    Left = 23
    Top = 275
    Width = 210
    Height = 78
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
    ExplicitHeight = 86
  end
  object btnSave: TButton
    Left = 23
    Top = 376
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 5
    ExplicitTop = 384
  end
  object btnDelete: TButton
    Left = 23
    Top = 408
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Song'
    TabOrder = 6
    ExplicitTop = 416
  end
  object edTrackNo: TEdit
    Left = 126
    Top = 221
    Width = 107
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
  end
end
