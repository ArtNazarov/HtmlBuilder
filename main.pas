unit main;

{$mode objfpc}{$H+}

interface



uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBCtrls,
  dbf, process, FileUtil, SynHighlighterHTML, SynEdit,
  StdCtrls, ExtCtrls, ComCtrls,
  Menus, blcksock, sockets, Synautil, synaip, synsock, ftpsend; {Use Synaptic}

const

    DELIM : Char = '/';

    DLM_MODULE = '`';

type


  { ServerThread }



  { TForm1 }

  TForm1 = class(TForm)
    btBold: TButton;
    btBuildSite: TButton;
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
    cboLocale: TComboBox;
    chkUseModules: TCheckBox;
    chkGetBlocksFromFile: TCheckBox;
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
    DBEdit21: TDBEdit;
    dbeSiteName: TDBEdit;
    dbeSiteDirectory: TDBEdit;
    dbeSectionId: TDBEdit;
    dbeSectionCaption: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    dbeBlockNote: TDBMemo;
    dbeBlockHtml: TDBMemo;
    dbmHeadTemplate: TDBMemo;
    dbmBodyPagesTemplate: TDBMemo;
    dbmSectionTemplate: TDBMemo;
    dbmBodySectionsTemplate: TDBMemo;
    dbmTemplateOfItem: TDBMemo;
    dbNav: TDBNavigator;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
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
    edPreset: TDBLookupComboBox;
    fCaption: TDBEdit;
    dContent: TDBMemo;
    fID: TDBEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
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
    dbeUserField7: TPanel;
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
    fContent: TSynEdit;
    SynHTMLSyn1: TSynHTMLSyn;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    dsPages: TDataSource;
    dsBlocks: TDataSource;
    dsPresets: TDataSource;
    dsSections: TDataSource;
    dbfPages: TDbf;
    dbfBlocks: TDbf;
    dbfPresets: TDbf;
    dbfSections: TDbf;
    DBLookupListBox1: TDBLookupListBox;
    DBLookupListBox2: TDBLookupListBox;
    DBLookupListBox3: TDBLookupListBox;
    DBLookupListBox4: TDBLookupListBox;
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
    procedure btBoldClick(Sender: TObject);
    procedure btBuildSiteClick(Sender: TObject);
    procedure btFtpUpdateClick(Sender: TObject);
    procedure btItalicClick(Sender: TObject);
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
    procedure dbfPagesBeforePost(DataSet: TDataSet);
    procedure DBLookupListBox1Click(Sender: TObject);
    procedure DBLookupListBox2Click(Sender: TObject);
    procedure DBLookupListBox3Click(Sender: TObject);
    procedure DBLookupListBox4Click(Sender: TObject);
    procedure dsPagesDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure FormCreate(Sender: TObject);

    procedure btImgClick(Sender: TObject);



  private
    { private declarations }
  public
    { public declarations }
    Titles, Urls, Sections: TMemo;
    SiteSectionUrls, SiteSectionTitles: TMemo;
    ListenerSocket, ConnectionSocket: TTCPBlockSocket;

    Cache : tStringList;    {{ for webserver }}
    PostsEditorState : String;
    procedure initdb();
    function buildHead(title: string; headTemplate: string): string;
    function buildBody(title: string; body: string; bodyTemplate: string): string;
    function useBlocks(part: string): string;
    procedure scanLinks();
    procedure scanSections();
    function insLinks(body: string): string;
    function insSections(body: string): string;
    procedure SiteMapping();
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
    function buildOwnFields(html: string): string;
    function prefExtension(lin: string): string;
    procedure localeRUS();
    procedure localeENG();

    function Pager(layout: String; pages: String): String;

    procedure createPages();
    procedure createSections();
    procedure createBlocks();
    procedure createPresets();
    function applyVar(str, variable, value : string) : string;

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  initdb();

  Cache:=TStringList.Create;

  dbNav.DataSource.AutoEdit := True;
  dbNav.Enabled := True;

  Titles := TMemo.Create(Self); // Заголовки
  Urls := TMemo.Create(Self); // URL страниц
  Sections := TMemo.Create(Self); // Разделы страниц

  SiteSectionUrls := TMemo.Create(Self); // URL разделов
  SiteSectionTitles := TMemo.Create(Self); // Заголовки разделов

  edPreset.ItemIndex := 0;

  edPathToBuild.Text:=GetEnvironmentVariable('HOME')+'/mysite';
