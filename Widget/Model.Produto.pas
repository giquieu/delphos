unit Model.Produto;

interface

type

  TProduto = class
  private
    FDescricao: String;
    procedure SetDescricao(const Value: String);
  public
    constructor Create(ADescricao: String); reintroduce;

    property Descricao: String read FDescricao write SetDescricao;
  end;

implementation

{ TProduto }

constructor TProduto.Create(ADescricao: String);
begin
  FDescricao := ADescricao;
end;

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
