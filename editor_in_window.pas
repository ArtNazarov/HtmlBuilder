unit editor_in_window;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, ActnList, SynEdit, SynHighlighterHTML, SynEditSearch, SynEditTypes;

type

  { TfrmEditor }

  TfrmEditor = class(TForm)
    acEditor: TActionList;
    acSearch: TAction;
    acReplace: TAction;
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
    cboFormatting: TComboBox;
    cboFontFamily: TComboBox;
    cboJustify: TComboBox;
    Label1: TLabel;
    editor: TSynEdit;
    mnuReplace: TMenuItem;
    mnuSearch: TMenuItem;
    mmMenuEditor: TMainMenu;
    mnuFinder: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    panHtml5: TPanel;
    SynHTMLSyn1: TSynHTMLSyn;
    procedure acReplaceExecute(Sender: TObject);
    procedure acSearchExecute(Sender: TObject);
    procedure btnAnchorClick(Sender: TObject);
    procedure btnArticleClick(Sender: TObject);
    procedure btnASideClick(Sender: TObject);
    procedure btnBoldClick(Sender: TObject);
    procedure btnBrClick(Sender: TObject);
    procedure btnCloseEditorClick(Sender: TObject);
    procedure btnFontSizeLargerClick(Sender: TObject);
    procedure btnFontSizeSmallerClick(Sender: TObject);
    procedure btnFontStyleClick(Sender: TObject);
    procedure btnFooterClick(Sender: TObject);
    procedure btnHeaderClick(Sender: TObject);
    procedure btnHrClick(Sender: TObject);
    procedure btnHrefClick(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnJustifyClick(Sender: TObject);
    procedure btnMarginClick(Sender: TObject);
    procedure btnNavClick(Sender: TObject);
    procedure btnOrderedListClick(Sender: TObject);
    procedure btnFormatterClick(Sender: TObject);
    procedure btnPictureClick(Sender: TObject);
    procedure btnSectionClick(Sender: TObject);
    procedure btnStrikeClick(Sender: TObject);
    procedure btnSubClick(Sender: TObject);
    procedure btnSupClick(Sender: TObject);
    procedure btnTableClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure btnUnorderedListClick(Sender: TObject);
    procedure editorChange(Sender: TObject);
  private

  public
    markup : String;
    procedure pair(t: string);
    procedure tagHref();
    procedure tagImg();
    procedure tagAnchor();
    procedure tagList(t: string);

    procedure setMarkup(html : String);
    function getMarkup() : String;
    procedure tagC(tg, params : String);
    procedure tagX(tg, params : String);
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

procedure TfrmEditor.btnFooterClick(Sender: TObject);
begin
  pair('footer');
end;

procedure TfrmEditor.btnHeaderClick(Sender: TObject);
begin
  pair('header');
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

procedure TfrmEditor.acReplaceExecute(Sender: TObject);
var str, rep : String;
begin
  str:=InputBox('Поиск', 'Ищем', '');
  rep:=InputBox('Замена', 'На что меняем', '');
  if (str<>'') and (rep<>'') then
  editor.SearchReplace(str, rep,[ssoReplaceAll, ssoMatchCase,ssoEntireScope]);
end;

procedure TfrmEditor.btnArticleClick(Sender: TObject);
begin
  pair('article');
end;

procedure TfrmEditor.btnASideClick(Sender: TObject);
begin
  pair('aside');
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

procedure TfrmEditor.btnNavClick(Sender: TObject);
begin
  pair('nav');
end;

procedure TfrmEditor.btnOrderedListClick(Sender: TObject);
begin
  taglist('ol');
end;

procedure TfrmEditor.btnFormatterClick(Sender: TObject);
begin
  if cboFormatting.ItemIndex <=6 then
     begin
       pair('h'+IntToStr(cboFormatting.ItemIndex+1));
     end
  else
   begin
      case cboFormatting.ItemIndex of
      7 : begin pair('p'); end;
      8 : begin pair('code'); end;
      9 : begin pair('pre');  end;
      10 : begin pair('blockquote'); end;
      end;
   end;

end;

procedure TfrmEditor.btnPictureClick(Sender: TObject);
begin
  tagImg();
end;

procedure TfrmEditor.btnSectionClick(Sender: TObject);
begin
  pair('section');
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

procedure TfrmEditor.pair(t: string);
begin

  if (editor.SelText <> '') then
  editor.SelText:='<'+t+'>'+  editor.SelText+'</'+t+'>'
  else
    editor.Lines.Add('<'+t+'></'+t+'>');
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
    editor.Lines.Add('<'+tg+' '+params+'>'+'</'+tg+'>');
end;

procedure TfrmEditor.tagX(tg, params: String);
begin
     if (editor.SelText <> '') then
  editor.SelText:='<'+tg+' '+params+' />'+editor.SelText
  else
    editor.Lines.Add('<'+tg+' '+params+' />');
end;


end.

