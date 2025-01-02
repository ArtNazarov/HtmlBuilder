{ Contains dialog with css editor }
unit editor_css;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterCss, SynCompletion, Types, LCLType, ActnList, Menus,
  StrUtils, css_props_dlg, FontSettings;

type

  { TfrmEditorCss }

  { Dialog for css stylesheets }
  TfrmEditorCss = class(TForm)
    acTextAlignLeft: TAction;
    acTextAlignRight: TAction;
    acTextAlignCenter: TAction;
    acTextAlignJustify: TAction;
    acTextColor: TAction;
    acBackgroundColor: TAction;
    actFontSize: TAction;
    aclCssActions: TActionList;
    acFontFamily: TAction;
    btnClose: TButton;
    btnAddClass: TButton;
    btnAddId: TButton;
    lbCss: TLabel;
    mnuTextColor: TMenuItem;
    mnuBackgroundColor: TMenuItem;
    mnuColors: TMenuItem;
    mnuFontFamily: TMenuItem;
    mnuFontSize: TMenuItem;
    mnuTextAlignJustify: TMenuItem;
    mnuTextAlignRight: TMenuItem;
    mnuTextAlignCenter: TMenuItem;
    mnuTextAlignLeft: TMenuItem;
    mnuCssEditor: TMainMenu;
    mnuTextAlign: TMenuItem;
    mnuFontProperties: TMenuItem;
    panCss: TPanel;
    SynCompletion1: TSynCompletion;
    SynCssSyn1: TSynCssSyn;
    editor: TSynEdit;

    { handles click of btnAddClass }
    procedure acBackgroundColorExecute(Sender: TObject);
    procedure acFontFamilyExecute(Sender: TObject);
    procedure acTextAlignCenterExecute(Sender: TObject);
    procedure acTextAlignJustifyExecute(Sender: TObject);
    procedure acTextAlignLeftExecute(Sender: TObject);
    procedure acTextAlignRightExecute(Sender: TObject);
    procedure acTextColorExecute(Sender: TObject);
    procedure actFontSizeExecute(Sender: TObject);
    procedure btnAddClassClick(Sender: TObject);

    { handles click of btnAddId }
    procedure btnAddIdClick(Sender: TObject);

    { handles click of btnClose }
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    { handles autocompletion for css }
    procedure SynCompletion1CodeCompletion(var Value: string;
      SourceValue: string; var SourceStart, SourceEnd: TPoint;
      KeyChar: TUTF8Char; Shift: TShiftState);



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

procedure TfrmEditorCss.FormCreate(Sender: TObject);
var
   FontManager: TFontManager;
begin
     FontManager := TFontManager.Create();
     editor.Font := FontManager.Font;
     FontManager.Free;
end;

procedure TfrmEditorCss.SynCompletion1CodeCompletion(var Value: string;
  SourceValue: string; var SourceStart, SourceEnd: TPoint; KeyChar: TUTF8Char;
  Shift: TShiftState);
var i, j : Integer; S : TStringList; M : TMemo; A, B : TStringArray;
  dlg : TfrmCssProps;
begin
S:=TStringList.Create();
M:=TMemo.Create(Self);

M.Lines.LoadFromFile('css3-props-all.txt');
for i:=0 to M.Lines.Count-1 do
 begin
       if M.Lines[i] <>'' then
                   begin
                     SetLength(A, 0);
                     A:=StrUtils.SplitString(M.Lines[i],':');
                     S.AddPair(A[0], A[1]);

                     if Pos( value, A[0])>=0 then
                        begin
                             SetLength(B, 0);
                             B:=StrUtils.SplitString(A[1], '|');
                             dlg:=TfrmCssProps.Create(Self);
                             dlg.css_props.Clear;
                             for j:=0 to length(B)-1 do
                              begin
                                    dlg.css_props.AddItem( Trim( B[j] ), nil);
                              end;
                             dlg.ShowModal();
                             if dlg.css_props.ItemIndex >=0 then
                                 Value:=A[0]+':'+dlg.css_props.Items[ dlg.css_props.ItemIndex];


                             Break;
                       end;

                   end;

 end;
s.Free;
m.Free;

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

procedure TfrmEditorCss.acTextAlignLeftExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('text-align : left;');
end;

procedure TfrmEditorCss.acTextAlignCenterExecute(Sender: TObject);
begin
    editor.InsertTextAtCaret('text-align : center;');
end;

procedure TfrmEditorCss.acBackgroundColorExecute(Sender: TObject);
begin
    editor.InsertTextAtCaret('background-color : white;');
end;

procedure TfrmEditorCss.acFontFamilyExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('font-family : serif;');
end;

procedure TfrmEditorCss.acTextAlignJustifyExecute(Sender: TObject);
begin
    editor.InsertTextAtCaret('text-align : justify;');
end;

procedure TfrmEditorCss.acTextAlignRightExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('text-align : right;');
end;

procedure TfrmEditorCss.acTextColorExecute(Sender: TObject);
begin
    editor.InsertTextAtCaret('color : black;');
end;

procedure TfrmEditorCss.actFontSizeExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('font-size: 14pt;');
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

