program Suchbaum;

uses
  Forms,
  suchbaumtest in 'suchbaumtest.pas' {Form1},
  uTSuchbaum in 'uTSuchbaum.PAS';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
