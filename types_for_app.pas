unit types_for_app;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBCtrls, dbf, SQLite3Conn, SQLDB, process, FileUtil, SynHighlighterHTML,
  SynEdit, DBDateTimePicker, StdCtrls, ExtCtrls, ComCtrls, Menus, DBGrids,
  ActnList, Buttons, blcksock, sockets, Synautil, synaip, synsock, ftpsend,
  db_helpers,   db_create_tables, replacers, editor_in_window,
  editor_css, editor_js, DateUtils, fgl, regexpr; {Use Synaptic}

type

  TSection_Record = record
            id, section, preset, note, full_text, tree : String
  end;

  Menu = record
       menu_id : String;
       menu_caption : String;
       menu_wrap_tpl : String;
       menu_item_tpl : String;
  end;

  MenuItem = record
       menu_item_id : String;
       menu_item_caption : String;
       menu_item_type : String;
       menu_item_link_for : String;
       menu_item_menu_id  : String; // внешний ключ
  end;


  PresetRecord = record

  id, sitename, dirpath, headtpl, bodytpl, sectiontpl, itemtpl, orf, ors,
  tags_tpl, item_tag_tpl : String;
  end;

  Tag = record
            tag_id : String;
            tag_caption : String;
  end;

Tag_Page_Link = record
            id_tag_page : String;
            id_tag : String;
            id_page : String;
  end;

  sdict = specialize TFPGmap<string, string>;{define type under type}
  TagsPagesMap = specialize TFPGmap<string, Tag_Page_Link>;
  TagsMap = specialize TFPGmap<string, Tag>;

  sqls_list = array[byte] of TSQLquery;

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
            tree    : string;
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
            dt        : TDateTime;
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
            tags : String;
  end;

  PagesMap = specialize TFPGmap<string, page_params>;

implementation

end.

