unit main;

{$mode objfpc}{$H+}

interface



uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBCtrls, dbf, SQLite3Conn, SQLDB, process, FileUtil, SynHighlighterHTML,
  SynEdit, StdCtrls, ExtCtrls, ComCtrls, Menus, DBGrids, ActnList, Buttons,
  blcksock, sockets, Synautil, synaip, synsock, ftpsend, db_helpers,
  db_insertdemo, db_create_tables, replacers, editor_in_window; {Use Synaptic}

const

   SilentMode : boolean = True;
   logger_info : boolean = True;
   sqlite_filename : String = 'sqlite.db';
   msgBaseSuccess : String = 'База данных успешно создана.';
   msgErrorCreating : String = 'Невозможно создать новую базу данных';
   msgCantCheckDbFile : String = 'Невозможно проверить, существует ли файл базы данных';

    DELIM : Char = '/';

    DLM_MODULE = '%';

type

  user_records = array[0..7] of record
              name : string;
              value : string;
            end;

  rubric_pages = record
            pages_total   : array[0..255] of byte; // число страниц
            section_index : array[0..255] of byte;
            sectionhtml : array[0..255] of String;
            number_of_page : array[0..255] of byte;
            rubric_counter : byte;


  end;

  page_pairs = record
            content_id : string;
            caption    : string;
  end;

  section_params = record
            id : string;
            section : string;
            note    : string;
            full_text : string;
            content_id : string;
            caption : string;
            sectiontpl :  string;
            headtpl : string;
            itemtpl : string;
            dirpath : string;
            pages   : array[0..255] of page_pairs;
            pages_counter : byte; // счетчик страниц

  end;

  section_list = record
            sections : array[0..255] of section_params;
            section_counter : byte; // счетчик разделов
  end;

  page_params = record
            id        : String;
            title     : String;
            body      : String;
            section_id : String;
            section_title : String;
            sitename : String;
            dirpath : String;
            headtpl : String;
            bodytpl : String;
            sectiontpl : String;
            dir : String;
            user_field_names : array[0..7] of String;
            user_field_values  : array[0..7] of String;
  end;


  { ServerThread }



  { TForm1 }

  TForm1 = class(TForm)
    acEditorForSectionNote: TAction;
    acEditorForSectionFullText: TAction;
    acEditorForBlockMarkup: TAction;
    acEditorForHeadTemplate: TAction;
    acEditorForBodyTemplate: TAction;
    acEditorForRubricSectionTemplate: TAction;
    acEditorForRubricItemTemplate: TAction;
    actsEditors: TActionList;
    btFtpUpdate: TButton;
    btStartServer: TButton;
    btStopServer: TButton;
    Buffer: TMemo;
    btnMakeArchive: TButton;
    btnLoad: TButton;
    btnJoin: TButton;
    btnEditorContent: TButton;
    btnEditorForSectionNote: TButton;
    btnEditorForSectionFullText: TButton;
    btnEditorForBlockMarkup: TButton;
    btnEditorHeadTemplate: TButton;
    btnEditorBodyPagesTemplate: TButton;
    BtnEditorBodySectionsTemplate: TButton;
    btnEditorTemplateOfItem: TButton;
    cboLocale: TComboBox;
    chkUseModules: TCheckBox;
    chkGetBlocksFromFile: TCheckBox;
    choicePreset: TDBLookupComboBox;
    dbmSectionFullText: TDBMemo;
    ds_Rubrication: TDataSource;
    dgCounter: TDBGrid;
    ds_Counter: TDataSource;
    ds_Join: TDataSource;
    dbJoin: TDBGrid;
    lbSpecification: TLabel;
    lvPresets: TListView;
    lvBlocks: TListView;
    lvContent: TListView;
    lvSections: TListView;
    mmRubrics: TMemo;
    panJoin: TPanel;
    selSection: TDBLookupComboBox;
    ds_Content: TDataSource;
    ds_Presets: TDataSource;
    ds_Blocks: TDataSource;
    ds_Sections: TDataSource;
    dbeBlockId: TDBEdit;
    dbePageField1: TDBEdit;
    dbePageField2: TDBEdit;
    dbePageField3: TDBEdit;
    dbePageField4: TDBEdit;
    dbePageField5: TDBEdit;
    dbePageField6: TDBEdit;
    dbePageField7: TDBMemo;
    dbeUserField1: TDBEdit;
    dbeUserField2: TDBEdit;
    dbeUserField3: TDBEdit;
    dbeUserField4: TDBEdit;
    dbeUserField5: TDBEdit;
    dbePreset: TDBEdit;
    dbeUserField6: TDBEdit;
    dbeUserField7: TDBEdit;
    dbeSiteName: TDBEdit;
    dbeSiteDirectory: TDBEdit;
    dbeSectionId: TDBEdit;
    dbeSectionCaption: TDBEdit;
    dbeBlockNote: TDBMemo;
    dbeBlockHtml: TDBMemo;
    dbmHeadTemplate: TDBMemo;
    dbmBodyPagesTemplate: TDBMemo;
    dbmSectionNote: TDBMemo;
    dbmBodySectionsTemplate: TDBMemo;
    dbmTemplateOfItem: TDBMemo;
    dbNav_Content: TDBNavigator;
    dbNav_Blocks: TDBNavigator;
    dbNav_Presets: TDBNavigator;
    dbNav_Sections: TDBNavigator;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    edFtpIP: TEdit;
    edFtpPassword: TEdit;
    edFtpPort: TEdit;
    edFtpUsername: TEdit;
    edFileManager: TEdit;
    edArchiveName: TEdit;
    edIpAddress: TEdit;
    edPort: TEdit;
    edPathToBuild: TEdit;
    edItemsPerPage: TEdit;
    fCaption: TDBEdit;
    fContent: TDBMemo;
    fID: TDBEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    lbIpAddress: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    lbConnectionLog: TLabel;
    lbPort: TLabel;
    lbArchiveName: TLabel;
    lbPathToBuild: TLabel;
    lbFileManager: TLabel;
    lbItemsPerPage: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    mmFtpLog: TMemo;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    panUserFields: TPanel;
    Panel15: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    panWebServer: TPanel;
    panServActions: TPanel;
    Panel25: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PrefferedExtension: TComboBox;
    conn: TSQLite3Connection;
    sqlContent: TSQLQuery;
    sqlJoin: TSQLQuery;
    sqlCounter: TSQLQuery;
    sqlRubrication: TSQLQuery;
    tabJoin: TTabSheet;
    temp_sql: TSQLQuery;
    trans: TSQLTransaction;
    sqlSections: TSQLQuery;
    sqlBlocks: TSQLQuery;
    sqlPresets: TSQLQuery;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    MainMenu1: TMainMenu;
    Panel16: TPanel;
    Panel17: TPanel;
    tabUpdateByFTP: TTabSheet;
    tabSpecial: TTabSheet;
    mmAbout: TMemo;
    AppPages: TPageControl;
    Panel1: TPanel;
    Panel12: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Process1: TProcess;
    tabPages: TTabSheet;
    tabWebServer: TTabSheet;
    tabCommonSettings: TTabSheet;
    tabHelp: TTabSheet;
    tabGlobalBlocks: TTabSheet;
    tabSections: TTabSheet;
    WebServerLog: TMemo;
    ZipArchiverCommand: TEdit;


    procedure acEditorForBlockMarkupExecute(Sender: TObject);
    procedure acEditorForBodyTemplateExecute(Sender: TObject);
    procedure acEditorForHeadTemplateExecute(Sender: TObject);
    procedure acEditorForRubricItemTemplateExecute(Sender: TObject);
    procedure acEditorForRubricSectionTemplateExecute(Sender: TObject);
    procedure acEditorForSectionFullTextExecute(Sender: TObject);
    procedure acEditorForSectionNoteExecute(Sender: TObject);
    procedure btBuildSiteClick(Sender: TObject);
    procedure btFtpUpdateClick(Sender: TObject);

    procedure btnJoinClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);


    procedure btStartServerClick(Sender: TObject);
    procedure btStopServerClick(Sender: TObject);

    procedure btnMakeArchiveClick(Sender: TObject);

    procedure btnEditorContentClick(Sender: TObject);

    procedure cboLocaleChange(Sender: TObject);
    procedure dbNav_ContentBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure dbNav_BlocksBeforeAction(Sender: TObject; Button: TDBNavButtonType
      );
    procedure dbNav_PresetsBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure dbNav_SectionsBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure lvBlocksClick(Sender: TObject);
    procedure lvContentClick(Sender: TObject);
    procedure lvPresetsClick(Sender: TObject);
    procedure lvSectionsClick(Sender: TObject);







    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure FormCreate(Sender: TObject);


    procedure sqlBlocksAfterDelete(DataSet: TDataSet);
    procedure sqlBlocksAfterPost(DataSet: TDataSet);
    procedure sqlContentAfterDelete(DataSet: TDataSet);

    procedure sqlContentAfterPost(DataSet: TDataSet);
    procedure sqlPresetsAfterDelete(DataSet: TDataSet);
    procedure sqlPresetsAfterPost(DataSet: TDataSet);
    procedure sqlSectionsAfterDelete(DataSet: TDataSet);
    procedure sqlSectionsAfterPost(DataSet: TDataSet);




  private
    { private declarations }
  public
    { public declarations }
    Titles, Urls, Sections: TMemo;
    SiteSectionUrls, SiteSectionTitles: TMemo;
    SitePresets : TMemo;
    ListenerSocket, ConnectionSocket: TTCPBlockSocket;

    Blocks : TStringList; // блоки

    Cache : tStringList;    {{ for webserver }}
    PostsEditorState : String;

    procedure initdbSQL(); // <-- новая инициализация
    function buildHead(title: string; headTemplate: string): string;
    function buildBody(title: string; body: string; bodyTemplate: string): string;
    function useBlocks(part: string): string;
    procedure scanLinks();
    procedure scanSections();
    function insLinks(body: string): string;
    function insSections(body: string): string;




    function moduleexec(cmd: string): string;
    function useModules(app: string): string;
    function owntagexec(containter, cmd: string): string;
    function useOwnTags(app: string): string;
    function buildItem(itemtpl: string; itemUrl: string; itemTitle: string; ur : user_records): string;
    function buildSection(sectiontpl: string; sectionUrl: string;
      sectionTitle: string;
      sectionNote: string;
      sectionFullText : string;
      items: string): string;
    function buildPagination(url: string; currentPage: byte;
      pagesTotal: integer): string;
    procedure AttendConnection(ASocket: TTCPBlockSocket);
    procedure StartOwnServer();
    procedure StopOwnServer();
    function OutputHTMLFile(uri: string): string;
    function buildOwnFields(html: string; p : page_params): string;
    function prefExtension(lin: string): string;
    procedure localeRUS();
    procedure localeENG();

    function Pager(layout: String; pages: String): String;


    procedure initTransactionSQL(); // Иниц. транзакция Sqlite
















    { Просмотр базы }
    procedure makeSqlActive();
    procedure makeSqlInactive();
    procedure viewPagesSQL();   // раздел страницы
    procedure viewSectionsSQL();  // раздел секции сайта
    procedure viewBlocksSQL();  // раздел глобальные блоки сайта
    procedure viewPresetsSQL();  // раздел пресеты (настройки сайта)
    procedure viewTablesSQL(); // выполняем запросы на просмотр таблиц


    { Переназначение datasource для таблицы content - страницы }
    procedure changeDataSourcesContent();
    { Переназначение datasource для таблицы section - разделы}
     procedure changeDataSourcesSections();
    { Переназначение datasource для таблицы block - глоб. блоки}
     procedure changeDataSourcesBlocks();
     { Переназначение datasource для таблицы preset - нач. настройки сайта}
     procedure changeDataSourcesPresets();

     (* Заполнение демо данными *)

     procedure makeCreationTables();
     procedure changeDataSources();





     procedure SilentMessage(msg : String);

     procedure AutoSaveDb();
     (* НОВАЯ ВЕРСИЯ СБОРКИ СТРАНИЦ *)
     procedure doJoinPages();
     procedure  makePageJoin(page : page_params; filenam : String );
     procedure  writeDocument( document : String; filenam: String);
     procedure doSections();
     procedure doSitemap();
     function insertSectionsAndLinks(str : string) : string;
     procedure scanBlocks();
     procedure scanPresets();
     procedure doScan();

     procedure editor_win_show(sql : TSQLQuery; field : String );






       end;










