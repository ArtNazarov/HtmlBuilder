unit main;

{$mode objfpc}{$H+}

interface



uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBCtrls, dbf, SQLite3Conn, SQLDB, process, FileUtil, SynHighlighterHTML,
  SynEdit, DBDateTimePicker, StdCtrls, ExtCtrls, ComCtrls, Menus, DBGrids,
  ActnList, Buttons, blcksock, sockets, Synautil, synaip, synsock, ftpsend,
  db_helpers, db_insertdemo, db_create_tables, replacers, editor_in_window,
  editor_css, editor_js, DateUtils, fgl, regexpr, types_for_app,
  selectorTagsPages, const_for_app; {Use Synaptic}






type




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
    acActionsForMenu: TActionList;
    acFindContentByCaption: TAction;
    actsEditors: TActionList;
    btFtpUpdate: TButton;
    btnJoin: TButton;
    btnLoadFromWysiwyg: TButton;
    btStartServer: TButton;
    btStopServer: TButton;
    Buffer: TMemo;
    btnMakeArchive: TButton;
    btnLoad: TButton;
    btnEditorContent: TButton;
    btnEditorForSectionNote: TButton;
    btnEditorForSectionFullText: TButton;
    btnEditorForBlockMarkup: TButton;
    btnEditorHeadTemplate: TButton;
    btnEditorBodyPagesTemplate: TButton;
    BtnEditorBodySectionsTemplate: TButton;
    btnEditorTemplateOfItem: TButton;
    btnEditorCssOpen: TButton;
    btnEditorJs: TButton;
    btnOpenWithWysiwyg: TButton;
    btnPublishToGithubPages: TButton;
    btnAttachTagToMaterial: TButton;
    btnRefreshTree: TButton;
    cboLocale: TComboBox;
    chkUseTrees: TCheckBox;
    chkUseModules: TCheckBox;
    chkGetBlocksFromFile: TCheckBox;
    choicePreset: TDBLookupComboBox;
    dbeTree: TDBEdit;
    dbeMenuItemMenuId: TDBEdit;
    dbeMenuItemType: TDBEdit;
    dbeMenuItemCaption: TDBEdit;
    ds_MenuItem: TDataSource;
    ds_Menu: TDataSource;
    dbeItemMenuId: TDBEdit;
    dbeItemMenuLinkedWith: TDBEdit;
    dbeMenuId: TDBEdit;
    dbeMenuCaption: TDBEdit;
    dbmMenuTpl: TDBMemo;
    dbmMenuItemTpl: TDBMemo;
    dbNav_MenuItems: TDBNavigator;
    dbNav_Menus: TDBNavigator;
    dbSelectorTag: TDBLookupComboBox;
    ds_TagsOnPage: TDataSource;
    dbmTagsTemplate: TDBMemo;
    dbmItemTagTemplate: TDBMemo;
    ds_Tags_Pages: TDataSource;
    dbeTagsPages_id_tag_page: TDBEdit;
    dbeTagsPages_id_tag: TDBEdit;
    dbeTagsPages_id_page: TDBEdit;
    dbNav_TagsPages: TDBNavigator;
    ds_Tags: TDataSource;
    dbeTagId: TDBEdit;
    dbeTagCaption: TDBEdit;
    dbNav_Tags: TDBNavigator;
    dbOrder_Field_Set: TDBComboBox;
    dbOrder_Field: TDBComboBox;
    DBDateTimePicker1: TDBDateTimePicker;
    ds_JsScripts: TDataSource;
    dbeJsScriptId: TDBEdit;
    dbeScriptPath: TDBEdit;
    dbmJsScriptFile: TDBMemo;
    dbNav_JsScripts: TDBNavigator;
    ds_CssStyles: TDataSource;
    dbeCssPath: TDBEdit;
    dbeCssId: TDBEdit;
    dbmCssStyle: TDBMemo;
    dbmSectionFullText: TDBMemo;
    dbNav_Css: TDBNavigator;
    ds_Rubrication: TDataSource;
    dgCounter: TDBGrid;
    ds_Counter: TDataSource;
    ds_Join: TDataSource;
    dbJoin: TDBGrid;
    edGithubPagesPath: TEdit;
    edLocalWysigygServer: TEdit;
    ImageList1: TImageList;
    Label12: TLabel;
    lbTreeStructure: TLabel;
    lbTree: TLabel;
    lbMenuItemMenuID: TLabel;
    lbMenuItemType: TLabel;
    lbMenuItemID: TLabel;
    lbMenuItemCaption: TLabel;
    lbMenuItem_LinkFor: TLabel;
    lbMenuItems: TLabel;
    lbMenuId: TLabel;
    lbMenuCaption: TLabel;
    lbMenuTpl: TLabel;
    lbMenuItemTpl: TLabel;
    lbAttachTagToPage: TLabel;
    lbTagsOnPageTab: TLabel;
    lbTagsTemplate: TLabel;
    lbItemTagTempate: TLabel;
    lbTagsPages_Page_Tag: TLabel;
    lbTagsPages_Tag_Id: TLabel;
    lbTagsPages: TLabel;
    lbTagsPages_Id_tag_page: TLabel;
    lbTagId: TLabel;
    lbTagCaption: TLabel;
    lbTags: TLabel;
    lbGithubPagesPath: TLabel;
    lbOrderSet: TLabel;
    lbOrderField: TLabel;
    lbDt: TLabel;
    lbProgress: TLabel;
    lbJsScriptId: TLabel;
    lbJsScriptPath: TLabel;
    lbScriptFile: TLabel;
    lbCssPath: TLabel;
    lbCSS_id: TLabel;
    lbCssStyle: TLabel;
    lbCSS: TLabel;
    lbSpecification: TLabel;
    listTags: TListBox;
    lvMenuItems: TListView;
    lvTagsPages: TListView;
    lvTags: TListView;
    lvJsScripts: TListView;
    lvCSS: TListView;
    lvPresets: TListView;
    lvBlocks: TListView;
    lvContent: TListView;
    lvSections: TListView;
    mnuFinder: TMenuItem;
    mnuFind: TMenuItem;
    mmRubrics: TMemo;
    panCSSList: TPanel;
    panCSSElements: TPanel;
    Panel24: TPanel;
    panMenuProps: TPanel;
    panMenuItems: TPanel;
    panMenusList: TPanel;
    panMenus: TPanel;
    panLvTagsPages: TPanel;
    panTagPagesForm: TPanel;
    panTagsForm: TPanel;
    panJoinAction: TPanel;
    panProgress: TPanel;
    panJsProps: TPanel;
    panJs: TPanel;
    panJoin: TPanel;
    pBar: TProgressBar;
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
    lbCategory: TLabel;
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
    sqlCssStyles: TSQLQuery;
    sqlJsScripts: TSQLQuery;
    sqlGetTagsForPage: TSQLQuery;
    sqlMenu: TSQLQuery;
    sqlMenuItem: TSQLQuery;
    sqlTagsPages: TSQLQuery;
    sqlTags: TSQLQuery;
    sqlRubrication: TSQLQuery;
    tabJoin: TTabSheet;
    tabCSS: TTabSheet;
    tabJs: TTabSheet;
    tabMenus: TTabSheet;
    tabTagsTemplate: TTabSheet;
    tabItemTagTemplate: TTabSheet;
    tabTagsPages: TTabSheet;
    tabTags: TTabSheet;
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
    mnuMainMenu: TMainMenu;
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
    tvContent: TTreeView;
    tvSections: TTreeView;
    WebServerLog: TMemo;
    ZipArchiverCommand: TEdit;


    procedure acEditorForBlockMarkupExecute(Sender: TObject);
    procedure acEditorForBodyTemplateExecute(Sender: TObject);
    procedure acEditorForHeadTemplateExecute(Sender: TObject);
    procedure acEditorForRubricItemTemplateExecute(Sender: TObject);
    procedure acEditorForRubricSectionTemplateExecute(Sender: TObject);
    procedure acEditorForSectionFullTextExecute(Sender: TObject);
    procedure acEditorForSectionNoteExecute(Sender: TObject);
    procedure acFindContentByCaptionExecute(Sender: TObject);
    procedure AppPagesChange(Sender: TObject);

    procedure btFtpUpdateClick(Sender: TObject);

    procedure btnAttachTagToMaterialClick(Sender: TObject);
    procedure btnEditorCssOpenClick(Sender: TObject);
    procedure btnEditorJsClick(Sender: TObject);

    procedure btnJoinClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnLoadFromWysiwygClick(Sender: TObject);
    procedure btnOpenWithWysiwygClick(Sender: TObject);
    procedure btnPublishToGithubPagesClick(Sender: TObject);
    procedure btnRefreshTreeClick(Sender: TObject);


    procedure btStartServerClick(Sender: TObject);
    procedure btStopServerClick(Sender: TObject);

    procedure btnMakeArchiveClick(Sender: TObject);

    procedure btnEditorContentClick(Sender: TObject);

    procedure cboLocaleChange(Sender: TObject);
    procedure dbmSectionFullTextChange(Sender: TObject);
    procedure dbNav_MenuItemsClick(Sender: TObject; Button: TDBNavButtonType);

    procedure dbNav_ContentBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure dbNav_BlocksBeforeAction(Sender: TObject; Button: TDBNavButtonType
      );
    procedure dbNav_CssBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure dbNav_PresetsBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure dbNav_SectionsBeforeAction(Sender: TObject;
      Button: TDBNavButtonType);
    procedure ListBox1Click(Sender: TObject);

    procedure lvBlocksClick(Sender: TObject);
    procedure lvContentClick(Sender: TObject);
    procedure lvCSSClick(Sender: TObject);
    procedure lvJsScriptsClick(Sender: TObject);
    procedure lvMenuItemsClick(Sender: TObject);
    procedure lvPresetsClick(Sender: TObject);
    procedure lvSectionsClick(Sender: TObject);
    procedure redrawLvMenuItems();
    procedure refreshTrees();
    procedure refreshContentTree();
    procedure refreshSectionTree();







    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure FormCreate(Sender: TObject);
    procedure lvTagsClick(Sender: TObject);
    procedure lvTagsPagesClick(Sender: TObject);
    procedure panJsClick(Sender: TObject);



    procedure sqlBlocksAfterPost(DataSet: TDataSet);
    procedure sqlBlocksBeforeDelete(DataSet: TDataSet);


    procedure sqlContentAfterPost(DataSet: TDataSet);
    procedure sqlContentBeforeDelete(DataSet: TDataSet);

    procedure sqlCssAfterPost(DataSet: TDataSet);

    procedure sqlCssStylesAfterEdit(DataSet: TDataSet);
    procedure sqlCssStylesAfterPost(DataSet: TDataSet);
    procedure sqlCssStylesBeforeDelete(DataSet: TDataSet);
    procedure sqlCssStylesBeforeRefresh(DataSet: TDataSet);

    procedure sqlJsScriptsAfterPost(DataSet: TDataSet);
    procedure sqlJsScriptsBeforeDelete(DataSet: TDataSet);
    procedure sqlJsScriptsBeforeRefresh(DataSet: TDataSet);
    procedure sqlMenuAfterScroll(DataSet: TDataSet);
    procedure sqlMenuBeforeRefresh(DataSet: TDataSet);
    procedure sqlMenuItemBeforeEdit(DataSet: TDataSet);
    procedure sqlMenuItemBeforeInsert(DataSet: TDataSet);
    procedure sqlMenuItemBeforeRefresh(DataSet: TDataSet);

    procedure sqlPresetsAfterPost(DataSet: TDataSet);
    procedure sqlPresetsBeforeDelete(DataSet: TDataSet);
    procedure sqlPresetsBeforeRefresh(DataSet: TDataSet);

    procedure sqlSectionsAfterPost(DataSet: TDataSet);
    procedure sqlSectionsBeforeDelete(DataSet: TDataSet);
    procedure sqlTagsAfterPost(DataSet: TDataSet);
    procedure sqlTagsBeforeDelete(DataSet: TDataSet);
    procedure sqlTagsBeforeRefresh(DataSet: TDataSet);
    procedure sqlTagsPagesAfterPost(DataSet: TDataSet);
    procedure sqlTagsPagesBeforeDelete(DataSet: TDataSet);
    procedure sqlTagsPagesBeforeRefresh(DataSet: TDataSet);




  private
    { private declarations }
  public
    { public declarations }
    Titles, Urls, Sections: TMemo;
    PagesTree : sdict;

    SiteSectionUrls, SiteSectionTitles: TMemo;
    SiteSectionTree : sdict;

    CssTitles   : TStringList;
    JsTitles    : TStringList;

    Tags        : sdict;
    mTagsPages  : TagsPagesMap;

    POrs   : sdict;
    POrf   : sdict;


    SitePresets : TMemo;
    sqls : sqls_list;
    ListenerSocket, ConnectionSocket: TTCPBlockSocket;

    Blocks : TStringList; // блоки

    Cache : tStringList;    {{ for webserver }}
    PostsEditorState : String;

    rubrication_start : String;

    procedure initdbSQL(); // <-- новая инициализация
    function buildHead(title: string; headTemplate: string): string;
    function buildBody(title: string; body: string; bodyTemplate: string): string;
    function useBlocks(part: string): string;
    procedure scanLinks();
    procedure scanSections();
    procedure scanCss();
    procedure scanTagsPages();



    function insLinks(body: string): string;
    function insSections(body: string): string;
    procedure showTagsOnPage(id : string);




    function moduleexec(cmd: string): string;
    function usePreset(app : String) : string;
    function useModules(app: string): string;
    function owntagexec(container, cmd: string): string;
    function useOwnTags(app: string): string;
    function buildItem(itemtpl: string; itemUrl: string; itemTitle: string; itemDt : TDateTime; ur : user_records; tree : String): string;
    function buildSection(sectiontpl: string; sectionUrl: string;
      sectionTitle: string;
      sectionNote: string;
      sectionFullText : string;
      items: string): string;
    function buildPagination(
      url: string; currentPage: byte;
      pagesTotal: integer;
      orf       : String;
      ors       : String;
      useO      : Boolean;
      useTrees : boolean; tree : String
      ): string;
    procedure AttendConnection(ASocket: TTCPBlockSocket);
    procedure StartOwnServer();
    procedure StopOwnServer();
    function OutputHTMLFile(uri: string): string;
    function buildOwnFields(html: string; p : page_params): string;
    function prefExtension(lin: string): string;
    procedure localeRUS();
    procedure localeENG();

    function Pager(layout: String; pages: String): String;
    function useMenus(app : String) : String;


    procedure initTransactionSQL(); // Иниц. транзакция Sqlite
















    { Просмотр базы }
    procedure makeSqlActive();
    procedure makeSqlInactive();
    procedure viewPagesSQL();   // раздел страницы
    procedure viewSectionsSQL();  // раздел секции сайта
    procedure viewBlocksSQL();  // раздел глобальные блоки сайта
    procedure viewPresetsSQL();  // раздел пресеты (настройки сайта)
    procedure viewCssSQL(); // просмотр таблиц CSS
    procedure viewJsSQL();
    procedure viewTablesSQL(); // выполняем запросы на просмотр таблиц
    procedure viewTagsSQL();
    procedure viewTagsPagesSQL();
    procedure viewMenuSQL();
    procedure viewMenuItemSQL();



    { Переназначение datasource для таблицы content - страницы }
    procedure changeDataSourcesContent();
    { Переназначение datasource для таблицы section - разделы}
     procedure changeDataSourcesSections();
    { Переназначение datasource для таблицы block - глоб. блоки}
     procedure changeDataSourcesBlocks();
     { Переназначение datasource для таблицы preset - нач. настройки сайта}
     procedure changeDataSourcesPresets();
     procedure changeDataSourcesCss();
     procedure changeDataSourcesTags();
     procedure changeDataSourcesTagsPages();

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
     procedure doTagsMap();
     function insertSectionsAndLinks(str : string) : string;
     procedure scanBlocks();
     procedure scanPresets();
     procedure scanTags();
     procedure doScan();


     procedure editor_win_show(var sql : TSQLQuery; field : String );

     procedure doCssTables();
     procedure scanJs();
     procedure doJs();
     procedure changeDataSourcesJs();


     function insParamsToHead(head: String; page : page_params): String;
     function insParamsToBody(body: String; page : page_params): String;
     function getSortSelector(section : String; tree : String) : String;
     // TODO - declarations
     procedure makeRubricationUsingSorts(page : Integer; itemsPerPage : Integer; pagesInRubrics : Integer;
       rubrication_query: String; selected_orf : String; selected_ors : String; useo : boolean);


    procedure AfterPostHelper(var lv : TListView; var sql : TSQLQuery; field : String);
    procedure BeforeDeleteHelper(var lv : TListView; var sql : TSQLQuery; field : String);
    procedure listViewClickHelper(var lv : TListView; var sql : TSQLQuery; field : String);

    procedure insertArticlesToNode(var Node : TTreeNode; section : String);


       end;










