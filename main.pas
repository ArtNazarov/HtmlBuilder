unit main;

{$mode objfpc}{$H+}

interface



uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBCtrls, dbf, SQLite3Conn, SQLDB, process, FileUtil, SynHighlighterHTML,
  SynEdit, StdCtrls, ExtCtrls, ComCtrls, Menus, DBGrids, blcksock, sockets,
  Synautil, synaip, synsock, ftpsend; {Use Synaptic}

const

   SilentMode : boolean = True;
   logger_info : boolean = True;
   sqlite_filename : String = 'sqlite.db';
   msgBaseSuccess : String = 'База данных успешно создана.';
   msgErrorCreating : String = 'Невозможно создать новую базу данных';
   msgCantCheckDbFile : String = 'Невозможно проверить, существует ли файл базы данных';

    DELIM : Char = '/';

    DLM_MODULE = '`';

type

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
    btBold: TButton;
    btFtpUpdate: TButton;
    btHref: TButton;
    btImg: TButton;
    btItalic: TButton;
    btOrderedList: TButton;
    btParagraph: TButton;
    btStartServer: TButton;
    btStopServer: TButton;
    btSub: TButton;
    btSup: TButton;
    btUnderline: TButton;
    btUnorderedList: TButton;
    Buffer: TMemo;
    btnMakeArchive: TButton;
    btnLoad: TButton;
    btnJoin: TButton;
    cboLocale: TComboBox;
    chkUseModules: TCheckBox;
    chkGetBlocksFromFile: TCheckBox;
    choicePreset: TDBLookupComboBox;
    ds_Rubrication: TDataSource;
    dgCounter: TDBGrid;
    ds_Counter: TDataSource;
    ds_Join: TDataSource;
    dbJoin: TDBGrid;
    mmRubrics: TMemo;
    panJoin: TPanel;
    selSection: TDBLookupComboBox;
    dbPresetsLook: TDBLookupListBox;
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
    dbmSectionTemplate: TDBMemo;
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
    dbContentLook: TDBLookupListBox;
    dbSectionsLook: TDBLookupListBox;
    dbBlocksLook: TDBLookupListBox;
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
    procedure AppPagesChange(Sender: TObject);
    procedure btBoldClick(Sender: TObject);
    procedure btBuildSiteClick(Sender: TObject);
    procedure btFtpUpdateClick(Sender: TObject);
    procedure btItalicClick(Sender: TObject);
    procedure btnJoinClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btOrderedListClick(Sender: TObject);
    procedure btParagraphClick(Sender: TObject);
    procedure btStartServerClick(Sender: TObject);
    procedure btStopServerClick(Sender: TObject);
    procedure btSubClick(Sender: TObject);
    procedure btSupClick(Sender: TObject);
    procedure btUnderlineClick(Sender: TObject);
    procedure btUnorderedListClick(Sender: TObject);
    procedure btnMakeArchiveClick(Sender: TObject);
    procedure btHrefClick(Sender: TObject);

    procedure cboLocaleChange(Sender: TObject);
    procedure dbNav_ContentBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure dbNav_BlocksBeforeAction(Sender: TObject; Button: TDBNavButtonType
      );
    procedure dbNav_PresetsBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure dbNav_SectionsBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure Panel25Click(Sender: TObject);

    procedure sqlBlocksAfterInsert(DataSet: TDataSet);
    procedure sqlBlocksAfterPost(DataSet: TDataSet);
    procedure sqlContentBeforeEdit(DataSet: TDataSet);
    procedure sqlPagesAfterOpen(DataSet: TDataSet);
    procedure sqlPagesBeforeOpen(DataSet: TDataSet);
    procedure sqlPagesBeforePost(DataSet: TDataSet);
    procedure dbContentLookClick(Sender: TObject);
    procedure dbSectionsLookClick(Sender: TObject);
    procedure dbBlocksLookClick(Sender: TObject);
    procedure dbPresetsLookClick(Sender: TObject);
    procedure dsPagesDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure FormCreate(Sender: TObject);

    procedure btImgClick(Sender: TObject);
    procedure sqlPagesBeforeScroll(DataSet: TDataSet);
    procedure sqlPresetsAfterInsert(DataSet: TDataSet);
    procedure sqlPresetsAfterPost(DataSet: TDataSet);
    procedure sqlSectionsAfterInsert(DataSet: TDataSet);
    procedure sqlSectionsAfterPost(DataSet: TDataSet);



  private
    { private declarations }
  public
    { public declarations }
    Titles, Urls, Sections: TMemo;
    SiteSectionUrls, SiteSectionTitles: TMemo;
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

    procedure makePage(title: string; body: string; headTemplate: string;
      bodyTemplate: string; filenam: string);
    procedure paired(t: string);
    procedure tagHref();
    procedure tagImg();
    procedure tagList(t: string);
    function moduleexec(cmd: string): string;
    function useModules(app: string): string;
    function owntagexec(containter, cmd: string): string;
    function useOwnTags(app: string): string;
    function buildItem(itemtpl: string; itemUrl: string; itemTitle: string): string;
    function buildSection(sectiontpl: string; sectionUrl: string;
      sectionTitle: string; items: string): string;
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


    procedure createPagesSQL(); // версия sqlite





    procedure createSectionsSQL(); // версия sqlite




    procedure createBlocksSQL(); // версия sqlite


    procedure createPresetsSQL(); // версия sqlite

    function applyVar(str, variable, value : string) : string;
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
     procedure insertDemoDataContent();
     procedure insertDemoDataSections();
     procedure insertDemoDataBlocks();
     procedure insertDemoDataPresets();
     procedure insertDemoData();
     procedure makeCreationTables();
     procedure changeDataSources();

     procedure checkConnect(msg : String);

     {Хелперы}
     procedure addIntoBlock( id, markup, remark : String);
     procedure addIntoSection( id, section, preset, note : String);
     procedure addIntoContent( id, cap, content, section : String);
     procedure addIntoPreset(id, sitename, dirpath, headtpl, bodytpl, sectiontpl, itemtpl : String);

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


  edPathToBuild.Text:=GetEnvironmentVariable('HOME')+'/mysite';
