unit RenderHtml;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, replacers, fgl, types_for_app;

type

  { Render }

  Render = class
    vars : sdict;
    template : String;
    html     : String;
    constructor Create;
    destructor Free;
    procedure setTemplate(aTemplate : String);
    procedure setVar(varname, varvalue : String);
    procedure buildHtml();
    function getHtml() : String;

  end;

implementation

{ Render }

constructor Render.Create;
begin
  vars:=sdict.Create;
end;

destructor Render.Free;
begin
  vars.Free;
end;

procedure Render.setTemplate(aTemplate: String);
begin
   template:=aTemplate;
end;

procedure Render.setVar(varname, varvalue: String);
begin
  vars.Add(varname, varvalue);
end;

procedure Render.buildHtml;
var R : String; i : Integer;
begin
  R:=template;
  for i:=0 to vars.count-1 do
   begin
     R:=applyVar(R, vars.Keys[i], vars.Data[i]);
   end;
  html:=R;
end;

function Render.getHtml: String;
begin
   buildHtml();
   result:=html;
end;

end.

