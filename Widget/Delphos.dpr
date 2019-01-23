program Delphos;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {FormMain},
  uSearchProdutoWidget in 'uSearchProdutoWidget.pas',
  Model.Produto in 'Model.Produto.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
