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
    ActionList1: TActionList;
    btnClose: TButton;
    btnAddFunction: TButton;
    MainMenu1: TMainMenu;
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
    procedure acNewJsFunctionExecute(Sender: TObject);
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
 editor.InsertTextAtCaret(' function '+funcName+'(){}');
end;

procedure TfrmEditorJs.acDecisionIfElseExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('if () {} else {}');
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