var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  SiteSectionTree:=sdict.Create;
  PagesTree:=sdict.Create;

  rubrication_start:=sqlRubrication.SQL.Text;

  form1.initdbSQL();

  Cache:=TStringList.Create;

  dbNav_Content.DataSource.AutoEdit := True;
  dbNav_Content.Enabled := True;

 // dbNav_Css.DataSource.AutoEdit := True;
 // dbNav_Css.Enabled := True;

  Titles := TMemo.Create(Self); // Заголовки
  Urls := TMemo.Create(Self); // URL страниц
  Sections := TMemo.Create(Self); // Разделы страниц
  CssTitles:=TStringList.Create;
  JsTitles:=TStringList.Create;

  Tags:=sdict.Create;
  mTagsPages:=TagsPagesMap.Create;

  POrf := sdict.create();
  POrs := sdict.create();


  SiteSectionUrls := TMemo.Create(Self); // URL разделов
  SiteSectionTitles := TMemo.Create(Self); // Заголовки разделов
  blocks:=TStringList.Create();
  sitePresets:=TMemo.Create(Self);

  doScan();
  edPathToBuild.Text:=GetEnvironmentVariable('HOME')+'/mysite';
end;

procedure TForm1.lvTagsClick(Sender: TObject);
var tag_id : String;
begin
  listViewClickHelper(lvTags, sqlTags, 'tag_id');
end;

procedure TForm1.lvTagsPagesClick(Sender: TObject);
begin
  ListViewClickHelper(lvTagsPages, sqlTagsPages, 'id_tag_page');
end;

procedure TForm1.panJsClick(Sender: TObject);
begin

end;






procedure TForm1.sqlBlocksAfterPost(DataSet: TDataSet);
begin
  AfterPostHelper(lvBlocks, sqlBlocks, 'id');
end;

procedure TForm1.sqlBlocksBeforeDelete(DataSet: TDataSet);
begin
  beforedeletehelper(lvBlocks, sqlblocks, 'id');
end;







procedure TForm1.sqlContentAfterPost(DataSet: TDataSet);
var content_id : String; i : Integer; flag : boolean;
begin
 AfterPostHelper(lvContent, sqlContent, 'id');
end;

procedure TForm1.sqlContentBeforeDelete(DataSet: TDataSet);

begin
  BeforeDeleteHelper(lvContent, sqlContent, 'id');
end;

