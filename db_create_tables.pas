unit db_create_tables;

{$mode ObjFPC}{$H+}

interface
uses

Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
 DBCtrls,   SQLite3Conn, SQLDB, process, StdCtrls, ExtCtrls, ComCtrls, Menus, DBGrids,
 db_helpers;

procedure  createSectionsSQL(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
procedure  createBlocksSQL(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
procedure  createPresetsSQL(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);  // начальная настройка пресетов
procedure  createPagesSQL(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
implementation

procedure  createSectionsSQL(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);


begin
       checkConnect(konnect, tranzact, 'нет соединения <createSectionsSQL>!');

        // Здесь мы настраиваем таблицу с именем "section" в новой базе данных.
        sql_execute_direct(
                     'CREATE TABLE "section"('+
                    ' "id" Char(60) NOT NULL PRIMARY KEY,'+
                    ' "section" Char(60),'+
                    ' "preset" Char(60),'+
                    ' "note" TEXT, '+
                    ' FOREIGN KEY(preset) REFERENCES preset(id) ON UPDATE CASCADE'+
                    ')', konnect, tranzact);

        // Создание индекса на основе идентификатора в таблице "section"

        sql_execute_direct(   'CREATE UNIQUE INDEX "section_id_idx" ON "section"( "id" );', konnect, tranzact);
        sql_execute_direct(   'CREATE INDEX "section_section_idx" ON "section"( "section" );', konnect, tranzact);
        sql_execute_direct(   'CREATE INDEX "section_preset_idx" ON "section"( "preset" );', konnect, tranzact);

        tranzact.Commit;

        //SilentMessage('начальная настройка секций, транзакция...');
 end;

procedure  createBlocksSQL(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
begin
  checkConnect(konnect, tranzact,'нет соединения <createBlocksSQL>!');
          // Здесь мы настраиваем таблицу с именем "block" в новой базе данных.
        sql_execute_direct('CREATE TABLE "block"('+
                    ' "id" Char(60) NOT NULL PRIMARY KEY,'+
                    ' "markup" TEXT,'+
                    ' "remark" TEXT)', konnect, tranzact);

        // Создание индекса на основе идентификатора в таблице "block"
       sql_execute_direct('CREATE UNIQUE INDEX "block_id_idx" ON "block"( "id" );', konnect, tranzact);

        tranzact.Commit;
        //SilentMessage('начальная настройка блоков, транзакция...');
end;

procedure  createPresetsSQL(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);  // начальная настройка пресетов
begin

        checkConnect(konnect, tranzact,'нет соединения <createPresetsSQL>!');

        // Здесь мы настраиваем таблицу с именем "presets" в новой базе данных.
       sql_execute_direct('CREATE TABLE "preset"('+
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

                    , konnect, tranzact);

        // Создание индекса на основе идентификатора в таблице "block"
        sql_execute_direct('CREATE UNIQUE INDEX "preset_id_idx" ON "preset"( "id" );', konnect, tranzact);

        tranzact.Commit;
        //SilentMessage('начальная настройка пресетов, транзакция...');
end;

procedure  createPagesSQL(var konnect : TSQLite3Connection; var tranzact : TSQLTransaction);
begin
     sql_execute_direct( 'PRAGMA foreign_keys = ON;', konnect, tranzact);
       // Здесь мы настраиваем таблицу с именем "content" в новой базе данных.
     sql_execute_direct('CREATE TABLE "content"('+
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
                    ' "uf7" Char(60),' +
                    ' CONSTRAINT fk_section FOREIGN KEY(section) REFERENCES section(id) ON DELETE CASCADE ON UPDATE CASCADE '+
                    ');', konnect, tranzact);

        // Создание индекса на основе идентификатора в таблице "DATA"
       sql_execute_direct('CREATE UNIQUE INDEX "content_id_idx" ON "content"( "id" );',konnect, tranzact);
       sql_execute_direct('CREATE INDEX "content_section_idx" ON "content"( "section" );',konnect, tranzact);


       // SilentMessage('начальная настройка страниц, транзакция...');



 end;

end.
