{ Contains dialog with css editor }
unit editor_css;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterCss, SynCompletion, Types, LCLType, ActnList, Menus,
  StrUtils, css_props_dlg, FontSettings, Process;

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
    acPositionRelative: TAction;
    acPositionAbsolute: TAction;
    acPositionFixed: TAction;
    acPositionSticky: TAction;
    acOffsetLeft: TAction;
    acOffsetTop: TAction;
    acOffsetRight: TAction;
    acOffsetBottom: TAction;
    acFontStyleItalic: TAction;
    acFontStyleOblique: TAction;
    acFontWeightBold: TAction;
    acFontWeightLight: TAction;
    acTextDecorationLineStrikeThrough: TAction;
    acTextDecorationLineOverline: TAction;
    acTextDecorationLineUnderline: TAction;
    acSuperScript: TAction;
    acSubScript: TAction;
    acApplyPrettier: TAction;
    btnClose: TButton;
    btnAddClass: TButton;
    btnAddId: TButton;
    lbCss: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    mnuApplyPrettier: TMenuItem;
    mnuCssActions: TMenuItem;
    mnuSuperscript: TMenuItem;
    mnuSubscript: TMenuItem;
    mnuIndexes: TMenuItem;
    mnuOverline: TMenuItem;
    mnuStrikeThrough: TMenuItem;
    mnuUnderline: TMenuItem;
    mnuLineDecorations: TMenuItem;
    mnuItalic: TMenuItem;
    mnuOblique: TMenuItem;
    mnuBold: TMenuItem;
    mnuLight: TMenuItem;
    mnuDecorations: TMenuItem;
    mnuBottomOffset: TMenuItem;
    mnuOffsets: TMenuItem;
    mnuPositionSticky: TMenuItem;
    mnuPositionFixed: TMenuItem;
    mnuPositionAbsolute: TMenuItem;
    mnuPositionRelative: TMenuItem;
    mnuPositioning: TMenuItem;
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

    { Обработчики событий }
    
    { Обрабатывает нажатие на кнопку "Применить Prettier" }
    procedure acApplyPrettierExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Цвет фона" }
    procedure acBackgroundColorExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Тип шрифта" }
    procedure acFontFamilyExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Курсив" }
    procedure acFontStyleItalicExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Наклонный" }
    procedure acFontStyleObliqueExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Полужирный" }
    procedure acFontWeightBoldExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Легкий" }
    procedure acFontWeightLightExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Отступ снизу" }
    procedure acOffsetBottomExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Отступ слева" }
    procedure acOffsetLeftExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Отступ справа" }
    procedure acOffsetRightExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Отступ сверху" }
    procedure acOffsetTopExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Абсолютное позиционирование" }
    procedure acPositionAbsoluteExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Фиксированное позиционирование" }
    procedure acPositionFixedExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Относительное позиционирование" }
    procedure acPositionRelativeExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Липкое позиционирование" }
    procedure acPositionStickyExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Нижний индекс" }
    procedure acSubScriptExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Верхний индекс" }
    procedure acSuperScriptExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Выравнивание текста по центру" }
    procedure acTextAlignCenterExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Выравнивание текста по ширине" }
    procedure acTextAlignJustifyExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Выравнивание текста по левому краю" }
    procedure acTextAlignLeftExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Выравнивание текста по правому краю" }
    procedure acTextAlignRightExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Цвет текста" }
    procedure acTextColorExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Перечеркивание текста сверху" }
    procedure acTextDecorationLineOverlineExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Перечеркивание текста снизу" }
    procedure acTextDecorationLineStrikeThroughExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Подчеркивание текста" }
    procedure acTextDecorationLineUnderlineExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Размер шрифта" }
    procedure actFontSizeExecute(Sender: TObject);

    { Обрабатывает нажатие на кнопку "Добавить класс" }
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

procedure TfrmEditorCss.acApplyPrettierExecute(Sender: TObject);
var
  Process: TProcess;

begin
  editor.Lines.SaveToFile('temp.css');
  // Get the current directory


  // Create and configure the process
  Process := TProcess.Create(nil);
  try
    Process.Executable := '/usr/bin/prettier';
    Process.Parameters.Add('--write');
    Process.Parameters.Add(GetCurrentDir+'/temp.css');

    // Optionally set other process options
    Process.Options := [poWaitOnExit];

    // Execute the process
    Process.Execute;

  finally
    Process.Free;
  end;
  editor.Lines.LoadFromFile('temp.css');
  DeleteFile('temp.css');

end;

procedure TfrmEditorCss.acFontFamilyExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('font-family : serif;');
end;

procedure TfrmEditorCss.acFontStyleItalicExecute(Sender: TObject);
begin
     editor.InsertTextAtCaret('font-style : italic;');
end;

procedure TfrmEditorCss.acFontStyleObliqueExecute(Sender: TObject);
begin
    editor.InsertTextAtCaret('font-style : oblique;');
end;

procedure TfrmEditorCss.acFontWeightBoldExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('font-weight : bold;');
end;

procedure TfrmEditorCss.acFontWeightLightExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('font-weight : lighter;');
end;

procedure TfrmEditorCss.acOffsetBottomExecute(Sender: TObject);
begin
     editor.InsertTextAtCaret('bottom : 0px;');
end;

procedure TfrmEditorCss.acOffsetLeftExecute(Sender: TObject);
begin
     editor.InsertTextAtCaret('left : 0px;');
end;

procedure TfrmEditorCss.acOffsetRightExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('right : 0px;');
end;

procedure TfrmEditorCss.acOffsetTopExecute(Sender: TObject);
begin
     editor.InsertTextAtCaret('top : 0px;');
end;

procedure TfrmEditorCss.acPositionAbsoluteExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('position : absolute;');
end;

procedure TfrmEditorCss.acPositionFixedExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('position : fixed;');
end;

procedure TfrmEditorCss.acPositionRelativeExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('position : relative;');
end;

procedure TfrmEditorCss.acPositionStickyExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('position : sticky;');
end;

procedure TfrmEditorCss.acSubScriptExecute(Sender: TObject);
begin
  editor.InsertTextAtCaret('font-size: smaller; vertical-align: sub;');
end;

procedure TfrmEditorCss.acSuperScriptExecute(Sender: TObject);
begin
   editor.InsertTextAtCaret('font-size: smaller; vertical-align: super;');
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

procedure TfrmEditorCss.acTextDecorationLineOverlineExecute(Sender: TObject);
begin
     editor.InsertTextAtCaret('text-decoration-line : overline;');
end;

procedure TfrmEditorCss.acTextDecorationLineStrikeThroughExecute(Sender: TObject
  );
begin
     editor.InsertTextAtCaret('text-decoration-line : line-through;');
end;

procedure TfrmEditorCss.acTextDecorationLineUnderlineExecute(Sender: TObject);
begin
   editor.InsertTextAtCaret('text-decoration-line : underline;');
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

