object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Farm'#225'cia'
  ClientHeight = 438
  ClientWidth = 814
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnCadastro: TButton
    Left = 264
    Top = 16
    Width = 137
    Height = 73
    Caption = 'Cadastro Procedimentos'
    TabOrder = 0
    OnClick = btnCadastroClick
  end
  object btnServicoFarmaceutico: TButton
    Left = 407
    Top = 16
    Width = 137
    Height = 73
    Caption = 'Servi'#231'o Farmaceutico'
    TabOrder = 1
    OnClick = btnServicoFarmaceuticoClick
  end
end
