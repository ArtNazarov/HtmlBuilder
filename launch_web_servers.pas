unit launch_web_servers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, UTF8Process;
type

{ TPythonServerLauncher }

TPythonServerLauncher = class(TThread)
 private
   p : TProcessUTF8;
 protected
   procedure Execute; override;
 public
   port : String;
   ipaddress : String;
   dirpath : String;
 end;


{ TPhpServerLauncher }

TPhpServerLauncher = class(TThread)
 private
   p : TProcessUTF8;
 protected
   procedure Execute; override;
 public
   port : String;
   ipaddress : String;
   dirpath : String;
 end;

implementation

{ TPythonServerLauncher }

procedure TPythonServerLauncher.Execute;
var
   Output : TStringList;
begin
  Output := TStringList.Create();
  p := TProcessUTF8.Create(nil);
  p.executable:='konsole';
  p.parameters.Add('-e');
  p.Parameters.Add('/usr/bin/python');
  p.parameters.add('-m');
  p.Parameters.add('http.server');
  p.Parameters.Add('-b');
  p.Parameters.Add(ipaddress);
  p.Parameters.Add(port);
  p.Parameters.Add('-d');
  p.Parameters.Add(dirpath);





  p.execute;
  while p.Active do ;
  Output.LoadFromStream(p.Output);
  Output.SaveToFile('result.log');
  p.Free;
  output.Free;
end;

{ TPhpServerLauncher }

procedure TPhpServerLauncher.Execute;
var
   Output : TStringList;
begin
  Output := TStringList.Create();
  p := TProcessUTF8.Create(nil);
  p.executable:='konsole';
  p.parameters.Add('-e');
  p.Parameters.Add('/usr/bin/php');
  p.parameters.add('-S');;
  p.Parameters.Add(ipaddress+':'+port);
  p.Parameters.Add('-t');
  p.Parameters.Add(dirpath);





  p.execute;
  while p.Active do ;
  Output.LoadFromStream(p.Output);
  Output.SaveToFile('result.log');
  p.Free;
  output.Free;
end;

end.