var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  form1.initdbSQL();

  Cache:=TStringList.Create;

  dbNav_Content.DataSource.AutoEdit := True;
  dbNav_Content.Enabled := True;

  Titles := TMemo.Create(Self); // Заголовки
  Urls := TMemo.Create(Self); // URL страниц
  Sections := TMemo.Create(Self); // Разделы страниц


  SiteSectionUrls := TMemo.Create(Self); // URL разделов
  SiteSectionTitles := TMemo.Create(Self); // Заголовки разделов
  blocks:=TStringList.Create();
  sitePresets:=TMemo.Create(Self);

  doScan();
  edPathToBuild.Text:=GetEnvironmentVariable('HOME')+'/mysite';
end;




procedure TForm1.sqlBlocksAfterDelete(DataSet: TDataSet);
begin
  doScan();
end;

procedure TForm1.sqlBlocksAfterPost(DataSet: TDataSet);
begin
  doScan();
end;

procedure TForm1.sqlContentAfterDelete(DataSet: TDataSet);
begin
  doScan();
end;





procedure TForm1.sqlContentAfterPost(DataSet: TDataSet);
begin
  doScan();
end;

procedure TForm1.sqlPresetsAfterDelete(DataSet: TDataSet);
begin
  doScan();
end;

procedure TForm1.sqlPresetsAfterPost(DataSet: TDataSet);
begin
  doScan();
end;

procedure TForm1.sqlSectionsAfterDelete(DataSet: TDataSet);
begin
  doScan();
end;

procedure TForm1.sqlSectionsAfterPost(DataSet: TDataSet);
begin
  doScan();
end;








procedure TForm1.btFtpUpdateClick(Sender: TObject);
var
  IP, Port, FileName, LocalFile, Path, User, Pass: string;
  F: TSearchRec;
  b: boolean;
  ServerEnabled: boolean;
  FTPClient: TFtpSend;
begin
     // test with vsftpd
  ServerEnabled := False;

  FTPClient := TFTPSend.Create;
  FTPClient.TargetHost := edFtpIp.Text;
  FTPClient.TargetPort := edFtpPort.Text;
  FTPClient.UserName := edFtpUsername.Text;
  FTPClient.Password := edFtpPassword.Text;


  btFtpUpdate.Enabled := False;
  IP := edFtpIP.Text;
  Port := edFtpPort.Text;
  User := edFtpUsername.Text;
  Pass := edFtpPassword.Text;

  Path := sqlPresets.FieldByName('dirpath').AsString;

  if FtpClient.Login then

      ServerEnabled := True;



  if ServerEnabled then mmFtpLog.Lines.Add(
      'Подключение установлено')
  else
    mmFtpLog.Lines.Add('Подключение не установлено');

  if ServerEnabled = True then
  begin
    if FindFirst(Path + DELIM+'*.*', faAnyFile, F) = 0 then
    begin
      while FindNext(F) = 0 do
      begin
        Application.ProcessMessages;
        if (F.Name = '.') or (F.Name = '..') then continue;
        LocalFile := Path + DELIM + F.Name;
        FileName := F.Name;

        // remove file on remote site (only from build)

        if FtpClient.Login then
        begin
          mmFtpLog.Lines.Add('Запрос на удаление ' +
            FileName + ' с сервера');
          if FtpClient.DeleteFile(FileName) then
            mmFtpLog.Lines.Add('... успешно удален')
          else
            mmFtpLog.Lines.Add('... не удалось удалить');
          FtpClient.Logout;
        end;

        // put new file

        b := FtpPutFile(IP, Port, FileName, LocalFile, User, Pass);
        if b then
          mmFtpLog.Lines.Add('[+] Файл ' + FileName +
            ' выгружен на сервер из ' + LocalFile)
        else
          mmFtpLog.Lines.Add('[x] Файл ' + FileName +
            ' не удалось выгрузить на сервер из ' + LocalFile);
      end;
    end;
    FindClose(F);

  end;
  FtpClient.Free;
  btFtpUpdate.Enabled := True;

end;



{ Тестовый код }
procedure TForm1.btnJoinClick(Sender: TObject);
begin

  form1.scanLinks(); // сканер ссылок нужен для автозамены
  form1.scanSections(); // сканер секций нужен для автозамены
  form1.scanBlocks(); // сканируем блоки

  doJoinPages(); // страницы
  doSections();  // разделы
  doSitemap(); // карта сайта
end;

{{ ===============     ЗАГРУЗКА ИЗ ТЕКСТОВЫХ ФАЙЛОВ ============= }}

procedure TForm1.btnLoadClick(Sender: TObject);
var fbuffer : TStringList; idOfBlocksInBase : TStringList;
   blockFiles : TStringList;
   id, markup : String;
   i, j, k : Integer;
   InstalledIds, InstalledMarkups : TStringList;
   exists : Boolean;
   indexToUpdate : Integer;
