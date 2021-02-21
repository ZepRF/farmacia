unit uProcedimentoDao;

interface

uses
  uPadraoDao, uProcedimentoModel, System.Generics.Collections;

type
  TProcedimentoDao = class(TPadraoDao)
  private
  public
    function consultar(pDesc:string):TList<TProcedimentoModel>;
    function excluir(pId:Integer):Boolean;
    function salvar(model:TProcedimentoModel):Boolean;
  end;

implementation

uses System.SysUtils;

{ TProcedimentoDao }
function TProcedimentoDao.consultar(pDesc: string): TList<TProcedimentoModel>;
var
  listRetorno:TList<TProcedimentoModel>;
  model:TProcedimentoModel;
begin
  listRetorno := TList<TProcedimentoModel>.Create;
  try
    query.Close;
    query.SQL.Text := 'SELECT * FROM PROCEDIMENTOS WHERE UPPER(DESCRICAO) LIKE UPPER(:pDesc)';
    query.ParamByName('pDesc').Value := '%' + pDesc + '%';
    query.Open;

    while not query.Eof do
    begin
      model := TProcedimentoModel.Create;
      model.id := query.FieldByName('id').Value;
      model.descricao := query.FieldByName('descricao').Value;
      model.tipo := query.FieldByName('tipo').Value;
      model.valor := query.FieldByName('valor').Value;
      listRetorno.Add(model);
      query.Next;
    end;

    Result := listRetorno;
  finally
    query.Close;
  end;

end;



function TProcedimentoDao.excluir(pId:Integer): Boolean;
begin
  try
    Result := True;
    query.Close;
    query.SQL.Text := 'DELETE FROM PROCEDIMENTOS WHERE ID = :ID';
    query.ParamByName('ID').Value := pid;
    query.ExecSQL;
  except
    Result := False;
  end;
end;

function TProcedimentoDao.salvar(model: TProcedimentoModel): Boolean;
var
  vID: Integer;
begin
  Result := True;
  try
    if model.id > 0 then
    begin
      query.Close;
      query.SQL.Text := 'UPDATE PROCEDIMENTOS SET DESCRICAO=:DESC, TIPO=:TIPO, VALOR=:VALOR WHERE ID = :ID';
      query.ParamByName('DESC').Value := model.descricao;
      query.ParamByName('TIPO').Value := model.tipo;
      query.ParamByName('VALOR').Value := model.valor;
      query.ParamByName('ID').Value := model.id;
      query.ExecSQL;
    end
    else
    begin
      vID := nextId('PROCEDIMENTOS');

      query.Close;
      query.SQL.Text := 'INSERT INTO PROCEDIMENTOS (ID, DESCRICAO, TIPO, VALOR) VALUES (:ID,:DESC, :TIPO, :VALOR)';
      query.ParamByName('ID').Value := vID;
      query.ParamByName('DESC').Value := model.descricao;
      query.ParamByName('TIPO').Value := model.tipo;
      query.ParamByName('VALOR').Value := model.valor;
      query.ExecSQL;
    end;

  except
    Result := False;
  end;

end;

end.
