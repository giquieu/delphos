unit Form.Main;

interface

uses
  Winapi.Windows, System.Classes, SysUtils, Forms, Data.FMTBcd, Data.DB, Data.SqlExpr, Vcl.Controls, Vcl.StdCtrls,
  Connection.Interfaces, Graphics, System.Threading, uSearchProdutoWidget, Model.Produto;

type

  TFormMain = class(TForm, ISearchProdutoWidgetObserver)
    SQLConnection: TSQLConnection;
    SQLQuery: TSQLQuery;
    Button1: TButton;
    EditSearchProduto: TEdit;
    Edit1: TEdit;
    MemoLog: TMemo;
    ListBox: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FSearchProdutoWidget: TSearchProdutoWidget;
    procedure OnSearchRepository(Sender: TObject);
    procedure OnSearchProduto(AProduto: TProduto);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  Connection.Fabrica;

{$R *.dfm}

procedure TFormMain.Button1Click(Sender: TObject);
var
  Connection: IConnection;
begin
  Connection := TConnectionFabrica.New.GetConnection();
//  Connection.Open;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FSearchProdutoWidget := TSearchProdutoWidget.Create(Self, EditSearchProduto);
  FSearchProdutoWidget.Observer(Self);
end;

procedure TFormMain.OnSearchProduto(AProduto: TProduto);
begin

end;

procedure TFormMain.OnSearchRepository(Sender: TObject);
begin
  TThread.Queue(TThread.CurrentThread,
    procedure
    begin
      if (not (Application.Terminated)) and Assigned(MemoLog) and Assigned(Sender) then
      begin
        MemoLog.Lines.Add(TEdit(Sender).Text);
      end;
    end
  );
end;

end.
