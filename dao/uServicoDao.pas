unit uServicoDao;

interface

uses
  uPadraoDao, uServicoModel, uProcedimentoModel,uServicoProcedimentoModel, System.SysUtils, System.Generics.Collections;

type

  TServicoDao = class(TPadraoDao)
  private
    procedure salvarProcedimentos(model: TServicoModel);
  public
    function salvar(var model: TServicoModel): Boolean;
  end;

implementation

{ TServicoDao }

function TServicoDao.salvar(var model: TServicoModel): Boolean;
begin

  conexao.StartTransaction;    
  Result := True;
  try
    model.id := nextId('SERVICOS');
    query.Close;
    query.SQL.Text := 'INSERT INTO SERVICOS(ID, DATA, FARMACEUTICO, PACIENTE, VALOR_TOTAL, OBSERVACOES ) ' +
                      '              VALUES(:ID, :DATA, :FARMACEUTICO, :PACIENTE, :VALOR_TOTAL, :OBSERVACOES)';
    query.ParamByName('ID').Value := model.id;
    query.ParamByName('DATA').Value := model.data;
    query.ParamByName('FARMACEUTICO').Value := model.farmaceutico;
    query.ParamByName('PACIENTE').Value := model.paciente;
    query.ParamByName('VALOR_TOTAL').Value := model.valorTotal;
    query.ParamByName('OBSERVACOES').Value := model.observacoes;
    query.ExecSQL;         
    
    salvarProcedimentos(model);    

    conexao.Commit;    
  except
    Result := false;
    conexao.Rollback;
  end;
  
end;


procedure TServicoDao.salvarProcedimentos(model: TServicoModel);
var
  servicoProcedimentos:TServicoProcedimentoModel;
begin
  try
    for servicoProcedimentos in model.procedimentos do
    begin

      servicoProcedimentos.id := nextId('SERVICOS_PROCEDIMENTOS');
      servicoProcedimentos.idServico := model.id;
      
      query.Close;
      query.SQL.Text := ' INSERT INTO SERVICOS_PROCEDIMENTOS(ID,ID_SERVICO,ID_PROCEDIMENTOS ) ' +
                        ' VALUES(:ID,:ID_SERVICO,:ID_PROCEDIMENTOS) ';
      query.ParamByName('ID').Value := servicoProcedimentos.id;  
      query.ParamByName('ID_SERVICO').Value := servicoProcedimentos.idServico;
      query.ParamByName('ID_PROCEDIMENTOS').Value := servicoProcedimentos.procedimento.id;
      query.ExecSQL;    
    end;    
  except 
    on E: Exception do
      raise Exception.Create(e.Message);
  end;
end;

end.
