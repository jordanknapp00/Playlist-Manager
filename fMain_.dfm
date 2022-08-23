object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Playlist Manager'
  ClientHeight = 594
  ClientWidth = 599
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pageControl: TPageControl
    Left = 0
    Top = 0
    Width = 601
    Height = 505
    ActivePage = tsQuery
    TabOrder = 0
    object tsQuery: TTabSheet
      Caption = 'Query'
      object ListView1: TListView
        Left = 16
        Top = 16
        Width = 561
        Height = 441
        Columns = <
          item
            Caption = 'Num'
          end
          item
            Caption = 'Band'
          end
          item
            Caption = 'Album'
          end
          item
            Caption = 'Song'
          end
          item
            Caption = 'Favorite?'
          end
          item
            Caption = 'Year'
          end>
        TabOrder = 0
      end
    end
    object tsModify: TTabSheet
      Caption = 'Modify'
      ImageIndex = 1
    end
  end
end
