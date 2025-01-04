unit sel_char_dlg;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, IniFiles,
  StdCtrls, SynEdit, ComCtrls;

type

  { TSelectSpecCharDlg }

  TSelectSpecCharDlg = class(TForm)
    btnSpace: TButton;
    btnForAll: TButton;
    btnCent: TButton;
    btnPart: TButton;
    btnExists: TButton;
    btnEmpty: TButton;
    btnNabla: TButton;
    btnIsIn: TButton;
    btnNotIn: TButton;
    pcKeyboards: TPageControl;
    MathSheet: TTabSheet;
    MiscSheet: TTabSheet;
    procedure btnEmptyClick(Sender: TObject);
    procedure btnExistsClick(Sender: TObject);
    procedure btnForAllClick(Sender: TObject);
    procedure btnIsInClick(Sender: TObject);
    procedure btnNablaClick(Sender: TObject);
    procedure btnNotInClick(Sender: TObject);
    procedure btnPartClick(Sender: TObject);
    procedure btnSpaceClick(Sender: TObject);
  private

  public
    editor : TSynEdit;
    procedure setEditor(var some_editor : TSynEdit);
    procedure putKeys(str : string);
  end;

var
  SelectSpecCharDlg: TSelectSpecCharDlg;

implementation

{ TSelectSpecCharDlg }

procedure TSelectSpecCharDlg.btnSpaceClick(Sender: TObject);
begin
  putKeys('&nbsp;');
end;

procedure TSelectSpecCharDlg.btnForAllClick(Sender: TObject);
begin
   putKeys('&forall;');
end;

procedure TSelectSpecCharDlg.btnIsInClick(Sender: TObject);
begin
  putKeys('&isin;');
end;

procedure TSelectSpecCharDlg.btnNablaClick(Sender: TObject);
begin
  putKeys('&nabla;');
end;

procedure TSelectSpecCharDlg.btnNotInClick(Sender: TObject);
begin
  putKeys('&notin;');
end;

procedure TSelectSpecCharDlg.btnExistsClick(Sender: TObject);
begin
  putKeys('&part;');
end;

procedure TSelectSpecCharDlg.btnEmptyClick(Sender: TObject);
begin
  putKeys('&empty;');
end;

procedure TSelectSpecCharDlg.btnPartClick(Sender: TObject);
begin
  putKeys('&exist;');
end;

procedure TSelectSpecCharDlg.setEditor(var some_editor: TSynEdit);
begin
  editor := some_editor;
end;

procedure TSelectSpecCharDlg.putKeys(str: string);
begin
  editor.InsertTextAtCaret(str);
end;

initialization
  {$I sel_char_dlg.lrs}

end.

