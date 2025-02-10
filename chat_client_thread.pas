{ unit for calling LLM client with separate thread}
unit chat_client_thread;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Process, StdCtrls;
type
{ TChatClientThread }

  TChatClientThread = class(TThread)
  private
    { process of LLM client }
    FChatClient: TProcess;
    { exit code of process }
    FExitCode: Integer;
    { error message if exit code not 0 }
    FErrorMsg: string;
    { name of file for saving responce from LLM }
    FResponseFile: string;
    { working dir for LLM client }
    FWorkingDir : string;
    { ui component to update GUI in synchronization }
    mmChatResponce : TMemo;
  protected
    { code for launching LLM client process }
    procedure Execute; override;
    { code for updating GUI to show responce }
    procedure UpdateGUI;
  public
    constructor Create(var mmChat : TMemo; workingDir : String);
    destructor Destroy; override;
  end;

implementation

{ TChatClientThread }

  procedure TChatClientThread.Execute;
  begin
    FChatClient := TProcess.Create(nil);
    try
      // Назначаем путь к исполняемому
      FChatClient.Executable := '/usr/bin/python';
      // Добавляем имя скрипта клиента Python
      FChatClient.Parameters.Add('client.py');
      // Устанавливаем текущий каталог для процесса согласно рабочего каталога программы
      FChatClient.CurrentDirectory := FWorkingDir;
      // Добавляем опции для асинхронного запуска
      FChatClient.Options := FChatClient.Options + [poWaitOnExit]; // Дождаться завершения процесса
      FChatClient.Execute; // Выполняем процесс клиента

      // Получаем код завершения клиента
      FExitCode := FChatClient.ExitCode;
      if FExitCode <> 0 then
      begin
        // Если ненулевой, добавляем сообщение об ошибке
        FErrorMsg := 'Error executing client.py';
      end
      else
      begin
        // Если без ошибок - забираем ответ из выходного файла
        FResponseFile := 'resp.txt';
      end;
    except
      on E: Exception do
      begin
        FErrorMsg := E.Message;
      end;
    end;

    // Обновляем GUI в основном потоке
      Synchronize(@UpdateGUI);
  end;

  procedure TChatClientThread.UpdateGUI;
  begin
        if FErrorMsg <> '' then
    begin
      // Показываем сообщение об ошибке
      mmChatResponce.Lines.Add(FErrorMsg);
    end
    else if FResponseFile <> '' then
    begin
      // Загружаем ответ из файла
      mmChatResponce.Lines.LoadFromFile(FResponseFile);
    end;
  end;

  constructor TChatClientThread.Create(var mmChat: TMemo; workingDir : String);
  begin
       inherited Create(False); // Создаем и сразу запускаем поток
       FreeOnTerminate := True; // Поток автоматически уничтожится после выполнения
       FResponseFile := 'resp.txt';
       mmChatResponce := mmChat;
       FWorkingDir := workingDir;
  end;

  destructor TChatClientThread.Destroy;
  begin
       mmChatResponce := nil;
       FChatClient.Free;
       inherited Destroy;
  end;


end.

