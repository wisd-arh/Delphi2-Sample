object Form1: TForm1
  Left = 181
  Top = 106
  Width = 689
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    681
    434)
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 681
    Height = 409
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 7
    Ctl3D = False
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goAlwaysShowEditor]
    ParentCtl3D = False
    TabOrder = 0
    ColWidths = (
      64
      102
      100
      133
      93
      176
      64)
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 415
    Width = 681
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 168
    Top = 376
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        ShortCut = 16463
        OnClick = N2Click
      end
      object N14: TMenuItem
        Caption = #1042#1099#1075#1088#1091#1079#1082#1072
        ShortCut = 113
        OnClick = N14Click
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object N18: TMenuItem
        Caption = #1069#1082#1089#1090#1088#1072#1082#1094#1080#1103
        OnClick = N18Click
      end
    end
    object N3: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      object N4: TMenuItem
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1094#1077#1085#1091
        OnClick = N4Click
      end
      object N9: TMenuItem
        Caption = #1055#1086#1080#1089#1082' '#1072#1088#1090#1077#1092#1072#1082#1090#1086#1074
        ShortCut = 16454
        OnClick = N9Click
      end
      object N10: TMenuItem
        Caption = #1048#1089#1082#1072#1090#1100' '#1076#1072#1083#1100#1096#1077
        ShortCut = 114
        OnClick = N10Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object N6: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1079#1072#1087#1088#1086#1089
        OnClick = N6Click
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object N15: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        ShortCut = 16464
        OnClick = N15Click
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object Reloadaftercrash1: TMenuItem
        Caption = 'Reload after crash'
        OnClick = Reloadaftercrash1Click
      end
    end
    object N7: TMenuItem
      Caption = #1052#1072#1089#1090#1077#1088
      object N8: TMenuItem
        Caption = #1052#1072#1089#1090#1077#1088' '#1082#1086#1085#1074#1077#1088#1090#1072#1094#1080#1080
        ShortCut = 120
        OnClick = N8Click
      end
      object N11: TMenuItem
        Caption = #1055#1077#1088#1077#1074#1086#1076' '#1085#1072#1079#1074#1072#1085#1080#1081
        ShortCut = 121
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = #1057#1076#1074#1080#1075
        ShortCut = 122
        OnClick = N12Click
      end
      object N13: TMenuItem
        Caption = #1053#1086#1088#1084#1072#1083#1080#1079#1072#1094#1080#1103' '#1080#1084#1077#1085
        ShortCut = 123
        OnClick = N13Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.txt|*.txt'
    Left = 120
    Top = 376
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'Text files|*.txt'
    Left = 208
    Top = 376
  end
end
