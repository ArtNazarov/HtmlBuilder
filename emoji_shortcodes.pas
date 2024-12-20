unit emoji_shortcodes;
(* Module for generation emojies *)
{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, types_for_app;

{ Gets all available shortcodes }
function getEmojiShortCodes() : TEmojiShortCodesArray;
{ Applying emojies to html text }
function useEmojies(text : String) : String;


implementation

{ Функция для получения всех коротких кодов эмодзи }
function getEmojiShortCodes(): TEmojiShortCodesArray;
var
  arr: TEmojiShortCodesArray;
begin
  SetLength(arr, 2); // Задаем размер массива

  // Заполняем массив короткими кодами и соответствующими эмодзи
  arr[0].shortcode := ':joy:';
  arr[0].utf8symbol := '😂'; // Эмодзи "Смеющийся до слез"

  arr[1].shortcode := ':smile:';
  arr[1].utf8symbol := '😄'; // Эмодзи "Улыбающееся лицо"

  Result := arr; // Возвращаем массив коротких кодов
end;

{ Функция для применения эмодзи к тексту }
function useEmojies(text: String): String;
var
  emojiArray: TEmojiShortCodesArray;
  i: Integer;
begin
  emojiArray := getEmojiShortCodes(); // Получаем массив коротких кодов

  // Проходим по каждому короткому коду и заменяем его на соответствующий эмодзи
  for i := Low(emojiArray) to High(emojiArray) do
  begin
    text := StringReplace(text, emojiArray[i].shortcode, emojiArray[i].utf8symbol, [rfReplaceAll]);
  end;

  Result := text; // Возвращаем измененный текст
end;

end.

