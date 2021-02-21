unit uServicoControler;

interface
uses
  uServicoModel;
type

  TServicoControler = class
  private
  public
    function salvar(var model: TServicoModel): boolean;
  end;

implementation

{ TServicoControler }

uses uServicoDao, System.SysUtils, System.Generics.Collections;

function TServicoControler.salvar(var model: TServicoModel): boolean;
var
  servicoDao:TServicoDao;
begin
  servicoDao := TServicoDao.Create;
  try
    if model.farmaceutico = EmptyStr then
      raise Exception.Create('Favor informar o Farmaceutico');

    if model.procedimentos.Count = 0 then
      raise Exception.Create('Favor informar os procedimentos executados.');

    Result := servicoDao.salvar(model);
    if not Result then
      raise Exception.Create('Não foi possível concluir esta operação');
  finally
    servicoDao.Free;
  end;
end;

end.
