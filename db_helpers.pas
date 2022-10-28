unit db_helpers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBCtrls,   SQLite3Conn, SQLDB, process, StdCtrls, ExtCtrls, ComCtrls, Menus, DBGrids ;


procedure checkConnect(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction; msg: String);

procedure  sql_execute(request: string; var konnect: TSQLite3Connection;
  var tranzact: TSQLTransaction; var sQ: TSQLQuery);
procedure  sql_execute_direct(request: string; var konnect: TSQLite3Connection;
  var tranzact: TSQLTransaction );
procedure  prepared_transaction_start(request : String; var sQ : TSQLQuery; tranzact : TSQLTransaction);
procedure  prepared_transaction_end(var sQ : TSQLQuery; tranzact : TSQLTransaction);
procedure  open_sql(request : string; var sQ : TSQLQuery);


implementation

procedure checkConnect(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction; msg: String);
begin
   if not konnect.Connected then
          begin
          // SilentMessage('нет соединения, переподключаюсь! <'+msg+'>');
           konnect.Open;
           tranzact.Active:=true;
          end; (*
  else
    SilentMessage('требование выполнено <'+msg+'>');
    *)
end;

procedure  sql_execute(request: string; var konnect: TSQLite3Connection;
  var tranzact: TSQLTransaction; var sQ: TSQLQuery);
begin
  if not tranzact.Active then tranzact.StartTransaction;
  try
    sQ.SQL.Text:=request;
    sQ.ExecSQL;
  finally
    if tranzact.Active then tranzact.Commit; { or fTrans.CommitRetaining; }
  end;
end;

procedure  sql_execute_direct(request: string; var konnect: TSQLite3Connection;
  var tranzact: TSQLTransaction );
begin
  if not tranzact.Active then tranzact.StartTransaction;
  try

    konnect.ExecuteDirect( request );
  finally
    if tranzact.Active then tranzact.Commit; { or fTrans.CommitRetaining; }
  end;
end;

procedure  prepared_transaction_start(request : String; var sQ : TSQLQuery; tranzact : TSQLTransaction);
begin
sQ.ReadOnly:=False;
sQ.sql.text := request;
sQ.prepare;
end;

procedure  prepared_transaction_end(var sQ : TSQLQuery; tranzact : TSQLTransaction);
begin
   sQ.ExecSQL; // подготовим запрос
   // выполним транзакцию
  tranzact.CommitRetaining;  //or possibly CommitRetainin
end;

procedure open_sql(request: string; var sQ: TSQLQuery);
begin
  sQ.SQL.Text := request;
  sQ.Open;
end;

end.