end;


procedure TForm1.btImgClick(Sender: TObject);
begin
  tagImg();
end;




 // КЛИК ПО КНОПКЕ СОБРАТЬ

procedure TForm1.btBuildSiteClick(Sender: TObject);
var
  filenam, dir, titl, content, headT, bodyT : String;
  fbuffer : TStringList;
begin
  fbuffer:=TStringList.Create;
  scanLinks();
  scanSections();

  dbfPresets.Locate('id', edPreset.Text , []);
  dir:=dbfPresets.FieldByName('dirpath').AsString;
  if not chkGetBlocksFromFile.Checked then
    begin
  headT := useBlocks(dbfPresets.FieldByName('headtpl').AsString);
  bodyT := useBlocks(dbfPresets.FieldByName('bodytpl').AsString);
    end
  else
    begin
      fbuffer.LoadFromFile(GetCurrentDir + DELIM+'parts'+DELIM+'head.tpl');
      headT:=fbuffer.Text;
      fbuffer.LoadFromFile(GetCurrentDir + DELIM+'parts'+DELIM+'body.tpl');
      bodyT:=fbuffer.Text;
    end;
    fbuffer.Free;
  if SysUtils.DirectoryExists(dir) then
  begin
         dbfPages.First;
                      while not dbfPages.EOF do
                              begin
                              filenam := dir+DELIM+dbfPages.FieldByName('id').AsString+'.'+PrefferedExtension.Text;
                              titl := dbfPages.FieldByName('caption').AsString;
                              content := dbfPages.FieldByName('content').AsString;
                              makePage(titl, content, headT, bodyT, filenam);
                                          dbfPages.Next;
   end;                           end;
  dbfPages.First;
  SiteMapping();

  // open project in file manager
  Process1.CommandLine:=edFileManager.Text+' '+dbfPresets.FieldByName('dirpath').AsString;
  Process1.Execute;
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

  Path := dbfPresets.FieldByName('dirpath').AsString;

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
  dbfPresets.Edit;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts'+DELIM+'head.tpl' );
  Form1.dbmHeadTemplate.Text:=fbuffer.text;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts' + DELIM+ 'body.tpl' );
  Form1.dbmBodyPagesTemplate.Text :=fbuffer.text;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts'+DELIM+'section.tpl' );
  Form1.dbmSectionTemplate.Text:=fbuffer.text;
  fbuffer.LoadFromFile( GetCurrentDir() + DELIM+'parts'+DELIM+'item.tpl' );
  Form1.dbmTemplateOfItem.Text:=fbuffer.text;
  dbfPresets.Post; // Применяем изменения
  // Получим список всех ID в таблице dbfBlocks
  dbfBlocks.First;
  while not dbfBlocks.EOF do begin
      idOfBlocksInBase.Add( dbfBlocks.FieldByName('id').AsString);
      dbfBlocks.Next;
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
                   dbfBlocks.First; k := 0;
                   while not dbfBlocks.EOF do
                         begin
                            if k<>indexToUpdate then

                             inc(k) else break;

                             dbfBlocks.Next;

                         end;
                   dbfBlocks.Edit;
                   dbfBlocks.FieldByName('id').AsString := installedIds[i];
                   dbfBlocks.FieldByName('markup').AsString := installedMarkups[i];
                   dbfBlocks.Post;
              end
           else
           begin
                 dbfBlocks.Insert;
                 dbfBLocks.FieldByName('id').AsString := installedIds[i];
                 dbfBlocks.FieldByName('markup').AsString := installedMarkups[i];
                 dbfBlocks.Post;
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
  dir := dbfPresets.FieldByName('dirpath').AsString;
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

procedure TForm1.dbfPagesBeforePost(DataSet: TDataSet);
begin
    dbfPages.FieldByName('content').AsString:=fContent.text; // пишем из редактора в поле перед обновлением
end;

