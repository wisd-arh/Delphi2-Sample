object Form3: TForm3
  Left = 181
  Top = 103
  Width = 404
  Height = 285
  Caption = 'Settings'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 129
    Height = 13
    Caption = #1057#1090#1072#1088#1090#1086#1074#1099#1081' '#1085#1086#1084#1077#1088' '#1079#1072#1087#1080#1089#1080
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 165
    Height = 13
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1081' '#1088#1072#1079#1084#1077#1088' '#1079#1072#1087#1088#1086#1089#1072
  end
  object Edit1: TEdit
    Left = 184
    Top = 16
    Width = 121
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    Text = '5000'
  end
  object Edit2: TEdit
    Left = 184
    Top = 48
    Width = 121
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    Text = '90000'
  end
  object Button1: TButton
    Left = 304
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Close'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
end
