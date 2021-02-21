unit uFrmServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXPickers, Vcl.Grids, Vcl.ComCtrls, uProcedimentoModel, uServicoModel, uServicoProcedimentoModel;

type
  TFrmServico = class(TForm)
    pnBottoes: TPanel;
    btnNovo: TButton;
    btnFechar: TButton;
    gbProcedimentos: TGroupBox;
    sgProcedimentosExecutados: TStringGrid;
    lbTotal: TLabel;
    edTotal: TEdit;
    btnAddProcedimento: TButton;
    gbInfo: TGroupBox;
    edtID: TLabeledEdit;
    edtFarmaceutico: TLabeledEdit;
    edtPaciente: TLabeledEdit;
    dtData: TDateTimePicker;
    Label1: TLabel;
    btnSalvar: TButton;
    Observações: TLabel;
    mObs: TMemo;
    procedure btnAddProcedimentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    servicoModel:TServicoModel;
    procedure novo;
    procedure salvar;
    procedure adicionarProcedimento(procedimentoModel:TprocedimentoModel);
    procedure ajustaControles;

  public
    { Public declarations }
  end;

var
  FrmServico: TFrmServico;

implementation

{$R *.dfm}

uses uFrmProcedimento, uServicoControler;

procedure TFrmServico.adicionarProcedimento(procedimentoModel: TprocedimentoModel);
var
  sp:TServicoProcedimentoModel;
begin
  sp := TServicoProcedimentoModel.Create;
  sp.idServico := servicoModel.id;
  sp.procedimento := procedimentoModel;
  servicoModel.procedimentos.Add(sp);

  sgProcedimentosExecutados.Cells[0,pred(sgProcedimentosExecutados.RowCount)] := IntToStr(procedimentoModel.id);
  sgProcedimentosExecutados.Cells[1,pred(sgProcedimentosExecutados.RowCount)] := procedimentoModel.descricao;
  sgProcedimentosExecutados.Cells[2,pred(sgProcedimentosExecutados.RowCount)] := procedimentoModel.tipoText;
  sgProcedimentosExecutados.Cells[3,pred(sgProcedimentosExecutados.RowCount)] := FloatToStrF(procedimentoModel.valor,ffCurrency,9,2);
  sgProcedimentosExecutados.RowCount := sgProcedimentosExecutados.RowCount + 1;

  servicoModel.valorTotal := servicoModel.valorTotal + procedimentoModel.valor;

  edTotal.Text := FloatToStrF(servicoModel.valorTotal, ffCurrency, 9,2);
end;

procedure TFrmServico.ajustaControles;
var
  i:Integer;
begin
  gbInfo.Enabled := True;
  gbProcedimentos.Enabled := True;
  dtData.SetFocus;
  edtID.Clear;
  dtData.DateTime := Now;
  edtFarmaceutico.Clear;
  edtPaciente.Clear;
  edTotal.Clear;
  mObs.Lines.Clear;
  
  for I := 1 to sgProcedimentosExecutados.RowCount - 1 do
    sgProcedimentosExecutados.Rows[i].Clear;
  sgProcedimentosExecutados.RowCount := 2;

  btnNovo.Enabled := btnSalvar.Enabled;
  btnSalvar.Enabled := not btnNovo.Enabled;
end;

procedure TFrmServico.btnAddProcedimentoClick(Sender: TObject);
begin
  try
    FrmProcedimento := TFrmProcedimento.Create(self);
    FrmProcedimento.operacao := opConsultar;
    if FrmProcedimento.ShowModal = mrOk then
     adicionarProcedimento(FrmProcedimento.model);
  finally
    FrmProcedimento.Free;
  end;
end;

procedure TFrmServico.btnFecharClick(Sender: TObject);
begin
 close;
end;

procedure TFrmServico.btnNovoClick(Sender: TObject);
begin
  novo;
end;

procedure TFrmServico.btnSalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TFrmServico.FormCreate(Sender: TObject);
begin
  sgProcedimentosExecutados.Cells[0,0] := 'Id.';
  sgProcedimentosExecutados.Cells[1,0] := 'Descrição';
  sgProcedimentosExecutados.Cells[2,0] := 'Tipo';
  sgProcedimentosExecutados.Cells[3,0] := 'Valor';
end;

procedure TFrmServico.novo;
var
  i:Integer;
begin
  servicoModel := TServicoModel.Create;
  ajustaControles;
end;

procedure TFrmServico.salvar;
var
  controler:TServicoControler;
begin
  controler := TServicoControler.Create;
  try
    servicoModel.data := dtData.DateTime;
    servicoModel.farmaceutico := edtFarmaceutico.Text;
    servicoModel.paciente := edtPaciente.Text;
    servicoModel.observacoes := mObs.Text;         
    
    if controler.salvar(servicoModel) then
    begin   
      edtID.Text := IntToStr(servicoModel.id);
      gbInfo.Enabled := false;
      gbProcedimentos.Enabled := false;
      btnNovo.Enabled := true;
      btnSalvar.Enabled := false;    
    end;

  finally
    controler.Free;
  end;

end;

end.
