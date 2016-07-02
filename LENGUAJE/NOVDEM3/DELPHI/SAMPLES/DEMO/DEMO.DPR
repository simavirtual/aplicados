program Demo;

uses
  Forms,
  Dialogs,
  Novdemo in 'NOVDEMO.PAS' {Form1},
  Novlib;

{$R *.RES}

begin
  if (WSConnNumberGet > 0) then
    begin
      Application.CreateForm(TDemoForm, DemoForm);
      Application.Run;
    end
  else
    begin
      messagedlg('You are not attached to a Novell Network!',mtError,[mbAbort],0);
      NovTaskEnd;
      Application.Terminate;
    end;
end.

