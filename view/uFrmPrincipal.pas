unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    btnCadastro: TButton;
    btnServicoFarmaceutico: TButton;
    procedure btnCadastroClick(Sender: TObject);
    procedure btnServicoFarmaceuticoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation
uses uProcedimentoModel, uFrmProcedimento, uFrmServico;

{$R *.dfm}

procedure TfrmPrincipal.btnCadastroClick(Sender: TObject);
begin
  FrmProcedimento := TFrmProcedimento.Create(self);
  FrmProcedimento.ShowModal;
  FrmProcedimento.Free;
end;

procedure TfrmPrincipal.btnServicoFarmaceuticoClick(Sender: TObject);
begin
  FrmServico := TFrmServico.Create(Self);
  FrmServico.ShowModal;
  FrmServico.Free;
end;

end.
