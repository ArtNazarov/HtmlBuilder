unit replacers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function applyVar(str, variable, value : string) : string;
implementation

function  applyVar(str, variable, value: string): string;
begin
   Result:=StringReplace(str, '{'+variable+'}', value, [rfReplaceAll]);
end;
end.

