object fManageBand: TfManageBand
  Left = 0
  Top = 0
  Caption = 'Manage Bands'
  ClientHeight = 311
  ClientWidth = 247
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 263
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    247
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 23
    Top = 8
    Width = 201
    Height = 13
    Alignment = taCenter
    Anchors = [akTop]
    Caption = 'Select a Band to Modify:'
  end
  object Label2: TLabel
    Left = 23
    Top = 120
    Width = 201
    Height = 13
    Anchors = [akTop]
    Caption = 'Enter Tags (put each one on its own line):'
  end
  object cbBands: TComboBox
    Left = 23
    Top = 27
    Width = 201
    Height = 21
    Anchors = [akTop]
    TabOrder = 0
  end
  object cbFavorite: TCheckBox
    Left = 23
    Top = 80
    Width = 201
    Height = 17
    Anchors = [akTop]
    Caption = 'Band is a favorite'
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 23
    Top = 139
    Width = 201
    Height = 86
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object btnSave: TButton
    Left = 23
    Top = 246
    Width = 201
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 3
    ExplicitTop = 293
  end
  object btnDelete: TButton
    Left = 23
    Top = 278
    Width = 201
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Band'
    TabOrder = 4
    ExplicitTop = 325
  end
end
