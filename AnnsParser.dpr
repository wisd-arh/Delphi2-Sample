program AnnsParser;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uFInfo in 'uFInfo.pas' {Form2},
  uFSettings in 'uFSettings.pas' {Form3},
  uHTMLP in 'uHTMLP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