end;


procedure TForm1.btImgClick(Sender: TObject);
begin
  tagImg();
end;

procedure TForm1.sqlPagesBeforeScroll(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlPresetsAfterInsert(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlPresetsAfterPost(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlSectionsAfterInsert(DataSet: TDataSet);
begin
   ShowMessage('вставка!');

end;

procedure TForm1.sqlSectionsAfterPost(DataSet: TDataSet);
begin

   ShowMessage('пост!');

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

procedure TForm1.btItalicClick(Sender: TObject);
begin
  paired('i');
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
  Form1.dbmSectionTemplate.Text:=fbuffer.text;
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

procedure TForm1.btOrderedListClick(Sender: TObject);
begin
  tagList('ol');
end;

procedure TForm1.btBoldClick(Sender: TObject);
begin
  paired('b');
end;

procedure TForm1.btBuildSiteClick(Sender: TObject);
begin

end;

procedure TForm1.AppPagesChange(Sender: TObject);
begin

end;

procedure TForm1.btParagraphClick(Sender: TObject);
begin
  paired('p');
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

procedure TForm1.btSubClick(Sender: TObject);
begin
  paired('sub');
end;

procedure TForm1.btSupClick(Sender: TObject);
begin
  paired('sup');
end;

procedure TForm1.btUnderlineClick(Sender: TObject);
begin
  paired('u');
end;

procedure TForm1.btUnorderedListClick(Sender: TObject);
begin
  tagList('ul');
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

procedure TForm1.btHrefClick(Sender: TObject);
begin
  tagHref();
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

procedure TForm1.Panel25Click(Sender: TObject);
begin

end;





procedure TForm1.sqlBlocksAfterInsert(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlBlocksAfterPost(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlContentBeforeEdit(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlPagesAfterOpen(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlPagesBeforeOpen(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlPagesBeforePost(DataSet: TDataSet);
begin

end;

procedure TForm1.dbContentLookClick(Sender: TObject);
begin

     dbContentLook.ListSource.DataSet.Locate(dbContentLook.KeyField, dbContentLook.KeyValue, []);


end;

procedure TForm1.dbSectionsLookClick(Sender: TObject);
begin
//dbSectionsLook.ListSource.DataSet.Locate(dbSectionsLook.KeyField, dbSectionsLook.KeyValue, []);
end;

procedure TForm1.dbBlocksLookClick(Sender: TObject);
begin
 //.BlocksLook.ListSource.DataSet.Locate(dbBlocksLook.KeyField,dbBlocksLook.KeyValue, []);
end;

procedure TForm1.dbPresetsLookClick(Sender: TObject);
begin

end;

procedure TForm1.dsPagesDataChange(Sender: TObject; Field: TField);
begin

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
 r:=applyVar(r, '{section}', s);
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
end;

procedure TForm1.scanSections;
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






{{ ================== сборка файла  ====================== }}

procedure TForm1.makePage(title: string; body: string; headTemplate: string;
  bodyTemplate: string; filenam: string);
var
  id : String;
begin
    if FileExists(filenam) then DeleteFile(filenam);
    Buffer.Clear;
    Buffer.Lines.Add('<!DOCTYPE html>');
    Buffer.Lines.Add('<html><head>');
                              Buffer.Lines.Add(
                              useOwnTags(useModules(useBlocks(buildHead(title, headTemplate)))));
                              Buffer.Lines.Add('</head><body>');
                              Buffer.Lines.Add( useOwnTags(useModules(insSections(insLinks(useBlocks(buildBody(title, body, bodyTemplate)))))));
                              Buffer.Lines.Add('</body></html>');


                              // id of pages
                              id := ExtractFileName(filenam);
                              id := Copy(id, 1, Pos('.', id)-1);
                              Buffer.Text:=StringReplace(Buffer.Text, '{id}',
                              id , [rfReplaceAll]);
                              try


                               if logger_info then mmRubrics.Lines.Add('ФАЙЛ НА ЗАПИСЬ!');
                               if logger_info then mmRubrics.Lines.Add(Buffer.Lines.Text);

                              Buffer.Lines.SaveToFile(filenam);
                              except
                              end;
end;

procedure TForm1.paired(t: string);
begin
  if (fContent.SelText <> '') then
  fContent.SelText:='<'+t+'>'+  fContent.SelText+'</'+t+'>'
  else
    fContent.Lines.Add('<'+t+'></'+t+'>');
end;

procedure TForm1.tagHref;
begin
  fContent.Lines.Add('<a href=""></a>');
end;

procedure TForm1.tagImg;
begin
  fContent.Lines.Add('<img src="" />');
end;

procedure TForm1.tagList(t: string);
begin
  fContent.Lines.Add('<' + t + '>');
  fContent.Lines.Add('<li>Элемент списка 1</li>');
  fContent.Lines.Add('<li>Элемент списка 2</li>');
  fContent.Lines.Add('</' + t + '>');
end;

function TForm1.moduleexec(cmd: string): string;
var
  P: TProcess;
  R: string;
  M: TMemo;
  filenam: string;
begin
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
  sectionTitle: string; items: string): string;
var
  r: string;
begin

  r := sectionTpl;
  r := applyVar(r, 'sectionUrl', sectionUrl );
  r := applyVar(r, 'sectionTitle', sectionTitle );
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
end;



procedure TForm1.createPagesSQL;
begin


        // Здесь мы настраиваем таблицу с именем "content" в новой базе данных.
        conn.ExecuteDirect('CREATE TABLE "content"('+
                    ' "id" Char(128) NOT NULL PRIMARY KEY,'+
                    ' "caption" Char(128),'+
                    ' "content" TEXT,'+
                    ' "section" Chat(128),'+
                    ' "uf1" Char(60),'+
                    ' "uf2" Char(60),'+
                    ' "uf3" Char(60),'+
                    ' "uf4" Char(60),'+
                    ' "uf5" Char(60),'+
                    ' "uf6" Char(60),'+
                    ' "uf7" Char(60)'
                    +');');

        // Создание индекса на основе идентификатора в таблице "DATA"
        conn.ExecuteDirect('CREATE UNIQUE INDEX "content_id_idx" ON "content"( "id" );');

        trans.Commit;
        SilentMessage('начальная настройка страниц, транзакция...');



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
         checkConnect('initTransactionSQL');


    end

    else

    begin
      // Создаем базу данных и таблицы
      SilentMessage('Создаем базу с нуля');



        // запросы в рамках транзакции

       checkConnect('initTransactionSQL');
         try
        form1.makeCreationTables(); // запросы на создание таблиц



        // пытаемся выполнить вставку данных

        form1.insertDemoData();






        SilentMessage(msgBaseSuccess);
          except
            SilentMessage(msgErrorCreating);
          end;
        end;
      except
        SilentMessage(msgCantCheckDbFile);
      end;

end;



procedure TForm1.createSectionsSQL;


begin
       CheckConnect('нет соединения <createSectionsSQL>!');

        // Здесь мы настраиваем таблицу с именем "section" в новой базе данных.
        conn.ExecuteDirect('CREATE TABLE "section"('+
                    ' "id" Char(60) NOT NULL PRIMARY KEY,'+
                    ' "section" Char(60),'+
                    ' "preset" Char(60),'+
                    ' "note" TEXT)');

        // Создание индекса на основе идентификатора в таблице "section"
        conn.ExecuteDirect('CREATE UNIQUE INDEX "section_id_idx" ON "section"( "id" );');

        trans.Commit;
       SilentMessage('начальная настройка секций, транзакция...');
 end;



procedure TForm1.createBlocksSQL;
begin
  CheckConnect('нет соединения <createBlocksSQL>!');
          // Здесь мы настраиваем таблицу с именем "block" в новой базе данных.
        conn.ExecuteDirect('CREATE TABLE "block"('+
                    ' "id" Char(60) NOT NULL PRIMARY KEY,'+
                    ' "markup" TEXT,'+
                    ' "remark" TEXT)');

        // Создание индекса на основе идентификатора в таблице "block"
        conn.ExecuteDirect('CREATE UNIQUE INDEX "block_id_idx" ON "block"( "id" );');

        trans.Commit;
        SilentMessage('начальная настройка блоков, транзакция...');
end;



procedure TForm1.createPresetsSQL;  // начальная настройка пресетов
begin

        CheckConnect('нет соединения <createPresetsSQL>!');

        // Здесь мы настраиваем таблицу с именем "presets" в новой базе данных.
        conn.ExecuteDirect('CREATE TABLE "preset"('+
                    ' "id" Char(60) NOT NULL PRIMARY KEY,'+
                    ' "sitename" Char(60),'+  // Название сайта
                    ' "dirpath" Char(60),'+      // Путь к папке в результатами
                    ' "headtpl" TEXT,'+         // Заголовочная часть шаблона
                    ' "bodytpl" TEXT,'+     // Основная часть шаблона
                    ' "sectiontpl" TEXT,'+  // Раздела обрамление
                    ' "itemtpl" TEXT,'+      // Оформление списка
                    ' "ufn1" Char(60),'+     // Название доп. поля 1, 2...
                    ' "ufn2" Char(60),'+
                    ' "ufn3" Char(60),'+
                    ' "ufn4" Char(60),'+
                    ' "ufn5" Char(60),'+
                    ' "ufn6" Char(60),'+
                    ' "ufn7" Char(60))'

                    );

        // Создание индекса на основе идентификатора в таблице "block"
        conn.ExecuteDirect('CREATE UNIQUE INDEX "preset_id_idx" ON "preset"( "id" );');

        trans.Commit;
        SilentMessage('начальная настройка пресетов, транзакция...');
end;

function TForm1.applyVar(str, variable, value: string): string;
begin
   Result:=StringReplace(str, '{'+variable+'}', value, [rfReplaceAll]);
end;

procedure TForm1.makeSqlActive;
begin

  checkConnect('makeSqlActive');
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

sqlContent.SQL.Text := 'select * from content';
sqlContent.Open;
ds_Content.AutoEdit:=True;
SilentMessage('выполнена загрузка страниц!');
end;

procedure TForm1.viewSectionsSQL;
  begin

  sqlSections.SQL.Text := 'select * from section';
  sqlSections.Open;
  SilentMessage('выполнена загрузка разделов!');
  end;

procedure TForm1.viewBlocksSQL;
begin

  sqlBlocks.SQL.Text := 'select * from block';
  sqlBlocks.Open;
  SilentMessage('выполнена загрузка блоков!');
end;

procedure TForm1.viewPresetsSQL;
begin

  sqlPresets.SQL.Text := 'select * from preset';
  sqlPresets.Open;

  SilentMessage('выполнена загрузка настроек!');
end;

procedure TForm1.viewTablesSQL;
begin
  checkConnect('viewTablesSQL');
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

  dbContentLook.DataSource:=form1.ds_Content; // список страниц
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
  dbmSectionTemplate.DataSource:=form1.ds_Sections; // поле шаблон раздела


  dbSectionsLook.DataSource:=form1.ds_Sections; // список секций
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
  dbBlocksLook.DataSource:=form1.ds_Blocks; // список блоков
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

  dbPresetsLook.DataSource:=form1.ds_Presets;
  dbNav_Presets.DataSource:=form1.ds_Presets; // листалка
end;

procedure TForm1.insertDemoDataContent;   // демо страниц

begin
  checkConnect('нет соединения <insertDemoDataContent>!');

  form1.addIntoContent('index', 'Hello!',
    'This is my first static page. Here link <<blog>> to section', 'blog');
  form1.addIntoContent('about', 'Other page',
    'This is my second static page. See <<photos>>. Here link <<blog>> to section', 'blog');
   form1.addIntoContent('photos1', 'Demo image 1',
    '<img width="640" src="https://iso.500px.com/wp-content/uploads/2015/01/50shades_17.jpg">. Here link <<blog>> to section', 'photos');
  form1.addIntoContent('photos2', 'Demo image2',
    '<img width="640" src="https://images.squarespace-cdn.com/content/v1/5b0cc6d2e2ccd12e7e8c03c6/1542800092550-16CBUJK7FOSVUC5SC46D/levitating_woman_hat_01.jpg?format=1000w"/>. See <<photos>>. Here link <<blog>> to section', 'photos');
  // параметризированный запрос

  //or possibly CommitRetaining, depending on how your application is set up
  SilentMessage('Демо данные установлены, страницы');



end;

procedure TForm1.insertDemoDataSections;   // демо данные для разделов
begin
  checkConnect('нет соединения <inserDemoDataSections>!');

  addIntoSection( 'blog', 'Блог'  , 'basis'  , 'Мой блог');
  addIntoSection( 'photos', 'Фото'  , 'basis'  , 'Фотографии');


  SilentMessage('Демо данные установлены, разделы');
end;

procedure TForm1.insertDemoDataBlocks; // демо данные блоки
begin
  checkConnect('нет соединения <inserDemoDataBlocks>!');


  addIntoBlock( 'mainmenu',
   'Ссылка на раздел <<blog>> , Ссылка на раздел <<photos>>', 'Nav template');

  addIntoBlock('bootstrap',
  '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">'+
  '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>',
  'bootstrap 5');




  SilentMessage('Демо данные установлены, блоки');
end;

procedure TForm1.insertDemoDataPresets;
begin
  checkConnect('нет соединения <inserDemoDataPresets>!');

  addIntoPreset( 'basis', 'My Site' , GetEnvironmentVariable('HOME')+'/mysite',
  '{bootstrap}<meta charset="utf-8"><title>{sitename}-{title}</title>',
  '{mainmenu}<h1>{title}</h1><p>{content}</p>',
  '{mainmenu}<h1>Тема: {sectionTitle}</h1> Материалы :<ul>{items}</ul>',
   '<li><a href="{itemUrl}.{ext}">{itemTitle}</a></li>');



     SilentMessage('Демо данные установлены, настройки');
end;

procedure TForm1.insertDemoData;
begin
  checkConnect('нет соединения <insertDemoData>!');
   // инициализация демо данными
          try
             form1.insertDemoDataContent();
          except
             SilentMessage('Не удалось настроить контент');
          end;

          try
              form1.insertDemoDataSections();
          except
             SilentMessage('Не удалось настроить разделы');
          end;

          try
              form1.insertDemoDataBlocks();
          except
             SilentMessage('Не удалось настроить блоки');
          end;

          try
              form1.insertDemoDataPresets();
          except
             SilentMessage('Не удалось настроить пресеты');
          end;
end;

procedure TForm1.makeCreationTables;
begin

            checkConnect('makeCreationTables');


            try
            form1.createPagesSQL();

            except
                 SilentMessage('Проблема с таблицей content');
            end;
            form1.createSectionsSQL();
            form1.createBlocksSQL();
            form1.createPresetsSQL();
end;

procedure TForm1.changeDataSources;
begin
  Form1.changeDataSourcesContent();
  Form1.changeDataSourcesSections();
  Form1.changeDataSourcesBlocks();
  Form1.changeDataSourcesPresets();
end;

procedure TForm1.checkConnect(msg: String);
begin
   if not conn.Connected then
          begin
           SilentMessage('нет соединения, переподключаюсь! <'+msg+'>');
           conn.Open;
           trans.Active:=true;
          end
  else
    SilentMessage('требование выполнено <'+msg+'>');
end;

procedure TForm1.addIntoBlock(id, markup, remark: String);
begin
 temp_sql.ReadOnly:=False;
 temp_sql.sql.text := 'insert into block (id, markup, remark) values (:ID,:MARKUP,:REMARK)';
 temp_sql.prepare;
 temp_sql.Params.ParamByName('ID').AsString := id;
 temp_sql.Params.ParamByName('MARKUP').AsString := markup;
 temp_sql.Params.ParamByName('REMARK').AsString := remark;

 temp_sql.ExecSQL; // подготовим запрос
   // выполним транзакцию
  trans.CommitRetaining;  //or possibly CommitRetainin
end;

procedure TForm1.addIntoSection(id, section, preset, note: String);
begin
  temp_sql.ReadOnly:=False;
   temp_sql.sql.text := 'insert into section (id, section, preset, note) values (:ID,:SECTION,:PRESET, :NOTE)';
   temp_sql.prepare;

  temp_sql.Params.ParamByName('ID').AsString := id;
  temp_sql.Params.ParamByName('SECTION').AsString := section;
 temp_sql.Params.ParamByName('PRESET').AsString := preset;
 temp_sql.Params.ParamByName('NOTE').AsString := note;
 temp_sql.ExecSQL; // подготовим запрос
 // выполним транзакцию
  trans.CommitRetaining;
end;

procedure TForm1.addIntoContent(id, cap, content, section: String);
begin
  temp_sql.ReadOnly:=False;
    temp_sql.sql.text := 'insert into content (id, caption, content, section) values (:ID,:CAPTION,:CONTENT, :SECTION)';
  temp_sql.prepare;
  // заполним параметры

  temp_sql.Params.ParamByName('ID').AsString := id;

  temp_sql.Params.ParamByName('CAPTION').AsString := cap;

  temp_sql.Params.ParamByName('CONTENT').AsString := content;


  temp_sql.Params.ParamByName('SECTION').AsString := section;

  temp_sql.ExecSQL; // подготовим запрос
 // выполним транзакцию
 trans.CommitRetaining;
end;

procedure TForm1.addIntoPreset(id, sitename, dirpath, headtpl, bodytpl,
  sectiontpl, itemtpl: String);
begin
 temp_sql.ReadOnly:=False;
   temp_sql.sql.text := 'insert into preset (id, sitename,dirpath,headtpl,bodytpl,sectiontpl,itemtpl) values '+
  '(:ID,:SITENAME,:DIRPATH,:HEADTPL,:BODYTPL,:SECTIONTPL,:ITEMTPL)';
  temp_sql.prepare;
  temp_sql.Params.ParamByName('ID').AsString := id;
   temp_sql.Params.ParamByName('SITENAME').AsString := sitename;
   temp_sql.Params.ParamByName('DIRPATH').AsString := dirpath;
  temp_sql.Params.ParamByName('HEADTPL').AsString := headtpl;
  temp_sql.Params.ParamByName('BODYTPL').AsString :=  bodytpl;
  temp_sql.Params.ParamByName('SECTIONTPL').AsString :=  sectiontpl;
  temp_sql.Params.ParamByName('ITEMTPL').AsString := itemtpl;

   temp_sql.ExecSQL; // подготовим запрос
   // выполним транзакцию
  trans.CommitRetaining;  //or possibly CommitRetainin
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
                                    buildOwnFields(
                                           useBlocks(
                                                   insertSectionsAndLinks(
                                                             buffer.Lines.Text)
                                                    ),
                                        page);


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

function TForm1.buildItem(itemtpl: string; itemUrl: string; itemTitle: string): string;
var
  r: string;
begin
  r := itemTpl;
  r := applyVar(r, 'itemUrl', itemUrl);
  r := applyVar(r, 'itemTitle', itemTitle);
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
                       sqlRubrication.Prepare;
                       sectionId := sqlCounter.FieldByName('section').AsString;
                       sqlRubrication.ParamByName('section_id').AsString:=sectionId;
                       sqlRubrication.ParamByName('pageoffset').AsInteger:=(page-1)*itemsPerPage;
                       sqlRubrication.ParamByName('pagelimit').AsInteger := itemsPerPage;
                       sqlRubrication.Open;
                       itemHtml := '';
                       sqlRubrication.First;
                       while not sqlRubrication.EOF do
                             begin
                                   itemHTML := itemHtml +

                                   buildItem( sqlRubrication.FieldByName('itemtpl').AsString,
                                     sqlRubrication.FieldByName('content_id').AsString,
                                     sqlRubrication.FieldByName('caption').AsString );
                                   sqlRubrication.Next;
                             end;



                            sectionHtml :=




                            applyVar(



                            buildSection( sqlRubrication.FieldByName('sectiontpl').AsString,
                                              sqlRubrication.FieldByName('id').asString,
                                              sqlRubrication.FieldByName('section').AsString, itemHtml ),
                            'pager',
                                    buildPagination(sqlRubrication.FieldByName('id').AsString, page, pagesInRubrics)
                                    );




                            headHtml:=buildHead( sqlRubrication.FieldByName('section').AsString,
                                                sqlRubrication.FieldByName('headtpl').AsString);

                            document:='<html><head>{header}</head><body>{body}</body>';

                            document:=ApplyVar(document, 'header', headHtml);
                            document:=ApplyVar(document, 'body', sectionHtml);
                            // постобработка
                            document:=useBlocks( insertSectionsAndLinks( document ) );


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
  makePage('Карта сайта', fbuffer.Text, sqlPresets.FieldByName('headtpl').AsString,
  sqlPresets.FieldByName('bodytpl').AsString
  , sqlPresets.FieldByName('dirpath').AsString+DELIM +'sitemap.'+form1.PrefferedExtension.Text);
  fbuffer.Free;
end;

function TForm1.insertSectionsAndLinks(str: string): string;
begin
  Result:= insSections(insLinks(str));
end;

procedure TForm1.scanBlocks;
var k : byte;
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

end;









end.
