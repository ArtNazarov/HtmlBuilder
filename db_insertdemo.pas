unit db_insertdemo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBCtrls,   SQLite3Conn, SQLDB, process, StdCtrls, ExtCtrls, ComCtrls, Menus, DBGrids,
  db_helpers;

    procedure insertDemoDataContent(var sq : TSQLQuery;var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataSections(var sq : TSQLQuery;var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataBlocks(var sq : TSQLQuery;var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataPresets(var sq : TSQLQuery;var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoData(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
    procedure insertDemoDataCss(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);

     {Хелперы}
     procedure addIntoBlock( id, markup, remark : String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoSection( id, section, preset, note, full_text : String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoContent( id, cap, content, section : String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoPreset(id, sitename, dirpath, headtpl, bodytpl, sectiontpl, itemtpl : String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
     procedure addIntoCss( css_id, css_style, css_path: String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
implementation


 procedure insertDemoDataContent(var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
begin
  checkConnect(konnect, tranzact, 'нет соединения <insertDemoDataContent>!');

  addIntoContent('index', 'Hello!',
    'This is my first static page. Here link <<blog>> to section', 'blog', sq, konnect, tranzact);
  addIntoContent('about', 'Other page',
    'This is my second static page. See <<photos>>. Here link <<blog>> to section', 'blog', sq, konnect, tranzact);
   addIntoContent('photos1', 'Demo image 1',
    '<img width="640" src="https://iso.500px.com/wp-content/uploads/2015/01/50shades_17.jpg">. Here link <<blog>> to section', 'photos', sq, konnect, tranzact);
  addIntoContent('photos2', 'Demo image2',
    '<img width="640" src="https://images.squarespace-cdn.com/content/v1/5b0cc6d2e2ccd12e7e8c03c6/1542800092550-16CBUJK7FOSVUC5SC46D/levitating_woman_hat_01.jpg?format=1000w"/>. See <<photos>>. Here link <<blog>> to section',
    'photos',
    sq, konnect, tranzact);
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

 procedure insertDemoDataPresets(var sq : TSQLQuery; var konnect: TSQLite3Connection;
   var tranzact: TSQLTransaction);
 begin


     checkConnect(konnect, tranzact, 'нет соединения <inserDemoDataPresets>!');

     addIntoPreset( 'basis', 'My Site' , GetEnvironmentVariable('HOME')+'/mysite',
     '{bootstrap}<meta charset="utf-8"><title>{sitename}-{title}</title>',
     '{mainmenu}<h1>{title}</h1><p>{content}</p>',
     '{mainmenu}<h1>Тема: {sectionTitle}</h1> Материалы :<ul>{items}</ul>',
      '<li><a href="{itemUrl}.{ext}">{itemTitle}</a></li>', sq, konnect, tranzact);



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


end;

 procedure insertDemoDataCss(var sq: TSQLQuery; var konnect: TSQLite3Connection;
   var tranzact: TSQLTransaction);
 begin
   addIntoCss('styles', '.example {text-decoration:italic}','/home/artem/mysite/style.css', sq, konnect, tranzact);
   addIntoCss('other_styles', '#some_id {text-decoration:italic}','/home/artem/mysite/other.css', sq, konnect, tranzact);
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


  procedure addIntoContent( id, cap, content, section : String; var sq : TSQLQuery; var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
  begin
   prepared_transaction_start(
    'insert into content (id, caption, content, section) values (:ID,:CAPTION,:CONTENT, :SECTION)',
    sq, tranzact);
    // заполним параметры

    sq.Params.ParamByName('ID').AsString := id;

    sq.Params.ParamByName('CAPTION').AsString := cap;

    sq.Params.ParamByName('CONTENT').AsString := content;


    sq.Params.ParamByName('SECTION').AsString := section;
   prepared_transaction_end( sq, tranzact);
  end;

 procedure addIntoPreset(id, sitename, dirpath, headtpl, bodytpl, sectiontpl,
   itemtpl: String; var sq : TSQLQuery; var konnect: TSQLite3Connection;
   var tranzact: TSQLTransaction);
 begin



   prepared_transaction_start(
   'insert into preset (id, sitename,dirpath,headtpl,bodytpl,sectiontpl,itemtpl) values '+
  '(:ID,:SITENAME,:DIRPATH,:HEADTPL,:BODYTPL,:SECTIONTPL,:ITEMTPL)',
  sq, tranzact);

  sq.Params.ParamByName('ID').AsString := id;
  sq.Params.ParamByName('SITENAME').AsString := sitename;
  sq.Params.ParamByName('DIRPATH').AsString := dirpath;
  sq.Params.ParamByName('HEADTPL').AsString := headtpl;
  sq.Params.ParamByName('BODYTPL').AsString :=  bodytpl;
  sq.Params.ParamByName('SECTIONTPL').AsString :=  sectiontpl;
  sq.Params.ParamByName('ITEMTPL').AsString := itemtpl;

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

end.

