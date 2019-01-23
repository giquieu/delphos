unit Model.Produto;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Defaults, System.Generics.Collections, System.AnsiStrings;

type

  TProduto = class
  private
    FDescricao: String;
  public
    constructor Create(); overload;
    constructor Create(const AProduto: TProduto); overload;
    constructor Create(ADescricao: String); overload;

    property Descricao: String read FDescricao write FDescricao;
  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  inherited Create;
end;

constructor TProduto.Create(ADescricao: String);
begin
  FDescricao := ADescricao;
end;

constructor TProduto.Create(const AProduto: TProduto);
begin
  FDescricao := AProduto.Descricao;
end;

end.
