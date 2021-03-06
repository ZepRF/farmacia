﻿object FrmServico: TFrmServico
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Servi'#231'o Farmaceutico'
  ClientHeight = 493
  ClientWidth = 893
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbInfo: TGroupBox
    Left = 8
    Top = 3
    Width = 760
    Height = 175
    Caption = 'Informa'#231#245'es Gerais'
    Enabled = False
    TabOrder = 0
    object Label1: TLabel
      Left = 143
      Top = 18
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object Observações: TLabel
      Left = 14
      Top = 97
      Width = 63
      Height = 13
      Caption = 'Observa'#231#245'es'
    end
    object edtID: TLabeledEdit
      Left = 15
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 14
      EditLabel.Height = 13
      EditLabel.Caption = 'Id.'
      Enabled = False
      TabOrder = 0
    end
    object edtFarmaceutico: TLabeledEdit
      Left = 15
      Top = 73
      Width = 347
      Height = 21
      EditLabel.Width = 64
      EditLabel.Height = 13
      EditLabel.Caption = 'Farmaceutico'
      TabOrder = 2
    end
    object edtPaciente: TLabeledEdit
      Left = 368
      Top = 73
      Width = 377
      Height = 21
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = 'Paciente'
      TabOrder = 3
    end
    object dtData: TDateTimePicker
      Left = 142
      Top = 32
      Width = 123
      Height = 21
      Date = 44247.000000000000000000
      Time = 0.739695370371919100
      TabOrder = 1
    end
    object mObs: TMemo
      Left = 15
      Top = 111
      Width = 730
      Height = 60
      MaxLength = 500
      TabOrder = 4
    end
  end
  object gbProcedimentos: TGroupBox
    Left = 8
    Top = 184
    Width = 760
    Height = 306
    Align = alCustom
    Caption = 'Procedimentos Executados'
    Enabled = False
    TabOrder = 1
    object lbTotal: TLabel
      Left = 582
      Top = 277
      Width = 28
      Height = 13
      Caption = 'Total:'
    end
    object sgProcedimentosExecutados: TStringGrid
      Left = 13
      Top = 50
      Width = 730
      Height = 220
      ColCount = 4
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 0
      ColWidths = (
        61
        291
        198
        152)
      RowHeights = (
        24
        24)
    end
    object edTotal: TEdit
      Left = 614
      Top = 277
      Width = 129
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object btnAddProcedimento: TButton
      Left = 13
      Top = 19
      Width = 128
      Height = 25
      Caption = 'Adicionar Procedimento'
      TabOrder = 2
      OnClick = btnAddProcedimentoClick
    end
  end
  object pnBottoes: TPanel
    AlignWithMargins = True
    Left = 774
    Top = 3
    Width = 116
    Height = 487
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitHeight = 427
    object btnNovo: TButton
      Left = 0
      Top = 0
      Width = 116
      Height = 25
      Align = alTop
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnFechar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 459
      Width = 110
      Height = 25
      Align = alBottom
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
      ExplicitTop = 399
    end
    object btnSalvar: TButton
      Left = 0
      Top = 25
      Width = 116
      Height = 25
      Align = alTop
      Caption = 'Salvar'
      Enabled = False
      TabOrder = 2
      OnClick = btnSalvarClick
    end
  end
end