procedure TForm1.DBLookupListBox1Click(Sender: TObject);
begin
  DBLookupListBox1.ListSource.DataSet.Locate(DBLookupListBox1.KeyField,
    DBLookupListBox1.KeyValue, []);
end;

procedure TForm1.DBLookupListBox2Click(Sender: TObject);
begin
  DBLookupListBox2.ListSource.DataSet.Locate(DBLookupListBox2.KeyField,
    DBLookupListBox2.KeyValue, []);
end;

procedure TForm1.DBLookupListBox3Click(Sender: TObject);
begin
  DBLookupListBox3.ListSource.DataSet.Locate(DBLookupListBox3.KeyField,
    DBLookupListBox3.KeyValue, []);
end;

procedure TForm1.DBLookupListBox4Click(Sender: TObject);
begin
  DBLookupListBox4.ListSource.DataSet.Locate(DBLookupListBox4.KeyField,
    DBLookupListBox4.KeyValue, []);
end;

procedure TForm1.dsPagesDataChange(Sender: TObject; Field: TField);
begin
   fContent.Text:=dbfPages.FieldByName('content').AsString;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if ListenerSocket <> nil then ListenerSocket.Free;
  if ConnectionSocket <> nil then  ConnectionSocket.Free;
end;

procedure TForm1.initdb;    { Cоздание базы данных }
begin
  createPages();
  createBlocks();
  createPresets();

  createSections();


  dbfPages.Active := True;
  dbfBlocks.Active := True;
  dbfPresets.Active := True;
  dbfSections.Active := True;
end;

function TForm1.buildHead(title: string; headTemplate: string): string;
var
  r: string;
begin
  r := headTemplate;
  r := StringReplace(r, '{title}', title, [rfReplaceAll]);
  r := StringReplace(r, '{sitename}', dbfPresets.FieldByName('sitename').AsString,
    [rfReplaceAll]);
  Result := r;
end;

{{ ============================== ОПОРНЫЕ ЧАСТИ ДВИЖКА - СБОРКА ТЕЛА СТРАНИЦЫ =============================== }}
function TForm1.buildBody(title : String; body : String; bodyTemplate  : String)  : String;
var r : String; s, s2 : string;
begin
 r:=bodyTemplate;
 r:=applyVar(r, 'title', title);
 r:=applyVar(r, 'content', body);
 s:=dbfPages.FieldByName('section').AsString;
 r:=applyVar(r, '{section}', s);
 dbfSections.First;
 while not dbfSections.EOF do
       begin
            s2:=dbfSections.FieldByName('id').AsString;
            if s2=s then
               begin
                 r:=applyVar(r, 'sectionName', dbfSections.FieldByName('section').AsString);
                 break;
               end;
               dbfSections.Next;
       end;
 r:=applyVar(r, 'sitename', dbfPresets.FieldByName('sitename').AsString);
 r:=applyVar(r, 'ext', PrefferedExtension.Text);
 Result:=R;
end;


{{ ============================== ОПОРНЫЕ ЧАСТИ ДВИЖКА - ПРИМЕНЕНИЕ ГЛОБАЛЬНЫХ БЛОКОВ =============================== }}
function TForm1.useBlocks(part: String): String;
var r : String; i, j : Integer; h, t : String;  fbuffer : TStringList;  blockFiles : TStringList;
   log : TStringList;

begin
  r := part;
  log := TStringList.Create;
  if not chkGetBlocksFromFile.Checked then // use database
  begin
  dbfBlocks.First;
  while not dbfBlocks.EOF do begin
        r:=StringReplace(r, '{'+dbfBlocks.FieldByName('id').AsString+'}', dbfBlocks.FieldByName('markup').AsString, [rfReplaceAll]);
        dbfBlocks.Next;
  end;
  dbfBlocks.First;
  end
  else begin

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
          log.Add('Replace in '+r+'{'+h+'} on '+t);
          log.Add('===== Result is ====');
          log.Add(r);
          log.Add('======/Result======');

        end;
    fbuffer.Free;
    log.SaveToFile('log.txt');
    log.Free;
  end;
  Result:=r;
end;

