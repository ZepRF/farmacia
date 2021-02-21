unit uServicoProcedimentoModel;

interface

uses uProcedimentoModel, System.SysUtils;

type
  TServicoProcedimentoModel = class(TObject)
  private
    Fprocedimento: TProcedimentoModel;
    Fid: integer;
    FidServico: integer;
  public
    property id:integer read Fid write Fid;
    property idServico: integer read FidServico write FidServico;
    property procedimento:TProcedimentoModel read Fprocedimento write Fprocedimento;
    destructor Destroy; override;
  end;

implementation

{ TServicoProcedimentoModel }
destructor TServicoProcedimentoModel.Destroy;
begin
  FreeAndNil(Fprocedimento);
  inherited;
end;



end.
