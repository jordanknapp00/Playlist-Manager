object fManageBand: TfManageBand
  Left = 0
  Top = 0
  Caption = 'Manage Bands'
  ClientHeight = 344
  ClientWidth = 247
  Color = clBtnFace
  Constraints.MinHeight = 383
  Constraints.MinWidth = 263
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
    247
    344)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 23
    Top = 8
    Width = 117
    Height = 13
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'Select a Band to Modify:'
  end
  object Label2: TLabel
    Left = 23
    Top = 96
    Width = 201
    Height = 13
    Anchors = [akTop]
    Caption = 'Enter Tags (put each one on its own line):'
  end
  object luBands: TComboBox
    Left = 23
    Top = 27
    Width = 201
    Height = 21
    Anchors = [akTop]
    TabOrder = 0
    OnChange = luBandsChange
  end
  object cbFavorite: TCheckBox
    Left = 23
    Top = 73
    Width = 201
    Height = 17
    Anchors = [akTop]
    Caption = 'Band is a favorite'
    TabOrder = 1
    OnClick = DetermineNeedSave
  end
  object textBox: TMemo
    Left = 23
    Top = 115
    Width = 201
    Height = 82
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'edTags')
    TabOrder = 2
    OnChange = DetermineNeedSave
    ExplicitHeight = 80
  end
  object btnSave: TButton
    Left = 23
    Top = 280
    Width = 201
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 3
    OnClick = btnSaveClick
    ExplicitTop = 297
  end
  object btnDelete: TButton
    Left = 23
    Top = 311
    Width = 201
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Band'
    TabOrder = 4
    OnClick = btnDeleteClick
    ExplicitTop = 246
  end
  object btnApplyAlbums: TButton
    Left = 23
    Top = 201
    Width = 201
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Apply Tags to All This Band'#39's Albums'
    TabOrder = 5
    OnClick = btnApplyAlbumsClick
  end
  object btnApplySongs: TButton
    Left = 23
    Top = 232
    Width = 201
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Apply Tags to All This Band'#39's Songs'
    TabOrder = 6
    OnClick = btnApplySongsClick
  end
end
