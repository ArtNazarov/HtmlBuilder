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
    pcKeyboards: TPageControl;
    MathSheet: TTabSheet;
    MiscSheet: TTabSheet;
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

