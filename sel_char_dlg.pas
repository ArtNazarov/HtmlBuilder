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
    btnNi: TButton;
    btnProd: TButton;
    btnSum: TButton;
    btnLowast: TButton;
    btnRadic: TButton;
    btnProp: TButton;
    btnInfinity: TButton;
    btnAngle: TButton;
    btnIntegral: TButton;
    pcKeyboards: TPageControl;
    MathSheet: TTabSheet;
    MiscSheet: TTabSheet;
    procedure btnAngleClick(Sender: TObject);
    procedure btnEmptyClick(Sender: TObject);
    procedure btnExistsClick(Sender: TObject);
    procedure btnForAllClick(Sender: TObject);
    procedure btnInfinityClick(Sender: TObject);
    procedure btnIntegralClick(Sender: TObject);
    procedure btnIsInClick(Sender: TObject);
    procedure btnLowastClick(Sender: TObject);
    procedure btnNablaClick(Sender: TObject);
    procedure btnNiClick(Sender: TObject);
    procedure btnNotInClick(Sender: TObject);
    procedure btnPartClick(Sender: TObject);
    procedure btnProdClick(Sender: TObject);
    procedure btnPropClick(Sender: TObject);
    procedure btnRadicClick(Sender: TObject);
    procedure btnSpaceClick(Sender: TObject);
    procedure btnSumClick(Sender: TObject);
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

procedure TSelectSpecCharDlg.btnSumClick(Sender: TObject);
begin
  putKeys('&sum;');
end;

procedure TSelectSpecCharDlg.btnForAllClick(Sender: TObject);
begin
   putKeys('&forall;');
end;

procedure TSelectSpecCharDlg.btnInfinityClick(Sender: TObject);
begin
  putKeys('&infin;');
end;

procedure TSelectSpecCharDlg.btnIntegralClick(Sender: TObject);
begin
  putKeys('&int;');
end;

procedure TSelectSpecCharDlg.btnIsInClick(Sender: TObject);
begin
  putKeys('&isin;');
end;

procedure TSelectSpecCharDlg.btnLowastClick(Sender: TObject);
begin
   putKeys('&lowast;');
end;

procedure TSelectSpecCharDlg.btnNablaClick(Sender: TObject);
begin
  putKeys('&nabla;');
end;

procedure TSelectSpecCharDlg.btnNiClick(Sender: TObject);
begin
  putKeys('&ni;');
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

procedure TSelectSpecCharDlg.btnAngleClick(Sender: TObject);
begin
  putKeys('&ang;');
end;

procedure TSelectSpecCharDlg.btnPartClick(Sender: TObject);
begin
  putKeys('&exist;');
end;

procedure TSelectSpecCharDlg.btnProdClick(Sender: TObject);
begin
  putKeys('&prod;');
end;

procedure TSelectSpecCharDlg.btnPropClick(Sender: TObject);
begin
  putKeys('&prop;');
end;

procedure TSelectSpecCharDlg.btnRadicClick(Sender: TObject);
begin
  putKeys('&radic;');
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

