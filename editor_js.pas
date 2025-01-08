{ Contains editor for javascript }

Unit editor_js;

{$mode ObjFPC}{$H+}

Interface

Uses 
Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
SynEdit, SynHighlighterJScript, SynCompletion, Types, LCLType, Menus,
ActnList, FontSettings, Process;

Type 

  { TfrmEditorJs }

  { Window with javascript editor }
  TfrmEditorJs = Class(TForm)
    acNewJsFunction: TAction;
    acDecisionIfElse: TAction;
    aclJsEditorActions: TActionList;
    acForKeyInLoop: TAction;
    acForValueOfIterable: TAction;
    acSwitch: TAction;
    acNewClass: TAction;
    acDoWhileLoop: TAction;
    acAddBinaryJsFunction: TAction;
    acAddTernaryJsFunction: TAction;
    acApplyPrettier: TAction;
    acWhileLoop: TAction;
    acTryCatch: TAction;
    btnClose: TButton;
    btnAddFunction: TButton;
    btnAddClass: TButton;
    mnuApplyPrettier: TMenuItem;
    mnuJsActions: TMenuItem;
    mnuAddBinaryJsFunction: TMenuItem;
    mnuAddTernaryJsFunction: TMenuItem;
    mnuDoWhileLoop: TMenuItem;
    mnuWhileLoop: TMenuItem;
    mnuAddClass: TMenuItem;
    mnuSwitch: TMenuItem;
    mnuTryCatch: TMenuItem;
    mnuForValueOfIterable: TMenuItem;
    mnuForKeyIn: TMenuItem;
    mmJsEditorMenu: TMainMenu;
    mnuStatements: TMenuItem;
    mnuNewFunction: TMenuItem;
    mnuDecisionIfElse: TMenuItem;
    mnuIfElseDecision: TButton;
    lbScriptName: TLabel;
    editor: TSynEdit;
    panJs: TPanel;
    SynCompletion1: TSynCompletion;
    SynJScriptSyn1: TSynJScriptSyn;

    { Handles click of btnAddFunction }



    { Handles click of btnClose }
    Procedure acAddBinaryJsFunctionExecute(Sender: TObject);
    Procedure acAddTernaryJsFunctionExecute(Sender: TObject);
    procedure acApplyPrettierExecute(Sender: TObject);
    Procedure acDecisionIfElseExecute(Sender: TObject);
    Procedure acDoWhileLoopExecute(Sender: TObject);
    Procedure acForKeyInLoopExecute(Sender: TObject);
    Procedure acForValueOfIterableExecute(Sender: TObject);
    Procedure acNewClassExecute(Sender: TObject);
    Procedure acNewJsFunctionExecute(Sender: TObject);
    Procedure acSwitchExecute(Sender: TObject);
    Procedure acTryCatchExecute(Sender: TObject);
    Procedure acWhileLoopExecute(Sender: TObject);
    Procedure btnCloseClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);



    { Handles autocompletions for javascript }
    Procedure SynCompletion1CodeCompletion(Var Value: String;
                                           SourceValue: String; Var SourceStart,
                                           SourceEnd: TPoint;
                                           KeyChar: TUTF8Char; Shift:
                                           TShiftState);

    Private 

    Public 

  End;







Var 
  frmEditorJs: TfrmEditorJs;

Implementation

{$R *.lfm}

Function replKeys(Const Input: String): string;
Begin
  // Replace '[enter]' with Chr(13)
  Result := StringReplace(Input, '[enter]', Chr(13), [rfReplaceAll]);
  // Replace '[tab]' with Chr(9)
  Result := StringReplace(Result, '[tab]', Chr(9), [rfReplaceAll]);
End;


{ TfrmEditorJs }

Procedure TfrmEditorJs.btnCloseClick(Sender: TObject);
Begin
  modalresult := mrok;
  close;
End;

Procedure TfrmEditorJs.acNewJsFunctionExecute(Sender: TObject);

Var funcName : String;
Begin
  funcName := InputBox('Новая функция', 'имя функции',
              'newF');
  editor.InsertTextAtCaret(replKeys('function '+funcName+'(){[enter]}[enter]'));
