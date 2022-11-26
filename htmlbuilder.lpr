program htmlbuilder;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads, // диспетчер памяти C в некоторых системах намного быстрее для многопоточности
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, dbflaz, datetimectrls, main, db_helpers, db_insertdemo,
  db_create_tables, replacers, editor_in_window, editor_css, editor_js,
  css_props_dlg;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmEditor, frmEditor);
  Application.CreateForm(TfrmEditorCss, frmEditorCss);
  Application.CreateForm(TfrmEditorJs, frmEditorJs);
  Application.CreateForm(TfrmCssProps, frmCssProps);
  Application.Run;
end.