begin

  fbuffer:=TStringList.Create();
  // Получим список всех id из текстовых файлов /blocks/*.blk и разметку markup
    idOfBlocksInBase:=TStringList.Create;
    installedIds:=TStringList.Create;
    installedMarkups:=TStringList.Create;
    fbuffer:=TStringList.Create;
  // Установка разметки контейнеров
  sqlPresets.Edit;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts'+DELIM+'head.tpl' );
  Form1.dbmHeadTemplate.Text:=fbuffer.text;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts' + DELIM+ 'body.tpl' );
  Form1.dbmBodyPagesTemplate.Text :=fbuffer.text;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts'+DELIM+'section.tpl' );
  Form1.dbmSectionNote.Text:=fbuffer.text;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts'+DELIM+'full_text.tpl' );
  Form1.dbmSectionFullText.Text:=fbuffer.text;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts'+DELIM+'item.tpl' );
  Form1.dbmTemplateOfItem.Text:=fbuffer.text;
  sqlPresets.Post; // Применяем изменения
  // Получим список всех ID в таблице sqlBlocks
  sqlBlocks.First;
  while not sqlBlocks.EOF do begin
      idOfBlocksInBase.Add( sqlBlocks.FieldByName('id').AsString);
      sqlBlocks.Next;
  end;

    blockFiles := FindAllFiles(GetCurrentDir()+DELIM+'blocks', '*.blk', false); // получили список блоков
    // первая строка - id блока
    // остальные HTML разметка
    for i:=0 to blockFiles.Count-1 do
        begin
          fbuffer.LoadFromFile( blockFiles[i] ); // already have abs paths
          id:=fbuffer.Strings[0];
          markup:='';
          for j:=1 to fbuffer.Count-1 do
              begin
                markup:=markup+fbuffer.Strings[j];
              end;
              InstalledIds.Add(id);
              InstalledMarkups.Add(markup);
        end;

     for i:=0 to InstalledIds.Count-1 do
         begin
           exists:=false;
           indexToUpdate := -1;
           for j:=0 to  idOfBlocksInBase.Count -1 do
               begin
                 if idOfBlocksInBase[j]=InstalledIds[i] then
                   begin
                        exists:=true; IndexToUpdate := j; break;
                   end;
               end;
           if exists then
              begin
                   sqlBlocks.First; k := 0;
                   while not sqlBlocks.EOF do
                         begin
                            if k<>indexToUpdate then

                             inc(k) else break;

                             sqlBlocks.Next;

                         end;
                   sqlBlocks.Edit;
                   sqlBlocks.FieldByName('id').AsString := installedIds[i];
                   sqlBlocks.FieldByName('markup').AsString := installedMarkups[i];
                   sqlBlocks.Post;
              end
           else
           begin
                 sqlBlocks.Insert;
                 sqlBlocks.FieldByName('id').AsString := installedIds[i];
                 sqlBlocks.FieldByName('markup').AsString := installedMarkups[i];
                 sqlBlocks.Post;
           end;
         end;


  fbuffer.Free;
  idOfBlocksInBase.Free;
  installedMarkups.Free;
  installedIds.Free;
end;



procedure TForm1.btBuildSiteClick(Sender: TObject);
begin

end;

procedure TForm1.acEditorForSectionNoteExecute(Sender: TObject);

begin
     editor_win_show( sqlSections, 'note');
end;

procedure TForm1.acEditorForSectionFullTextExecute(Sender: TObject);
begin
    editor_win_show( sqlSections, 'full_text');
end;

procedure TForm1.acEditorForBlockMarkupExecute(Sender: TObject);
begin
     editor_win_show( sqlBlocks, 'markup');
end;

procedure TForm1.acEditorForBodyTemplateExecute(Sender: TObject);
begin
       editor_win_show(sqlPresets, 'bodytpl');
end;

procedure TForm1.acEditorForHeadTemplateExecute(Sender: TObject);
begin
   editor_win_show(sqlPresets, 'headtpl');
end;

procedure TForm1.acEditorForRubricItemTemplateExecute(Sender: TObject);
begin
  editor_win_show(sqlPresets, 'itemtpl');
end;

procedure TForm1.acEditorForRubricSectionTemplateExecute(Sender: TObject);
begin
   editor_win_show(sqlPresets, 'sectiontpl');
end;



procedure TForm1.btStartServerClick(Sender: TObject);
begin
  btStartServer.Enabled := False;
  btStopServer.Enabled := True;
  StartOwnServer();

end;

procedure TForm1.btStopServerClick(Sender: TObject);
begin

  StopOwnServer();
  btStartServer.Enabled := True;
  btStopServer.Enabled := False;
end;



procedure TForm1.btnMakeArchiveClick(Sender: TObject);
var
  dir: string;
  command_for_archive : String;
begin
  dir := sqlPresets.FieldByName('dirpath').AsString;
  command_for_archive:=applyVar(applyVar(applyVar(ZipArchiverCommand.Text, 'DIR', dir), 'ZIPNAME', edArchiveName.Text),
  'DEST',  edPathToBuild.Text);

  Process1.CommandLine := command_for_archive;
  Process1.Execute;
  Process1.CommandLine := edFileManager.Text + ' '+ edPathToBuild.Text;
  Process1.Execute;

  edFileManager.Text :=  command_for_archive;

end;



procedure TForm1.btnEditorContentClick(Sender: TObject);
var fE : TfrmEditor;
begin
  fE:=TfrmEditor.Create(Self);
  fE.setMarkup( sqlContent.FieldByName('content').AsString);
  fE.ShowModal();

  sqlContent.Edit;
  sqlContent.FieldByName('content').AsString:=fE.getMarkup();

  fE.Close();
  fE.Free;
end;



procedure TForm1.cboLocaleChange(Sender: TObject);
begin
  if cboLocale.ItemIndex = 0 then
    LocaleRUS()
  else
    LocaleENG();
end;

procedure TForm1.dbNav_ContentBeforeAction(Sender: TObject; Button: TDBNavButtonType);
begin
    if (Button = nbRefresh) or (Button=nbDelete) then
  begin
   sqlContent.ApplyUpdates();
   trans.CommitRetaining;
  end;
end;

procedure TForm1.dbNav_BlocksBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
   if (Button = nbRefresh) or (Button=nbDelete) then
  begin
   sqlBlocks.ApplyUpdates();
   trans.CommitRetaining;
  end;
end;

procedure TForm1.dbNav_PresetsBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
     if (Button = nbRefresh) or (Button=nbDelete) then
  begin
   sqlPresets.ApplyUpdates();
   trans.CommitRetaining;
  end;
end;

procedure TForm1.dbNav_SectionsBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
    if (Button = nbRefresh) or (Button=nbDelete) then
  begin
   sqlSections.ApplyUpdates();
   trans.CommitRetaining;
  end;
end;

procedure TForm1.lvBlocksClick(Sender: TObject);
var block_id : String;
begin
  block_id := lvBlocks.Selected.Caption;
  sqlBlocks.Locate('id', block_id, []);
end;

procedure TForm1.lvContentClick(Sender: TObject);
var content_id : String;
begin
  content_id := lvContent.Selected.Caption;
  sqlContent.Locate('id', content_id, []);
end;

procedure TForm1.lvPresetsClick(Sender: TObject);
var preset_id : String;
begin
  preset_id := lvPresets.Selected.Caption;
  sqlPresets.Locate('id', preset_id, []);
end;

procedure TForm1.lvSectionsClick(Sender: TObject);
var section_id : String;
begin
  section_id := lvSections.Selected.Caption;
  sqlSections.Locate('id', section_id, []);
end;





















procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  form1.makeSqlInactive();
  if ListenerSocket <> nil then ListenerSocket.Free;
  if ConnectionSocket <> nil then  ConnectionSocket.Free;
end;



procedure TForm1.initdbSQL;
begin
  // в начале иниц. транзакция
  Form1.initTransactionSQL();
  // по выходу из блока предполагается, что
  // либо база создана с нуля, либо уже заполнена
  SilentMessage('Начальная транзакция сделана...');

  // 2. переключаем источники данных
  form1.changeDataSources(); // назначаем для 4 таблиц
  SilentMessage('Источники подключены...');
  form1.viewTablesSQL(); // 3. вызываем запросы
  SilentMessage('Запросы выполнены...');
end;

function TForm1.buildHead(title: string; headTemplate: string): string;
var
  r: string;