End;

Procedure TfrmEditorJs.acSwitchExecute(Sender: TObject);
Begin
  editor.InsertTextAtCaret(replKeys(
'switch (expr) {[enter]case value1 :[enter][tab]// some actions[enter]break;[enter]default:[enter][tab]// default actions[enter]}[enter]'
  ));
End;

Procedure TfrmEditorJs.acTryCatchExecute(Sender: TObject);
Begin
  editor.InsertTextAtCaret(replKeys(
'try {[enter][tab]}[enter]catch(err) {[enter][tab]console.log(err.message);[enter]}[enter]'
  ));
End;

Procedure TfrmEditorJs.acWhileLoopExecute(Sender: TObject);
Begin
  editor.InsertTextAtCaret(replKeys(
                           'while (){[enter][tab]// while loop[enter]}[enter]'))
  ;
End;

Procedure TfrmEditorJs.acDecisionIfElseExecute(Sender: TObject);
Begin
  editor.InsertTextAtCaret(replKeys('if () {[enter]} else {[enter]}[enter]'));
End;

Procedure TfrmEditorJs.acAddBinaryJsFunctionExecute(Sender: TObject);

Var 
  funcName : String;
Begin
  funcName := InputBox('Новая функция', 'имя функции',
              'newF');
  editor.InsertTextAtCaret(replKeys('function '+funcName+
                           '(p, q) {[enter]}[enter]'));
End;

Procedure TfrmEditorJs.acAddTernaryJsFunctionExecute(Sender: TObject);

Var 
  funcName : String;
Begin
  funcName := InputBox('Новая функция', 'имя функции',
              'newF');
  editor.InsertTextAtCaret(replKeys('function '+funcName+
                           '(p, q, t) {[enter]}[enter]'));
End;

procedure TfrmEditorJs.acApplyPrettierExecute(Sender: TObject);
var
  Process: TProcess;

begin
  editor.Lines.SaveToFile('temp.js');
  // Get the current directory


  // Create and configure the process
  Process := TProcess.Create(nil);
  try
    Process.Executable := '/usr/bin/prettier';
    Process.Parameters.Add('--write');
    Process.Parameters.Add(GetCurrentDir+'/temp.js');

    // Optionally set other process options
    Process.Options := [poWaitOnExit];

    // Execute the process
    Process.Execute;

  finally
    Process.Free;
  end;
  editor.Lines.LoadFromFile('temp.js');
  DeleteFile('temp.js');
end;


Procedure TfrmEditorJs.acDoWhileLoopExecute(Sender: TObject);
Begin
  editor.InsertTextAtCaret(replKeys(
              'do {[enter][tab]// do while loop[enter]}[enter]while ( );[enter]'
  ));
End;

Procedure TfrmEditorJs.acForKeyInLoopExecute(Sender: TObject);
Begin
  editor.InsertTextAtCaret(replKeys('for (let key in object) {[enter]}'));
End;

Procedure TfrmEditorJs.acForValueOfIterableExecute(Sender: TObject);
Begin
  editor.InsertTextAtCaret(replKeys(
                           'for (let value of iterable) {[enter]}[enter]'));
End;

Procedure TfrmEditorJs.acNewClassExecute(Sender: TObject);
Begin
  editor.InsertTextAtCaret(replKeys(
'class ClassName {[enter][tab]constructor (){[enter][tab]// Add constructor[enter][tab]}[enter]}[enter]'
  ));
End;


Procedure TfrmEditorJs.FormCreate(Sender: TObject);

Var 
  FontManager: TFontManager;
Begin
  FontManager := TFontManager.Create();
  editor.Font := FontManager.Font;
  FontManager.Free;
End;





Procedure TfrmEditorJs.SynCompletion1CodeCompletion(Var Value: String;
                                                    SourceValue: String; Var
                                                    SourceStart, SourceEnd:
                                                    TPoint; KeyChar: TUTF8Char;
                                                    Shift: TShiftState);
Begin

End;



End.
