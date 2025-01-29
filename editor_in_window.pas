{ Contains window with HTML editor }
unit editor_in_window;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, ActnList, SynEdit, SynHighlighterHTML, SynEditSearch, SynEditTypes,
  SynCompletion, UTF8Process, Types, LCLType, ColorBox, ExtDlgs, FontSettings,
  sel_char_dlg, Process;

type

  { TfrmEditor }

  { Window with HTML editor }
  TfrmEditor = class(TForm)
    acEditor: TActionList;
    acSearch: TAction;
    acReplace: TAction;
    acRedo: TAction;
    acNewForm: TAction;
    acDocSection: TAction;
    acDocArticle: TAction;
    acDocSide: TAction;
    acDocHeader: TAction;
    acDocFooter: TAction;
    acDocNavMenu: TAction;
    acAddress: TAction;
    acDefinitionListWrapper: TAction;
    acDefTerm: TAction;
    acDefDefinition: TAction;
    acMainTag: TAction;
    acInputText: TAction;
    acInputPassword: TAction;
    acInputCheckbox: TAction;
    acInputRadio: TAction;
    acInputHidden: TAction;
    acSelectTag: TAction;
    acOptionTag: TAction;
    acScreenKeyboard: TAction;
    acTextArea: TAction;
    acOutputTag: TAction;
    acApplyPrettier: TAction;
    acMetaDescription: TAction;
    acMetaAuthor: TAction;
    acAudioTag: TAction;
    acAudioSourceTag: TAction;
    acForegroundColor: TAction;
    acBackgroundColor: TAction;
    acInsertDate: TAction;
    acVideoSourceTag: TAction;
    acVideoTag: TAction;
    acUndo: TAction;
    btnCloseEditor: TButton;
    btnFormatter: TButton;
    btnUnorderedList: TButton;
    btnItalic: TButton;
    btnBold: TButton;
    btnUnderline: TButton;
    btnSup: TButton;
    btnSub: TButton;
    btnHref: TButton;
    btnPicture: TButton;
    btnOrderedList: TButton;
    btnAnchor: TButton;
    btnFontStyle: TButton;
    btnTable: TButton;
    btnHr: TButton;
    btnStrike: TButton;
    btnMargin: TButton;
    btnJustify: TButton;
    btnBr: TButton;
    btnSection: TButton;
    btnArticle: TButton;
    btnASide: TButton;
    btnHeader: TButton;
    btnFooter: TButton;
    btnNav: TButton;
    btnFontSizeLarger: TButton;
    btnFontSizeSmaller: TButton;
    btmMainTag: TButton;
    btnForegroundColor: TButton;
    btnBackgroundSpanColor: TButton;
    cdDate: TCalendarDialog;
    cboFormatting: TComboBox;
    cboFontFamily: TComboBox;
    cboJustify: TComboBox;
    cbColors: TColorBox;
    Label1: TLabel;
    editor: TSynEdit;
    MenuItem1: TMenuItem;
    mnuInsertDate: TMenuItem;
    mnuAudioSourceTag: TMenuItem;
    mnuAudioTag: TMenuItem;
    mnuMetaAuthor: TMenuItem;
    mnuMetaDescription: TMenuItem;
    mnuMetaTags: TMenuItem;
    mnuOutputTag: TMenuItem;
    mnuTextArea: TMenuItem;
    mnuScreenKeyboard: TMenuItem;
    mnuSelectTag: TMenuItem;
    mnuOptionTag: TMenuItem;
    mnuInputRadio: TMenuItem;
    mnuInputHidden: TMenuItem;
    mnuInputCheckbox: TMenuItem;
    mnuInputPassword: TMenuItem;
    mnuVideoSource: TMenuItem;
    mnuVideoTag: TMenuItem;
    mnuContent: TMenuItem;
    mnuInputText: TMenuItem;
    mnuMainTag: TMenuItem;
    mnuDefDefinition: TMenuItem;
    mnuDefTerm: TMenuItem;
    mnuDefinitionsListWrapper: TMenuItem;
    mnuDefinitions: TMenuItem;
    mnuAddress: TMenuItem;
    mnuDocSection: TMenuItem;
    mnuDocArticle: TMenuItem;
    mnuDocSide: TMenuItem;
    mnuDocHeader: TMenuItem;
    mnuDocFooter: TMenuItem;
    mnuDocNavMenu: TMenuItem;
    mnuDocStructure: TMenuItem;
    mnuNewForm: TMenuItem;
    mnuForms: TMenuItem;
    mnuRedo: TMenuItem;
    mnuActions: TMenuItem;
    mnuUndo: TMenuItem;
    mnuReplace: TMenuItem;
    mnuSearch: TMenuItem;
    mmMenuEditor: TMainMenu;
    mnuFinder: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    panHtml5: TPanel;
    SynCompletion1: TSynCompletion;
    SynHTMLSyn1: TSynHTMLSyn;
    procedure acAddressExecute(Sender: TObject);
    procedure acApplyPrettierExecute(Sender: TObject);
    procedure acAudioSourceTagExecute(Sender: TObject);
    procedure acAudioTagExecute(Sender: TObject);
    procedure acBackgroundColorExecute(Sender: TObject);
    procedure acDefDefinitionExecute(Sender: TObject);
    procedure acDefinitionListWrapperExecute(Sender: TObject);
    procedure acDefTermExecute(Sender: TObject);
    procedure acDocArticleExecute(Sender: TObject);
    procedure acDocFooterExecute(Sender: TObject);
    procedure acDocHeaderExecute(Sender: TObject);
    procedure acDocNavMenuExecute(Sender: TObject);
    procedure acDocSectionExecute(Sender: TObject);
    procedure acDocSideExecute(Sender: TObject);
    procedure acForegroundColorExecute(Sender: TObject);
    procedure acInputCheckboxExecute(Sender: TObject);
    procedure acInputHiddenExecute(Sender: TObject);
    procedure acInputPasswordExecute(Sender: TObject);
    procedure acInputRadioExecute(Sender: TObject);
    procedure acInputTextExecute(Sender: TObject);
    procedure acInsertDateExecute(Sender: TObject);
    procedure acMainTagExecute(Sender: TObject);
    procedure acMetaAuthorExecute(Sender: TObject);
    procedure acMetaDescriptionExecute(Sender: TObject);
    procedure acNewFormExecute(Sender: TObject);
    procedure acOptionTagExecute(Sender: TObject);
    procedure acOutputTagExecute(Sender: TObject);
    procedure acRedoExecute(Sender: TObject);
    procedure acReplaceExecute(Sender: TObject);
    procedure acScreenKeyboardExecute(Sender: TObject);
    procedure acSearchExecute(Sender: TObject);
    procedure acSelectTagExecute(Sender: TObject);
    procedure acTextAreaExecute(Sender: TObject);
    procedure acUndoExecute(Sender: TObject);
    procedure acVideoSourceTagExecute(Sender: TObject);
    procedure acVideoTagExecute(Sender: TObject);
    procedure btnAnchorClick(Sender: TObject);


    procedure btnBoldClick(Sender: TObject);
    procedure btnBrClick(Sender: TObject);
    procedure btnCloseEditorClick(Sender: TObject);
    procedure btnFontSizeLargerClick(Sender: TObject);
    procedure btnFontSizeSmallerClick(Sender: TObject);
    procedure btnFontStyleClick(Sender: TObject);


    procedure btnHrClick(Sender: TObject);
    procedure btnHrefClick(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnJustifyClick(Sender: TObject);
    procedure btnMarginClick(Sender: TObject);

    procedure btnOrderedListClick(Sender: TObject);
    procedure btnFormatterClick(Sender: TObject);
    procedure btnPictureClick(Sender: TObject);

    procedure btnStrikeClick(Sender: TObject);
    procedure btnSubClick(Sender: TObject);
    procedure btnSupClick(Sender: TObject);
    procedure btnTableClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure btnUnorderedListClick(Sender: TObject);
    procedure editorChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SynCompletion1CodeCompletion(var Value: string;
      SourceValue: string; var SourceStart, SourceEnd: TPoint;
      KeyChar: TUTF8Char; Shift: TShiftState);
  private

  public
    { HTML text}
    markup : String;

    { Places paired tag }
    procedure pair(t: string);

    { Places a href tag}
    procedure tagHref();

    { Places img tag}
    procedure tagImg();

    { Places anchor }
    procedure tagAnchor();

    { Places list tag}
    procedure tagList(t: string);

    { Setter for member markup }
    procedure setMarkup(html : String);

    { Getter for member markup}
    function getMarkup() : String;

    { Places open and closed tags}
    procedure tagC(tg, params : String);

    { Places single tag like hr}
    procedure tagX(tg, params : String);

    { Get RGB color from TColorBox}
    function getRGB(var cbSomeColorBox : TColorBox): String;
  end;

var
  frmEditor: TfrmEditor;

implementation

{$R *.lfm}

{ TfrmEditor }

procedure TfrmEditor.btnCloseEditorClick(Sender: TObject);
begin
  ModalResult:=mrOK;
  Close();
end;

procedure TfrmEditor.btnFontSizeLargerClick(Sender: TObject);
begin
  tagC('span', 'style="font-size:larger"');
end;

procedure TfrmEditor.btnFontSizeSmallerClick(Sender: TObject);
begin
  tagC('span', 'style="font-size:smaller"');
end;

procedure TfrmEditor.btnFontStyleClick(Sender: TObject);
begin
  if cboFontFamily.ItemIndex>=0 then
  tagC('span', 'style="font-family:'+cboFontFamily.Items[cboFontFamily.ItemIndex]+'"');
end;





procedure TfrmEditor.btnHrClick(Sender: TObject);
begin
  tagX('hr','');
end;

procedure TfrmEditor.btnHrefClick(Sender: TObject);
begin
  tagHref();
end;

procedure TfrmEditor.btnBoldClick(Sender: TObject);
begin
  pair('b');
end;

procedure TfrmEditor.btnBrClick(Sender: TObject);
begin
  tagX('br', '');
end;

procedure TfrmEditor.btnAnchorClick(Sender: TObject);
begin
  tagAnchor();
end;

procedure TfrmEditor.acSearchExecute(Sender: TObject);
var str : String;

begin
  str:=InputBox('Поиск', 'Ищем', '');

  if str<>'' then
  editor.SearchReplace(str, '', [ssoMatchCase,ssoEntireScope]);
end;

procedure TfrmEditor.acSelectTagExecute(Sender: TObject);
begin
  tagC('select', 'name="vname"');
end;

procedure TfrmEditor.acTextAreaExecute(Sender: TObject);
begin
  tagC('textarea', 'cols="60"');
end;

procedure TfrmEditor.acUndoExecute(Sender: TObject);
begin
  editor.Undo;
end;

procedure TfrmEditor.acVideoSourceTagExecute(Sender: TObject);
begin
  tagX('source', 'src="video.mp4" type="video/mp4"');
end;

procedure TfrmEditor.acVideoTagExecute(Sender: TObject);
begin
  tagC('video', 'width="640" height="360" controls');
end;

procedure TfrmEditor.acReplaceExecute(Sender: TObject);
var str, rep : String;
begin
  str:=InputBox('Поиск', 'Ищем', '');
  rep:=InputBox('Замена', 'На что меняем', '');
  if (str<>'') and (rep<>'') then
  editor.SearchReplace(str, rep,[ssoReplaceAll, ssoMatchCase,ssoEntireScope]);
end;

procedure TfrmEditor.acScreenKeyboardExecute(Sender: TObject);
var
  d : TSelectSpecCharDlg;
begin
   d := TSelectSpecCharDlg.Create(Self);
   d.setEditor(self.editor);
   d.Show;
end;

procedure TfrmEditor.acRedoExecute(Sender: TObject);
begin
  editor.Redo;
end;

procedure TfrmEditor.acNewFormExecute(Sender: TObject);
begin
 tagC('form', 'method="POST"');
end;

procedure TfrmEditor.acOptionTagExecute(Sender: TObject);
begin
  tagC('option', 'value="some_value"');
end;

procedure TfrmEditor.acOutputTagExecute(Sender: TObject);
begin
  tagC('output', 'for="name"');
end;

procedure TfrmEditor.acDocSectionExecute(Sender: TObject);
begin
     pair('section');
end;

procedure TfrmEditor.acDocSideExecute(Sender: TObject);
begin
    pair('aside');
end;

procedure TfrmEditor.acForegroundColorExecute(Sender: TObject);
begin
  if cbColors.ItemIndex > 1 then begin
     tagC('span', 'style="color: '+
     getRGB(cbColors)+
     '"');
  end;
end;

procedure TfrmEditor.acInputCheckboxExecute(Sender: TObject);
begin
  tagX('input', 'type="checkbox" name="vname" checked');
end;

procedure TfrmEditor.acInputHiddenExecute(Sender: TObject);
begin
    tagX('input', 'type="hidden" name="vname" value="defvalue"');
end;

procedure TfrmEditor.acInputPasswordExecute(Sender: TObject);
begin
  tagX('input', 'type="password" name="vname" size="10" maxlength="40" value="defval"');
end;

procedure TfrmEditor.acInputRadioExecute(Sender: TObject);
begin
     tagX('input', 'type="radio" name="vname"');
end;

procedure TfrmEditor.acInputTextExecute(Sender: TObject);
begin
  tagX('input', 'type="text" name="vname" size="10" maxlength="40" value="defval"');
end;

procedure TfrmEditor.acInsertDateExecute(Sender: TObject);
begin
  if cdDate.Execute then
     begin
        editor.InsertTextAtCaret( DateToStr(cdDate.Date) );
     end;
end;

procedure TfrmEditor.acMainTagExecute(Sender: TObject);
begin
  pair('main');
end;

procedure TfrmEditor.acMetaAuthorExecute(Sender: TObject);
begin
  tagX('meta', 'name="author" content="Author Name"');
end;

procedure TfrmEditor.acMetaDescriptionExecute(Sender: TObject);
begin
  tagX('meta', 'name="description" content="A brief description of your page."');
end;

procedure TfrmEditor.acDocArticleExecute(Sender: TObject);
begin
  pair('article');
end;

procedure TfrmEditor.acAddressExecute(Sender: TObject);
begin
  pair('address');
end;

procedure TfrmEditor.acApplyPrettierExecute(Sender: TObject);
var
  Process: TProcess;

begin
  editor.Lines.SaveToFile('temp.html');
  // Get the current directory


  // Create and configure the process
  Process := TProcessUTF8.Create(nil);
  try
    Process.Executable := '/usr/bin/prettier';
    Process.Parameters.Add('--write');
    Process.Parameters.Add(GetCurrentDir+'/temp.html');

    // Optionally set other process options
    Process.Options := [poWaitOnExit];

    // Execute the process
    Process.Execute;

  finally
    Process.Free;
  end;
  editor.Lines.LoadFromFile('temp.html');
  DeleteFile('temp.html');
  markup := editor.Lines.Text;
end;

procedure TfrmEditor.acAudioSourceTagExecute(Sender: TObject);
begin
  tagX('source', 'src="/path/to/file.mp3" type="audio/mpeg"')
end;

procedure TfrmEditor.acAudioTagExecute(Sender: TObject);
begin
  tagC('audio', 'controls');
end;

procedure TfrmEditor.acBackgroundColorExecute(Sender: TObject);
begin
  if cbColors.ItemIndex > -1 then begin
     tagC('span', 'style="background-color: '+
     getRGB(cbColors)+
     '"');
  end;
end;

procedure TfrmEditor.acDefDefinitionExecute(Sender: TObject);
begin
  pair('dd');
end;

procedure TfrmEditor.acDefinitionListWrapperExecute(Sender: TObject);
begin
  pair('dl');
end;

procedure TfrmEditor.acDefTermExecute(Sender: TObject);
begin
  pair('dt');
end;

procedure TfrmEditor.acDocFooterExecute(Sender: TObject);
begin
    pair('footer');
end;

procedure TfrmEditor.acDocHeaderExecute(Sender: TObject);
begin
   pair('header');
end;

procedure TfrmEditor.acDocNavMenuExecute(Sender: TObject);
begin
   pair('nav');
end;





procedure TfrmEditor.btnItalicClick(Sender: TObject);
begin
  pair('i');
end;

procedure TfrmEditor.btnJustifyClick(Sender: TObject);
begin
  if cboJustify.ItemIndex > 0 then
  case cboJustify.ItemIndex of
  0 : begin tagC('span', 'style="text-align:left"'); end;
  1 : begin tagC('span', 'style="text-align:right"'); end;
  2 : begin tagC('span', 'style="text-align:center"'); end;
  3 : begin tagC('span', 'style="text-align:justify"'); end;
  end;
end;

procedure TfrmEditor.btnMarginClick(Sender: TObject);
var k, m : byte;
begin
 m:=StrToInt(inputBox('Шаг отступа', 'В пикселях', '10'));
 k:=StrToInt(inputBox('Сдвиг', 'Множитель', '1'));
 tagC('div', 'style="margin-left:'+IntToStr(m*k)+'px;"');
end;



procedure TfrmEditor.btnOrderedListClick(Sender: TObject);
begin
  taglist('ol');
end;

procedure TfrmEditor.btnFormatterClick(Sender: TObject);
begin
  if cboFormatting.ItemIndex <=5 then
     begin
       pair('h'+IntToStr(cboFormatting.ItemIndex+1));
     end
  else
   begin
      case cboFormatting.ItemIndex of
      6 : begin pair('p'); end;
      7 : begin pair('code'); end;
      8 : begin pair('pre');  end;
      9 : begin pair('blockquote'); end;
      end;
   end;

end;

procedure TfrmEditor.btnPictureClick(Sender: TObject);
begin
  tagImg();
end;



procedure TfrmEditor.btnStrikeClick(Sender: TObject);
begin
  pair('strike');
end;

procedure TfrmEditor.btnSubClick(Sender: TObject);
begin
  pair('sub');
end;

procedure TfrmEditor.btnSupClick(Sender: TObject);
begin
  pair('sup');
end;

procedure TfrmEditor.btnTableClick(Sender: TObject);
var
  table_view : String;
  row_view   : String;
  row_count : Integer;
  col_count : Integer;
  row, col  : Integer;
begin
  row_count:=StrToInt(InputBox('Таблица', 'Введи число строк', '2')) ;
  col_count:=StrToInt(InputBox('Таблица', 'Введи число колонок', '2')) ;



  table_view:='<table>';
  for row:=1 to row_count do begin
      row_view:='<tr>';
  for col:=1 to col_count do
      begin
         row_view:=row_view+'<td></td>';
      end;
      row_view:=row_view+'</tr>';
      table_view := table_view + row_view;
  end;
  table_view := table_view + '</table>';

  editor.Lines.Add(table_view);



end;

procedure TfrmEditor.btnUnderlineClick(Sender: TObject);
begin
  pair('u');
end;

procedure TfrmEditor.btnUnorderedListClick(Sender: TObject);
begin
  tagList('ul');
end;

procedure TfrmEditor.editorChange(Sender: TObject);
begin
  markup:=editor.Text;
end;

procedure TfrmEditor.FormCreate(Sender: TObject);
var
   FontManager: TFontManager;
begin
     FontManager := TFontManager.Create();
     editor.Font := FontManager.Font;
     FontManager.Free;
end;

procedure TfrmEditor.SynCompletion1CodeCompletion(var Value: string;
  SourceValue: string; var SourceStart, SourceEnd: TPoint; KeyChar: TUTF8Char;
  Shift: TShiftState);
begin

  if (SourceStart.x >= 1) and  (SourceStart.y >= 1) then
  begin
      Value := '<' + Value+'> </' + Value+'>';
    end;
end;

procedure TfrmEditor.pair(t: string);
begin

  if (editor.SelText <> '') then
  editor.SelText:='<'+t+'>'+  editor.SelText+'</'+t+'>'
  else
    editor.InsertTextAtCaret('<'+t+'></'+t+'>');
end;


procedure TfrmEditor.tagHref;
begin
  tagC('a','href=""');
end;

procedure TfrmEditor.tagImg;
begin
  tagX('img', 'src="" alt="" ');
end;

procedure TfrmEditor.tagAnchor;
begin
  tagC('a', 'href="#name"');
end;

procedure TfrmEditor.tagList(t: string);
var i, k :  byte;
begin
  k:=StrToInt( InputBox('Список', 'Число элементов в списке', '3'));
   editor.Lines.Add('<' + t + '>');
   for i:=1 to k do
        begin
           editor.Lines.Add('<li>Элемент списка '+IntToStr(i)+'</li>');
        end;
   editor.Lines.Add('</' + t + '>');
end;

procedure TfrmEditor.setMarkup(html: String);
begin
  markup:=html;
  editor.Text:=html;
end;

function TfrmEditor.getMarkup: String;
begin
  result:=markup;
end;

procedure TfrmEditor.tagC(tg, params: String);
 begin
  if (editor.SelText <> '') then
  editor.SelText:='<'+tg+' '+params+'>'+editor.SelText+'</'+tg+'>'
  else
    editor.InsertTextAtCaret('<'+tg+' '+params+'>'+'</'+tg+'>');
end;

procedure TfrmEditor.tagX(tg, params: String);
begin
     if (editor.SelText <> '') then
  editor.SelText:='<'+tg+' '+params+' />'+editor.SelText
  else
    editor.InsertTextAtCaret('<'+tg+' '+params+' />');
end;

function TfrmEditor.getRGB(var cbSomeColorBox: TColorBox): String;
var
  c: TColor;
  r, g, b: Byte;
begin
  c := cbSomeColorBox.Selected;
  r := Red(c);
  g := Green(c);
  b := Blue(c);

  // Форматирование в строку #RRGGBB
  Result := Format('#%2.2X%2.2X%2.2X', [r, g, b]);
end;


end.