begin
  r := headTemplate;
  r := StringReplace(r, '{title}', title, [rfReplaceAll]);
  r := StringReplace(r, '{sitename}', sqlPresets.FieldByName('sitename').AsString,
    [rfReplaceAll]);
  Result := r;
end;

{{ ============================== ОПОРНЫЕ ЧАСТИ ДВИЖКА - СБОРКА ТЕЛА СТРАНИЦЫ =============================== }}
function TForm1.buildBody(title: string; body: string; bodyTemplate: string
  ): string;
var r : String; s, s2 : string;
begin
 r:=bodyTemplate;
 r:=applyVar(r, 'title', title);
 r:=applyVar(r, 'content', body);
 s:=sqlContent.FieldByName('section').AsString;
 r:=applyVar(r, 'section', s);
 sqlSections.First;
 while not sqlSections.EOF do
       begin
            s2:=sqlSections.FieldByName('id').AsString;
            if s2=s then
               begin
                 r:=applyVar(r, 'sectionName', sqlSections.FieldByName('section').AsString);
                 break;
               end;
               sqlSections.Next;
       end;
 r:=applyVar(r, 'sitename', sqlPresets.FieldByName('sitename').AsString);
 r:=applyVar(r, 'ext', PrefferedExtension.Text);
 Result:=R;
end;


{{ ============================== ОПОРНЫЕ ЧАСТИ ДВИЖКА - ПРИМЕНЕНИЕ ГЛОБАЛЬНЫХ БЛОКОВ =============================== }}
function TForm1.useBlocks(part: string): string;
var r : String; i, j : Integer; h, t : String;  fbuffer : TStringList;  blockFiles : TStringList;
   log : TStringList;
   key, value : String;
   block_index : integer;
begin
  r := part;
  log := TStringList.Create;
  if not chkGetBlocksFromFile.Checked then // use database
  begin
  if logger_info then  mmRubrics.Lines.Add('USE BLOCKS FROM ram');
  if logger_info then  mmRubrics.Lines.Add('Глобальных блоков '+IntToStr(blocks.Count));
  for block_index:=0 to blocks.Count - 1 do
                     begin

                       key:=Blocks.Names[block_index];
                       value:=Blocks.ValueFromIndex[block_index];
                       //showMessage('key '+key);
                       //showMessage('value = '+value);

        h := '{'+key+'}';
        t :=  value;
        r:=StringReplace(r, h, t, [rfReplaceAll]);
        if logger_info then  mmRubrics.Lines.Add('replace '+h+' ==>> to '+t);
 end;

  end
  else begin
    if logger_info then  mmRubrics.Lines.Add('USE BLOCKS FROM FILES');
    fbuffer:=TStringList.Create;
    blockFiles := FindAllFiles(GetCurrentDir()+DELIM+'blocks'+DELIM, '*.blk', false); // получили список блоков
    // первая строка - id блока
    // остальные HTML разметка
    for i:=0 to blockFiles.Count-1 do
        begin
          fbuffer.LoadFromFile( blockFiles[i] ); // already have abs paths
          h:=fbuffer.Strings[0];
          t:='';
          for j:=1 to fbuffer.Count-1 do
              begin
                t:=t+fbuffer.Strings[j];
              end;
          r:=StringReplace(r, '{'+h+'}', t, [rfReplaceAll]);

          
  if logger_info then  mmRubrics.Lines.Add('replace {'+h+'+} to '+t);

          log.Add('Replace in '+r+'{'+h+'} on '+t);
          log.Add('===== Result is ====');
          log.Add(r);
          log.Add('======/Result======');


        end;
    fbuffer.Free;
    log.SaveToFile('log.txt');
    log.Free;
  end;

  if logger_info then
  begin
     form1.mmRubrics.Lines.add('ОБРАБОТКА ГЛОБ. БЛОКОВ до');
     form1.mmRubrics.Lines.add(part);
     form1.mmRubrics.Lines.add('ОБРАБОТКА ГЛОБ. БЛОКОВ после');
     form1.mmRubrics.Lines.Add(r);
     if part = r then
             form1.mmRubrics.Lines.Add('!!! ЗАМЕНА НЕ ВЫПОЛНЕНА !!!');
  end;

  Result:=r;
end;

procedure TForm1.scanLinks;
var i : integer;
begin

  Titles.Clear;      // Titles is a list of pages captions
  Urls.Clear;        // Urls is a list of urls for pages
  Sections.Clear;

  sqlContent.First;  // lookup from first record
  while not sqlContent.EOF do
  begin
    // add to list so each index is same item
    Titles.Lines.Add(sqlContent.FieldByName('caption').AsString);
    Urls.Lines.Add(sqlContent.FieldByName('id').AsString);
    Sections.Lines.Add(sqlContent.FieldByName('section').AsString);
    sqlContent.Next;  // see next page
  end;
  sqlContent.First;  // set cursor to first

  lvContent.clear;
  for i:=0 to Urls.Lines.Count-1 do
      begin
        lvContent.AddItem( Urls.Lines.Strings[i] , nil);
      end;



end;

procedure TForm1.scanSections;
var i : integer;
begin
  // identically as scanLinks
  SiteSectionUrls.Clear;
  SiteSectionTitles.Clear;
  sqlSections.First;
  while not sqlSections.EOF do
  begin
    SiteSectionTitles.Lines.Add(sqlSections.FieldByName('section').AsString);
    SiteSectionUrls.Lines.Add(sqlSections.FieldByName('id').AsString);
    sqlSections.Next;
  end;
  sqlSections.First;


  lvSections.clear;
  for i:=0 to SiteSectionUrls.Lines.Count-1 do
      begin
        lvSections.AddItem( SiteSectionUrls.Lines.Strings[i] , nil);
      end;

  if logger_info then mmRubrics.Lines.Add('Заголовков страниц<scanSections>:'+IntToStr(SiteSectionTitles.Lines.Count));
  if logger_info then mmRubrics.Lines.Add('URL страниц<scanSections>:'+IntToStr(SiteSectionUrls.Lines.Count));
end;

function TForm1.insLinks(body: string): string;
var
  r: string;
  i: integer;
begin
  // in body tag all existing shorttags
  // [linkname] replaced to <a href="linkurl">title</a>
  r := body;
  i := 0;
  while i < Urls.Lines.Count do
  begin
    r :=
      StringReplace(r, '[' + Urls.Lines[i] + ']',
      '<a href="' + Urls.Lines[i] + '.' +
      PrefferedExtension.Text + '">' + Titles.Lines[i] + '</a>', [rfReplaceAll]);
    Inc(i);
  end;
  if logger_info then mmRubrics.Lines.Add('ПРОСТАВЛЯЕМ ССЫЛКИ');
  if logger_info then mmRubrics.Lines.Add('Вызвана<insLinks> до '+body);
  if logger_info then mmRubrics.Lines.Add('Вызвана<insLinks> после '+r);
  Result := r;
end;

function TForm1.insSections(body: string): string;
var
  r: string;
  i: integer;
begin
  //  in body identically as insSections
  //  <<section_url>> will be replaced to <a href="section_url">section_title</a>
  r := body;
  i := 0;
  //showMessage(IntToStr(SiteSectionUrls.Lines.Count));
  while i < SiteSectionUrls.Lines.Count do
  begin
    r :=
      StringReplace(r, '<<' + SiteSectionUrls.Lines[i] + '>>',
      '<a href="section_' + SiteSectionUrls.Lines[i] +
      '.' + PrefferedExtension.Text + '">' + SiteSectionTitles.Lines[i] + '</a>', [rfReplaceAll]);
    Inc(i);
  end;
  if logger_info then mmRubrics.Lines.Add('ПРОСТАВЛЯЕМ СЕКЦИИ');
  if logger_info then mmRubrics.Lines.Add('Вызвана<insSections> до ' +body);
  if logger_info then mmRubrics.Lines.Add('Вызвана<insSections> после '+r);
  if logger_info then if r=body then mmRubrics.Lines.Add('!!! СОВПАДАЮТ' );
  Result := r;
end;




function TForm1.Pager(layout: String; pages: String): String;
var
   r : String;
begin
  r:=applyVar(layout, 'pager', pages );
  if logger_info then mmRubrics.Lines.Add('ПРОСТАВЛЯЕМ ПАГИНАТОР');
  if logger_info then mmRubrics.Lines.Add('Вызвана<insPages> до ' +layout);
  if logger_info then mmRubrics.Lines.Add('Вызвана<insSections> после '+r);
  result:=r;
end;














function TForm1.moduleexec(cmd: string): string;
var
  P: TProcess;
  R: string;
  M: TMemo;
  filenam: string;
