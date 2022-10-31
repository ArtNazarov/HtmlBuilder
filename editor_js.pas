unit editor_js;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterJScript;

type

  { TfrmEditorJs }

  TfrmEditorJs = class(TForm)
    btnClose: TButton;
    btnAddFunction: TButton;
    lbScriptName: TLabel;
    editor: TSynEdit;
    panJs: TPanel;
    SynJScriptSyn1: TSynJScriptSyn;
    procedure btnAddFunctionClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure panJsClick(Sender: TObject);

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



end.

