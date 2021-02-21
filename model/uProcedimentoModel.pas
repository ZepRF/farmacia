unit uProcedimentoModel;

interface
type

  TProcedimentoModel = class
  private
    Fid: integer;
    Fdescricao: string;
    Fvalor: double;
    Ftipo: integer;
    FtipoText: string;
  public
    { public declarations }
    property id:integer read Fid write Fid;
    property descricao:string read Fdescricao write Fdescricao;
    property tipo:integer read Ftipo write Ftipo;
    property tipoText:string read FtipoText write FtipoText;
    property valor:double read Fvalor write Fvalor;
  end;

implementation

end.
