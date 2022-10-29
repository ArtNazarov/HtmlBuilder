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
    btnPar: TButton;
    btnUnorderedList: TButton;
    btnItalic: TButton;
    btnBold: TButton;
    btnUnderline: TButton;
    btnSup: TButton;
    btnSub: TButton;
    btnHref: TButton;
    btnPicture: TButton;
    btnOrderedList: TButton;
    Label1: TLabel;
    editor: TSynEdit;
    Panel1: TPanel;
    SynHTMLSyn1: TSynHTMLSyn;
    procedure btnBoldClick(Sender: TObject);
    procedure btnCloseEditorClick(Sender: TObject);
    procedure btnHrefClick(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnOrderedListClick(Sender: TObject);
    procedure btnParClick(Sender: TObject);
    procedure btnPictureClick(Sender: TObject);
    procedure btnSubClick(Sender: TObject);
    procedure btnSupClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure btnUnorderedListClick(Sender: TObject);
    procedure editorChange(Sender: TObject);
  private

  public
    markup : String;
    procedure pair(t: string);
    procedure tagHref();
    procedure tagImg();
    procedure tagList(t: string);

    procedure setMarkup(html : String);
    function getMarkup() : String;
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

procedure TfrmEditor.btnHrefClick(Sender: TObject);
begin
  tagHref();
end;

procedure TfrmEditor.btnBoldClick(Sender: TObject);
begin
  pair('b');
end;

procedure TfrmEditor.btnItalicClick(Sender: TObject);
begin
  pair('i');
end;

procedure TfrmEditor.btnOrderedListClick(Sender: TObject);
begin
  taglist('ol');
end;

procedure TfrmEditor.btnParClick(Sender: TObject);
begin
  pair('p');
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
  editor.Lines.Add('<a href=""></a>');
end;

procedure TfrmEditor.tagImg;
begin
  editor.Lines.Add('<img src="" />');
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

end.

