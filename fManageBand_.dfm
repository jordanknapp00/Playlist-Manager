object fManageBand: TfManageBand
  Left = 0
  Top = 0
  Caption = 'Manage Bands'
  ClientHeight = 279
  ClientWidth = 247
  Color = clBtnFace
  Constraints.MinHeight = 318
  Constraints.MinWidth = 263
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    247
    279)
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
    Top = 96
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
    Top = 73
    Width = 201
    Height = 17
    Anchors = [akTop]
    Caption = 'Band is a favorite'
    TabOrder = 1
  end
  object edTags: TMemo
    Left = 23
    Top = 115
    Width = 201
    Height = 80
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'edTags')
    TabOrder = 2
    ExplicitHeight = 62
  end
  object btnSave: TButton
    Left = 23
    Top = 214
    Width = 201
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Save'
    TabOrder = 3
    ExplicitTop = 196
  end
  object btnDelete: TButton
    Left = 23
    Top = 246
    Width = 201
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Delete Selected Band'
    TabOrder = 4
    ExplicitTop = 228
  end
end
