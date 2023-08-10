{ Functions for applyting variables to html templates }
unit replacers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

{ Sets in HTML template str value of variable  to string value }
function applyVar(str, variable, value : string) : string;


function applyImage(str, variable, source, alt: string): string;


implementation

function  applyVar(str, variable, value: string): string;
begin
   Result:=StringReplace(str, '{'+variable+'}', value, [rfReplaceAll]);
end;

function  applyImage(str, variable, source, alt: string): string;
begin
   Result:=StringReplace(str, '(('+variable+'))',
   '<img src="' + source + '" alt="'+alt+'" >', [rfReplaceAll]);
end;




end.

