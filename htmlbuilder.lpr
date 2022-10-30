program htmlbuilder;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, dbflaz, main, db_helpers, db_insertdemo, db_create_tables, replacers,
  editor_in_window, editor_css;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmEditor, frmEditor);
  Application.CreateForm(TfrmEditorCss, frmEditorCss);
  Application.Run;
end.

