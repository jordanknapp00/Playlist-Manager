object fAddBand: TfAddBand
  Left = 0
  Top = 0
  Caption = 'Add Band(s)'
  ClientHeight = 230
  ClientWidth = 237
  Color = clBtnFace
  Constraints.MinHeight = 269
  Constraints.MinWidth = 253
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    237
    230)
  PixelsPerInch = 96
  TextHeight = 13
  object lblAddBands: TLabel
    Left = 8
    Top = 8
    Width = 220
    Height = 13
    Caption = 'Add Band(s) -- Put Each One on Its Own Line:'
  end
  object textBox: TMemo
    Left = 8
    Top = 27
    Width = 220
    Height = 158
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'textBox')
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object btnAddBands: TButton
    Left = 8
    Top = 198
    Width = 220
    Height = 24
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Add Band(s)'
    TabOrder = 1
    OnClick = btnAddBandsClick
  end
end
