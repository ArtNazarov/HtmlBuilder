{ Contains editor for javascript }
unit editor_js;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterJScript, SynCompletion, Types, LCLType, Menus,
  ActnList, FontSettings;

type

  { TfrmEditorJs }

  { Window with javascript editor }
  TfrmEditorJs = class(TForm)
    acNewJsFunction: TAction;
    acDecisionIfElse: TAction;
    aclJsEditorActions: TActionList;
    acForKeyInLoop: TAction;
    acForValueOfIterable: TAction;
    acSwitch: TAction;
    acTryCatch: TAction;
    btnClose: TButton;
    btnAddFunction: TButton;
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
    procedure acDecisionIfElseExecute(Sender: TObject);
    procedure acForKeyInLoopExecute(Sender: TObject);
    procedure acForValueOfIterableExecute(Sender: TObject);
    procedure acNewJsFunctionExecute(Sender: TObject);
    procedure acSwitchExecute(Sender: TObject);
    procedure acTryCatchExecute(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);



    { Handles autocompletions for javascript }
    procedure SynCompletion1CodeCompletion(var Value: string;
      SourceValue: string; var SourceStart, SourceEnd: TPoint;
      KeyChar: TUTF8Char; Shift: TShiftState);

  private

  public

    end;







var
  frmEditorJs: TfrmEditorJs;

implementation

{$R *.lfm}

function replKeys(const Input: string): string;
begin
  // Replace '[enter]' with Chr(13)
  Result := StringReplace(Input, '[enter]', Chr(13), [rfReplaceAll]);
  // Replace '[tab]' with Chr(9)
  Result := StringReplace(Result, '[tab]', Chr(9), [rfReplaceAll]);
end;


{ TfrmEditorJs }

procedure TfrmEditorJs.btnCloseClick(Sender: TObject);
begin
    modalresult:=mrok;
    close;
end;

procedure TfrmEditorJs.acNewJsFunctionExecute(Sender: TObject);
var funcName : String;
begin
  funcName := InputBox('Новая функция', 'имя функции', 'newF');
 editor.InsertTextAtCaret(replKeys('function '+funcName+'(){[enter]}[enter]'));
end;

procedure TfrmEditorJs.acSwitchExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret(replKeys('switch (expr) {[enter]case value1 :[enter][tab]// some actions[enter]break;[enter]default:[enter][tab]// default actions[enter]}[enter]'));
end;

procedure TfrmEditorJs.acTryCatchExecute(Sender: TObject);
begin
 editor.InsertTextAtCaret(replKeys('try {[enter][tab]}[enter]catch(err) {[enter][tab]console.log(err.message);[enter]}[enter]'));
end;

procedure TfrmEditorJs.acDecisionIfElseExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret(replKeys('if () {[enter]} else {[enter]}[enter]'));
end;

procedure TfrmEditorJs.acForKeyInLoopExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret(replKeys('for (let key in object) {[enter]}'));
end;

procedure TfrmEditorJs.acForValueOfIterableExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret(replKeys('for (let value of iterable) {[enter]}[enter]'));
end;


procedure TfrmEditorJs.FormCreate(Sender: TObject);
var
   FontManager: TFontManager;
begin
     FontManager := TFontManager.Create();
     editor.Font := FontManager.Font;
     FontManager.Free;
end;





procedure TfrmEditorJs.SynCompletion1CodeCompletion(var Value: string;
  SourceValue: string; var SourceStart, SourceEnd: TPoint; KeyChar: TUTF8Char;
  Shift: TShiftState);
begin

end;



end.