begin
  //showMessage('Запущен модуль '+cmd);
  P := TProcess.Create(Self);
  M := TMemo.Create(Self);
  P.CommandLine := cmd;
  P.Execute;
  while P.Active do ;
  filenam := Copy(cmd, 1, Pos(' ', cmd) - 1) + '.tmp';
  R := '';
  if FileExists(filenam) then
  begin
    M.Lines.LoadFromFile(filenam);
    R := M.Text;
    DeleteFile(filenam);
  end;
  P.Free;
  M.Free;
  Result := R;
end;

{{ ======================== РАСШИРЕНИЕ ВОЗМОЖНОСТЕЙ МОДУЛЯМИ ================ }}

function TForm1.useModules(app: string): string;
var C, Start, En_d : integer;
  replacement : String;
  R : String;
begin

 R:=app;
 if chkUseModules.Checked then begin
                          if logger_info then mmRubrics.Lines.Add('ПОДДЕРЖКА МОДУЛЕЙ ВКЛЮЧЕНА');
  C:=0;
  Start := -1;
  En_d := -1;
  while C<Length(r) do
                           begin
                           if Copy(r, C, 1) = DLM_MODULE then
                              begin
                                if Start<0 then Start:=C else
                                  begin
                                   En_d :=C;

                                   if logger_info then mmRubrics.Lines.Add('ОБНАРУЖЕНИЕ МОДУЛЯ...');
                                   replacement:=moduleexec(Copy(r, Start+1, En_d-Start-1));
                                   r:=StringReplace(r, Copy(r, Start, En_d-Start+1),
                                   replacement, [rfReplaceAll]);
                                   c:=Start+Length(replacement)-1;
                                   Start:=-1;
                                   En_d := -1;
                                  end;
                              end;
                           C:=C+1;
                           end;
 end; // else will be not processed
 Result:=R;
end;

function TForm1.owntagexec(containter, cmd: string): string;
var
  M: TMemo;
  P: TProcess;
  R: string;
begin
  M := TMemo.Create(Self);
  M.Clear;
  M.Text := containter;
  M.Lines.SaveToFile(cmd + '.inp');
  P := TProcess.Create(Self);
  P.CommandLine := cmd;
  P.Execute;
  while P.Active do ;
  R := '';
  if FileExists(cmd + '.out') then
  begin
    M.Clear;
    M.Lines.LoadFromFile(cmd + '.out');
    R := M.Text;
  end;
  if FileExists(cmd + '.inp') then DeleteFile(cmd + '.inp');
  if FileExists(cmd + '.out') then DeleteFile(cmd + '.out');
  M.Free;

  if logger_info then mmRubrics.Lines.Add('ВЫЗОВ ИСПОЛНЯЕМОГО ТЕГА<owntagexec>');
  if logger_info then mmRubrics.Lines.Add('КОНТЕЙНЕР');
  if logger_info then mmRubrics.Lines.Add(containter);
  if logger_info then mmRubrics.Lines.Add('ОБРАБОТЧИК');
  if logger_info then mmRubrics.Lines.Add(cmd);
  if logger_info then mmRubrics.Lines.Add('РЕЗУЛЬТАТ');
  if logger_info then mmRubrics.Lines.Add(r);
  Result := R;
end;

function TForm1.useOwnTags(app: string): string;
var
  C, Start, En_d, Q: integer;
  R: string;
  pattern: string;
  containter: string;
  replacement: string;
  stub: string;
  epattern: string;
  remstr: string;
  z: integer;
begin
  //showMessage('USE OWN TAGS CALL');
  r := app;
  c := 0;
  Start := -1;
  En_d := -1;
  Q := -1;
  while (C < Length(r)) do
  begin
    if Copy(r, c, 1) = '~' then
    begin
      if Start < 0 then
        Start := C
      else
      begin
        En_d := C;
        pattern := Copy(r, start + 1, en_d - start - 1);
        // Stub := InputBox('Debug', 'pattern=', pattern);
        epattern := '~/' + pattern + '~';
        Q := Pos(epattern, r);
        containter := Copy(r, en_d + 1, q - en_d - 1);
        // Stub := InputBox('Parameter', 'containter=', containter);


        if logger_info then mmRubrics.Lines.Add('ОБНАРУЖЕНИЕ ИСПОЛНЯЕМОГО ТЕГА');
        //ShowMessage('Нашел тег '+ containter);

        replacement := owntagexec(containter, pattern);
        //Stub := InputBox('replacement', 'result=', replacement);
        z := q + Length(epattern) - 1;
        remstr := Copy(r, Start, Z - Start + 1);
        //  Stub := InputBox('RemStr', 'RemStr=', remstr);
        r :=
          StringReplace(r, remstr, replacement, [rfReplaceAll]);
        // Stub := InputBox('Out', 'Out=', r);
        //Stub := InputBox('C', 'C=', String(C));
        C := Start + Length(replacement) - 1;
        Start := -1;
        En_d := -1;
        Q := -1;
      end;
    end;
    c := c + 1;
  end;
  Result := R;
end;



function TForm1.buildSection(sectiontpl: string; sectionUrl: string;
  sectionTitle: string; sectionNote : string; sectionFullText : string;
  items: string): string;
var
  r: string;
begin

  r := sectionTpl;
  r := applyVar(r, 'sectionUrl', sectionUrl );
  r := applyVar(r, 'sectionTitle', sectionTitle );
  r := applyVar(r, 'sectionNote', sectionNote );
  r := applyVar(r, 'sectionFullText', sectionFullText );
  r := applyVar(r, 'items', items );
  r := insSections(insLinks(r));


  if logger_info then mmRubrics.Lines.Add('СБОРКА СЕКЦИИ<buildSection>');
  if logger_info then mmRubrics.Lines.Add('ШАБЛОН СЕКЦИИ');
  if logger_info then mmRubrics.Lines.Add(sectiontpl);
  if logger_info then mmRubrics.Lines.Add('URL СЕКЦИИ');
  if logger_info then mmRubrics.Lines.Add(sectionUrl);
  if logger_info then mmRubrics.Lines.Add('ЗАГОЛОВОК СЕКЦИИ');
  if logger_info then mmRubrics.Lines.Add(sectionTitle);
  if logger_info then mmRubrics.Lines.Add('ЭЛЕМЕНТЫ СПИСКА');
  if logger_info then mmRubrics.Lines.Add(items);
  if logger_info then mmRubrics.Lines.Add('--- РЕЗУЛЬТАТ ---');
  if logger_info then mmRubrics.Lines.Add(R);






  Result := R;
end;

function TForm1.buildPagination(url: string; currentPage: byte;
  pagesTotal: integer): string;
var
  paginator: string;
  page: byte;

begin




  paginator := '<div class="paginator">';

  for page := 1 to pagesTotal do
    if currentPage <> page then
    begin
      if page = 1 then
        paginator :=
          paginator + '<a href="section_' + url + '.' + PrefferedExtension.Text + '">1</a> '
      else
        paginator :=
          paginator + '<a href="section_' + url + '_' + IntToStr(page) + '.' + PrefferedExtension.Text +
          '">' + IntToStr(page) + '</a> ';
    end
    else
      paginator := paginator + ' ' + IntToStr(currentPage) + ' ';
  {/for}
  paginator := paginator + '</div>';



  if logger_info then mmRubrics.Lines.Add('СБОРКА ПЕРЕКЛЮЧАТЕЛЯ СТРАНИЦ<buildPagination>');
  if logger_info then mmRubrics.Lines.Add('URL раздела');
  if logger_info then mmRubrics.Lines.Add(url);
  if logger_info then mmRubrics.Lines.Add('Номер текущей');
  if logger_info then mmRubrics.Lines.Add(IntToStr(currentPage));
  if logger_info then mmRubrics.Lines.Add('Всего страниц в разделе');
  if logger_info then mmRubrics.Lines.Add(IntToStr(pagesTotal));

  if logger_info then mmRubrics.Lines.Add('--- РЕЗУЛЬТАТ ---');
  if logger_info then mmRubrics.Lines.Add(paginator);


  Result := paginator;
end;

procedure TForm1.AttendConnection(ASocket: TTCPBlockSocket);
var
  timeout: integer;
  s: string;
  method, uri, protocol: string;
  OutputDataString: string;
  ResultCode: integer;
  content_type: string;
