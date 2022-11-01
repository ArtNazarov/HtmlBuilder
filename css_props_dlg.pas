unit css_props_dlg;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmCssProps }

  TfrmCssProps = class(TForm)
    btnClose: TButton;
    lbCssProps: TLabel;
    css_props: TListBox;
  private

  public

  end;

var
  frmCssProps: TfrmCssProps;

implementation

{$R *.lfm}

end.

