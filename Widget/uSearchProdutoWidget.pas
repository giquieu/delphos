unit uSearchProdutoWidget;

interface

uses
  Winapi.Windows, System.Classes, SysUtils, Forms, Data.FMTBcd, Data.DB, Data.SqlExpr, Vcl.Controls, Vcl.StdCtrls, Graphics,
  System.Threading, Model.Produto, System.Generics.Collections, System.Generics.Defaults;

type

  ISearchProdutoWidgetObserver = interface
    ['{EAC6B8E6-0669-4D96-964A-601F807709EC}']
    procedure OnSearchRepository(Sender: TObject);
    procedure OnSearchProduto(AProduto: TProduto);
  end;

  ISearchProdutoRepository = interface
    ['{C3CD03EF-A38E-49D9-AE7B-2546669A75A8}']
    function FindProdutoByDescricao(ADescricao: String): TObjectList<TProduto>;
  end;

  TSearchProdutoRepository = class(TInterfacedObject, ISearchProdutoRepository)
  public
    function FindProdutoByDescricao(ADescricao: String): TObjectList<TProduto>;
  end;

  TSearchProdutoWidget = class(TComponent)
  private
    FEdit: TEdit;
    FListBox: TListBox;
    FSearchRepository: ISearchProdutoRepository;
    FSearchRepositoryTask: ITask;
    FObservers: TInterfaceList;
    procedure OnSearchRepository(Sender: TObject);
    procedure OnEditEnter(Sender: TObject);
    procedure OnEditExit(Sender: TObject);
    procedure OnEditChange(Sender: TObject);
    procedure Notify(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; AEdit: TEdit); reintroduce;
    destructor  Destroy; override;

    procedure Observer(const AObserver: ISearchProdutoWidgetObserver);
  end;

implementation

{ TSearchProdutoWidget }

constructor TSearchProdutoWidget.Create(AOwner: TComponent; AEdit: TEdit);
begin
  inherited Create(AOwner);
  FEdit := AEdit;
  FEdit.TextHint := 'Procurar um Produto...';
  FEdit.OnEnter  := OnEditEnter;
  FEdit.OnExit   := OnEditExit;
  FEdit.OnChange := OnEditChange;

  FListBox := TListBox.Create(Self);
  FListBox.Parent := TWinControL(FEdit.Owner);

  FListBox.Left    := FEdit.Left;
  FListBox.Top     := FEdit.Top + FEdit.Height + 2;
  FListBox.Width   := FEdit.Width;
  FListBox.Visible := False;

  FListBox.Height  := 100;

  FSearchRepository := TSearchProdutoRepository.Create;

  FObservers := TInterfaceList.Create;
end;

destructor TSearchProdutoWidget.Destroy;
begin
  FSearchRepositoryTask.Wait;
  FObservers.Free;
  inherited Destroy;
end;

procedure TSearchProdutoWidget.Notify(Sender: TObject);
var
  I: Integer;
  Observer: ISearchProdutoWidgetObserver;
begin
  for I := 0 to Pred(FObservers.Count) do
  begin
    Observer := FObservers.Items[I] as ISearchProdutoWidgetObserver;
    Observer.OnSearchRepository(Sender);
  end;
end;

procedure TSearchProdutoWidget.Observer(const AObserver: ISearchProdutoWidgetObserver);
begin
  FObservers.Add(AObserver);
end;

procedure TSearchProdutoWidget.OnEditChange(Sender: TObject);
begin
  FSearchRepositoryTask := TTask.Run(FEdit, OnSearchRepository);
  FSearchRepositoryTask.Start;
end;

procedure TSearchProdutoWidget.OnEditEnter(Sender: TObject);
begin
  FEdit.Color := clActiveCaption;
end;

procedure TSearchProdutoWidget.OnEditExit(Sender: TObject);
begin
  FEdit.Color := clWindow;
end;

procedure TSearchProdutoWidget.OnSearchRepository(Sender: TObject);
var
  I: Integer;
  Produto: TProduto;
  Produtos: TObjectList<TProduto>;
begin
  if (Length(TEdit(Sender).Text) = 0) then
  begin
    Notify(Sender);
  end
  else
  if (Length(TEdit(Sender).Text) >= 5) then
  begin
    Produtos := FSearchRepository.FindProdutoByDescricao(TEdit(Sender).Text);
    for I := 0 to Pred(Produtos.Count) do
    begin
      Produto := Produtos[I];
      TThread.Queue(TThread.CurrentThread,
        procedure
        begin
          FListBox.Items.Add(Produto.Descricao);
        end
      );
    end;
    TThread.Queue(TThread.CurrentThread,
      procedure
      begin
        FListBox.Visible := True;
      end
    );
    Notify(Sender);
  end;
  TThread.Sleep(10);
//  while (not (Application.Terminated)) and (not (FSearchRepository.Status = TTaskStatus.Canceled)) do
//  begin
//
//  end;
end;

{ TSearchRepository }

function TSearchProdutoRepository.FindProdutoByDescricao(ADescricao: String): TObjectList<TProduto>;
begin
  Result := TObjectList<TProduto>.Create;
  Result.Add(TProduto.Create('Banana'));
  Result.Add(TProduto.Create('Maca'));
  Result.Add(TProduto.Create('Iogurte'));
  Result.Add(TProduto.Create('Salame'));
  Result.Add(TProduto.Create('Pao de Padeiro'));
end;

end.