procedure TForm1.sqlCssAfterPost(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlCssStylesAfterEdit(DataSet: TDataSet);
begin

end;

procedure TForm1.sqlCssStylesAfterPost(DataSet: TDataSet);
begin
  AfterPostHelper(lvCSS,  sqlCssStyles, 'css_id');
end;

procedure TForm1.sqlCssStylesBeforeDelete(DataSet: TDataSet);
begin
  BeforeDeleteHelper(lvCSS, sqlCssStyles, 'css_id');
end;

procedure TForm1.sqlCssStylesBeforeRefresh(DataSet: TDataSet);
begin
  sqlCssStyles.ApplyUpdates;
end;

procedure TForm1.sqlJsScriptsAfterPost(DataSet: TDataSet);
begin
  AfterPostHelper(lvJsScripts, sqlJsScripts, 'js_id');
end;

procedure TForm1.sqlJsScriptsBeforeDelete(DataSet: TDataSet);
begin
  BeforeDeleteHelper(lvJsScripts, sqlJsScripts, 'js_id');
end;

procedure TForm1.sqlJsScriptsBeforeRefresh(DataSet: TDataSet);
begin
  sqlJsScripts.ApplyUpdates;
end;

procedure TForm1.sqlMenuAfterScroll(DataSet: TDataSet);
var new_request : String;
begin
  new_request:='select * from menu_item where menu_item_menu_id="'+
  sqlMenu.FieldByName('menu_id').AsString+'"';
  //showMessage(new_request);
 // sqlMenuItem.Close;
  sqlMenuItem.SQL.text:=new_request;
  open_sql(new_request, sqlMenuItem);
  sqlMenuItem.Refresh;
  redrawLvMenuItems();

end;

procedure TForm1.sqlMenuBeforeRefresh(DataSet: TDataSet);
begin
  sqlMenu.ApplyUpdates;
end;

procedure TForm1.sqlMenuItemBeforeEdit(DataSet: TDataSet);
begin
  sqlMenuItem.Refresh;
end;

procedure TForm1.sqlMenuItemBeforeInsert(DataSet: TDataSet);
begin
  sqlMenuItem.Refresh;
end;

procedure TForm1.sqlMenuItemBeforeRefresh(DataSet: TDataSet);
begin
  sqlMenuItem.ApplyUpdates;
end;

procedure TForm1.sqlPresetsAfterPost(DataSet: TDataSet);
begin
   AfterPostHelper(lvPresets, sqlPresets, 'id');
end;

procedure TForm1.sqlPresetsBeforeDelete(DataSet: TDataSet);
begin
  BeforeDeleteHelper(lvPresets, sqlPresets, 'id');
end;

procedure TForm1.sqlPresetsBeforeRefresh(DataSet: TDataSet);
begin
  sqlPresets.ApplyUpdates;
end;

procedure TForm1.sqlSectionsAfterPost(DataSet: TDataSet);
begin
  afterPostHelper(lvSections, sqlSections, 'id');
end;























procedure TForm1.sqlSectionsBeforeDelete(DataSet: TDataSet);
begin
  BeforeDeleteHelper(lvSections, sqlSections, 'id');
end;

procedure TForm1.sqlTagsAfterPost(DataSet: TDataSet);
begin
  afterPostHelper(lvTags, sqlTags, 'tag_id');
end;

procedure TForm1.sqlTagsBeforeDelete(DataSet: TDataSet);
begin
  BeforeDeleteHelper(lvTags, sqlTags, 'tag_id');
end;

procedure TForm1.sqlTagsBeforeRefresh(DataSet: TDataSet);
begin
  sqlTags.ApplyUpdates;
end;

procedure TForm1.sqlTagsPagesAfterPost(DataSet: TDataSet);
begin
  afterPostHelper(lvTagsPages, sqlTagsPages, 'id_tag_page');
end;

procedure TForm1.sqlTagsPagesBeforeDelete(DataSet: TDataSet);
begin
  beforedeletehelper(lvTagsPages, sqlTagsPages, 'id_tag_page');
end;

procedure TForm1.sqlTagsPagesBeforeRefresh(DataSet: TDataSet);
begin
  sqlTagsPages.ApplyUpdates;
end;








procedure TForm1.btFtpUpdateClick(Sender: TObject);
var
  IP, Port, FileName, LocalFile, Path, User, Pass: string;
  F: TSearchRec;
  is_file_put : boolean;
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
        mmFtpLog.Lines.Add('Local file name ' + LocalFile);
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

       is_file_put := FtpPutFile(IP, Port, FileName, LocalFile, User, Pass);
        if is_file_put then
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





procedure TForm1.btnAttachTagToMaterialClick(Sender: TObject);
var
  link_id : String; id_tag : String; id_page : String;
  add_sql : TSqlQuery;
begin
  add_sql:=TSqlQuery.Create(self);
  add_sql.SQLConnection:=conn;
  add_sql.Transaction:=trans;

   id_tag:=dbSelectorTag.KeyValue;
   id_page:=sqlContent.FieldByName('id').AsString;
   link_id:='linked_'+id_tag+'_with_'+id_page;
   addIntoTagsPages(link_id,  id_tag, id_page,  add_sql, conn, trans);

add_sql.Free;
   form1.showTagsOnPage(id_page);
end;

procedure TForm1.btnEditorCssOpenClick(Sender: TObject);
var ed : TfrmEditorCss;
begin
  ed:=TfrmEditorCss.Create(self);
  ed.editor.Text:=  sqlCssStyles.FieldByName('css_style').AsString;
  ed.ShowModal();



        sqlCssStyles.ApplyUpdates();
        sqlCssStyles.Edit;
        sqlCssStyles.FieldByName('css_style').AsString:=ed.editor.Text;

  ed.close();
  ed.free();
end;

procedure TForm1.btnEditorJsClick(Sender: TObject);
var jE : TfrmEditorJs;
begin
   jE:=TfrmEditorJs.Create(Self);
   jE.editor.text:=sqlJsScripts.FieldByName('js_file').AsString;
   jE.ShowModal;


   sqlJsScripts.ApplyUpdates;
   sqlJsScripts.Edit;
   sqlJsScripts.FieldByName('js_file').AsString:=jE.editor.text;
   sqlJsScripts.Post;

end;



{ Тестовый код }
procedure TForm1.btnJoinClick(Sender: TObject);
var start, stop: TDateTime;



begin



  start:=Now();

  form1.scanLinks(); // сканер ссылок нужен для автозамены
  form1.scanSections(); // сканер секций нужен для автозамены
  form1.scanBlocks(); // сканируем блоки




  doJoinPages(); // страницы
  doSections();  // разделы
  doSitemap(); // карта сайта
  doCssTables(); // css таблицы
  doJs(); // скрипты
  doTagsMap(); // все теги на сайте




  stop:=Now();


  mmRubrics.Lines.Add('НА СБОРКУ ПОТРЕБОВАЛОСЬ СЕКУНД:');
  mmRubrics.Lines.Add(FloatToStr(MilliSecondsBetween(start, stop)/1000));




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
      Application.ProcessMessages;
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
                             application.ProcessMessages;
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

procedure TForm1.btnLoadFromWysiwygClick(Sender: TObject);
var
   fileContent : TMemo;
   path : String;
begin

  path := form1.edLocalWysigygServer.Text;

  fileContent := TMemo.Create(Self);
  fileContent.Lines.LoadFromFile(path+'/public/content.txt');
  sqlContent.Edit;
  sqlContent.FieldByName('content').AsString:=fileContent.Text;

  fileContent.Free;


  Process1.CommandLine:='pkill node';
  Process1.Execute;

end;

procedure TForm1.btnOpenWithWysiwygClick(Sender: TObject);
var
   fileContent : TMemo;
   path : String;
   Process2 : TProcess;
   output : String;
begin

  path := form1.edLocalWysigygServer.Text;

  fileContent := TMemo.Create(Self);
  fileContent.Text:=sqlContent.FieldByName('content').AsString;
  fileContent.Lines.SaveToFile(path+'/public/content.txt');
  fileContent.Free;

  Process1.CommandLine:='node '+path+'/index.js';
  Process1.Execute;

  Process2:=TProcess.Create(Self);
  Process2.CommandLine := 'firefox http://127.0.0.1:3000';
  Process2.Execute;



end;

procedure TForm1.btnPublishToGithubPagesClick(Sender: TObject);
var ProcessCopy : TProcess;
begin
   ProcessCopy:=TProcess.Create(Self);
   ProcessCopy.CommandLine:='/usr/bin/bash -c "cp -r  '+form1.edPathToBuild.Text+'/* '+form1.edGithubPagesPath.Text+'" ';
   ProcessCopy.Execute;
   ProcessCopy.WaitOnExit; // ждем завершения копирования
   ProcessCopy.Free;

   ProcessCopy:=TProcess.Create(Self);
   ProcessCopy.CommandLine:='/usr/bin/bash -c "cd '+form1.edGithubPagesPath.Text+' && git add * " ';
   ProcessCopy.Execute;
   ProcessCopy.WaitOnExit; // добавляем файл в коммит
   ProcessCopy.Free;

   ProcessCopy:=TProcess.Create(Self);
   ProcessCopy.CommandLine:='/usr/bin/bash -c " cd '+form1.edGithubPagesPath.Text+' &&  git commit -m /"next commit/"  " ';
   ProcessCopy.Execute;
   ProcessCopy.WaitOnExit; // делаем коммит
   ProcessCopy.Free;







end;

procedure TForm1.btnRefreshTreeClick(Sender: TObject);
begin
     refreshTrees();
end;


procedure TForm1.acEditorForSectionNoteExecute(Sender: TObject);

begin
     editor_win_show( sqlSections, 'note');
end;

procedure TForm1.acFindContentByCaptionExecute(Sender: TObject);
var q : String;
   i : Integer;
   is_find : boolean;
begin
  // TODO Поиск по заголовку
  q:=InputBox('Поиск', 'Ищем ', '');
  is_find:=sqlContent.Locate('caption', q, [loCaseInsensitive, loPartialKey]);
  if is_find then
    begin
  for i:=0 to lvContent.Items.Count-1 do begin
    if lvContent.Items[i]<>NIL then
      if lvContent.Items[i].Caption = sqlContent.FieldByName('id').AsString then
        begin
             lvContent.ItemIndex:=i;
             break;
        end;
  end;
    end;
end;

procedure TForm1.AppPagesChange(Sender: TObject);
begin

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

begin
  form1.editor_win_show(sqlContent, 'content');
end;



procedure TForm1.cboLocaleChange(Sender: TObject);
begin
  if cboLocale.ItemIndex = 0 then
    LocaleRUS()
  else
    LocaleENG();
end;

procedure TForm1.dbmSectionFullTextChange(Sender: TObject);
begin

end;

procedure TForm1.dbNav_MenuItemsClick(Sender: TObject; Button: TDBNavButtonType);
begin

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

procedure TForm1.dbNav_CssBeforeAction(Sender: TObject; Button: TDBNavButtonType
  );
begin
   if (Button = nbRefresh) or (Button=nbDelete) then
  begin
   sqlCssStyles.ApplyUpdates();
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

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.lvBlocksClick(Sender: TObject);
begin
    listViewClickHelper(lvBlocks, sqlBlocks, 'id');
end;

procedure TForm1.lvContentClick(Sender: TObject);
begin
  listViewClickHelper(lvContent, sqlContent, 'id');
  showTagsOnPage(sqlContent.FieldByName('id').AsString);


end;

procedure TForm1.lvCSSClick(Sender: TObject);
begin
  listViewClickHelper(lvCSS, sqlCssStyles, 'css_id');
end;

procedure TForm1.lvJsScriptsClick(Sender: TObject);

begin
  listViewClickHelper(lvJsScripts, sqlJsScripts, 'js_id');
end;

procedure TForm1.lvMenuItemsClick(Sender: TObject);
begin
  listViewClickHelper(lvMenuItems, sqlMenuItem, 'menu_item_id');
end;

procedure TForm1.lvPresetsClick(Sender: TObject);
begin
  listViewClickHelper(lvPresets, sqlPresets, 'id');
end;

procedure TForm1.lvSectionsClick(Sender: TObject);
begin
  listViewClickHelper(lvSections, sqlSections, 'id');
end;

procedure TForm1.redrawLvMenuItems;
begin
  lvMenuItems.Clear;
  sqlMenuItem.First;
  while not sqlMenuItem.Eof do
         begin
           lvMenuItems.AddItem(sqlMenuItem.FieldByName('menu_item_id').AsString, nil);
           sqlMenuItem.Next;
         end;
  sqlMenuItem.First;
end;

procedure TForm1.refreshTrees;
begin
     refreshSectionTree;
     refreshContentTree;
end;

procedure TForm1.refreshContentTree;
var
  Branch : TStringList; k : Integer;
  Node, rootNode, parentNode, childNode    : TTreeNode;
  tree : String; // '/x/y/z';
  add_root : boolean;
  prev_node, ins_node : String;
begin
  tvContent.Items.Clear;



  sqlContent.ApplyUpdates;
  sqlContent.Refresh;

  sqlSections.ApplyUpdates;
  sqlSections.Refresh;


  sqlSections.First;
  while not sqlSections.EOF do
    begin
      tree:=sqlSections.FieldByName('tree').AsString;
      Branch:=TStringList.Create;
      Branch.Delimiter:='/';
      Branch.DelimitedText:=tree;

       add_root:=true;
       node:=nil;
      for k:=0 to Branch.Count-1 do
          begin

            if Branch[k] = '' then continue; // skip empty

            Node:=tvContent.Items.FindNodeWithText(Branch[k]);
            if (Node=NIL) and (k=1) then
               begin
                    Node:=tvContent.Items.Add(Node, Branch[k]);
                    Node.ImageIndex:=0;
                    // add content to this node
                    insertArticlesToNode(Node, Branch[k]);
               end;
            if (k>1) then
                begin
                  parentNode:=tvContent.Items.FindNodeWithText(Branch[k-1]);
                  Node:=tvContent.Items.FindNodeWithText(Branch[k]);
                  if (parentNode<>NIL) and (Node = NIL) then
                     begin
                          childNode:=tvContent.Items.AddChild(parentNode, Branch[k]);
                          childNode.ImageIndex:=0;
                          // add content to parent node

                           insertArticlesToNode(childNode, Branch[k]);
                     end;
                end;




          end;
      Branch.Free;
      sqlSections.Next;
    end;
  sqlSections.First;

end;

procedure TForm1.refreshSectionTree;
var
  Branch : TStringList; k : Integer;
  Node, rootNode, parentNode    : TTreeNode;
  tree : String; // '/x/y/z';
  add_root : boolean;
  prev_node, ins_node : String;
begin
  tvSections.Items.Clear;




  sqlSections.ApplyUpdates;
  sqlSections.Refresh;


  sqlSections.First;
  while not sqlSections.EOF do
    begin
      tree:=sqlSections.FieldByName('tree').AsString;
      Branch:=TStringList.Create;
      Branch.Delimiter:='/';
      Branch.DelimitedText:=tree;

       add_root:=true;
       node:=nil;
      for k:=0 to Branch.Count-1 do
          begin

            if Branch[k] = '' then continue; // skip empty

            Node:=tvSections.Items.FindNodeWithText(Branch[k]);
            if (Node=NIL) and (k=1) then
               Node:=tvSections.Items.Add(Node, Branch[k]);

            if (k>1) then
                begin
                  parentNode:=tvSections.Items.FindNodeWithText(Branch[k-1]);
                  Node:=tvSections.Items.FindNodeWithText(Branch[k]);
                  if (parentNode<>NIL) and (Node = NIL) then
                     tvSections.Items.AddChild(parentNode, Branch[k]);

                end;




          end;
      Branch.Free;
      sqlSections.Next;
    end;
  sqlSections.First;

end;





















procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  Tags.Free;

  try
  form1.makeSqlInactive();
  except
   //showMessage('Проблема при сохранении');
  end;

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
function TForm1.buildBody(title: string; body: string; bodyTemplate: string): string;
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
               Application.ProcessMessages;
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
        Application.ProcessMessages;
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

           Application.ProcessMessages;
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
var
   i : integer;
   sql_GetLinks : TSQLQuery;
begin
   sql_GetLinks:=TSQLQuery.Create(Self);
   sql_GetLinks.SQLConnection:=conn;
   sql_GetLinks.Transaction:=trans;
   sql_GetLinks.SQL.Text:='select content.* , section.tree from content left join section on content.section = section.id';
   sql_GetLinks.ExecSQL;
   sql_GetLinks.Active:=true;

  form1.dbNav_Content.Enabled:=false;

  Titles.Clear;      // Titles is a list of pages captions
  Urls.Clear;        // Urls is a list of urls for pages
  Sections.Clear;
  lvContent.clear;
  PagesTree.Clear;

  if not sql_GetLinks.Eof then  begin
  sql_GetLinks.First;  // lookup from first record
  while not sql_GetLinks.EOF do
  begin
    // add to list so each index is same item
    Titles.Lines.Add(sql_GetLinks.FieldByName('caption').AsString);
    Urls.Lines.Add(sql_GetLinks.FieldByName('id').AsString);
    Sections.Lines.Add(sql_GetLinks.FieldByName('section').AsString);
    PagesTree.Add(sql_GetLinks.FieldByName('id').AsString, sql_GetLinks.FieldByName('tree').AsString);
    sql_GetLinks.Next;  // see next page
    Application.ProcessMessages;
  end;
  sql_GetLinks.Free;  // set cursor to first


  for i:=0 to Urls.Lines.Count-1 do
      begin
        lvContent.AddItem( Urls.Lines.Strings[i] , nil);
      end;

  end;
  form1.dbNav_Content.Enabled:=true;
end;

procedure TForm1.scanSections;
var i : integer;
begin
  // identically as scanLinks
  SiteSectionTree.Clear;
  SiteSectionUrls.Clear;
  SiteSectionTitles.Clear;
  lvSections.clear;

  if not sqlSections.EOF then begin

  sqlSections.First;
  while not sqlSections.EOF do
  begin
    SiteSectionTitles.Lines.Add(sqlSections.FieldByName('section').AsString);
    SiteSectionUrls.Lines.Add(sqlSections.FieldByName('id').AsString);
    SiteSectionTree.Add(sqlSections.FieldByName('id').AsString, sqlSections.FieldByName('tree').AsString );
    sqlSections.Next;
    Application.ProcessMessages;
  end;
  sqlSections.First;



  for i:=0 to SiteSectionUrls.Lines.Count-1 do
      begin
        lvSections.AddItem( SiteSectionUrls.Lines.Strings[i] , nil);
        application.ProcessMessages;
      end;

  if logger_info then mmRubrics.Lines.Add('Заголовков страниц<scanSections>:'+IntToStr(SiteSectionTitles.Lines.Count));
  if logger_info then mmRubrics.Lines.Add('URL страниц<scanSections>:'+IntToStr(SiteSectionUrls.Lines.Count));
  end;
end;

procedure TForm1.scanCss;
var i : integer;
begin
  // identically as scanLinks
  CssTitles.clear;
  lvCss.clear;
  if not sqlCssStyles.eof then
    begin

  sqlCssStyles.First;
  while not  sqlCssStyles.EOF do
  begin
    CssTitles.AddPair(sqlCssStyles.FieldByName('css_id').AsString, '');

      sqlCssStyles.Next;
    Application.ProcessMessages;
  end;
   sqlCssStyles.First;



  for i:=0 to CssTitles.Count-1 do
      begin
        lvCss.AddItem( CssTitles.Names[i] , nil);
        application.ProcessMessages;
      end;


  if logger_info then mmRubrics.Lines.Add('URL страниц CSS<scanCss>:'+IntToStr(CssTitles.Count));
    end;
end;

procedure TForm1.scanTagsPages;
var r : Tag_Page_Link;   i : Integer;
begin
  sqlTagsPages.First;
  while not sqlTagsPages.EOF do
    begin
      r.id_tag_page:=sqlTagsPages.FieldByName('id_tag_page').AsString;

      r.id_tag:=sqlTagsPages.FieldByName('id_tag').AsString;
      r.id_page:=sqlTagsPages.FieldByName('id_page').AsString;
      mTagsPages.Add(r.id_tag_page, r);
      sqlTagsPages.Next;

    end;
  sqlTagsPages.First;

  // to ui

  for i:=0 to mTagsPages.Count-1 do
      begin
        lvTagsPages.AddItem( mTagsPages.Keys[i], nil);
      end;

end;



function TForm1.insLinks(body: string): string;
var
  r: string;
  i: integer;
  url, base_url, link : String;
begin
  // in body tag all existing shorttags
  // [linkname] replaced to <a href="linkurl">title</a>
  r := body;
  i := 0;
  while i < Urls.Lines.Count do
  begin
    base_url:='';
    if chkUseTrees.Checked then
      base_url:=PagesTree[ Urls.Lines[i] ];



    link:='<a href="{base_url}/' + Urls.Lines[i] + '.' +
      PrefferedExtension.Text + '">' + Titles.Lines[i] + '</a>';

    link:=ApplyVar(link, 'base_url', base_url);

    r := StringReplace(r, '[' + Urls.Lines[i] + ']',
      link, [rfReplaceAll]);
    Inc(i);
    Application.ProcessMessages;
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
  base_url, url : String;
begin
  //  in body identically as insSections
  //  <<section_url>> will be replaced to <a href="section_url">section_title</a>
  r := body;
  i := 0;
  //showMessage(IntToStr(SiteSectionUrls.Lines.Count));
  while i < SiteSectionUrls.Lines.Count do
  begin
    url:='<a href="{base_url}/section_' + SiteSectionUrls.Lines[i] +
      '.' + PrefferedExtension.Text + '">' + SiteSectionTitles.Lines[i] + '</a>';
    base_url:='';
    if chkUseTrees.Checked then
       base_url:=SiteSectionTree[SiteSectionUrls.Lines[i]];
    url:=applyVar(url, 'base_url', base_url);

    r := StringReplace(r, '<<' + SiteSectionUrls.Lines[i] + '>>', url, [rfReplaceAll]);
    Inc(i);
    Application.ProcessMessages;
  end;
  if logger_info then mmRubrics.Lines.Add('ПРОСТАВЛЯЕМ СЕКЦИИ');
  if logger_info then mmRubrics.Lines.Add('Вызвана<insSections> до ' +body);
  if logger_info then mmRubrics.Lines.Add('Вызвана<insSections> после '+r);
  if logger_info then if r=body then mmRubrics.Lines.Add('!!! СОВПАДАЮТ' );
  Result := r;
end;

procedure TForm1.showTagsOnPage(id: string);
begin
  sqlGetTagsForPage.Clear;
  sqlGetTagsForPage.Transaction:=trans;
  sqlGetTagsForPage.SQLConnection:=conn;
  sqlGetTagsForPage.SQL.LoadFromFile('sql_tags_for_page.txt');


 prepared_transaction_start(sqlGetTagsForPage.SQL.Text,
  sqlGetTagsForPage, trans);

  sqlGetTagsForPage.ParamByName('ID_PAGE').AsString := id;

  prepared_transaction_end( sqlGetTagsForPage, trans);

  sqlGetTagsForPage.Active:=true;

  listTags.Clear;
  sqlGetTagsForPage.First;
  while not sqlGetTagsForPage.EOF do
    begin
      listTags.AddItem(sqlGetTagsForPage.FieldByName('tag_caption').AsString, nil);
      sqlGetTagsForPage.Next;
    end;
  sqlGetTagsForPage.First;

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

function TForm1.useMenus(app: String): String;
var
  menu_map : sdict;
  m : Menu;
  sql_getMenuItems : TSqlQuery;
  list_html : String;
  itemView  : String;
  itemTitle : String;
  itemUrl   : String;
  k : Integer;
  R : String;
  menuView : String;
begin


  menu_map := sdict.Create;


sqlMenu.Refresh;
 sqlMenu.ApplyUpdates;

 sqlMenu.First;
 while not sqlMenu.EOF do
    begin
       m.menu_id:=sqlMenu.FieldByName('menu_id').AsString;
       m.menu_caption:=sqlMenu.FieldByName('menu_caption').AsString;

       sql_GetMenuItems:=TSqlQuery.Create(nil);


       sql_GetMenuItems.Transaction:=trans;
       sql_GetMenuItems.SQLConnection:=conn;
       sql_GetMenuItems.SQL.Clear;
       sql_GetMenuItems.SQL.Text:=
   'select * from menu_item WHERE '+
   ' menu_item_menu_id = "'+m.menu_id+'"';

   sql_GetMenuItems.Active:=true;

       list_html:='';
       sql_GetMenuItems.First;
       while not sql_getMenuItems.Eof do
          begin
            itemTitle:=sql_GetMenuItems.FieldByName('menu_item_caption').AsString;
            itemUrl:=sql_GetMenuItems.FieldByName('menu_item_link_for').AsString;
            itemView:=sqlMenu.FieldByName('menu_item_tpl').AsString;
            itemView:=applyVar(itemView, 'itemTitle', itemTitle);


            if sql_GetMenuItems.FieldByName('menu_item_type').AsString='sc' then
              itemUrl:='section_'+itemUrl;

            itemView:=applyVar(itemView, 'itemUrl', itemUrl);




            itemView:=applyVar(itemView, 'ext', form1.PrefferedExtension.Text);
            list_html:=list_html+itemView;
            sql_GetMenuItems.Next;
          end;


        menuView:=sqlMenu.FieldByName('menu_wrap_tpl').AsString;
        menuView:=applyVar(menuView, 'items', list_html);
        menuView:=applyVar(menuView, 'menuCaption', m.menu_caption);

        menu_map.Add( m.menu_id, menuView);

    sql_GetMenuItems.Free;
    sqlMenu.Next;
    end;


 R:=app;
 for k:=0 to menu_map.Count-1 do
     begin
        R:=applyvar(R, 'menu='+menu_map.Keys[k], menu_map.Data[k]);
     end;
 menu_map.free;
 Result:=R;

end;














function TForm1.moduleexec(cmd: string): string;
var
  P: TProcess;
  R: string;
  M: TMemo;
  filenam: string;
begin
  showMessage('Запущен модуль '+cmd);
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

function TForm1.usePreset(app: String): string;
var R : String;
begin
  R:=app;
  R:=ApplyVar(R, 'sitename', sqlPresets.FieldByName('sitename').AsString);
  Result:=R;
end;

{{ ======================== РАСШИРЕНИЕ ВОЗМОЖНОСТЕЙ МОДУЛЯМИ ================ }}

function TForm1.useModules(app: string): string;
var C, Start, En_d : integer;
  replacement : String;
  R : String;
  container: String;
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
                                   container:=Copy(r, Start+1, En_d-Start-1);
                                   ShowMessage(container);
                                   replacement:=moduleexec(container);
                                   r:=StringReplace(r, Copy(r, Start, En_d-Start+1),
                                   replacement, [rfReplaceAll]);
                                   c:=Start+Length(replacement)-1;
                                   Start:=-1;
                                   En_d := -1;
                                  end;
                              end;
                           C:=C+1;
                           Application.ProcessMessages;
                           end;
 end; // else will be not processed
 Result:=R;
end;

function TForm1.owntagexec(container, cmd: string): string;
var
  M: TMemo;
  P: TProcess;
  R: string;
begin
  //ShowMessage('Запущен '+cmd+' для '+container);
  M := TMemo.Create(Self);
  M.Clear;
  M.Text := container;
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
  if logger_info then mmRubrics.Lines.Add(container);
  if logger_info then mmRubrics.Lines.Add('ОБРАБОТЧИК');
  if logger_info then mmRubrics.Lines.Add(cmd);
  if logger_info then mmRubrics.Lines.Add('РЕЗУЛЬТАТ');
  if logger_info then mmRubrics.Lines.Add(r);
  //showMessage('Результат обработки '+R);
  Result := R;
end;

function TForm1.useOwnTags(app: string): string;
var
  R: string;

  container: string;
  replacement: string;


  tags_list : TStringList;
  tag_name : String;
  t : Integer;
  RE : TRegExpr;
  Matcher : TRegExpr;
  ReplaceFrom : TStringList;
  ReplaceTo   : TStringList;
  i : integer;
begin
  (* ПЕРЕПИСАНО НА РЕГУЛЯРКИ *)
  R:=app;
  (* 1. НАЙДЕМ ВСЕ ПОЛЬЗОВАТЕЛЬСКИЕ ТЕГИ *)
  re := TRegExpr.Create(DLM_OWN_TAG+'([\w]+)'+DLM_OWN_TAG);
  tags_list:=TStringList.Create;

  if re.Exec(R) then begin
       tag_name:=re.Match[1];
       tags_list.Add(tag_name);
       while re.ExecNext do begin
         tag_name := re.Match[1];
         tags_list.Add( tag_name );
         Application.ProcessMessages;
      end;
  end;







        (* 3 СОЗДАДИМ СПИСОК ЧТО НА ЧТО МЕНЯТЬ *)
        ReplaceFrom := TStringList.Create;
        ReplaceTo := TStringList.Create;

        for t:=0 to tags_list.count-1 do begin
                 tag_name:=tags_list[t];

                 (* НАЙДЕМ ВСЕ, ОБРАМЛЕННОЕ ТЕГОМ *)
                 Matcher := TRegExpr.Create(
                        DLM_OWN_TAG+tag_name+DLM_OWN_TAG+
                         '([\d\D\r\n]+)'+
                         DLM_OWN_TAG+'/'+tag_name+DLM_OWN_TAG);

                (* ДЛЯ ВСЕХ СОВПАДЕНИЙ ЗАПУСТИМ ОБРАБОТЧИК ТЕГОВ *)
                if Matcher.Exec(R) then begin
                   container:=Matcher.Match[1];
                   replacement:=owntagexec(container, tag_name);
                   (* ДОБАВИМ В СПИСКИ ЗАМЕН *)
                   ReplaceFrom.Add(container);
                   ReplaceTo.Add(replacement);




                      while Matcher.ExecNext do begin
                            container := Matcher.Match[1];
                            replacement:=owntagexec(container, tag_name);

                            ReplaceFrom.Add(container);
                            ReplaceTo.Add(replacement);

                            Application.ProcessMessages;
                   end;
               end;

        end;

   (* ВЫПОЛНИМ ВСЕ НАЙДЕННЫЕ ПОДСТАНОВКИ *)
  for i:=0 to ReplaceTo.Count - 1 do
      begin
            //ShowMessage(ReplaceFrom[i] + ' меняется на '+ReplaceTo[i]);
            R:=StringReplace(R, ReplaceFrom[i], ReplaceTo[i], [rfReplaceAll, rfIgnoreCase]);


      end;

   (* УДАЛЯЕМ ТЕГИ *)
  for i:=0 to tags_list.Count - 1 do
      begin
            R:=StringReplace(R, DLM_OWN_TAG+tags_list[i]+DLM_OWN_TAG, '', [rfReplaceAll, rfIgnoreCase]);
            R:=StringReplace(R, DLM_OWN_TAG+'/'+tags_list[i]+DLM_OWN_TAG, '', [rfReplaceAll, rfIgnoreCase]);
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
  pagesTotal: integer; orf: String; ors: String; useO: Boolean;  useTrees : boolean; tree : String): string;