begin
  timeout := 120000;
  Application.ProcessMessages;
  //  WebServerLog.Lines.Add('Полученные заголовки, запрошенный браузером документ:');

  //read request line
  s := ASocket.RecvString(timeout);
  WebServerLog.Lines.Add(s);
  method := fetch(s, ' ');
  uri := fetch(s, ' ');
  protocol := fetch(s, ' ');

  //read request headers
  repeat

    s := ASocket.RecvString(Timeout);
    WebServerLog.Lines.Add(s);
    Application.ProcessMessages;
  until s = '';

  // Now write the document to the output stream

  content_type := 'Text/Html';
  if (pos('.css', uri) > 0) then content_type := 'text/css';
  if (pos('.jpg', uri) > 0) then content_type := 'image/jpeg';

  if ((pos('.jpg', uri) > 0) or (pos('.css', uri) > 0) or
    (pos('.htm', uri) > 0) or (uri = '/')) then
  begin
    // Write the output document to the stream
    OutputDataString := OutputHTMLFile(uri) + CRLF;
    // Write the headers back to the client
    ASocket.SendString('HTTP/1.0 200' + CRLF);
    ASocket.SendString('Content-type: ' + content_type + CRLF);
    ASocket.SendString('Content-length: ' + IntToStr(Length(OutputDataString)) + CRLF);
    ASocket.SendString('Connection: close' + CRLF);
    ASocket.SendString('Date: ' + Rfc822DateTime(now) + CRLF);
    ASocket.SendString('Server: HtmlBuilder' + CRLF);
    ASocket.SendString('' + CRLF);

    //  if ASocket.lasterror <> 0 then HandleError;

    // Write the document back to the browser
    ASocket.SendString(OutputDataString);
  end
  else
    ASocket.SendString('HTTP/1.0 404' + CRLF);
end;

procedure TForm1.StartOwnServer;
begin
  ListenerSocket := TTCPBlockSocket.Create;
  ConnectionSocket := TTCPBlockSocket.Create;

  ListenerSocket.CreateSocket;
  ListenerSocket.setLinger(True, 10);
  ListenerSocket.bind('127.0.0.1', '8080');
  ListenerSocket.listen;

  repeat
    Application.ProcessMessages;
    if ListenerSocket.canread(512) then
    begin
      ConnectionSocket.Socket := ListenerSocket.accept;
      WebServerLog.Lines.Add(
        'Выполняем подключение. Код ошибки (0=Успех): ' +
        IntToStr(ConnectionSocket.lasterror));
      AttendConnection(ConnectionSocket);
    end;
  until ListenerSocket.StopFlag or ConnectionSocket.StopFlag;
  ListenerSocket.Free;
  ConnectionSocket.Free;
end;

procedure TForm1.StopOwnServer;
begin
  ListenerSocket.AbortSocket;
  ConnectionSocket.AbortSocket;

end;

{{ ============== Чтение файла с диска / используется веб-сервером =============== }}

function TForm1.OutputHTMLFile(uri: string): string;
var path : String; filename : String; Buf : TMemo;
  r : String;   fullq : String;
begin

  if uri = '/' then uri:='/index.'+PrefferedExtension.text;
  path := sqlPresets.FieldByName('dirpath').AsString;
  Buf:=TMemo.Create(Self);
  r:='';
  fullq:=path+uri;
  if Cache.Values[uri] <> '' then r:=Cache.values[uri] else begin
  if FileExists(fullq) then begin
  Buf.Lines.LoadFromFile(fullq);
  cache.values[uri]:=Buf.text;
  r:=Buf.Text;
  end;
  end;
  Buf.Free;
  result:=r;
end;

function TForm1.buildOwnFields(html: string; p : page_params): string;
var
  r: string;
  i: byte;

begin
  r := html;
  for i := 1 to 7 do
  begin
    r := StringReplace(r, '{f' + IntToStr( i )  + '}',
                          p.user_field_names[i],
      [rfReplaceAll]);
   r := StringReplace(r, '{v' + IntToStr( i )  + '}',
                          p.user_field_values[i],
      [rfReplaceAll]);

  end;



  if logger_info then mmRubrics.Lines.Add('СБОРКА СОБСТВЕННЫХ ПОЛЕЙ<buildOwnFields>');
  if logger_info then mmRubrics.Lines.Add('ВХОД');
  if logger_info then mmRubrics.Lines.Add(html);
  if logger_info then mmRubrics.Lines.Add('--- РЕЗУЛЬТАТ ---');
  if logger_info then mmRubrics.Lines.Add(R);
  Result := r;
end;

function TForm1.prefExtension(lin: string): string;
var
  r: string;
begin
  r := lin;
  r := StringReplace(r, '{ext}', PrefferedExtension.Text, [rfReplaceAll]);

  if logger_info then mmRubrics.Lines.Add('УСТАНОВКА РАСШИРЕНИЯ <prefExtension>');
  if logger_info then mmRubrics.Lines.Add('ВХОД');
  if logger_info then mmRubrics.Lines.Add(lin);
  if logger_info then mmRubrics.Lines.Add('--- РЕЗУЛЬТАТ ---');
  if logger_info then mmRubrics.Lines.Add(R);

  Result := r;
end;

procedure TForm1.localeRUS;
begin
  {НАЧАЛО ЛОКАЛИЗАЦИИ}
  {НАЗВАНИЕ ОКНА ПРОГРАММЫ}
  form1.Caption := 'Генератор статических HTML сайтов';
  {ЗАГОЛОВКИ ВКЛАДОК}
  tabPages.Caption := 'Страницы';
  tabSections.Caption := 'Разделы';
  tabGlobalBlocks.Caption := 'Глобальные блоки';
  tabSpecial.Caption := 'Специальное';
  tabUpdateByFTP.Caption := 'Обновление по FTP';
  tabWebServer.Caption := 'Веб-сервер';
  tabHelp.Caption := 'О программе';
  mmAbout.lines.LoadFromFile('russian_help.txt');
end;

procedure TForm1.localeENG;
begin
  {START ENG LOCALE}
  Form1.Caption := 'Generator of static HTML websites';
  {TAB HEADERS}
  tabPages.Caption := 'Pages';
  tabSections.Caption := 'Sections';
  tabGlobalBlocks.Caption := 'Global blocks';
  tabSpecial.Caption := 'Special';
  tabUpdateByFTP.Caption := 'Update By FTP';
  tabWebServer.Caption := 'Web Server';
  tabHelp.Caption := 'About app';
  mmAbout.lines.LoadFromFile('english_help.txt');
end;





procedure TForm1.initTransactionSQL;

var
  isOK : Boolean;
begin

  conn.Close; // Убедитесь, что соединение закрыто при запуске
  conn.DatabaseName := sqlite_filename; // назначаем имя файла
  try
  //Поскольку мы делаем эту базу данных впервые,
  // проверяем, существует ли уже файл
  isOK := FileExists(conn.DatabaseName);

    if isOK then
    begin




         // делать ничего не нужно, обработается при выходе, сообщаем
         SilentMessage('Файл найден!');
         checkConnect(conn, trans, 'initTransactionSQL');


    end

    else

    begin
      // Создаем базу данных и таблицы
      SilentMessage('Создаем базу с нуля');



        // запросы в рамках транзакции

       checkConnect(conn, trans,'initTransactionSQL');
         try
        form1.makeCreationTables(); // запросы на создание таблиц



        // пытаемся выполнить вставку данных

        insertDemoData(temp_sql, conn, trans);






        SilentMessage(msgBaseSuccess);
          except
            SilentMessage(msgErrorCreating);
          end;
        end;
      except
        SilentMessage(msgCantCheckDbFile);
      end;

end;















procedure TForm1.makeSqlActive;
begin

  checkConnect(conn, trans,'makeSqlActive');
  // к моменту вызова этого запроса таблицы должны существовать
  if (sqlContent.SQL.Text = '') then
          SilentMessage('Запрос не задан sqlPages')
    else
          sqlContent.Active:=True; // запрос в активном режиме, SQL должен быть определен!
    if (sqlSections.SQL.Text = '') then
          SilentMessage('Запрос не задан sqlSections')
    else
        sqlSections.Active:=True; // запрос в активном режиме


   if (sqlBlocks.Sql.text = '') then
      SilentMessage('Запрос не задан SqlBlocks')
   else
  sqlBlocks.Active:=True; // запрос в активном режиме

  if (sqlPresets.Sql.Text = '') then
     SilentMessage('Запрос не задан sqlPresets') else
  sqlPresets.Active:=True; // запрос в активном режиме
end;

procedure TForm1.makeSqlInactive;
begin

  AutoSaveDb();

  SilentMessage('Закрываем транзакцию и соединение');
  sqlContent.Active:=False; // запрос в активном режиме
  sqlSections.Active:=False; // запрос в активном режиме
  sqlBlocks.Active:=False; // запрос в активном режиме
  sqlPresets.Active:=False; // запрос в активном режиме
  trans.Active:=false;
  conn.Close;
