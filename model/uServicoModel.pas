unit uServicoModel;

interface
uses System.Generics.Collections, uServicoProcedimentoModel, System.SysUtils;

type
  TServicoModel = class
  private
    Fid: integer;
    Fpaciente: string;
    FvalorTotal: double;
    Ffarmaceutico: string;
    Fdata: TDateTime;
    Fobservacoes: string;
    Fprocedimentos:TList<TServicoProcedimentoModel>;
    function getProcedimentos: TList<TServicoProcedimentoModel>;
  public
    { public declarations }
    property id:integer read Fid write Fid;
    property data:TDateTime read Fdata write Fdata;
    property farmaceutico:string read Ffarmaceutico write Ffarmaceutico;
    property paciente:string read Fpaciente write Fpaciente;
    property valorTotal:double read FvalorTotal write FvalorTotal;
    property observacoes:string read Fobservacoes write Fobservacoes;
    property procedimentos:TList<TServicoProcedimentoModel> read getProcedimentos;

    destructor Destroy; override;
  end;

implementation

{ TServicoModel }

destructor TServicoModel.Destroy;
begin
  FreeAndNil(Fprocedimentos);
  inherited;
end;

function TServicoModel.getProcedimentos: TList<TServicoProcedimentoModel>;
begin
  if not Assigned(Fprocedimentos) then
    Fprocedimentos := TList<TServicoProcedimentoModel>.Create;

  Result := Fprocedimentos;
end;

end.