procedure TForm1.scanLinks;
begin

  Titles.Clear;      // Titles is a list of pages captions
  Urls.Clear;        // Urls is a list of urls for pages
  Sections.Clear;

  dbfPages.First;  // lookup from first record
  while not dbfPages.EOF do
  begin
    // add to list so each index is same item
    Titles.Lines.Add(dbfPages.FieldByName('caption').AsString);
    Urls.Lines.Add(dbfPages.FieldByName('id').AsString);
    Sections.Lines.Add(dbfPages.FieldByName('section').AsString);
    dbfPages.Next;  // see next page
  end;
  dbfPages.First;  // set cursor to first
end;

procedure TForm1.scanSections;
begin
  // identically as scanLinks
  SiteSectionUrls.Clear;
  SiteSectionTitles.Clear;
  dbfSections.First;
  while not dbfSections.EOF do
  begin
    SiteSectionTitles.Lines.Add(dbfSections.FieldByName('section').AsString);
    SiteSectionUrls.Lines.Add(dbfSections.FieldByName('id').AsString);
    dbfSections.Next;
  end;
  dbfSections.First;
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
  Result := r;
end;


function TForm1.Pager(layout: String; pages: String): String;
begin
  Result:=applyVar(layout, '{pager}', pages );
end;

 {{ ============================== ОПОРНЫЕ ЧАСТИ ДВИЖКА - ГЕНЕРАЦИЯ КАРТЫ САЙТА  =============================== }}


procedure TForm1.SiteMapping();
var i, j : integer; dir : String;  filenam : String; body : String;
  bodyTemplate, headTemplate, itemTpl, sectionTpl : String;
  stub : String;
  pagesTotal : integer;
  pageCurrent : integer;
  itemsPerPage : integer;
  itemsOnPage : integer;
  page : integer;
  b : String;
  items : Integer;
  paginator : String;
  pages : array[byte] of String;
  itemTxt : String;
  itemsTotal : byte;
  fbuffer : TStringList;
  ext : String;
  bodyTpl : String;
  pags : String;
begin
  ext := PrefferedExtension.Text;
  fbuffer := TStringList.Create;
  itemsPerPage := 7;
  dir:=dbfPresets.FieldByName('dirpath').AsString;
  bodyTemplate:= '{content}';
  if chkGetBlocksFromFile.Checked then
  begin                      // забираем из файла
     fbuffer.LoadFromFile(GetCurrentDir() + DELIM+'parts'+DELIM+'head.tpl'); // шаблон оформления
     headTemplate:=fbuffer.Text;
     fbuffer.LoadFromFile(GetCurrentDir() +DELIM+'parts'+DELIM+'item.tpl'); // шаблон элемента списка
     itemTpl:=fbuffer.Text;
     fbuffer.LoadFromFile(GetCurrentDir() +DELIM+'parts'+DELIM+'section.tpl'); // шаблон представления списка
     sectionTpl:=fbuffer.Text;
     fbuffer.LoadFromFile(GetCurrentDir() +DELIM+'parts'+DELIM+'body.tpl'); // шаблон представления списка
     bodyTpl:=fbuffer.Text;
     fbuffer.Free;
  end else begin                          // забираем из базы
  headTemplate:=dbfPresets.FieldByName('headtpl').AsString;
  itemTpl := dbfPresets.FieldByName('itemtpl').AsString;
  sectionTpl := dbfPresets.FieldByName('sectionTpl').AsString;
  bodyTpl := dbfPresets.FieldByName('bodyTpl').AsString;
  end;
  i:=0;
  while i<SiteSectionUrls.Lines.Count do
                           begin
                           {Подсчет страниц в разделе}
                           pagesTotal := 1;
                           pageCurrent := 1;
                           itemsOnPage := 0;
                           itemsTotal :=0;
                           Buffer.Clear;
                                              j:=0;
                           while j<Sections.Lines.Count do begin
                                    if Sections.lines[j] = SiteSectionUrls.lines[i] then
                                       begin
                                           inc(itemsOnPage);
                                           inc(itemsTotal);
                                           itemTxt:= buildItem(itemtpl, Urls.Lines[j], Titles.Lines[j]);
                                           Buffer.Lines.Add(itemTxt);
                                            if itemsOnPage<=itemsPerPage then
                                               pages[pageCurrent]:=buffer.text
                                               else begin
                                               inc(pageCurrent);
                                               buffer.Clear;
                                               buffer.Lines.Add(itemTxt);
                                               pages[pageCurrent]:=buffer.text;
                                               inc(pagesTotal);
                                               itemsOnPage:=1;
                                               end;
                                       end;
                   j:=j+1;
                                                      end; {/while}



  for page:=1 to pagesTotal do begin
  Buffer.Clear;
  buffer.lines.add(pages[page]);
