object frmOSD: TfrmOSD
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 220
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'OSD'
  ClientHeight = 96
  ClientWidth = 113
  Color = 1315860
  TransparentColor = True
  TransparentColorValue = 1315860
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  Position = poDefault
  OnPaint = FormPaint
  TextHeight = 15
  object shpBackground: TEsShape
    Left = 0
    Top = 0
    Width = 113
    Height = 96
    Align = alClient
    Brush.Color = clBlack
    Shape = RoundRectangle
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 151
    ExplicitHeight = 139
  end
  object lblKeyInfo: TLabel
    Left = 0
    Top = 0
    Width = 113
    Height = 96
    Align = alClient
    Alignment = taCenter
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    StyleName = 'Windows'
    ExplicitWidth = 18
    ExplicitHeight = 45
  end
  object shpDiode: TEsShape
    Left = 8
    Top = 8
    Width = 15
    Height = 15
    Brush.Color = clGreen
    Shape = Circle
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 72
    Top = 6
  end
end