var
  paginator: string;
  page: byte;

  sorted_folder : string;
begin




  paginator := '<div class="paginator">';
  sorted_folder := '';
    if useO then
      begin
           sorted_folder := '/o/'+orf+'-'+ors+'/';
      end;

  if useTrees then
    sorted_folder:=tree+sorted_folder;

  for page := 1 to pagesTotal do   begin




    if currentPage <> page then
    begin
      if page = 1 then
        paginator :=
          paginator + '<a href="{sorted_folder}/section_' + url + '.' + PrefferedExtension.Text + '">1</a> '
      else
        paginator :=
          paginator + '<a href="{sorted_folder}/section_' + url + '_' + IntToStr(page) + '.' + PrefferedExtension.Text +
          '">' + IntToStr(page) + '</a> ';
    end
    else
      paginator := paginator + ' ' + IntToStr(currentPage) + ' ';
  end;


  {/for}
  paginator := paginator + '</div>';

  paginator:=applyvar(paginator, 'sorted_folder', sorted_folder);

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
  test_flag : boolean;
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
  if (pos('.png', uri) > 0) then content_type := 'image/png';
  if (pos('.gif', uri) > 0) then content_type := 'image/gif';

  if (pos('.js', uri) > 0) then content_type := 'application/javascript';

  test_flag := false;
  test_flag := test_flag or (pos('.jpg', uri) > 0);
  test_flag := test_flag or (pos('.gif', uri) > 0);
  test_flag := test_flag or (pos('.png', uri) > 0);

  test_flag := test_flag or (pos('.htm', uri) > 0);
  test_flag := test_flag or (pos('.html', uri) > 0);
  test_flag := test_flag or (pos('.css', uri) > 0);
  test_flag := test_flag or (pos('.js', uri) > 0);

  test_flag := test_flag or ( uri = '/');

  if ( test_flag ) then
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




  conn.DatabaseName := getCurrentDir() + DELIM + sqlite_filename; // назначаем имя файла
  //showMessage( conn.DatabaseName );
  try
  //Поскольку мы делаем эту базу данных впервые,
  // проверяем, существует ли уже файл
  isOK := FileExists(conn.DatabaseName);

    if isOK then
    begin



         conn.Open;

         trans.Active:=True;

         conn.ExecuteDirect('End transaction');
         conn.ExecuteDirect('pragma synchronous = 0');
         conn.ExecuteDirect('pragma foreign_keys = off');
         conn.ExecuteDirect('pragma journal_mode = off');

          trans.Active:=True;
         conn.ExecuteDirect('Begin transaction');


         // делать ничего не нужно, обработается при выходе, сообщаем
         SilentMessage('Файл найден!');
         checkConnect(conn, trans, 'initTransactionSQL');


    end

    else

    begin
      // Создаем базу данных и таблицы
      SilentMessage('Создаем базу с нуля');



        // запросы в рамках транзакции


       trans.Active:=True;

         conn.ExecuteDirect('End transaction');
         conn.ExecuteDirect('pragma synchronous = 0');
         conn.ExecuteDirect('pragma foreign_keys = off');
         conn.ExecuteDirect('pragma journal_mode = off');
          trans.Active:=True;
         conn.ExecuteDirect('Begin transaction');

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
    sqlPresets.Active:=true;
    sqlBlocks.Active:=true;
    sqlSections.Active:=true;
    sqlContent.Active:=true;
    sqlCssStyles.Active:=true;
    sqlJsScripts.Active:=true;
    sqlTags.Active:=true;
    sqlTagsPages.Active:=true;
    sqlMenu.Active:=true;
    sqlMenuItem.Active:=true;