// не добавляем buffer.lines.add(buildPagination(SiteSectionUrls.Lines[i], page, pagesTotal));
pags :=  buildPagination(SiteSectionUrls.Lines[i], page, pagesTotal);
//  stub:=InputBox('A', 'A', buildPagination(SiteSectionUrls.Lines[i], page, pagesTotal));
  if page=1 then
  filenam := dir + DELIM +'section_'+SiteSectionUrls.Lines[i]+'.'+ext
  else
   filenam := dir + DELIM +'section_'+SiteSectionUrls.Lines[i]+'_'+IntToStr(page)+'.'+ext;
  body:=insSections(insLinks(buildSection(sectionTpl, SiteSectionUrls.lines[i], SiteSectionTitles.Lines[i], buffer.Text)));
//  stub:=InputBox('B', 'B', body);
  body:=Pager(body, pags);
  makePage(SiteSectionTitles.Lines[i], body, headTemplate, bodyTemplate, filenam);
                   end; {/for}


              i:=i+1;
                                       end;

 // карта категорий
  fbuffer.Clear;
  fbuffer.Add('<ul>');
  dbfSections.First;
  while not dbfSections.EOF do
        begin
             fbuffer.Add(
             '<li><a href="./section_' + dbfSections.FieldByName('id').AsString + '.{ext}">'+
             dbfSections.FieldByName('section').AsString+'</a></li>');
             dbfSections.Next;
        end;
  fbuffer.Add('</ul>');
  makePage('Карта сайта', fbuffer.Text, headTemplate, bodyTpl, dir+ DELIM +'sitemap.'+ext);
end;

{{ ================== сборка файла  ====================== }}

procedure TForm1.makePage(title: String; body: String; headTemplate: String;
  bodyTemplate: String; filenam : String);
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
                              Buffer.Lines.Add(buildOwnFields(useOwnTags(useModules(insSections(insLinks(useBlocks(buildBody(title, body, bodyTemplate))))))));
                              Buffer.Lines.Add('</body></html>');


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

procedure TForm1.paired(t : String);
begin
  if (fContent.SelText <> '') then
  fContent.SelText:='<'+t+'>'+  fContent.SelText+'</'+t+'>'
  else
    fContent.Lines.Add('<'+t+'></'+t+'>');
end;

procedure TForm1.tagHref;
begin
  dContent.Lines.Add('<a href=""></a>');
end;

procedure TForm1.tagImg;
begin
  dContent.Lines.Add('<img src="" />');
end;

procedure TForm1.tagList(t: string);
begin
  dContent.Lines.Add('<' + t + '>');
  dContent.Lines.Add('<li>Элемент списка 1</li>');
  dContent.Lines.Add('<li>Элемент списка 2</li>');
  dContent.Lines.Add('</' + t + '>');
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

function TForm1.useModules(app: String): String;
var C, Start, En_d : integer;
  replacement : String;
  R : String;
begin

 R:=app;
 if chkUseModules.Checked then begin
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

function TForm1.OutputHTMLFile(uri: String): String;
var path : String; filename : String; Buf : TMemo;
  r : String;   fullq : String;
begin

  if uri = '/' then uri:='/index.'+PrefferedExtension.text;
  path := dbfPresets.FieldByName('dirpath').AsString;
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

function TForm1.buildOwnFields(html: string): string;
var
  r: string;
  i: byte;
  t: string;
begin
  r := html;
  for i := 1 to 7 do
  begin
    t := IntToStr(i);
    r := StringReplace(r, '{f' + t + '}', dbfPresets.FieldByName('ufn' + t).AsString,
      [rfReplaceAll]);
    r := StringReplace(r, '{v' + t + '}', dbfPages.FieldByName('uf' + t).AsString,
      [rfReplaceAll]);
  end;
  Result := r;
