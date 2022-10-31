unit editor_css;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterCss;

type

  { TfrmEditorCss }

  TfrmEditorCss = class(TForm)
    btnClose: TButton;
    btnAddClass: TButton;
    btnAddId: TButton;
    lbCss: TLabel;
    panCss: TPanel;
    SynCssSyn1: TSynCssSyn;
    editor: TSynEdit;
    procedure btnAddClassClick(Sender: TObject);
    procedure btnAddIdClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);



  private

  public
    procedure addCssInstruction(selector : String; var rules : TStringList);

  end;

var
  frmEditorCss: TfrmEditorCss;

implementation

{$R *.lfm}

{ TfrmEditorCss }

procedure TfrmEditorCss.btnCloseClick(Sender: TObject);
begin
   ModalResult:=mrOK;
   Close;
end;

procedure TfrmEditorCss.addCssInstruction(selector : String; var rules: TStringList);
var k : byte;
begin
   editor.Lines.add(selector+'{');
   for k:=0 to rules.count-1 do
    begin
        editor.lines.add( rules.Names[k]+' : '+rules.ValueFromIndex[k]+';');
    end;
   editor.lines.add('}');
end;

procedure TfrmEditorCss.btnAddClassClick(Sender: TObject);
var
  list : TStringList;
  classCss : String;
begin
  list:=TStringList.Create;
  list.AddPair('display','block');
  classCss := InputBox('Новый класс', 'Имя класса', '.newClass');
  addCssInstruction( classCss, list);
  list.free;
end;

procedure TfrmEditorCss.btnAddIdClick(Sender: TObject);
var
  list : TStringList;
  IdCss : String;
begin
  list:=TStringList.Create;
  list.AddPair('display','block');
  IdCss := InputBox('Новый ID', 'Имя ID', '#newId');
  addCssInstruction( IdCss, list);
  list.free;
end;








end.