end;

procedure TForm1.makeSqlInactive;

begin

 // showMessage('Сохраняем базу');
  AutoSaveDb();
 // showMessage('База сохранена');

  sqlPresets.Active:=false;
  sqlContent.Active:=false;
  sqlCssStyles.Active:=false;
  sqlSections.Active:=false;
  sqlBlocks.Active:=false;
  sqlJsScripts.Active:=false;
  sqlTags.Active:=false;
  sqlTagsPages.Active:=false;
  sqlMenu.Active:=false;
  sqlMenuItem.Active:=false;

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

procedure TForm1.viewCssSQL;
begin

  open_sql( 'select * from css', sqlCssStyles);

  //ds_Css.AutoEdit:=true;
  SilentMessage('выполнена загрузка таблиц стилей');
end;

procedure TForm1.viewJsSQL;
begin
    open_sql( 'select * from js', sqlJsScripts);

end;

procedure TForm1.viewTablesSQL;
begin
 checkConnect(conn, trans,'viewTablesSQL');
  form1.makeSqlActive(); // активируем запросы
  form1.viewPagesSQL();
  form1.viewBlocksSQL();
  form1.viewPresetsSQL();
  form1.viewSectionsSQL();
  form1.viewCssSQL();
  form1.viewJsSQL();
  form1.viewTagsSQL();
  form1.viewMenuSQL();
  form1.viewMenuItemSQL();