end;

function TForm1.prefExtension(lin: string): string;
var
  r: string;
begin
  r := lin;
  r := StringReplace(r, '$$ext', PrefferedExtension.Text, [rfReplaceAll]);
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

procedure TForm1.createPages();

begin
  // ТАБЛИЦА № 1 - КОНТЕНТ
  dbfPages.TableName := 'content.dbf';
  dbfPages.Exclusive := True;
  dbfPages.Active := False;
  if not SysUtils.FileExists('content.dbf') then
  begin

    with dbfPages.FieldDefs do
    begin
      Add('id', ftString, 60, True); // ID страницы
      Add('caption', ftString, 255, True); // Заголовок страницы
      Add('content', ftMemo, 16, True); // Контент страницы
      Add('section', ftString, 60, True);
      // Раздел, к которому относится страница
      Add('uf1', ftString, 60, True); // Доп. поле 1
      Add('uf2', ftString, 60, True); // Доп. поле 2
      Add('uf3', ftString, 60, True); // Доп. поле 3
      Add('uf4', ftString, 60, True); // Доп. поле 4
      Add('uf5', ftString, 60, True); // Доп. поле 5
      Add('uf6', ftString, 60, True); // Доп. поле 6
      Add('uf7', ftMemo, 16, True); // Доп. поле 7
    end;

    dbfPages.CreateTable;
    dbfPages.Active := True;
    dbfPages.Insert;
    dbfPages.FieldByName('id').AsString := 'index';
    dbfPages.FieldByName('caption').AsString := 'Hello!';
    dbfPages.FieldByName('content').AsString :=
      'This is my first static page. Here link <<blog>> to section';
    dbfPages.FieldByName('section').AsString := 'blog';
    dbfPages.Post;
    dbfPages.Insert;
    dbfPages.FieldByName('id').AsString := 'p1';
    dbfPages.FieldByName('caption').AsString := 'Second page';
    dbfPages.FieldByName('content').AsString :=
      'This is my second static page. Link to other <<index>> section.';
    dbfPages.FieldByName('section').AsString := 'blog';
    dbfPages.Post;
    dbfPages.Insert;
    dbfPages.FieldByName('id').AsString := 'p2';
    dbfPages.FieldByName('caption').AsString := 'Third page';
    dbfPages.FieldByName('content').AsString := 'This is my third static page.';
    dbfPages.FieldByName('section').AsString := 'index';
    dbfPages.Post;
  end;
end;

procedure TForm1.createSections;
begin
  // ТАБЛИЦА № 4 - РАЗДЕЛЫ САЙТА
  dbfSections.TableName := 'sections.dbf';
  dbfSections.Exclusive := True;
  dbfSections.Active := False;
  if not SysUtils.FileExists('sections.dbf') then
  begin
    with dbfSections.FieldDefs do
    begin
      Add('id', ftString, 60, True); // ID пресета
      Add('section', ftString, 60, True); // Название сайта
      Add('preset', ftString, 60, True);
      // Путь к папке в результатами
      Add('note', ftMemo, 16, True); // Заголовочная часть шаблона
    end;
    dbfSections.CreateTable;
    dbfSections.Active := True;
    dbfSections.Insert;
    dbfSections.FieldByName('id').AsString := 'blog';
    dbfSections.FieldByName('section').AsString := 'Блог';
    dbfSections.FieldByName('preset').AsString := 'basis';
    dbfSections.FieldByName('note').AsString := 'Мой блог';
    dbfSections.Post;
    dbfSections.Insert;
    dbfSections.FieldByName('id').AsString := 'index';
    dbfSections.FieldByName('section').AsString := 'Прочее';
    dbfSections.FieldByName('preset').AsString := 'basis';
    dbfSections.FieldByName('note').AsString := 'Мой блог';
    dbfSections.Post;
  end;
end;

