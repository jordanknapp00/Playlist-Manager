object fManageSong: TfManageSong
  Left = 0
  Top = 0
  Caption = 'Manage Songs'
  ClientHeight = 470
  ClientWidth = 257
  Color = clBtnFace
  Constraints.MinHeight = 509
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
    470)
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
    Width = 108
    Height = 13
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'Select Song to Modify:'
  end
  object Label4: TLabel
    Left = 23
    Top = 229
    Width = 201
    Height = 13
    Anchors = [akTop]
    Caption = 'Enter Tags (put each one on its own line):'
  end
  object Label5: TLabel
    Left = 23
    Top = 205
    Width = 97
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Song Track Number:'
  end
  object luBands: TComboBox
    Left = 23
    Top = 27
    Width = 210
    Height = 21
    Anchors = [akTop]
    TabOrder = 0
  end
  object luAlbums: TComboBox
    Left = 23
    Top = 83
    Width = 210
    Height = 21
    Anchors = [akTop]
    TabOrder = 1
  end
  object luSongs: TComboBox
    Left = 23
    Top = 139
    Width = 210
    Height = 21
    Anchors = [akTop]
    TabOrder = 2
  end
  object cbFavorite: TCheckBox
    Left = 23
    Top = 182
    Width = 210
    Height = 17
    Anchors = [akTop]
    Caption = 'Song is a favorite'
    TabOrder = 3
  end
  object textBox: TMemo
    Left = 23
    Top = 248
    Width = 210
    Height = 78
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object btnSave: TButton
    Left = 23
    Top = 403
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 5
    ExplicitTop = 405
  end
  object btnDelete: TButton
    Left = 23
    Top = 434
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Song'
    TabOrder = 6
    ExplicitTop = 436
  end
  object edTrackNo: TEdit
    Left = 126
    Top = 202
    Width = 35
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
  end
  object btnApplyAlbum: TButton
    Left = 23
    Top = 332
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Apply Tags to This Song'#39's Album'
    TabOrder = 8
  end
  object btnApplyBand: TButton
    Left = 23
    Top = 363
    Width = 210
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Apply Tags to This Song'#39's Band'
    TabOrder = 9
  end
end