end;

procedure TForm1.viewTagsSQL;
begin
  open_sql(    'select * from tags', sqlTags);
  ds_Tags.AutoEdit:=True;
  SilentMessage('выполнена загрузка страниц!');
end;

procedure TForm1.viewTagsPagesSQL;
begin
  open_sql(    'select * from tags_pages', sqlTagsPages);
  ds_Tags_Pages.AutoEdit:=True;
  SilentMessage('выполнена загрузка страниц!');
end;

procedure TForm1.viewMenuSQL;
begin
  open_sql( 'select * from menu', sqlMenu);
  ds_Menu.AutoEdit:=true;
end;

procedure TForm1.viewMenuItemSQL;
begin
  open_sql( 'select * from menu_item', sqlMenuItem);
  ds_MenuItem.AutoEdit:=true;
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


  //dbPresetsLook.DataSource:=form1.ds_Presets;
  dbNav_Presets.DataSource:=form1.ds_Presets; // листалка
end;

procedure TForm1.changeDataSourcesCss;
begin
 // dbeCssId.DataSource:=form1.ds_Css;
 // dbmCssStyle.DataSource:=form1.ds_Css;
 // dbNav_Css.DataSource:=form1.ds_Css;
end;

procedure TForm1.changeDataSourcesTags;
begin
  dbeTagId.DataSource:=ds_Tags;
  dbeTagCaption.DataSource:=ds_Tags;
  dbNav_Tags.DataSource:=ds_Tags;

end;

procedure TForm1.changeDataSourcesTagsPages;
begin
  dbeTagsPages_id_tag_page.DataSource:=ds_Tags_Pages;
  dbeTagsPages_id_tag.DataSource:=ds_Tags_Pages;
  dbeTagsPages_id_page.DataSource:=ds_Tags_Pages;
  dbNav_TagsPages.DataSource:=ds_Tags_Pages;
end;












procedure TForm1.makeCreationTables;
begin

          checkConnect(conn, trans, 'makeCreationTables');



            createPagesSQL(conn, trans);
            createSectionsSQL(conn, trans);
            createBlocksSQL(conn, trans);
            createPresetsSQL(conn, trans);
            createCssSQL(conn, trans);
            createJsSQL(conn, trans);
            createTagsSQL(conn, trans);
            createTagsPagesSQL(conn, trans);
            createMenusSQL(conn, trans);
            createItemsForMenuSQL(conn, trans);



end;

procedure TForm1.changeDataSources;
begin
  Form1.changeDataSourcesContent();
  Form1.changeDataSourcesSections();
  Form1.changeDataSourcesBlocks();
  Form1.changeDataSourcesPresets();
  Form1.changeDataSourcesCss();
  Form1.changeDataSourcesJs();
  Form1.changeDataSourcesTags();
  Form1.changeDataSourcesTagsPages();
end;











procedure TForm1.SilentMessage(msg: String);
begin
  if (not SilentMode) then ShowMessage(msg);
end;

procedure TForm1.AutoSaveDb; // автосохранение, исп. в FormClose


begin


   if sqlPresets.Active then sqlPresets.ApplyUpdates();

   if sqlContent.Active then sqlContent.ApplyUpdates();

   if sqlBlocks.Active then sqlBlocks.ApplyUpdates();

   if sqlSections.Active then sqlSections.ApplyUpdates();

   if sqlCssStyles.Active then sqlCssStyles.ApplyUpdates();
   trans.Commit();

end;

(* ========================== новая сборка страниц ====================== *)

procedure TForm1.doJoinPages;
var
        page : page_params;   filenam  : String;
        fbuffer : TStringList;
        headT, bodyT : String;
        page_param_num : byte;
        cnt, k : byte;

        tagsHere : TagsMap;
        sql_for_tags : TSQLQuery;
        tags_html : String;
        processDir : TProcess;
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


   cnt:=form1.Titles.Lines.Count;
   pBar.Max:=cnt;
   pBar.Step:=1;
   pBar.Min:=1;
   pBar.Position:=1;
   k:=0;

   (* Сборка страниц *)
   sqlJoin.Open;
   sqlJoin.First;

   while not sqlJoin.EOF do
         begin

            lbProgress.Caption:='Сборка страницы '+IntToStr(k+1)+' / '+IntToStr(cnt);

            page.id := sqlJoin.FieldByName('id').AsString;
            page.title := sqlJoin.FieldByName('caption').AsString;
            page.body := sqlJoin.FieldByName('content').AsString;
            page.section_id := sqlJoin.FieldByName('section_id').AsString;
            page.section_title := sqlJoin.FieldByName('section').AsString;
            page.sitename := sqlJoin.FieldByName('sitename').AsString;
            page.dirpath := sqlJoin.FieldByName('dirpath').AsString;
            page.dt:=sqlJoin.FieldByName('dt').AsDateTime;
            page.tree:=sqlJoin.FieldByName('tree').AsString;

            //получить теги страницы

            sql_for_tags:=TSQLQuery.Create(Self);

            sql_for_tags.SQLConnection:=conn;

            sql_for_tags.Transaction:=trans;

            tagsHere:=TagsMap.Create;

            sql_for_tags.Active:=false;

            loadTagsForPages(page.id, tagsHere, sql_for_tags, trans);

            tags_html:=tagsInPageHtml(tagsHere, form1.PrefferedExtension.text);

            tagsHere.Free;

            sql_for_tags.Free;

            page.tags:=tags_html;



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

            if chkUseTrees.checked then
              begin
                 processDir:=TProcess.Create(Self);
                 processDir.CommandLine:='/usr/bin/bash -c "mkdir -p '+page.dir+page.tree+'"';
                 processDir.Execute;
                 processDir.WaitOnExit();
                 processDir.Free;
                 filenam:=page.dir+page.tree+DELIM+page.id+'.'+prefferedExtension.Text;
              end

            else

            filenam := page.dirpath+DELIM+page.id+'.'+PrefferedExtension.Text;

           if page.dir <> '' then
                      makePageJoin( page, filenam);


         sqlJoin.Next;
         Application.ProcessMessages;

         inc(k);
         pBar.Position:=k;
         //Sleep(10000);
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

                                           insparamstohead(
                                                                  buildHead(page.title, page.headtpl),
                                                           page)

                               );


                                t:=page.bodytpl;

                              Buffer.Lines.Add('</head><body>');
                              Buffer.Lines.Add(
                                               insParamsToBody(
                                                               buildBody(page.title, page.body, t),
                                               page)

                              );
                              Buffer.Lines.Add('</body></html>');

                              // постобработка
                              Buffer.Lines.Text :=
                              useMenus(
                               useModules(
                                useOwnTags(
                                    buildOwnFields(
                                           insertSectionsAndLinks(
                                                  useBlocks(
                                                             buffer.Lines.Text)
                                                    ),
                                        page))));


                              // id of pages
                              id := ExtractFileName(filenam);
                              id := Copy(id, 1, Pos('.', id)-1);
                              Buffer.Text:=StringReplace(Buffer.Text, '{id}',
                              id , [rfReplaceAll]);
                              WriteDocument(Buffer.Lines.Text, filenam);


end;

function TForm1.buildItem(itemtpl: string; itemUrl: string; itemTitle: string; itemDt : TDateTime; ur : user_records; tree : String): string;
var
  r: string;
  fi : byte;
begin
  r := itemTpl;

  if chkUseTrees.checked then
     itemUrl := tree+ DELIM+itemUrl;

 // showMessage(itemUrl);

  // fix relative links
  if itemUrl[1]<>'/' then itemUrl:='/'+itemUrl;

  r := applyVar(r, 'itemUrl', itemUrl);
  r := applyVar(r, 'itemTitle', itemTitle);
  r := applyVar(r, 'itemDt', DateTimeToStr(itemDt));

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

  PagesinRubrics : Integer;
  itemsPerPage : Integer;
  page : byte;




  rubrication_query : String;
  current_preset : String;

  selected_ors : String; // выбранное поле для сортировки
  selected_orf : String; // выбранный порядок сортировки
  useo  : boolean; // упорядочение по умолчанию, не добавлять папки


  orfs   : TStringList;
  o : Integer;
begin

 orfs := TStringList.Create;
 orfs.Clear;
 orfs.Add('dt');
 orfs.Add('caption');