procedure TForm1.createBlocks;
begin
  // ТАБЛИЦА № 2 - ГЛОБАЛЬНЫЕ БЛОКИ
  dbfBlocks.TableName := 'blocks.dbf';
  dbfBlocks.Exclusive := True;
  dbfBlocks.Active := False;
  if not SysUtils.FileExists('blocks.dbf') then
  begin
    with dbfBlocks.FieldDefs do
    begin
      Add('id', ftString, 60, True); // ID блока
      Add('markup', ftMemo, 16, True); // Разметка блока
      Add('remark', ftMemo, 16, True); // Примечание к блоку
    end;
    dbfBlocks.CreateTable;

    dbfBlocks.CreateTable;
    dbfBlocks.Active := True;
    dbfBlocks.Insert;
    dbfBlocks.FieldByName('id').AsString := 'mainmenu';
    dbfBlocks.FieldByName('markup').AsString :=
      '<div style="background-color:#e8e8e8"><ul><li>[index]</li><li>[p1]</li></ul></div>';
    dbfBlocks.FieldByName('remark').AsString := 'Меню';
    dbfBlocks.Post;

  end;
end;

procedure TForm1.createPresets;
begin
  // ТАБЛИЦА № 3 - ПРЕСЕТЫ (НАСТРОЙКИ И ШАБЛОНЫ)
  dbfPresets.TableName := 'presets.dbf';
  dbfPresets.Exclusive := True;
  dbfPresets.Active := False;
  if not SysUtils.FileExists('presets.dbf') then
  begin
    with dbfPresets.FieldDefs do
    begin
      Add('id', ftString, 60, True); // ID пресета
      Add('sitename', ftString, 60, True); // Название сайта
      Add('dirpath', ftString, 60, True);
      // Путь к папке в результатами
      Add('headtpl', ftMemo, 16, True);
      // Заголовочная часть шаблона
      Add('bodytpl', ftMemo, 16, True); // Основная часть шаблона
      Add('sectiontpl', ftMemo, 16, True); // Раздела обрамление
      Add('itemtpl', ftMemo, 16, True); // Оформление списка
      Add('ufn1', ftString, 60, True); // Название доп. поля 1
      Add('ufn2', ftString, 60, True); // Название доп. поля 2
      Add('ufn3', ftString, 60, True); // Название доп. поля 3
      Add('ufn4', ftString, 60, True); // Название доп. поля 4
      Add('ufn5', ftString, 60, True); // Название доп. поля 5
      Add('ufn6', ftString, 60, True); // Название доп. поля 6
      Add('ufn7', ftString, 60, True); // Название доп. поля 7
    end;
    dbfPresets.CreateTable;
    dbfPresets.Active := True;
    dbfPresets.Insert;
    dbfPresets.FieldByName('id').AsString := 'basis';
    dbfPresets.FieldByName('sitename').AsString := 'My Site';
    dbfPresets.FieldByName('dirpath').AsString := GetEnvironmentVariable('HOME')+'/mysite';
    dbfPresets.FieldByName('headtpl').AsString :=
      '<meta charset="utf-8"><title>{sitename}-{title}</title>';
    dbfPresets.FieldByName('bodytpl').AsString :=
      '{mainmenu}<h1>{title}</h1><p>{content}</p>';
    dbfPresets.FieldByName('sectiontpl').AsString :=
      '{mainmenu}<h1>Тема: {sectionTitle}</h1> Материалы :<ul>{items}</ul>';
    dbfPresets.FieldByName('itemtpl').AsString :=
      '<li><a href="{itemUrl}.htm">{itemTitle}</a></li>';
    dbfPresets.FieldByName('ufn1').AsString := 'UserField1';
    dbfPresets.FieldByName('ufn2').AsString := 'UserField2';
    dbfPresets.FieldByName('ufn3').AsString := 'UserField3';
    dbfPresets.FieldByName('ufn4').AsString := 'UserField4';
    dbfPresets.FieldByName('ufn5').AsString := 'UserField5';
    dbfPresets.FieldByName('ufn6').AsString := 'UserField6';
    dbfPresets.FieldByName('ufn7').AsString := 'UserField7';
    dbfPresets.Post;
  end;
end;

function TForm1.applyVar(str, variable, value: string): string;
begin
   Result:=StringReplace(str, '{'+variable+'}', value, [rfReplaceAll]);
end;




end.
