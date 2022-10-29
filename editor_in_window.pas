unit editor_in_window;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterHTML;

type

  { TfrmEditor }

  TfrmEditor = class(TForm)
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
    cboFormatting: TComboBox;
    cboFontFamily: TComboBox;
    Label1: TLabel;
    editor: TSynEdit;
    Panel1: TPanel;
    SynHTMLSyn1: TSynHTMLSyn;
    procedure btnAnchorClick(Sender: TObject);
    procedure btnBoldClick(Sender: TObject);
    procedure btnCloseEditorClick(Sender: TObject);
    procedure btnFontStyleClick(Sender: TObject);
    procedure btnHrefClick(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnOrderedListClick(Sender: TObject);
    procedure btnFormatterClick(Sender: TObject);
    procedure btnPictureClick(Sender: TObject);
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

procedure TfrmEditor.btnFontStyleClick(Sender: TObject);
begin
  if cboFontFamily.ItemIndex>=0 then
  tagC('span', 'style="font-family:'+cboFontFamily.Items[cboFontFamily.ItemIndex]+'"');
end;

procedure TfrmEditor.btnHrefClick(Sender: TObject);
begin
  tagHref();
end;

procedure TfrmEditor.btnBoldClick(Sender: TObject);
begin
  pair('b');
end;

procedure TfrmEditor.btnAnchorClick(Sender: TObject);
begin
  tagAnchor();
end;

procedure TfrmEditor.btnItalicClick(Sender: TObject);
begin
  pair('i');
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
      end;
   end;

end;

procedure TfrmEditor.btnPictureClick(Sender: TObject);
begin
  tagImg();
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
begin
   editor.Lines.Add('<' + t + '>');
   editor.Lines.Add('<li>Элемент списка 1</li>');
  editor.Lines.Add('<li>Элемент списка 2</li>');
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