// некоторые данные нужно считать 1 раз
// так как они будут нужны многократно
  scanLinks();  // ссылки
  scanSections(); // секции



  itemsPerPage := StrToInt(edItemsPerPage.Text);
  sqlCounter.Open; // Число страниц в каждом разделе
  sqlCounter.First;
  while not sqlCounter.EOF do
        begin
             Current_Preset := sqlCounter.FieldByName('preset_id').AsString;

             PagesTotal:=sqlCounter.FieldByName('cnt').AsInteger;
             if pagesTotal <= itemsPerPage then
                           pagesInRubrics:=1
             else
                 begin
                      pagesInRubrics := pagesTotal div itemsPerPage;
                      if (pagesTotal mod itemsPerPage)>0 then inc(pagesInRubrics);
                 end;



                application.processmessages();



                 pBar.Max:=pagesInRubrics;
                 pBar.Step:=1;
                 pBar.Min:=1;
                 pBar.Position:=1;


                for page := 1 to pagesInRubrics do
                    begin

                       lbProgress.Caption:='Генерация рубрики '+sqlCounter.FieldByName('section').AsString+'  :  '+IntToStr(page)+' / '+IntToStr(pagesInRubrics);
                       sqlRubrication.Close;



                       // --------------------------------
                       rubrication_query := rubrication_start;


                       selected_ors := pors[Current_Preset]; // порядок сортировки
                       selected_orf := porf[Current_Preset]; // поле сортировки





                       makeRubricationUsingSorts(page, itemsPerPage, pagesInRubrics, rubrication_query, selected_orf, selected_ors, false);

                       for o:=0 to orfs.Count-1 do
                         begin



                              selected_orf := orfs.Strings[o];
                              selected_ors := 'ASC';
                              sqlRubrication.Close;
                              makeRubricationUsingSorts(page, itemsPerPage, pagesInRubrics, rubrication_query, selected_orf, selected_ors, true);

                              selected_ors := 'DESC';
                              sqlRubrication.Close;
                              makeRubricationUsingSorts(page, itemsPerPage, pagesInRubrics, rubrication_query, selected_orf, selected_ors, true);

                         end;



                     // -----------------------
                    end;
         sqlCounter.Next;
         Application.ProcessMessages;
        end;










     end;











procedure TForm1.doSitemap;
var fbuffer : TMemo;
  sitemap_param : page_params;
  k, cnt : byte;
  listItem, tree : String;
begin

  fbuffer := TMemo.Create(self);
  // карта категорий
  cnt:=form1.SiteSectionTitles.Lines.Count;
  pBar.Max:=cnt;
  pBar.Step:=1;
  pBar.Min:=1;
  pBar.Position:=1;
  k:=0;

  fbuffer.Clear;
  fbuffer.Lines.Add('<ul>');
  sqlSections.First;
  while not sqlSections.EOF do
        begin
         lbProgress.Caption:='Сборка карты сайта '+IntToStr(k+1) + ' / '+IntToStr(cnt);

             tree:='';
             if chkUseTrees.Checked then
               tree:=sqlSections.FieldByName('tree').AsString;

             listItem:='<li><a href="{tree}/section_' + sqlSections.FieldByName('id').AsString + '.{ext}">';
             listItem:= listItem + sqlSections.FieldByName('section').AsString + '</a></li>';
             listItem:=applyVar(listItem, 'tree', tree);
             fbuffer.Lines.Add(listItem);

             sqlSections.Next;
             Application.ProcessMessages;
             inc(k);
             pBar.Position:=k;
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

procedure TForm1.doTagsMap;
var
  sq : TSqlQuery;
  tm : TagsMap;
  tags_html: String;
  doc : String;
  doc_path : String;
  i : Integer;
  pm : PagesMap;
  item_tag_tpl : String;
  headtpl : String;
  tags_tpl : String;
  items    : String;
  head, body : String;

begin
  sq := TSqlQuery.Create(self);
  sq.transaction:=form1.trans;
  sq.SQLConnection:=form1.conn;

  tm:=TagsMap.Create;

  loadAllTagsForSitemap(tm, sq, trans);

  tags_html:=tagsInSitemap(tm);


  head:=ApplyVar( sqlPresets.FieldByName('headtpl').AsString, 'title', 'Теги');

  body:=tags_html;

  doc_path:=sqlPresets.FieldByName('dirpath').AsString+DELIM +'all_tags.'+form1.PrefferedExtension.Text;

  doc:='<html><head>'+head+'</head><body>'+body+'</body></hmtl>';

  doc:=useMenus(usePreset(useModules(
                         useOwnTags(
                                    insertSectionsAndLinks(
                                                           useBlocks(doc)
                                                    )
                                       ))));

  writedocument( doc, doc_path);


  if Not DirectoryExists( sqlPresets.FieldByName('dirpath').AsString+DELIM+'/tags') then
         CreateDir(sqlPresets.FieldByName('dirpath').AsString+DELIM+'/tags');


  for i:=0 to tm.Count-1 do
    begin
         sq.Close;

         pm:=PagesMap.Create;
         loadPagesByTag(tm.Keys[i], pm, sq, trans);
        // ShowMessage( tm.Keys[i] );

         item_tag_tpl:=sqlPresets.FieldByName('item_tag_tpl').AsString;
        // showMessage(item_tag_tpl);

         items:=PagesWithTag(pm, item_tag_tpl, form1.PrefferedExtension.text, chkUseTrees.Checked);

        // ShowMessage(items);


         headtpl:=sqlPresets.FieldByName('headtpl').AsString;

         tags_tpl:=sqlPresets.FieldByName('tags_tpl').AsString;

         head:= applyVar(headtpl, 'title',  tm.Data[i].tag_caption);
         head:=useOwnTags(useBlocks(head));

         body:= applyVar(tags_tpl, 'tagCaption', tm.Data[i].tag_caption);
         body:= applyVar(body, 'items', items);
         body:=useOwnTags(useBlocks(body));



         doc:='<html><head>'+head+'</head><body>'+body+'</body></hmtl>';
         doc:=useMenus(usePreset(useModules(
                         useOwnTags(
                                    insertSectionsAndLinks(
                                                           useBlocks(doc)
                                                    )
                                       ))));

         doc_path:=sqlPresets.FieldByName('dirpath').AsString+DELIM +'/tags/'+tm.Keys[i]+'.'+form1.PrefferedExtension.Text;
         writedocument( doc, doc_path);

         pm.Free;
    end;

  tm.Free;


  
  sq.Free;
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
           Application.ProcessMessages();
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
    porf.Clear;
    pors.Clear;
   sqlPresets.First();
   while not sqlPresets.EOF do
         begin
           pors.add(
                    sqlPresets.FieldByName('id').AsString,
                    sqlPresets.FieldByName('ors').AsString
           );
           porf.add(
                    sqlPresets.FieldByName('id').AsString,
                    sqlPresets.FieldByName('orf').AsString
           );

           SitePresets.lines.add( sqlPresets.FieldByName('id').AsString);
           sqlPresets.Next();
           inc(k);
           Application.ProcessMessages;
         end;
   sqlPresets.First();

   lvPresets.Clear;
   for i:=0 to sitePresets.Lines.Count-1 do
     begin
        lvPresets.AddItem( sitePresets.lines[i], nil);
     end;
end;

procedure TForm1.scanTags;
var i : Integer;
begin
   Tags.Clear;
   sqlTags.First;
   while not sqlTags.EOF do begin
     Tags.Add(
              sqlTags.FieldByName('tag_id').AsString,
              sqlTags.FieldByName('tag_id').AsString
              );

   sqlTags.Next;
   end;
   sqlTags.First;

    // to interface


     for i:=0 to Tags.Count-1 do
      begin
        lvTags.AddItem(Tags.Keys[i], nil);
        application.ProcessMessages;
      end;

end;

procedure TForm1.doScan;
begin
  Form1.Enabled:=False;

  if sqlPresets.Active then
  sqlPresets.ApplyUpdates();

  if sqlContent.Active then
  sqlContent.ApplyUpdates();


  if sqlSections.Active then
  sqlSections.ApplyUpdates();

  if sqlBlocks.Active then
  sqlBlocks.ApplyUpdates();

  if sqlCssStyles.Active then
  sqlCssStyles.ApplyUpdates();

  if sqlJsScripts.Active then
  sqlJsScripts.ApplyUpdates;

  if sqlTags.Active then
  sqlTags.ApplyUpdates;

  if sqlTagsPages.Active then
  sqlTagsPages.ApplyUpdates;

  if sqlMenu.Active then
  sqlMenu.ApplyUpdates;

    if sqlMenuItem.Active then
  sqlMenuItem.ApplyUpdates;


  sqlContent.Refresh;
  sqlSections.Refresh;
  sqlPresets.Refresh;
  sqlBlocks.Refresh;
  sqlCssStyles.Refresh;
  sqlJsScripts.Refresh;
  sqlTags.Refresh;
  sqlTagsPages.Refresh;
  sqlMenu.Refresh;
  sqlMenuItem.Refresh;



  scanLinks();
  scanSections();
  scanBlocks();
  scanPresets();
  scanCss();
  scanJs();
  scanTags();
  scanTagsPages();

  Form1.Enabled:=True;
end;



procedure TForm1.editor_win_show(var sql: TSQLQuery; field: String);

  var fE : TfrmEditor;
begin

  if sql.Active then sql.ApplyUpdates();


  fE:=TfrmEditor.Create(Self);
  fE.setMarkup( sql.FieldByName(field).AsString);
  fE.ShowModal();
  conn.Open;
  trans.Active:=true;

  sql.Edit;
  sql.FieldByName(field).AsString:=fE.getMarkup();

  fE.Close();
  fE.Free;

end;

procedure TForm1.doCssTables;
var
  cnt, k : byte;
  isModuleUsed : boolean;
  doc : String;
  doc_path : String;
begin
  isModuleUsed:=form1.chkUseModules.Checked;

  cnt:=CssTitles.Count;
  pBar.Max:=cnt;
  pBar.Step:=1;
  pBar.Min:=1;
  pBar.Position:=1;
  k:=0;

  sqlCssStyles.First;

  while not sqlCssStyles.Eof do
   begin
     lbProgress.Caption:='Сборка CSS '+IntToStr(k+1)+' / '+IntToStr(cnt);
     doc:=sqlCssStyles.FieldByName('css_style').AsString;
     doc_path:=sqlCssStyles.FieldByName('css_path').AsString;
     if isModuleUsed then
        begin
             doc:=useModules(doc);
             doc:=useOwnTags(doc);
             doc:=useMenus(doc);
        end;
     writeDocument( doc , doc_path );

     sqlCssStyles.Next;
     Application.ProcessMessages;
     inc(k);
     pBar.Position:=k;
   end;
  sqlCssStyles.First;
end;

procedure TForm1.scanJs;
var k : integer;

begin
   jsTitles.clear;
   lvJsScripts.clear;

   if not sqlJsScripts.Eof then
         begin




  sqlJsScripts.First;
  while not sqlJsScripts.Eof do
   begin
     JsTitles.AddPair( sqlJsScripts.FieldByName('js_id').AsString, '');
     sqlJsScripts.Next;
     Application.ProcessMessages;
   end;
  sqlJsScripts.First;


  for k:=0 to JsTitles.Count-1 do
    begin
       lvJsScripts.AddItem( jsTitles.Names[k], nil );
       Application.ProcessMessages;
    end;
          end;