end;

procedure TForm1.viewPagesSQL;
begin
open_sql(    'select * from content', sqlContent);
ds_Content.AutoEdit:=True;
SilentMessage('выполнена загрузка страниц!');
end;

procedure TForm1.viewSectionsSQL;
  begin
  open_sql(  'select * from section', sqlSections);
  SilentMessage('выполнена загрузка разделов!');
  end;

procedure TForm1.viewBlocksSQL;
begin

  open_sql(  'select * from block', sqlBlocks);

  SilentMessage('выполнена загрузка блоков!');
end;

procedure TForm1.viewPresetsSQL;
begin
  open_sql ( 'select * from preset' , sqlPresets);
  SilentMessage('выполнена загрузка настроек!');
end;

procedure TForm1.viewTablesSQL;
begin
 checkConnect(conn, trans,'viewTablesSQL');
  form1.makeSqlActive(); // активируем запросы
  form1.viewPagesSQL();
  form1.viewBlocksSQL();
  form1.viewPresetsSQL();
  form1.viewSectionsSQL();
end;

(*
переназначает источник данных с tdbf на sqlite  - ТАБЛИЦА КОНТЕНТ
*)
procedure TForm1.changeDataSourcesContent;
begin
  fID.DataSource:=form1.ds_Content;  // поле идент. страницы
  fCaption.DataSource:=form1.ds_Content; //поле заголовок
  // fContent is editor
  fContent.DataSource:=form1.ds_Content; // поле контент

  //dbContentLook.DataSource:=form1.ds_Content; // список страниц
  // TODO ТУТ ДОЛЖНЫ БЫТЬ ДОП. ПОЛЯ!

  ds_Content.AutoEdit:=True;
  dbNav_Content.DataSource:=form1.ds_Content; // листалка
end;


(*
переназначает источник данных с tdbf на sqlite  - ТАБЛИЦА СЕКЦИИ
*)
procedure TForm1.changeDataSourcesSections;
begin
  dbeSectionId.DataSource:=form1.ds_Sections;  // поле идент. раздела
  dbeSectionCaption.DataSource:=form1.ds_Sections; // поле название раздела
  dbmSectionNote.DataSource:=form1.ds_Sections; // поле шаблон раздела


  //dbSectionsLook.DataSource:=form1.ds_Sections; // список секций
  // TODO ТУТ ДОЛЖНЫ БЫТЬ ДОП. ПОЛЯ!
  dbNav_Sections.DataSource:=form1.ds_Sections; // листалка
end;

(*
переназначает источник данных с tdbf на sqlite  - ТАБЛИЦА БЛОКИ
*)
procedure TForm1.changeDataSourcesBlocks;
begin
  dbeBlockId.DataSource:=form1.ds_Blocks;  // поле идент. раздела
  dbeBlockNote.DataSource:=form1.ds_Blocks; // поле название раздела
  dbeBlockHtml.DataSource:=form1.ds_Blocks; // поле шаблон раздела
  //dbBlocksLook.DataSource:=form1.ds_Blocks; // список блоков
  // TODO ТУТ ДОЛЖНЫ БЫТЬ ДОП. ПОЛЯ!
  dbNav_Blocks.DataSource:=form1.ds_Blocks; // листалка
end;

(*
переназначает источник данных с tdbf на sqlite  - ТАБЛИЦА ПРЕСЕТЫ(НАСТРОЙКИ)
*)
procedure TForm1.changeDataSourcesPresets;
begin
  dbePreset.DataSource:=form1.ds_Presets;  // идент. настроек
  dbeSiteName.DataSource:=form1.ds_Presets; // имя сайта
  dbeSiteDirectory.DataSource:=form1.ds_Presets; // каталог
  dbmHeadTemplate.DataSource:=form1.ds_Presets; // шаблон заголовка
  dbmBodyPagesTemplate.DataSource:=form1.ds_Presets; // шаблон страниц
  dbmBodySectionsTemplate.DataSource:=form1.ds_Presets;// шаблон секции
  dbmTemplateOfItem.DataSource:=form1.ds_Presets; // шаблон списка
  // TODO ТУТ ДОЛЖНЫ БЫТЬ ДОП. ПОЛЯ!

  //dbPresetsLook.DataSource:=form1.ds_Presets;
  dbNav_Presets.DataSource:=form1.ds_Presets; // листалка
end;











procedure TForm1.makeCreationTables;
begin

          checkConnect(conn, trans, 'makeCreationTables');


            try
            createPagesSQL(conn, trans);

            except
                 SilentMessage('Проблема с таблицей content');
            end;
            createSectionsSQL(conn, trans);
            createBlocksSQL(conn, trans);
            createPresetsSQL(conn, trans);
end;

procedure TForm1.changeDataSources;
begin
  Form1.changeDataSourcesContent();
  Form1.changeDataSourcesSections();
  Form1.changeDataSourcesBlocks();
  Form1.changeDataSourcesPresets();
end;











procedure TForm1.SilentMessage(msg: String);
begin
  if (not SilentMode) then ShowMessage(msg);
end;

procedure TForm1.AutoSaveDb; // автосохранение, исп. в FormClose
begin
   sqlContent.ApplyUpdates();
   trans.CommitRetaining();
   sqlSections.ApplyUpdates();
   trans.CommitRetaining();
   sqlBlocks.ApplyUpdates();
   trans.CommitRetaining();
   sqlPresets.ApplyUpdates();
   trans.CommitRetaining();
end;

(* ========================== новая сборка страниц ====================== *)

procedure TForm1.doJoinPages;
var
        page : page_params;   filenam  : String;
        fbuffer : TStringList;
        headT, bodyT : String;
        page_param_num : byte;
begin

   (* Загружаем шаблоны из файлов, если сделан такой выбор *)
  fBuffer := TStringList.Create();

 if chkGetBlocksFromFile.Checked then
       begin
      fbuffer.LoadFromFile(GetCurrentDir + DELIM+'parts'+DELIM+'head.tpl');
      headT:=fbuffer.Text;
      fbuffer.LoadFromFile(GetCurrentDir + DELIM+'parts'+DELIM+'body.tpl');
      bodyT:=fbuffer.Text;
    end;

 fbuffer.Free;



   (* Сборка страниц *)
   sqlJoin.Open;
   sqlJoin.First;

   while not sqlJoin.EOF do
         begin
            page.id := sqlJoin.FieldByName('id').AsString;
            page.title := sqlJoin.FieldByName('caption').AsString;
            page.body := sqlJoin.FieldByName('content').AsString;
            page.section_id := sqlJoin.FieldByName('section_id').AsString;
            page.section_title := sqlJoin.FieldByName('section').AsString;
            page.sitename := sqlJoin.FieldByName('sitename').AsString;
            page.dirpath := sqlJoin.FieldByName('dirpath').AsString;

            for page_param_num:=1 to 7 do
              begin
                page.user_field_names[ page_param_num ]:=
                                       sqlJoin.FieldByName('ufn'+IntToStr(page_param_num)).AsString;
                page.user_field_values[ page_param_num ]:=
                                       sqlJoin.FieldByName('uf'+IntToStr(page_param_num)).AsString;

              end;


                         if chkGetBlocksFromFile.Checked then
                             page.headtpl := headT
                         else
                             page.headtpl := sqlJoin.FieldByName('headtpl').AsString;
                         if chkGetBlocksFromFile.Checked then
                             page.bodytpl := bodyT
                         else
                           page.bodytpl := sqlJoin.FieldByName('bodytpl').AsString;


            page.sectiontpl := sqlJoin.FieldByName('itemtpl').AsString;
            page.dir:=sqlJoin.FieldByName('dirpath').AsString;

            filenam := page.dirpath+DELIM+page.id+'.'+PrefferedExtension.Text;

           if page.dir <> '' then
                      makePageJoin( page, filenam);


         sqlJoin.Next;
         end;
   sqlJoin.First;




end;

procedure TForm1.makePageJoin(page: page_params; filenam: String) ;
var
  id : String;
  t : String;



