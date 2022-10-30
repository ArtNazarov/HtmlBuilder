unit editor_css;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, SynEdit,
  SynHighlighterCss;

type

  { TfrmEditorCss }

  TfrmEditorCss = class(TForm)
    btnClose: TButton;
    lbCss: TLabel;
    SynCssSyn1: TSynCssSyn;
    editor: TSynEdit;
    procedure btnCloseClick(Sender: TObject);



  private

  public

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








end.

