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
    btnAnd: TButton;
    btnOr: TButton;
    btnCap: TButton;
    btnCup: TButton;
    btnTherefore: TButton;
    btnSimilarTo: TButton;
    btnCongruent: TButton;
    btnAlmostEqual: TButton;
    pcKeyboards: TPageControl;
    MathSheet: TTabSheet;
    MiscSheet: TTabSheet;
    procedure btnAlmostEqualClick(Sender: TObject);
    procedure btnAndClick(Sender: TObject);
    procedure btnAngleClick(Sender: TObject);
    procedure btnCapClick(Sender: TObject);
    procedure btnCongruentClick(Sender: TObject);
    procedure btnCupClick(Sender: TObject);
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
    procedure btnOrClick(Sender: TObject);
    procedure btnPartClick(Sender: TObject);
    procedure btnProdClick(Sender: TObject);
    procedure btnPropClick(Sender: TObject);
    procedure btnRadicClick(Sender: TObject);
    procedure btnSimilarToClick(Sender: TObject);
    procedure btnSpaceClick(Sender: TObject);
    procedure btnSumClick(Sender: TObject);
    procedure btnThereforeClick(Sender: TObject);
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

procedure TSelectSpecCharDlg.btnThereforeClick(Sender: TObject);
begin
  putKeys('&there4;');
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

procedure TSelectSpecCharDlg.btnOrClick(Sender: TObject);
begin
  putKeys('&or;');
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

procedure TSelectSpecCharDlg.btnCapClick(Sender: TObject);
begin
  putKeys('&cap;');
end;

procedure TSelectSpecCharDlg.btnCongruentClick(Sender: TObject);
begin
  putKeys('&cong;');
end;

procedure TSelectSpecCharDlg.btnCupClick(Sender: TObject);
begin
  putKeys('&cup;');
end;

procedure TSelectSpecCharDlg.btnAndClick(Sender: TObject);
begin
  putKeys('&and;');
end;

procedure TSelectSpecCharDlg.btnAlmostEqualClick(Sender: TObject);
begin
  putKeys('&asymp;');
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

procedure TSelectSpecCharDlg.btnSimilarToClick(Sender: TObject);
begin
  putKeys('&sim;');
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