end;

procedure TForm1.doJs;
var cnt, i : Byte;
begin

  cnt:=JsTitles.Count;
  pBar.Max:=cnt;
  pBar.Step:=1;
  pBar.Min:=1;
  pBar.Position:=1;

  sqlJsScripts.First;
  i:=0;
  while not sqlJsScripts.Eof do
   begin
     lbProgress.Caption:='Генерация скриптов '+IntToStr(i+1)+' / '+IntToStr(cnt);
     writeDocument( sqlJsScripts.FieldByName('js_file').AsString,
            sqlJsScripts.FieldByName('js_path').AsString );
     sqlJsScripts.Next;
     Application.ProcessMessages;
     inc(i);
     pBar.Position:=i;

   end;
  sqlJsScripts.First;
end;

procedure TForm1.changeDataSourcesJs;
begin

  dbeJsScriptId.DataSource:=ds_JsScripts;
  dbeScriptPath.DataSource:=ds_JsScripts;
  dbmJsScriptFile.DataSource:=ds_JsScripts;
end;

function TForm1.insParamsToHead(head: String; page : page_params): String;
var
  r : String;
  i : Integer;
begin
  r:=head;

  r:=applyvar(r, 'sectionTitle', page.section_title);

  for i:=0 to 7 do
    begin
         r:=applyvar(r, 'f'+IntToStr(i), page.user_field_names[i]);
         r:=applyvar(r, 'v'+IntToStr(i), page.user_field_values[i]);
    end;

  result:=r;
end;

function TForm1.insParamsToBody(body: String; page : page_params): String;
var
  r : String;
  i : Integer;
begin
  r:=body;

  r:=applyvar(r, 'dt', DateToStr(page.dt));
  r:=applyvar(r, 'tags', page.tags);


  // TODO Сюда дополнительные параметры страницы
  result:=r;
end;

function TForm1.getSortSelector(section : String; tree : String): String;
var
  s : String;
  orfs : sdict;
  i : Integer;
  base_url : String;
begin


  orfs := sdict.Create();
  orfs.Clear;
  orfs.Add('caption', 'По заголовку');
  orfs.Add('dt', 'По дате');


  s:='<a href="{base_url}/section_'+section+'.html">#</a>';

  for i:=0 to orfs.Count - 1 do
        s:=s+' &nbsp;|&nbsp; <a href="{base_url}/o/'+orfs.Keys[i]+'-DESC/section_'+section+'.html">&#x25BC;</a>&nbsp;' + orfs.Data[i] +
             '&nbsp;<a href="{base_url}/o/'+orfs.Keys[i]+'-ASC/section_'+section+'.html">&#x25B2;</a>&nbsp;|&nbsp;';
  base_url := '';
  if chkUseTrees.Checked then base_url:=tree;
  s:=ApplyVar(s, 'base_url', base_url);
  result := s;

end;

// TODO refactor this sorts
procedure TForm1.makeRubricationUsingSorts(
page : Integer; itemsPerPage : Integer; pagesInRubrics : Integer; rubrication_query: String;
selected_orf : String; selected_ors : String; useo : boolean);
var
  headHtml : String;
  itemHtml : String;
  sectionId  : String;
  itemK : byte;
  selector_order : String;
  sectionHtml : String;
  document : String;
  path : String;
  ur : user_records;
  fi : byte;
  cnt, k : byte;
  bpager : String;
  so : string;
  tree : string;
  path_with_tree : string;
  base_path : string;
  sort_path : string;

  ProcessDir : TProcess;

begin



  rubrication_query:=applyvar(rubrication_query, 'ors', selected_ors);
                       rubrication_query:=applyvar(rubrication_query, 'orf', selected_orf);




                       sqlRubrication.SQL.Text:=rubrication_query;

                       prepared_transaction_start(sqlRubrication.SQL.Text, sqlRubrication, trans);

                       sectionId := sqlCounter.FieldByName('section').AsString;


                       sqlRubrication.ParamByName('section_id').AsString:=sectionId;
                       sqlRubrication.ParamByName('pageoffset').AsInteger:=(page-1)*itemsPerPage;
                       sqlRubrication.ParamByName('pagelimit').AsInteger := itemsPerPage;

                       prepared_transaction_end(sqlRubrication, trans);
                       sqlRubrication.Open;

                       itemHtml := '';
                       itemK:=0;
                       sqlRubrication.First;


                       while not sqlRubrication.EOF do
                             begin
                                 pBar.Max:=itemsPerPage;
                                 inc(itemK);
                                 pBar.Position:=itemK;
                                 lbProgress.Caption:='Сборка элемента '+IntToStr(itemK)+' / '+IntToStr(itemsPerPage) + ' '+ sqlRubrication.FieldByName('content_id').AsString;
                                  for fi:=1 to 7 do
                                      begin
                                         ur[fi].name:=sqlRubrication.FieldByName('ufn'+IntToStr(fi)).AsString;
                                         ur[fi].value:=sqlRubrication.FieldByName('uf'+IntToStr(fi)).AsString;
                                      end;

                                   itemHTML := itemHtml +

                                   buildItem(
                                     sqlRubrication.FieldByName('itemtpl').AsString,
                                     sqlRubrication.FieldByName('content_id').AsString,
                                     sqlRubrication.FieldByName('caption').AsString,
                                     sqlRubrication.FieldByName('dt').AsDateTime,
                                     ur, sqlRubrication.FieldByName('tree').AsString );
                                   sqlRubrication.Next;
                                   Application.ProcessMessages;
                             end;



                            sectionHtml := buildSection( sqlRubrication.FieldByName('sectiontpl').AsString,
                                              sqlRubrication.FieldByName('id').asString,
                                              sqlRubrication.FieldByName('section').AsString,
                                              sqlRubrication.FieldByName('note').AsString,
                                              sqlRubrication.FieldByName('full_text').AsString,
                                              itemHtml );


                            bpager:=buildPagination( sqlRubrication.FieldByName('id').AsString,
                                                    page,
                                                    pagesInRubrics,
                                                    selected_orf,
                                                    selected_ors,
                                                    useO,
                                                    chkUseTrees.Checked,
                                                    sqlRubrication.FieldByName('tree').AsString);

                            sectionHtml:=applyVar(sectionHtml, 'pager', bpager);
                            selector_order := form1.getSortSelector(sectionId, sqlRubrication.FieldByName('tree').AsString);
                            sectionHtml:=applyVar(sectionHtml, 'sort_order', selector_order);


                            sectionHtml:=applyVar(sectionHtml, 'sectionTitle', sqlRubrication.FieldByName('section').AsString);
                            sectionHtml:=applyVar(sectionHtml, 'sectionNote', sqlRubrication.FieldByName('note').AsString);
                            sectionHtml:=applyVar(sectionHtml, 'sectionFullText', sqlRubrication.FieldByName('full_text').AsString);





                            headHtml:= buildHead( sqlRubrication.FieldByName('section').AsString,
                                                  sqlRubrication.FieldByName('headtpl').AsString);

                            headHtml:= applyVar(headHtml, 'sectionTitle',  sqlRubrication.FieldByName('section').AsString);




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

                            if (logger_info)   then
                            mmRubrics.Lines.Add(document);

                            so:='';
                            if useO then so:='o/'+selected_orf+'-'+selected_ors+'/';



                            if chkUseTrees.checked then
                              begin
                                   ProcessDir:=TProcess.Create(Self);
                                   ProcessDir.CommandLine:='/usr/bin/bash -c "mkdir -p '+ path_with_tree +'"';
                                   ProcessDir.WaitOnExit;
                                   ProcessDir.Free;
                              end;


                            base_path:=sqlRubrication.FieldByName('dirpath').AsString;

                            tree:=sqlRubrication.FieldByName('tree').AsString;
                            path_with_tree:=sqlRubrication.FieldByName('dirpath').AsString+tree;

                            if chkUseTrees.Checked then
                               base_path:=path_with_tree;

                            if not DirectoryExists(base_path+DELIM+'o') then
                               CreateDir( base_path+DELIM+'o' );

                            sort_path:= base_path+DELIM+so;

                            // for different_sorts need different folrders
                            If Not DirectoryExists(  sort_path ) then
                               CreateDir( sort_path );


                            if page > 1 then

                            path:=
                            base_path + DELIM + '{so}section_'+
                            sqlRubrication.FieldByName('id').AsString+'_'+IntToStr(page)+'.html'
                            else
                              begin
                            path:=base_path + DELIM +'{so}section_'+
                            sqlRubrication.FieldByName('id').AsString+'.html';
                              end;

                            path:=applyvar(path, 'so', so);



                            writeDocument( document,
                            path
                                           );


                     pBar.Max:=pagesInRubrics;
                     pBar.Position:=page;
end;

procedure TForm1.AfterPostHelper(var lv : TListView; var sql : TSQLQuery; field : String);
var field_id : String;  i : Integer;  flag : boolean;
begin
  field_id:=sql.FieldByName(field).AsString;
  flag := true;
   for i:=0 to lv.Items.Count-1 do
       if lv.Items[i].Caption = field_id then
              begin
                   flag:=false;
                   break;
              end;
   if flag then
          lv.AddItem(field_id, nil);
end;

procedure TForm1.BeforeDeleteHelper(var lv: TListView; var sql: TSQLQuery;
  field: String);
var delete_id : String; i : Integer;
begin
  delete_id:=sql.FieldByName(field).AsString;
  lv.ItemIndex:=-1;
  for i:=0 to lv.Items.Count-1 do
      if lv.Items[i]<>nil  then
         if lv.Items[i].Caption = delete_id then
            begin
                 lv.Items.Delete(i);
            end;
end;

procedure TForm1.listViewClickHelper(var lv: TListView; var sql: TSQLQuery;
  field: String);
var v : String;
begin
  if lv.ItemIndex >= 0 then
    begin
  v := lv.Items.Item[ lv.ItemIndex ].Caption;
  sql.Locate(field, v, []);
    end;
end;

procedure TForm1.insertArticlesToNode(var Node: TTreeNode; section: String);
var
   sql : TSqlQuery;
   iNode : TTreeNode;
begin
  sql:=TSQLQuery.Create(Self);

  sql.Transaction:=trans;
  sql.SQLConnection:=conn;
  sql.SQL.Text := 'select * from content where section="'+section+'"';

  sql.ExecSQL;
  sql.Active:=True;
  sql.First;
  while not sql.eof do
   begin
     iNode:=tvContent.Items.AddChild(Node, sql.FieldByName('id').AsString);
     iNode.ImageIndex:=1;
     sql.next;
   end;

  sql.Free;
end;











end.
