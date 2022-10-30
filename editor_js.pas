unit editor_js;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, SynEdit,
  SynHighlighterJScript;

type

  { TfrmEditorJs }

  TfrmEditorJs = class(TForm)
    btnClose: TButton;
    lbScriptName: TLabel;
    editor: TSynEdit;
    SynJScriptSyn1: TSynJScriptSyn;
    procedure btnCloseClick(Sender: TObject);

  private

  public

    end;







var
  frmEditorJs: TfrmEditorJs;

implementation

{$R *.lfm}

{ TfrmEditorJs }

procedure TfrmEditorJs.btnCloseClick(Sender: TObject);
begin
    modalresult:=mrok;
    close;
end;



end.

