program Farmacia;

uses
  Vcl.Forms,
  uFrmPrincipal in 'view\uFrmPrincipal.pas' {frmPrincipal},
  uProcedimentoModel in 'model\uProcedimentoModel.pas',
  uServicoModel in 'model\uServicoModel.pas',
  uServicoProcedimentoModel in 'model\uServicoProcedimentoModel.pas',
  uDMDataBase in 'dao\uDMDataBase.pas' {dmDataBase: TDataModule},
  uProcedimentoDao in 'dao\uProcedimentoDao.pas' {$R *.res},
  uServicoDao in 'dao\uServicoDao.pas',
  uProcedimentoControler in 'controler\uProcedimentoControler.pas',
  uServicoControler in 'controler\uServicoControler.pas',
  uFrmProcedimento in 'view\uFrmProcedimento.pas' {FrmProcedimento},
  uFrmServico in 'view\uFrmServico.pas' {FrmServico},
  uPadraoDao in 'dao\uPadraoDao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmDataBase, dmDataBase);
  Application.Run;
end.
