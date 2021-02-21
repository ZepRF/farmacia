unit uFrmProcedimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids, System.Generics.Collections,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, uProcedimentoControler, uProcedimentoModel,
  Vcl.DBCtrls, Vcl.Mask;

type

  TOperacao = (opNovo, opEditar, opListar, opConsultar);
  TFrmProcedimento = class(TForm)
    pgPrincipal: TPageControl;
    tbListagem: TTabSheet;
    tbDados: TTabSheet;
    pnBottoes: TPanel;
    btnNovo: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    btnConsultar: TButton;
    btnFechar: TButton;
    pnFiltros: TPanel;
    edtConsulta: TLabeledEdit;
    DBGrid1: TDBGrid;
    dsProcedimentos: TDataSource;
    cdsProcedimentos: TClientDataSet;
    cdsProcedimentosid: TIntegerField;
    cdsProcedimentosDescricao: TStringField;
    cdsProcedimentostipo: TIntegerField;
    cdsProcedimentosvalor: TCurrencyField;
    pnBotoesDados: TPanel;
    btSalvar: TButton;
    btCancelar: TButton;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    cbTipo: TComboBox;
    btnSelcionar: TButton;
    procedure btnFecharClick(Sender: TObject);
    procedure cdsProcedimentostipoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cdsProcedimentosBeforeDelete(DataSet: TDataSet);
    procedure btSalvarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure cbTipoChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure cdsProcedimentosAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    controler:TProcedimentoControler;
    procedure AjustaControles(operacao:TOperacao);
    procedure consultar(pDesc:string);
    procedure editar;
    procedure novo;
    procedure excluir;
    procedure salvar;
  public
    { Public declarations }
    operacao:TOperacao;
    model:TProcedimentoModel;
  end;

var
  FrmProcedimento: TFrmProcedimento;

implementation

{$R *.dfm}

procedure TFrmProcedimento.AjustaControles(operacao:TOperacao);
begin
  btnSelcionar.Visible := self.operacao = opConsultar;

  if operacao = opNovo then
  begin
    cbTipo.ItemIndex := -1;
    pgPrincipal.ActivePage := tbDados;
    btnConsultar.Enabled := False;
    btnNovo.Enabled := False;
    btnExcluir.Enabled := False;
    btnEditar.Enabled := False;
    Caption := ' Cadastro de Procedimentos - Inserindo Registro';
  end
  else
    if operacao = opEditar then
    begin
      cbTipo.ItemIndex := cdsProcedimentostipo.Value;
      pgPrincipal.ActivePage := tbDados;
      btnConsultar.Enabled := False;
      btnNovo.Enabled := False;
      btnExcluir.Enabled := False;
      btnEditar.Enabled := False;
      Caption := ' Cadastro de Procedimentos - Editando Registro';
    end
    else
      if operacao = opListar then
      begin
        pgPrincipal.ActivePage := tbListagem;
        btnConsultar.Enabled := True;
        btnNovo.Enabled := True;
        btnExcluir.Enabled := True;
        btnEditar.Enabled := True;
        Caption := ' Cadastro de Procedimentos - Listagem';
      end;
end;

procedure TFrmProcedimento.btCancelarClick(Sender: TObject);
begin
  cdsProcedimentos.Cancel;
  AjustaControles(opListar);  
end;

procedure TFrmProcedimento.btnConsultarClick(Sender: TObject);
begin
  consultar(edtConsulta.Text);
end;

procedure TFrmProcedimento.btnEditarClick(Sender: TObject);
begin
  editar;
end;

procedure TFrmProcedimento.btnExcluirClick(Sender: TObject);
begin
  excluir;
end;

procedure TFrmProcedimento.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmProcedimento.btnNovoClick(Sender: TObject);
begin
  novo;
end;

procedure TFrmProcedimento.btSalvarClick(Sender: TObject);
begin
  Salvar;
end;

procedure TFrmProcedimento.cbTipoChange(Sender: TObject);
begin
  cdsProcedimentostipo.Value := cbTipo.ItemIndex;
end;

procedure TFrmProcedimento.cdsProcedimentosAfterScroll(DataSet: TDataSet);
begin
  if not Assigned(model) then
    model := TProcedimentoModel.Create;

  model.id := cdsProcedimentosId.Value;
  model.descricao := cdsProcedimentosDescricao.Value;
  model.tipoText := cbTipo.Items[cdsProcedimentostipo.Value];

  model.valor := cdsProcedimentosvalor.Value;
end;

procedure TFrmProcedimento.cdsProcedimentosBeforeDelete(DataSet: TDataSet);
begin
  if not controler.excluir(cdsProcedimentosId.Value) then
    Abort;
end;

procedure TFrmProcedimento.cdsProcedimentostipoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not cdsProcedimentos.IsEmpty then
    Text := cbTipo.Items[cdsProcedimentostipo.Value];
end;

procedure TFrmProcedimento.consultar(pDesc:string);
var
  model:TProcedimentoModel;
begin
  cdsProcedimentos.EmptyDataSet;
  for model in controler.consultar(pDesc) do
  begin
     cdsProcedimentos.Append;
     cdsProcedimentosid.Value := model.id;
     cdsProcedimentosDescricao.Value := model.descricao;
     cdsProcedimentosTipo.Value := model.tipo;
     cdsProcedimentosValor.Value := model.valor;
     cdsProcedimentos.Post;
  end;
  cdsProcedimentos.First;
end;

procedure TFrmProcedimento.DBGrid1DblClick(Sender: TObject);
begin
  editar;
end;

procedure TFrmProcedimento.editar;
begin
  AjustaControles(opEditar);
  cdsProcedimentos.Edit;
end;

procedure TFrmProcedimento.excluir;
begin
  if Application.MessageBox('Deseja excluir este registro?','Confirmação',MB_YESNO + MB_ICONQUESTION) = ID_YES then
    cdsProcedimentos.Delete;
end;

procedure TFrmProcedimento.FormCreate(Sender: TObject);
begin
  controler := TProcedimentoControler.Create;
  tbListagem.TabVisible := False;
  tbDados.TabVisible := False;
  pgPrincipal.ActivePage := tbListagem;
end;

procedure TFrmProcedimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(controler);
end;

procedure TFrmProcedimento.FormShow(Sender: TObject);
begin
  //teste
  consultar('');
  btnSelcionar.Visible := operacao = opConsultar;
end;

procedure TFrmProcedimento.novo;
begin
  AjustaControles(opNovo);
  cdsProcedimentos.Append;
end;

procedure TFrmProcedimento.salvar;
var
  model:TProcedimentoModel;
begin
  try
    model := TProcedimentoModel.Create;
    model.id := cdsProcedimentosid.Value;
    model.descricao := cdsProcedimentosDescricao.Value;
    model.tipo := cdsProcedimentostipo.Value;
    model.valor := cdsProcedimentosvalor.Value;
    if controler.salvar(model) then
    begin
      cdsProcedimentos.Post;
      consultar('');
      AjustaControles(opListar);
    end;

  finally
    FreeAndNil(model);
  end
end;

end.
