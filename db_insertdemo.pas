unit db_insertdemo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBCtrls,   SQLite3Conn, SQLDB, process, StdCtrls, ExtCtrls, ComCtrls, Menus, DBGrids,
  db_helpers, types_for_app;

type
TPage_Record = record
    id, cap, content, section : String;
    dt : TDateTime;
end;
    procedure insertDemoDataContent(var sq : TSQLQuery;var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataSections(var sq : TSQLQuery;var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataBlocks(var sq : TSQLQuery;var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataPresets(var sq : TSQLQuery;var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoData(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataCss(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataJs(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataTags(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataTagsPages(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);


     {Хелперы}
     procedure addIntoBlock( id, markup, remark : String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoSection( id, section, preset, note, full_text : String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoContent( var p : TPage_Record; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoPreset(pr : PresetRecord; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoCss( css_id, css_style, css_path: String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoJs(js_id, js_path, js_file: String;  var sq: TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
     procedure addIntoTag(tag_id, tag_caption : String;  var sq: TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
     procedure addIntoTagsPages(id_tag_page, id_tag, id_page : String;  var sq: TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);

implementation


 procedure insertDemoDataContent(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
 var p : tpage_record;
     FS: TFormatSettings;
 begin
  checkConnect(konnect, tranzact, 'нет соединения <insertDemoDataContent>!');

  p.id:='index';
  p.cap:='Hello!';
  p.content:= 'This is my first static page. Here link <<blog>> to section';
  p.section:='blog';
  FS.DateSeparator:='.';
  FS.ShortDateFormat := 'dd.mm.yyyy';
  FS.ShortTimeFormat := 'hh:mm:ss';
  p.dt:=StrToDateTime('26.11.2022');
  addIntoContent(p, sq, konnect, tranzact);

  p.id:='about';
  p.cap:='Other page';
  p.content:= 'This is my second static page. See <<photos>>. Here link <<blog>> to section';
  p.section:='blog';
  addIntoContent(p, sq, konnect, tranzact);


  p.id:='photos1';
  p.cap:='Demo image 1';
  p.content:='<img width="640" src="https://iso.500px.com/wp-content/uploads/2015/01/50shades_17.jpg">. Here link <<blog>> to section';
  p.section:='photos';
  addIntoContent(p, sq, konnect, tranzact);

  p.id:='photos2';
  p.cap:='Demo image2';
  p.content:='<img width="640" src="https://images.squarespace-cdn.com/content/v1/5b0cc6d2e2ccd12e7e8c03c6/1542800092550-16CBUJK7FOSVUC5SC46D/levitating_woman_hat_01.jpg?format=1000w"/>. See <<photos>>. Here link <<blog>> to section';
  p.section:='photos';

  addIntoContent(p, sq, konnect, tranzact);
  // параметризированный запрос

  //or possibly CommitRetaining, depending on how your application is set up
  // SilentMessage('Демо данные установлены, страницы');



end;

 procedure insertDemoDataSections(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
begin
  checkConnect( konnect, tranzact, 'нет соединения <inserDemoDataSections>!');

  addIntoSection( 'blog', 'Блог'  , 'basis'  , 'Мой блог', 'Полное описание блога', sq, konnect, tranzact);
  addIntoSection( 'photos', 'Фото'  , 'basis'  , 'Фотографии', 'Полное описание фотоальбома', sq, konnect, tranzact);


  //SilentMessage('Демо данные установлены, разделы');
end;

 procedure insertDemoDataBlocks(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
begin
  checkConnect( konnect, tranzact, 'нет соединения <inserDemoDataBlocks>!');


  addIntoBlock( 'mainmenu',
   'Ссылка на раздел <<blog>> , Ссылка на раздел <<photos>>', 'Nav template', sq, konnect, tranzact);

  addIntoBlock('bootstrap',
  '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">'+
  '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>',
  'bootstrap 5', sq, konnect, tranzact);




  //SilentMessage('Демо данные установлены, блоки');
end;

 procedure insertDemoDataPresets( var sq : TSQLQuery; var konnect: TSQLite3Connection;
   var tranzact: TSQLTransaction);
 var
      pr : PresetRecord;
 begin


     checkConnect(konnect, tranzact, 'нет соединения <inserDemoDataPresets>!');

     pr.id:= 'basis';
     pr.sitename:='My Site';
     pr.dirpath:= GetEnvironmentVariable('HOME')+'/mysite';
     pr.headtpl:='{bootstrap}<meta charset="utf-8"><title>{sitename}-{title}</title>';
     pr.bodytpl:='{mainmenu}<h1>{title}</h1><p>{content}</p>';
     pr.sectiontpl:='{mainmenu}<h1>Тема: {sectionTitle}</h1> {sort_order} Материалы :<ul>{items}</ul>{pager}';
     pr.itemtpl:='<li><a href="{itemUrl}.{ext}">{itemTitle}</a></li>';
     pr.orf:='dt';
     pr.ors:='asc';
     pr.tags_tpl:='{mainmenu}<h1>Тег: {tagCaption}</h1> Список страниц :<ul>{items}</ul>';
     pr.item_tag_tpl:='<li><a href="{itemUrl}.{ext}">{itemTitle}</a></li>';

     addIntoPreset(pr, sq, konnect, tranzact);



       // SilentMessage('Демо данные установлены, настройки');
   end;

 procedure insertDemoData(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
begin
  checkConnect(konnect, tranzact, 'нет соединения <insertDemoData>!');






          try
              insertDemoDataPresets(sq, konnect, tranzact);
          except
            // SilentMessage('Не удалось настроить пресеты');
          end;

           try
              insertDemoDataBlocks(sq, konnect, tranzact);
          except
            // SilentMessage('Не удалось настроить блоки');
          end;

            try
              insertDemoDataSections(sq, konnect, tranzact);
          except
             // SilentMessage('Не удалось настроить разделы');
          end;

          // инициализация демо данными
          try
              insertDemoDataContent(sq, konnect, tranzact);
          except
             // SilentMessage('Не удалось настроить контент');
          end;

           // инициализация css
          try
              insertDemoDataCSS(sq, konnect, tranzact);
          except
             // SilentMessage('Не удалось настроить контент');
          end;

              // инициализация css
          try
              insertDemoDataJs(sq, konnect, tranzact);
          except
             // SilentMessage('Не удалось настроить контент');
          end;


                // инициализация tags
          try
              insertDemoDataTags(sq, konnect, tranzact);
          except
             // SilentMessage('Не удалось настроить контент');
          end;

          try
              insertDemoDataTagsPages(sq, konnect, tranzact);
          except
             // SilentMessage('Не удалось настроить контент');
          end;


end;

 procedure insertDemoDataCss(var sq: TSQLQuery; var konnect: TSQLite3Connection;
   var tranzact: TSQLTransaction);
 begin
   addIntoCss('styles', '.example {text-decoration:italic}','/home/artem/mysite/style.css', sq, konnect, tranzact);
   addIntoCss('other_styles', '#some_id {text-decoration:italic}','/home/artem/mysite/other.css', sq, konnect, tranzact);
 end;

 procedure insertDemoDataJs(var sq: TSQLQuery; var konnect: TSQLite3Connection;
   var tranzact: TSQLTransaction);
 begin

   addIntoJs('hello', '/home/artem/mysite/hello.js', 'alert("Hello!")', sq, konnect, tranzact);
   addIntoJs('console','/home/artem/mysite/console.js', 'console.log(1)', sq, konnect, tranzact);
 end;

 procedure insertDemoDataTags(var sq: TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
 begin

   addIntoTag('images', 'Картинки', sq, konnect, tranzact);
   addIntoTag('gallery', 'Галерея', sq, konnect, tranzact);
   addIntoTag('information', 'Информация', sq, konnect, tranzact);
   addIntoTag('etc', 'Прочее', sq, konnect, tranzact);

 end;

 procedure insertDemoDataTagsPages(var sq: TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
 begin

   addIntoTagsPages('id_l1', 'etc', 'index',  sq, konnect, tranzact);
   addIntoTagsPages('id_l2', 'etc', 'other', sq, konnect, tranzact);
   addIntoTagsPages('id_l3', 'gallery', 'photos1', sq, konnect, tranzact);
   addIntoTagsPages('id_l4', 'images', 'photos2', sq, konnect, tranzact);


 end;

 procedure addIntoBlock(id, markup, remark: String; var sq : TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
 begin



  prepared_transaction_start(
   'insert into block (id, markup, remark) values (:ID,:MARKUP,:REMARK)',

   sq,
   tranzact);

 sq.Params.ParamByName('ID').AsString := id;
 sq.Params.ParamByName('MARKUP').AsString := markup;
 sq.Params.ParamByName('REMARK').AsString := remark;

 prepared_transaction_end( sq, tranzact);


end;

 procedure addIntoSection(id, section, preset, note, full_text: String;
 var sq : TSQLQuery;  var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
 begin



   prepared_transaction_start( 'insert into section (id, section, preset, note, full_text) values (:ID,:SECTION,:PRESET, :NOTE, :FULL_TEXT)',
     sq, tranzact);

  sq.Params.ParamByName('ID').AsString := id;
  sq.Params.ParamByName('SECTION').AsString := section;
  sq.Params.ParamByName('PRESET').AsString := preset;
  sq.Params.ParamByName('NOTE').AsString := note;
  sq.Params.ParamByName('FULL_TEXT').AsString := full_text;
  prepared_transaction_end( sq, tranzact);
end;


  procedure addIntoContent( var p : TPage_Record; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
  begin
   prepared_transaction_start(
    'insert into content (id, caption, content, section, dt) values (:ID,:CAPTION,:CONTENT, :SECTION, :DT)',
    sq, tranzact);
    // заполним параметры

    sq.Params.ParamByName('ID').AsString := p.id;

    sq.Params.ParamByName('CAPTION').AsString := p.cap;

    sq.Params.ParamByName('CONTENT').AsString := p.content;


    sq.Params.ParamByName('SECTION').AsString := p.section;

    sq.Params.ParamByName('DT').AsDateTime := p.dt;

   prepared_transaction_end( sq, tranzact);
  end;

 procedure addIntoPreset(pr : PresetRecord; var sq : TSQLQuery; var konnect: TSQLite3Connection;
   var tranzact: TSQLTransaction);
 begin



   prepared_transaction_start(
   'insert into preset (id, sitename,dirpath,headtpl,bodytpl,sectiontpl,itemtpl, ors, orf,  tags_tpl, item_tag_tpl ) values '+
  '(:ID,:SITENAME,:DIRPATH,:HEADTPL,:BODYTPL,:SECTIONTPL,:ITEMTPL, :ORS, :ORF, :TAGS_TPL, :ITEM_TAG_TPL)',
  sq, tranzact);

   with pr do begin

  sq.Params.ParamByName('ID').AsString := id;
  sq.Params.ParamByName('SITENAME').AsString := sitename;
  sq.Params.ParamByName('DIRPATH').AsString := dirpath;
  sq.Params.ParamByName('HEADTPL').AsString := headtpl;
  sq.Params.ParamByName('BODYTPL').AsString :=  bodytpl;
  sq.Params.ParamByName('SECTIONTPL').AsString :=  sectiontpl;
  sq.Params.ParamByName('ITEMTPL').AsString := itemtpl;
  sq.Params.ParamByName('ORF').AsString := orf;
  sq.Params.ParamByName('ORS').AsString := ors;
  sq.Params.ParamByName('TAGS_TPL').AsString := tags_tpl;
  sq.Params.ParamByName('ITEM_TAG_TPL').AsString := item_tag_tpl;
          end;

 prepared_transaction_end( sq, tranzact);
end;

 procedure addIntoCss(css_id, css_style, css_path: String;  var sq: TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
 begin
    prepared_transaction_start(
   'insert into css (css_id, css_style, css_path) values '+
  '(:CSS_ID,:CSS_STYLE,:CSS_PATH)',
  sq, tranzact);

  sq.Params.ParamByName('CSS_ID').AsString := css_id;
  sq.Params.ParamByName('CSS_STYLE').AsString := css_style;
  sq.Params.ParamByName('CSS_PATH').AsString := css_path;

 prepared_transaction_end( sq, tranzact);
 end;

 procedure addIntoJs(js_id, js_path, js_file: String; var sq: TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
 begin
    prepared_transaction_start(
   'insert into js (js_id, js_path, js_file) values '+
  '(:JS_ID,:JS_PATH,:JS_FILE)',
  sq, tranzact);

  sq.Params.ParamByName('JS_ID').AsString := js_id;
  sq.Params.ParamByName('JS_PATH').AsString := js_path;
  sq.Params.ParamByName('JS_FILE').AsString := js_file;

 prepared_transaction_end( sq, tranzact);
 end;

 procedure addIntoTag(tag_id, tag_caption: String; var sq: TSQLQuery;
   var konnect: TSQLite3Connection; var tranzact: TSQLTransaction);
 begin
      prepared_transaction_start(
   'insert into tags (tag_id, tag_caption) values '+
  '(:TAG_ID,:TAG_CAPTION)',
  sq, tranzact);

  sq.Params.ParamByName('TAG_ID').AsString := tag_id;
  sq.Params.ParamByName('TAG_CAPTION').AsString := tag_caption;

 prepared_transaction_end( sq, tranzact);
 end;

 procedure addIntoTagsPages(id_tag_page, id_tag, id_page: String;
   var sq: TSQLQuery; var konnect: TSQLite3Connection;
   var tranzact: TSQLTransaction);
 begin
      prepared_transaction_start(
   'insert into tags_pages (id_tag_page, id_tag, id_page) values '+
  '(:ID_TAG_PAGE, :ID_TAG,:ID_PAGE)',
  sq, tranzact);

  sq.Params.ParamByName('ID_TAG_PAGE').AsString := id_tag_page;
  sq.Params.ParamByName('ID_TAG').AsString := id_tag;
  sq.Params.ParamByName('ID_PAGE').AsString := id_page;

 prepared_transaction_end( sq, tranzact);
 end;

end.

