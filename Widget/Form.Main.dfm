object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Delphos'
  ClientHeight = 541
  ClientWidth = 608
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    608
    541)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 527
    Top = 22
    Width = 66
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Conn'
    TabOrder = 0
    OnClick = Button1Click
  end
  object EditSearchProduto: TEdit
    Left = 8
    Top = 24
    Width = 353
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    TextHint = 'Procurar um Produto...'
  end
  object Edit1: TEdit
    Left = 380
    Top = 24
    Width = 136
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 2
    Text = 'Edit1'
  end
  object MemoLog: TMemo
    Left = 8
    Top = 256
    Width = 585
    Height = 277
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
  end
  object SQLConnection: TSQLConnection
    Left = 192
    Top = 216
  end
  object SQLQuery: TSQLQuery
    Params = <>
    Left = 200
    Top = 280
  end
end
