unit editor_js;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterJScript, SynCompletion, Types, LCLType;

type

  { TfrmEditorJs }

  TfrmEditorJs = class(TForm)
    btnClose: TButton;
    btnAddFunction: TButton;
    lbScriptName: TLabel;
    editor: TSynEdit;
    panJs: TPanel;
    SynCompletion1: TSynCompletion;
    SynJScriptSyn1: TSynJScriptSyn;
    procedure btnAddFunctionClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure panJsClick(Sender: TObject);
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

procedure TfrmEditorJs.btnAddFunctionClick(Sender: TObject);
var funcName : String;
begin
  funcName := InputBox('Новая функция', 'имя функции', 'newF');
  editor.Lines.Add(' function '+funcName+'(){');
  editor.Lines.Add('}');
end;

procedure TfrmEditorJs.panJsClick(Sender: TObject);
begin

end;

procedure TfrmEditorJs.SynCompletion1CodeCompletion(var Value: string;
  SourceValue: string; var SourceStart, SourceEnd: TPoint; KeyChar: TUTF8Char;
  Shift: TShiftState);
begin

end;



end.

