unit const_for_app;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const

   num_tables : byte = 5;
   SilentMode : boolean = True;
   logger_info : boolean = False;
   sqlite_filename : String = 'sqlite.db';
   msgBaseSuccess : String = 'База данных успешно создана.';
   msgErrorCreating : String = 'Невозможно создать новую базу данных';
   msgCantCheckDbFile : String = 'Невозможно проверить, существует ли файл базы данных';

    DELIM : Char = '/';

    DLM_MODULE = '%';
    DLM_OWN_TAG = '~';

implementation

end.