begin


    if FileExists(filenam) then DeleteFile(filenam);
    Buffer.Clear;
    Buffer.Lines.Add('<!DOCTYPE html>');
    Buffer.Lines.Add('<html><head>');
                              Buffer.Lines.Add(

                                               buildHead(page.title, page.headtpl)

                               );


                                t:=page.bodytpl;

                              Buffer.Lines.Add('</head><body>');
                              Buffer.Lines.Add(

                                              buildBody(page.title, page.body, t)

                              );
                              Buffer.Lines.Add('</body></html>');

                              // постобработка
                              Buffer.Lines.Text :=
                               useModules(
                                useOwnTags(
                                    buildOwnFields(
                                           insertSectionsAndLinks(
                                                  useBlocks(
                                                             buffer.Lines.Text)
                                                    ),
                                        page)));


                              // id of pages
                              id := ExtractFileName(filenam);
                              id := Copy(id, 1, Pos('.', id)-1);
                              Buffer.Text:=StringReplace(Buffer.Text, '{id}',
                              id , [rfReplaceAll]);
                              try
                              Buffer.Lines.SaveToFile(filenam);
                              except
                              end;
end;

function TForm1.buildItem(itemtpl: string; itemUrl: string; itemTitle: string; ur : user_records): string;
var
  r: string;
  fi : byte;
begin
  r := itemTpl;
  r := applyVar(r, 'itemUrl', itemUrl);
  r := applyVar(r, 'itemTitle', itemTitle);

  // применяем пользовательские поля, если есть
  for fi:=1 to 7 do begin
      r:=applyVar(r, 'f'+IntToStr(fi), ur[fi].name);
      r:=applyVar(r, 'v'+IntToStr(fi), ur[fi].value);
  end;

  r := insSections(insLinks(r));
  r := prefExtension(r);
  Result := R;
end;


procedure TForm1.writeDocument( document : String; filenam: String);
var
  id : String;
  t : String;



begin
    buffer.clear;
    buffer.lines.add(document);

    if FileExists(filenam) then DeleteFile(filenam);

                              try
                              Buffer.Lines.SaveToFile(filenam);
                              except
                              end;
end;

procedure TForm1.doSections;
var
  pagesTotal : Integer;
  sectionId  : String;
  PagesinRubrics : Integer;
  itemsPerPage : Integer;
  page : Integer;
  headHtml : String;
  itemHtml : String;
  sectionHtml : String;
  document : String;
  path : String;
  ur : user_records;
  fi : byte;
begin
// некоторые данные нужно считать 1 раз
// так как они будут нужны многократно
  scanLinks();  // ссылки
  scanSections(); // секции



  itemsPerPage := 3;
  sqlCounter.Open; // Число страниц в каждом разделе
  sqlCounter.First;
  while not sqlCounter.EOF do
        begin

             PagesTotal:=sqlCounter.FieldByName('cnt').AsInteger;
             if pagesTotal <= itemsPerPage then
                           pagesInRubrics:=1
             else
                 begin
                      pagesInRubrics := pagesTotal div itemsPerPage;
                      if (pagesTotal mod itemsPerPage)>0 then inc(pagesInRubrics);
                 end;



                for page := 1 to pagesInRubrics do
                    begin

                       sqlRubrication.Close;
                       prepared_transaction_start( sqlRubrication.SQL.Text, sqlRubrication, trans);

                       sectionId := sqlCounter.FieldByName('section').AsString;

                       sqlRubrication.ParamByName('section_id').AsString:=sectionId;
                       sqlRubrication.ParamByName('pageoffset').AsInteger:=(page-1)*itemsPerPage;
                       sqlRubrication.ParamByName('pagelimit').AsInteger := itemsPerPage;

                       prepared_transaction_end(sqlRubrication, trans);
                       sqlRubrication.Open;

                       itemHtml := '';
                       sqlRubrication.First;
                       while not sqlRubrication.EOF do
                             begin

                                  for fi:=1 to 7 do
                                      begin
                                         ur[fi].name:=sqlRubrication.FieldByName('ufn'+IntToStr(fi)).AsString;
                                         ur[fi].value:=sqlRubrication.FieldByName('uf'+IntToStr(fi)).AsString;
                                      end;

                                   itemHTML := itemHtml +

                                   buildItem( sqlRubrication.FieldByName('itemtpl').AsString,
                                     sqlRubrication.FieldByName('content_id').AsString,
                                     sqlRubrication.FieldByName('caption').AsString, ur );
                                   sqlRubrication.Next;
                             end;



                            sectionHtml :=




                            applyVar(



                            buildSection( sqlRubrication.FieldByName('sectiontpl').AsString,
                                              sqlRubrication.FieldByName('id').asString,
                                              sqlRubrication.FieldByName('section').AsString,
                                              sqlRubrication.FieldByName('note').AsString,
                                              sqlRubrication.FieldByName('full_text').AsString,
                                              itemHtml ),
                            'pager',
                                    buildPagination(sqlRubrication.FieldByName('id').AsString, page, pagesInRubrics)
                                    );




                            headHtml:= buildHead( sqlRubrication.FieldByName('section').AsString,
                            sqlRubrication.FieldByName('headtpl').AsString);

                            document:='<html><head>{header}</head><body>{body}</body>';

                            document:=ApplyVar(document, 'header', headHtml);
                            document:=ApplyVar(document, 'body', sectionHtml);
                            // постобработка

                            document:=
                                  useModules(
                                    useOwnTags(
                                       insertSectionsAndLinks(
                                      useBlocks(
                                                document ))));


                            mmRubrics.Lines.Add(document);


                            if page > 1 then

                            path:=
                            sqlRubrication.FieldByName('dirpath').AsString+DELIM+'section_'+
                            sqlRubrication.FieldByName('id').AsString+'_'+IntToStr(page)+'.html'
                            else
                            path:=sqlRubrication.FieldByName('dirpath').AsString+DELIM+'section_'+
                            sqlRubrication.FieldByName('id').AsString+'.html';


                            writeDocument( document,
                            path
                                           );




                    end;
         sqlCounter.Next;
        end;










     end;











procedure TForm1.doSitemap;
var fbuffer : TMemo;
  sitemap_param : page_params;
begin
  fbuffer := TMemo.Create(self);
  // карта категорий
  fbuffer.Clear;
  fbuffer.Lines.Add('<ul>');
  sqlSections.First;
  while not sqlSections.EOF do
        begin
             fbuffer.Lines.Add(
             '<li><a href="./section_' + sqlSections.FieldByName('id').AsString + '.{ext}">'+
             sqlSections.FieldByName('section').AsString+'</a></li>');
             sqlSections.Next;
        end;
  fbuffer.Lines.Add('</ul>');


  sitemap_param.headtpl:=sqlPresets.FieldByName('headtpl').AsString;
  sitemap_param.title:='Карта сайта';
  sitemap_param.body:=fbuffer.Text;
  sitemap_param.bodytpl:=sqlPresets.FieldByName('bodytpl').AsString;
  makePageJoin( sitemap_param,
  sqlPresets.FieldByName('dirpath').AsString+DELIM +'sitemap.'+form1.PrefferedExtension.Text);
  fbuffer.Free;
end;

function TForm1.insertSectionsAndLinks(str: string): string;
begin
  Result:= insSections(insLinks(str));
end;

procedure TForm1.scanBlocks;
var k : byte;   i : integer;
begin
    k:=0;
             Blocks.Clear;

   sqlBlocks.First();
   while not sqlBlocks.EOF do
         begin
           Blocks.AddPair( sqlBlocks.FieldByName('id').AsString, sqlBlocks.FieldByName('markup').AsString  );
           sqlBlocks.Next();
           inc(k);
         end;
   sqlBlocks.First();
   SilentMessage('ГЛОБАЛЬНЫХ БЛОКОВ '+IntToStr(k));

   lvBlocks.Clear;
   for i:=0 to Blocks.Count-1 do
     begin
        lvBlocks.AddItem(  Blocks.Names[i] , nil);
     end;

end;

procedure TForm1.scanPresets;
  var k : byte;   i : integer;
begin
    k:=0;
    SitePresets.Clear;
   sqlPresets.First();
   while not sqlPresets.EOF do
         begin
           SitePresets.lines.add( sqlPresets.FieldByName('id').AsString);
           sqlPresets.Next();
           inc(k);
         end;
   sqlPresets.First();

   lvPresets.Clear;
   for i:=0 to sitePresets.Lines.Count-1 do
     begin
        lvPresets.AddItem( sitePresets.lines[i], nil);
     end;
end;

procedure TForm1.doScan;
begin
  scanLinks();
  scanSections();
  scanBlocks();
  scanPresets();
end;

procedure TForm1.editor_win_show(sql: TSQLQuery; field: String);

  var fE : TfrmEditor;
begin
  fE:=TfrmEditor.Create(Self);
  fE.setMarkup( sql.FieldByName(field).AsString);
  fE.ShowModal();

  sql.Edit;
  sql.FieldByName(field).AsString:=fE.getMarkup();

  fE.Close();
  fE.Free;

end;











end.
