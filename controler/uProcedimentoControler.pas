unit uProcedimentoControler;

interface

uses
  uProcedimentoDao, uProcedimentoModel, System.SysUtils, System.Generics.Collections;

type

  TProcedimentoControler = class
  private
    FProcedimentoDao:TProcedimentoDao;
  public
    constructor Create;
    destructor Destroy; override;
    function consultar(pDesc:string):Tlist<TProcedimentoModel>;
    function excluir(pId:Integer):Boolean;
    function salvar(model:TProcedimentoModel):Boolean;

  end;

implementation

uses Vcl.Dialogs;

{ TProcedimentoControler }
function TProcedimentoControler.consultar(pDesc: string): Tlist<TProcedimentoModel>;
begin
  Result := FProcedimentoDao.consultar(pDesc);
end;

constructor TProcedimentoControler.Create;
begin
  inherited;
  FProcedimentoDao := TProcedimentoDao.Create;
end;

destructor TProcedimentoControler.Destroy;
begin
  FreeAndNil(FProcedimentoDao);
  inherited;
end;

function TProcedimentoControler.excluir(pId: Integer): Boolean;
begin
  if not FProcedimentoDao.excluir(pId) then
    ShowMessage('Exclus�o n�o permitida.');
end;

function TProcedimentoControler.salvar(model: TProcedimentoModel): Boolean;
begin
  Result := True;
  if not FProcedimentoDao.salvar(model) then
    raise EArgumentException.Create('N�o foi possivel concluir esta opera��o.');

end;

end.
