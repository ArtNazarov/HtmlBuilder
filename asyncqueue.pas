unit AsyncQueue;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


type

  { TAsyncWriter }

  TAsyncWriter = class
  private
    filename : String;
    data : String;

  public
    constructor Create(aFilename : String; aData : String );
    procedure writeDocument();
  end;


  { TAsyncWriteExecutor }

  TAsyncWriteExecutor = class(TThread)
    public

      aw : TAsyncWriter;
      filename : String;
      data : String;
      constructor Create(CreateSuspended : boolean);
      procedure setArgs(aFilename : String; aData : String);
  protected
    procedure Execute(); override;
  end;



   { TFilesQueue }

   TFilesQueue = class

     public
           filenames : Array of String;
           files : Array Of String;
           last : integer;
           constructor Create();
           procedure AddToJob(data : String; filename : String);
           procedure processEach();


   end;







implementation

{ TFilesQueue }

constructor TFilesQueue.Create();
begin
  last := -1;
  SetLength(filenames, 9999);
  SetLength(files, 9999);
end;

procedure TFilesQueue.AddToJob(data: String; filename : String);
begin
   last:=last+1;
   filenames[last]:=filename;
   files[last] := data;
end;

procedure TFilesQueue.processEach();
var
   i : Integer;
   aw : Array Of TAsyncWriteExecutor;
begin
  setLength(aw, last+1);
  for i:=0 to last do begin
      aw[i] := TAsyncWriteExecutor.Create(True);
      aw[i].setArgs(filenames[i], files[i]);
  end;
  for i:=0 to last do
  begin
      aw[i].Start;

  end;
end;


constructor TAsyncWriteExecutor.Create(CreateSuspended : boolean);
begin
    inherited Create(CreateSuspended);
    FreeOnTerminate := True;

end;

procedure TAsyncWriteExecutor.setArgs(aFilename: String; aData: String);
begin
  filename := aFilename;
  data := aData;
end;


procedure TAsyncWriteExecutor.Execute;

begin
  aw := TAsyncWriter.Create(filename, data);
  aw.writedocument;
end;

constructor TAsyncWriter.Create( aFilename : String; aData : String);
begin
  filename := aFileName;
  data := aData;

end;


procedure TAsyncWriter.writedocument();
var

  buffer : TStringList;


begin
  buffer  := TStringList.Create;


    if FileExists(filename) then DeleteFile(filename);
    buffer.Text:=data;
    buffer.SaveToFile(filename);

         buffer.Free;



end;

end.
