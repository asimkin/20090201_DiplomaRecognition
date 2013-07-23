{*******************************************************}
{                                                       }
{      Image Library for Bachelor Diploma Project       }
{               MSTU n.a. Bauman, ICS-1                 }
{              GNU GPL 2009, Simkin A.V.                }
{                                                       }
{*******************************************************}
{         Library Version 1.0.a from 21.05.2009         }
{*******************************************************}
{           'Implementation' from 21.06.2009            }
{*******************************************************}
unit ImgLibImpl;
 { Модуль реализации основных процедур и функций библиотеки }
interface {Открытый интерфейс модуля}

  uses
  ////////////////////////////////////////////////////////////
  // ИСПОЛЬЗУЕМЫЕ ВНЕШНИЕ МОДУЛИ
  //
  Windows, SysUtils, //Classes, Variants,       // системные модули
  Graphics,                                     // дополнительные модули
  ImgLibTypes;                                  // модули библиотеки IMG LIB

  ////////////////////////////////////////////////////////////
  // ЭКСПОРТИРУЕМЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
  //
  //////////////////////////////////////////////////////
  // ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАССИВАМИ ПИКСЕЛЕЙ (TImageArray)
  //// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ ////
  // СРАВНЕНИЕ, ПОИСК
  function CompareTImageArray(const Arr1, Arr2 : TImageArray; pThreshold: byte = 1): Double; stdcall;
  function FindLineArrayInTImageArray(Arr: TImageArray; ArrLine: TDByteArray; Threshold: byte = 1): Word; stdcall;
  // РАЗНОЕ
  procedure CalculateCentreOfMassBWTImageArray(const Arr: TImageArray; Margin: TMargins; out Xc, Yc: Word); stdcall;

  //// РАБОТА С ФУНКЦИОНАЛОМ ИЗОБРАЖЕНИЯ ////
  // ЯРКОСТЬ
  function CreateAverageTBrightnessArray(Arr: TImageArray): TBrightnessArray; stdcall;
  function CreateImageAverageBrightness(AverageBrightnessArr: TBrightnessArray): Byte; stdcall;
  function CreateAverageNpxTBrightnessArray(AverageBrightnessArr: TBrightnessArray; N: Byte): TBrightnessArray; stdcall;
  // НАЛОЖЕНИЕ МАСОК
  function OverlayMaskArrToTImageArray(var Arr: TImageArray; Mask: TMaskArray; Scale: Smallint = 1;
                                       BrightFlush: Smallint = 0): TImageArray; stdcall;
  function OverlayMaskTypeToTImageArray(var Arr: TImageArray; MaskType: TOverlayMaskType;
                                        Scale: Smallint = 1; BrightFlush: Smallint = 0): TImageArray; stdcall;

  //// ПРОЦЕДУРЫ И ФУНКЦИИ ФИЛЬТРАЦИИ ////
  // CANNY
  function CannyFiltration(var Arr: TImageArray; CannySett: TCannySetting): TImageArray; overload; stdcall;
  procedure CannyFiltration(var Arr: TImageArray; out Result: TPointGradArray; CannySett: TCannySetting); overload; stdcall;
  // LABELS
  function CreateTLevelsArray(var Arr: TImageArray): TLevelsArray; stdcall;
  // БИНАРИЗАЦИЯ
  function FindTImageArrayBlackThreshold(var Arr: TImageArray; Settings: TBinarizeSetting; CountryIndex: TCountryIndex = RUS): Byte; stdcall;
  procedure MonochromeToBWTImageArray(var Arr: TImageArray; BlackThreshold: byte = 128); stdcall;

  //// ПРОЦЕДУРЫ И ФУНКЦИИ СЕГМЕНТАЦИИ ////
  // ДОПОЛНИТЕЛЬНЫЕ ПРОЦЕДУРЫ
  function CreateLabelsTImageArray(const Arr: TImageArray; Threshold: byte = 255;
                                   Upper: boolean = false): TImageArray; stdcall;
  function CreateLabelsCountArray(LabelsArray: TImageArray): TDWordArray; stdcall;
  // ОСНОВНЫЕ ПРОЦЕДУРЫ
  function SegmentMainSymbolToSquareArray(const Arr: TImageArray; Threshold: Byte = 255): TImageArray; stdcall;
  function SegmentSymbolToSquareArray(const Arr: TImageArray; pThreshold: Byte = 255): TImageArray; stdcall;
  function SegmentNMainSymbolsFromBWTImageArray(const Arr: TImageArray; SymbolsNumber: Byte): TImagesArray; stdcall;

  //// ПРОЦЕДУРЫ И ФУНКЦИИ РАСПОЗНАВАНИЯ ////
  // ДОПОЛНИТЕЛЬНО
  function FindDelimiterLine(Arr: TImageArray; CountryIndex: TCountryIndex = RUS): Word; stdcall;
  // РАСПОЗНАВАНИЕ СИМВОЛОВ
  procedure RecognizeSymbolsFromBWTImageArray(var ResultArr: TSymbolsArray; Arr: TImageArray; SymbolsArr: TSymbolsArray;
                                              SymbolSize: TSymbolSize; ResizeType: TResizeType = fBilinearSpline;
                                              CountryIndex: TCountryIndex = RUS); stdcall;
  function RecognizeRUSNumberFromBWTImageArray(Arr: TImageArray; SymbolsArr: TSymbolsArray; SymbolSize: TSymbolSize;
                                               ResizeType: TResizeType = fBilinearSpline): TSymbolsArray; stdcall;
  function RecognizeMainSegmentSymbolsNumberFromBWTImageArray(Arr: TImageArray; SymbolsArr: TSymbolsArray; SymbolSize: TSymbolSize;
                                                              ResizeType: TResizeType = fBilinearSpline; CountryIndex: TCountryIndex = RUS): TSymbolsArray; stdcall;
  // ПОИСК НОМЕРА
  function FindNumberRectangle(var SArr, Arr: TImageArray; out CompareXY: TDWord2Array; CannySett: TCannySetting; CountryIndex: TCountryIndex = RUS): TMargins; stdcall;

  //////////////////////////////////////////////////////
  // ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАССИВАМИ ИЗОБРАЖЕНИЙ (TImagesArray)
  //// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ ////
  // КОНВЕРТАЦИЯ
  function CreateTImagesArrayFromStr(Symbols: String; Size: Integer = 12;
                                     FName: String = 'Tahoma'; FStyles: TFontStyles = [];
                                     SymbolArrLength: Word = 32):
                                     TImagesArray; stdcall;

  //// ПРОЦЕДУРЫ И ФУНКЦИИ ФИЛЬТРАЦИИ ////
  procedure MonochromeToBWTImagesArray(var Arr: TImagesArray; BlackThreshold: byte = 128); stdcall;

  //// ПРОЦЕДУРЫ И ФУНКЦИИ РАСПОЗНАВАНИЯ ////
  function FindAndCompareWithTImagesArray(Arr: TImageArray; ArrSymbols: TImagesArray;
                                          Threshold: byte = 1): TImageArray; stdcall;
  function FindMapForTImagesArray(Arr, ArrSymbols: TImagesArray; Threshold: byte = 1): TImagesArray; stdcall;

  //////////////////////////////////////////////////////
  // ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАССИВАМИ ЗАПИСЕЙ ИЗОБРАЖЕНИЙ (TSymbolsArray)
  //// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ ////
  // КОНВЕРТАЦИЯ
  function CreateTSymbolsArrayFromStr(Symbols: String; Size: Integer = 12;
                                      FName: String = 'Tahoma'; FStyles: TFontStyles = [];
                                      SymbolArrLength: Word = 32; BW: boolean = True):
                                      TSymbolsArray; stdcall;
  // ПРЕОБРАЗОВАНИЕ В МАТРИЦУ
  procedure ResizeTSymbolsArray(var Arr: TSymbolsArray; NewLength: Word; BW: boolean = True;
                                ResizeType: TResizeType = fBilinearSpline); stdcall;

  //// ПРОЦЕДУРЫ И ФУНКЦИИ ФИЛЬТРАЦИИ ////
  procedure MonochromeToBWTSymbolsArray(var Arr: TSymbolsArray; BlackThreshold: byte = 128); stdcall;

  //// ПРОЦЕДУРЫ И ФУНКЦИИ РАСПОЗНАВАНИЯ
  function FindAndCompareWithTSymbolsArray(Arr: TImageArray; ArrSymbols: TSymbolsArray;
                                           Threshold: byte = 1): TSymbol;stdcall;
  function FindMapForTSymbolsArray(Arr: TImagesArray; ArrSymbols: TSymbolsArray;
                                   Threshold: byte = 1): TSymbolsArray; stdcall;

  //////////////////////////////////////////////////////
  // ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАССИВАМИ ЗАПИСЕЙ ИЗОБРАЖЕНИЙ (TSizeSymbolsArray)
  //// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ ////
  // КОНВЕРТАЦИЯ
  function CreateTSizeSymbolsArrayFromStr(Symbols: String; Size: Word = 72;
                                          FName: String = 'RoadNumbers'; FStyles: TFontStyles = [];
                                          BW: Boolean = True): TSizeSymbolsArray; stdcall;

implementation {Реализация модуля}

  uses
  ////////////////////////////////////////////////////////////
  // ИСПОЛЬЗУЕМЫЕ ВНЕШНИЕ МОДУЛИ
  //
  //Classes,                            // системные модули
  Math,                                 // дополнительные модули
  ImgLibArrayExt, ImgLibImageExt;       // модули библиотеки IMG LIB

////////////////////////////////////////////////////////////////////////////////
//// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//// ЭКСПОРТИРУЕМЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАССИВАМИ ПИКСЕЛЕЙ (TImageArray)
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ
//

//////////////////////////////////////////////////////
// СРАВНЕНИЕ, ПОИСК

// Функция сравнивает 2 массива одинакового размера
//и возвращает отношение совпавших
//пикселей к общему числу
// Параметры:
//  Arr1, Arr2  - TImageArray. исходный массив
//  pThreshold - Byte. Граница "размывки" т.е. разницы между двумя
//значениями (пикселями), которые считаются одинаковыми
// Возвращаемое значение:
//  Double
 function CompareTImageArray(const Arr1, Arr2: TImageArray; pThreshold: byte = 1): Double;
 var i,j : word;
     AgreePixels: Cardinal;
 Begin
  // проверка
  if (Length(Arr1)<>Length(Arr2))or(Length(Arr1[0])<>Length(Arr2[0])) then
  begin
    Result := 0;
    Exit;
  end;
  // Сравнение
  AgreePixels := 0;
  for i := 0 to High(Arr1) do
  begin
    for j := 0 to High(Arr1[i]) do
    begin
      if Abs(Arr1[i,j] - Arr2[i,j]) < pThreshold then Inc(AgreePixels);
    end;
  end;
  Result := AgreePixels/Length(Arr1)/Length(Arr1[0]);
 End;

// Функция нахождения линейного массива в
//массиве пикселей изображения, возвращает
// индекс элемента max совпавших пикселей
//если превышает cAgreeLineHits иначе 0
// Параметры:
//  Arr
//  ArrLine
//  *Threshold
// Возвращаемое значение:
//  Word
 function FindLineArrayInTImageArray(Arr: TImageArray; ArrLine: TDByteArray; Threshold: byte = 1): Word;
 const cAgreeLineHits = 0.60;
 var i,j        : Word;
     AgreePixels: Cardinal;
     AgreeArr   : TDDoubleArray;
 Begin
  Result := 0;
  SetLength(AgreeArr, Length(ArrLine));
  // проверка
  if Length(Arr)<>Length(ArrLine) then Exit;
  for j := 0 to High(Arr[0]) do
  begin
    // Сравнение
    AgreePixels := 0;
    for i := 0 to High(Arr) do
      if Abs(Arr[i,j] - ArrLine[i]) <= Threshold then Inc(AgreePixels);
    AgreeArr[j] := AgreePixels/Length(ArrLine);
  end;
  if cAgreeLineHits > AgreeArr[aIndexOfMaxValue(AgreeArr)] then Result := 0
  else Result := aIndexOfMaxValue(AgreeArr);
 End; // FindLineArrayInTImageArray();

//////////////////////////////////////////////////////
// РАЗНОЕ

// Процедура вычисления центра масс образа бинаризованного массива
//(проверки бинаризации нету!)
// Параметры:
//  Arr - бинаризованный массив
//  Margin - Границы символа
//  @ Xc, Yc - Выходные значения
 procedure CalculateCentreOfMassBWTImageArray(const Arr: TImageArray; Margin: TMargins; out Xc, Yc: Word);
 var i,j          : Word;
     locMass      : Byte;
     SumX, SumY, N: Cardinal;
 Begin
  N := 0; SumX := 0; SumY := 0;
  for i := Margin.top to Margin.buttom do
   for j := Margin.left to Margin.right do begin
     locMass := Arr[i,j];
     Inc(SumX, (j - Margin.left)*locMass);
     Inc(SumY, (i - Margin.top)*locMass);
     Inc(N, locMass);
   end;
  Xc := Margin.left + round(SumX/N);
  Yc := Margin.top + round(SumY/N);
 End; // CalculateCentreOfMassBWTImageArray();


////////////////////////////////////////////////////////////
// РАБОТА С ФУНКЦИОНАЛОМ ИЗОБРАЖЕНИЯ
//

//////////////////////////////////////////////////////
// ЯРКОСТЬ

// Функция Создает массив средней яркости
//столцов изображения
// Параметры:
//  Arr - Массив пикселей изображения
// Возвращаемое значение:
//  TBrightnessArray
 function CreateAverageTBrightnessArray(Arr: TImageArray): TBrightnessArray;
 Var Height, Width, i, j: Word;
     SummBrightness     : Cardinal;
 Begin
  Height := Length(Arr);
  Width  := Length(Arr[0]);
  SetLength(Result, Width);
  for j := 0 to Width - 1 do
  begin
    SummBrightness := 0;
    for i := 0 to Height - 1 do Inc(SummBrightness, Arr[i,j]);
    Result[j] := ifthen(SummBrightness = 0, 0, Round(SummBrightness/Height));
  end;
 End; // CreateAverageTBrightnessArray();

// Функция возращает результат средней якрости изображения
// Параметры:
//  AverageBrightnessArr - Массив средних яркостей
//массива изображений
// Возвращаемое значение:
//  Byte
 function CreateImageAverageBrightness(AverageBrightnessArr: TBrightnessArray): Byte;
 Var Count: Cardinal;
     i    : Word;
 Begin
   Count := 0;
   for i := 0 to High(AverageBrightnessArr) do Inc(Count, AverageBrightnessArr[i]);
   Result := ifthen(Count = 0, 0, Round(Count/Length(AverageBrightnessArr)));
 End; // CreateImageAverageBrightness();

// Функция создающая (апроксимирующая) 
//массив распределения яркостей 
//изображения по средним значениям N 
//пикселей
// Параметры:
//  AverageBrightnessArr - Массив распределения яркостей
//  N - количество округляемых пикселей (округляется по методу div)
// Возвращаемое значение:
//  TBrightnessArray
 function CreateAverageNpxTBrightnessArray(AverageBrightnessArr: TBrightnessArray; N: Byte): TBrightnessArray;
 var i, Step, count: word;
     j: Smallint;
     AverSumm: Cardinal;
 Begin
  SetLength(Result, Length(AverageBrightnessArr));
  for i := 0 to High(AverageBrightnessArr) do
  begin
    AverSumm := 0;
    Step     := N div 2;
    count    := 0;
    for j := i - Step to i + Step do
    begin
      if (j < 0) or (j > High(AverageBrightnessArr)) then Continue;
      Inc(AverSumm, AverageBrightnessArr[j]);
      Inc(count);
    end;
    Result[i] := round(AverSumm/count);
  end;
 End; // CreateAverageNpxTBrightnessArray();

//////////////////////////////////////////////////////
// НАЛОЖЕНИЕ МАСОК

// Функция наложения массива маски TMaskArray на массив изображения TImageArray
// Параметры:
//  Arr          - Обрабатываемый массив
//  Mask         - Массив маски
//  *Scale       - масштаб деления
//  *BrightFlush - смещение относительно диапазона
// Возвращаемое значение:
//  TImageArray
 function OverlayMaskArrToTImageArray(var Arr: TImageArray; Mask: TMaskArray; Scale: Smallint = 1; BrightFlush: Smallint = 0): TImageArray;
 Var i, j: Integer;
 // вычисление маски
 function Overlay(): Integer;
 var m,n : smallint;
 begin
  Result := 0;
  for m := -2 to 2 do
    for n := -2 to 2 do
      Result := Result + Arr[i+m,j+n]*Mask[m+2,n+2];
  Result := Round(Result/Scale) + BrightFlush;
 end;

 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]));
  for i := 2 to High(Arr) - 2 do
    for j := 2 to High(Arr[i]) - 2 do
      Result[i,j] := tRoundToByte(Overlay);
 End; // OverlayMaskToTImageArray();

// Функция наложения маски по типу TOverlayMaskType на массив изображения TImageArray
// Параметры:
//  Arr          - Обрабатываемый массив
//  Mask         - Массив маски
//  *Scale       - масштаб деления
//  *BrightFlush - смещение относительно диапазона
// Возвращаемое значение:
//  TImageArray
 function OverlayMaskTypeToTImageArray(var Arr: TImageArray; MaskType: TOverlayMaskType;
                                       Scale: Smallint = 1; BrightFlush: Smallint = 0): TImageArray;
 Var Arr1, Arr2: TImageArray;
 Begin
  case MaskType of
    mSobel:        begin
                    Arr1  := OverlayMaskArrToTImageArray(Arr, cSobelMaskX, Scale, BrightFlush);
                    Arr2  := OverlayMaskArrToTImageArray(Arr, cSobelMaskY, Scale, BrightFlush);
                    Result:= aSuperposition(Arr1, Arr2, mSum);
                   end;
    mGaussuanBlur: begin
                    Result:= OverlayMaskArrToTImageArray(Arr, cGaussuanBlur, Scale, BrightFlush);
                   end;
  end;
 End; // OverlayMaskTypeToTImageArray();

////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ФИЛЬТРАЦИИ
//

//////////////////////////////////////////////////////
// CANNY

// Функция производящая фильтрацию по методу Кенни
//!Данная версия упращенная (более быстрая), не проверяет сопряженность границ
//!Обрабатывае только прямые углы
// Параметры:
//  Arr - исходное изображение
//  Threshold - граница фильтрации шума
// Возвращаемое значение:
//  TImageArray - результат фильтрации в изображении
 function SimpleCannyFiltration(var Arr: TImageArray; Threshold: Byte): TImageArray; overload;
 Var i, j, k    : Word;
     LineArr    : TDWordArray;
     LocalsMax  : TDCardinalArray;
     ImgParArr  : TPointPar2Array;
     maskX, maskY  : TImageArray;
 // процедура округления угла в ImgParArr
 procedure RoundAngle;
 var i,j : word;
     grad: single;
 begin
  for i := 0 to High(ImgParArr) do
    for j := 0 to High(ImgParArr[i]) do begin
      grad := ImgParArr[i,j].fi*180/Pi;
      if      (0<=grad)     and (grad<22.5)  then ImgParArr[i,j].fi := 0
      else if (22.5<=grad)  and (grad<67.5)  then ImgParArr[i,j].fi := 45
      else if (67.5<=grad)  and (grad<112.5) then ImgParArr[i,j].fi := 90
      else if (112.5<=grad) and (grad<157.5) then ImgParArr[i,j].fi := 135
      else if (157.5<=grad) and (grad<202.5) then ImgParArr[i,j].fi := 180
      else if (202.5<=grad) and (grad<247.5) then ImgParArr[i,j].fi := 225
      else if (247.5<=grad) and (grad<292.5) then ImgParArr[i,j].fi := 270
      else if (292.5<=grad) and (grad<337.5) then ImgParArr[i,j].fi := 315
      else if (337.5<=grad) and (grad<=360)  then ImgParArr[i,j].fi := 0
      else ImgParArr[i,j].fi := 0;
    end;
 end; // RoundAngle();

 Begin
  // 1. Макса Соби (дифференцирование)
  maskX := OverlayMaskArrToTImageArray(Arr, cSobelMaskX);
  maskY := OverlayMaskArrToTImageArray(Arr, cSobelMaskY);
  aConvertToArray(maskX, maskY, ImgParArr);
  // 2. округление углов
  RoundAngle;
  // 3a. Максимумы по горизонтали
  for i := 0 to High(ImgParArr) do begin
    // поиск локальных максимумов
    aConvertToArray(ImgParArr[i], LineArr);
    LocalsMax := aFindLocalsMax(LineArr);
    for k := 0 to High(LocalsMax) do begin
      if (ImgParArr[i,LocalsMax[k]].p > Threshold)
      and((ImgParArr[i,LocalsMax[k]].fi = 0)or(ImgParArr[i,LocalsMax[k]].fi = 180)) then
        ImgParArr[i,LocalsMax[k]].mark := True;
    end;
  end;
  // 3b. Максимумы по вертикали
  for j := 0 to High(ImgParArr[0]) do begin
    // поиск локальных максимумов
    SetLength(LineArr, length(ImgParArr));
    for i := 0 to High(ImgParArr) do
      LineArr[i] := ImgParArr[i,j].p;
    LocalsMax := aFindLocalsMax(LineArr);
    for k := 0 to High(LocalsMax) do begin
      if (ImgParArr[LocalsMax[k],j].p > Threshold)
      and((ImgParArr[LocalsMax[k],j].fi = 90)or(ImgParArr[LocalsMax[k],j].fi = 270)) then
        ImgParArr[LocalsMax[k],j].mark := True;
    end;
  end;
  // конвертируем в результат
  aSetLength(result, Length(Arr), Length(Arr[0]));
  for i := 0 to High(ImgParArr) do
    for j := 0 to High(ImgParArr[i]) do begin
      result[i,j] := ifthen(ImgParArr[i,j].mark, MAXBYTE, 0);
    end;
 end; // SimpleCannyFiltration();

// Процедура производящая фильтрацию по методу Кенни
//!Данная версия упращенная (более быстрая), не проверяет сопряженность границ
//!Обрабатывае только прямые углы
// Параметры:
//  Arr - исходное изображение
//  @Result - - список отфильтрованных точек с градиентом
//  Threshold - граница фильтрации шума
 procedure SimpleCannyFiltration(var Arr: TImageArray; out Result: TPointGradArray; Threshold: Byte); overload;
 Var i, j, k      : Word;
     LineArr      : TDWordArray;
     LocalsMax    : TDCardinalArray;
     ImgParArr    : TPointPar2Array;
     maskX, maskY : TImageArray;
     NewGrad      : TPointGradient;
 // процедура округления угла в ImgParArr
 procedure RoundAngle;
 var i,j : word;
     grad: single;
 begin
  for i := 0 to High(ImgParArr) do
    for j := 0 to High(ImgParArr[i]) do begin
      grad := ImgParArr[i,j].fi*180/Pi;
      if      (0<=grad)     and (grad<22.5)  then ImgParArr[i,j].fi := 0
      else if (22.5<=grad)  and (grad<67.5)  then ImgParArr[i,j].fi := 45
      else if (67.5<=grad)  and (grad<112.5) then ImgParArr[i,j].fi := 90
      else if (112.5<=grad) and (grad<157.5) then ImgParArr[i,j].fi := 135
      else if (157.5<=grad) and (grad<202.5) then ImgParArr[i,j].fi := 180
      else if (202.5<=grad) and (grad<247.5) then ImgParArr[i,j].fi := 225
      else if (247.5<=grad) and (grad<292.5) then ImgParArr[i,j].fi := 270
      else if (292.5<=grad) and (grad<337.5) then ImgParArr[i,j].fi := 315
      else if (337.5<=grad) and (grad<=360)  then ImgParArr[i,j].fi := 0
      else ImgParArr[i,j].fi := 0;
    end;
 end; // RoundAngle();

 Begin
  // 1. Макса Соби (дифференцирование)
  maskX := OverlayMaskArrToTImageArray(Arr, cSobelMaskX);
  maskY := OverlayMaskArrToTImageArray(Arr, cSobelMaskY);
  aConvertToArray(maskX, maskY, ImgParArr);
  // 2. округление углов
  RoundAngle;
  // 3a. Максимумы по горизонтали
  for i := 0 to High(ImgParArr) do begin
    // поиск локальных максимумов
    aConvertToArray(ImgParArr[i], LineArr);
    LocalsMax := aFindLocalsMax(LineArr);
    for k := 0 to High(LocalsMax) do begin
      if (ImgParArr[i,LocalsMax[k]].p > Threshold)
      and((ImgParArr[i,LocalsMax[k]].fi = 0)or(ImgParArr[i,LocalsMax[k]].fi = 180)) then
        ImgParArr[i,LocalsMax[k]].mark := True;
    end;
  end;
  // 3b. Максимумы по вертикали
  for j := 0 to High(ImgParArr[0]) do begin
    // поиск локальных максимумов
    SetLength(LineArr, length(ImgParArr));
    for i := 0 to High(ImgParArr) do
      LineArr[i] := ImgParArr[i,j].p;
    LocalsMax := aFindLocalsMax(LineArr);
    for k := 0 to High(LocalsMax) do begin
      if (ImgParArr[LocalsMax[k],j].p > Threshold)
      and((ImgParArr[LocalsMax[k],j].fi = 90)or(ImgParArr[LocalsMax[k],j].fi = 270)) then
        ImgParArr[LocalsMax[k],j].mark := True;
    end;
  end;
  // конвертируем в результат
  SetLength(Result, 0);
  for i := 0 to High(ImgParArr) do
    for j := 0 to High(ImgParArr[i]) do begin
      if ImgParArr[i,j].mark then begin
        NewGrad.x      := i;
        NewGrad.y      := j;
        NewGrad.length := ImgParArr[i,j].p;
        NewGrad.degree := abs(round(ImgParArr[i,j].fi));
        aAddToArray(Result, NewGrad);
      end;
    end;
 end; // SimpleCannyFiltration();

// Функция производящая фильтрацию по методу Кенни
//!Версия работающая через прослеживание границы (гистерезисная фильтрация)
// Параметры:
//  Arr - исходное изображение
//  Th - общая граница фильтрации шума
//  Th1, Th2 - пороговые границы (гистерезистный фильтр). NB! Th1 > Th2
// Возвращаемое значение:
//  TImageArray - результат фильтрации в изображении
 function HysteresisCannyFiltration(var Arr: TImageArray; Th, Th1, Th2: Byte): TImageArray; overload;
 Var i, j, Angle                  : Word;
     maskX, maskY                 : TImageArray;
     ImgParArr                    : TPointPar2Array;
     Point, PointNew, p           : TPointPosition;
     PointArr                     : TPointPosArray;
     LabelsPosArr                 : TPointPos2Array;
     LineArr                      : TDWordArray;
     LocalsMax                    : TDCardinalArray;
     LocalsMaxPos, EstimatedPoints: TPointPosArray;
     k                            : integer;
 // процедура округления угла в ImgParArr
 procedure RoundAngle;
 var i,j : word;
     grad: single;
 begin
  for i := 0 to High(ImgParArr) do
    for j := 0 to High(ImgParArr[i]) do begin
      grad := ImgParArr[i,j].fi*180/Pi;
      if      (0<=grad)     and (grad<22.5)  then ImgParArr[i,j].fi := 0
      else if (22.5<=grad)  and (grad<67.5)  then ImgParArr[i,j].fi := 45
      else if (67.5<=grad)  and (grad<112.5) then ImgParArr[i,j].fi := 90
      else if (112.5<=grad) and (grad<157.5) then ImgParArr[i,j].fi := 135
      else if (157.5<=grad) and (grad<202.5) then ImgParArr[i,j].fi := 180
      else if (202.5<=grad) and (grad<247.5) then ImgParArr[i,j].fi := 225
      else if (247.5<=grad) and (grad<292.5) then ImgParArr[i,j].fi := 270
      else if (292.5<=grad) and (grad<337.5) then ImgParArr[i,j].fi := 315
      else if (337.5<=grad) and (grad<=360)  then ImgParArr[i,j].fi := 0
      else ImgParArr[i,j].fi := 0;
    end;
 end; // RoundAngle();
 // процедура получения соседних пикселей по ориентации угла
 procedure GetNeighbors(Angle: Word; out p1, p2: TPointPosition);
 begin
   if (Angle = 0)or(Angle = 180) then begin
    // координаты соседей
    p1.i := i;
    p1.j := j - 1;
    p2.i := i;
    p2.j := j + 1;
  end
  else if (Angle = 45)or(Angle = 225)  then begin
    // координаты соседей
    p1.i := i - 1;
    p1.j := j + 1;
    p2.i := i + 1;
    p2.j := j - 1;
  end
  else if (Angle = 90)or(Angle = 270) then begin
    // координаты соседей
    p1.i := i - 1;
    p1.j := j;
    p2.i := i + 1;
    p2.j := j;
  end
  else if (Angle = 135)or(Angle = 315) then begin
    // координаты соседей
    p1.i := i - 1;
    p1.j := j - 1;
    p2.i := i + 1;
    p2.j := j + 1;
  end;
 end; // GetNeighbors();
 // процедура получения соседнего пикселя по ориентации угла
 function GetGradNeighbor(Angle: Word; p: TPointPosition): TPointPosition;
 begin
   if (Angle = 0) or (Angle = 360) then begin
    result.i := p.i;
    result.j := p.j + 1;
  end
  else if Angle = 180 then begin
    result.i := p.i;
    result.j := p.j - 1;
  end
  else if Angle = 45  then begin
    result.i := p.i - 1;
    result.j := p.j + 1;
  end
  else if Angle = 225  then begin
    result.i := p.i + 1;
    result.j := p.j - 1;
  end
  else if Angle = 90 then begin
    result.i := p.i - 1;
    result.j := p.j;
  end
  else if Angle = 270 then begin
    result.i := p.i + 1;
    result.j := p.j;
  end
  else if Angle = 135 then begin
    result.i := p.i - 1;
    result.j := p.j - 1;
  end
  else if Angle = 315 then begin
    result.i := p.i + 1;
    result.j := p.j + 1;
  end
  else Assert(true, 'Angle range error!');
 end; // GetGradNeighbor();
 // Функция поиска максимальной яркости в соседних точках по ориентации угла
 function FindMaxInGradientTrend(p0: TPointPosition; Angle: Word): TPointPosition;
 var p1, p2: TPointPosition;
     tmpArr: TDWordArray;
     index, i : cardinal;
 begin
  GetNeighbors(Angle, p1, p2);
  // записываем точки в массив
  SetLength(tmpArr, 3);
  tmpArr[0] := ImgParArr[p1.i,p1.j].p;
  tmpArr[1] := ImgParArr[p0.i,p0.j].p;
  tmpArr[2] := ImgParArr[p2.i,p2.j].p;
  // получаем максимум
  index     := aIndexOfMaxValue(tmpArr);
  // определяем координату
  if      index = 0 then Result := p1
  else if index = 1 then Result := p0
  else if index = 2 then Result := p2;
  for i := 0 to 2 do
    if tmpArr[index] = ImgParArr[Result.i,Result.j].p then begin
      Result := p0;
      Exit;
    end;
  //?/ проставляем метки
  ImgParArr[p1.i,p1.j].mark := True;
  ImgParArr[p0.i,p0.j].mark := True;
  ImgParArr[p2.i,p2.j].mark := True;
 end; // FindMaxInGradientTrend();
 // получение 3ех точек по направлению от исходной
 function Estimate3Points(Parent: TPointPosition; Angle: integer): TPointPosArray;
 begin
  setlength(Result, 0);
  aAddToArray(Result, GetGradNeighbor(Angle, Parent));
  // +45
  Inc(Angle, 45);
  Angle := Angle + ifthen(Angle > 360, -360, 0);
  aAddToArray(Result, GetGradNeighbor(Angle, Parent));
  // -45
  Dec(Angle, 90);
  Angle := Angle + ifthen(Angle < 0, 360, 0);
  aAddToArray(Result, GetGradNeighbor(Angle, Parent));
 end;
 // Проверка пометок в окрестности исходной точки
 function CheckSurroundMarkPoints(Parent: TPointPosition): boolean;
 var i,j: integer;
 begin
  Result := False;
  for i := Parent.i - 1 to Parent.i + 1 do
    for j := Parent.j - 1 to Parent.j + 1 do
      if ImgParArr[i,j].mark then begin
        Result := True;
        Exit;
      end;
 end;
 // Функция проверки связей
 function CheckConnected(Parent, pNew: TPointPosition; locPointArr: TPointPosArray): Boolean;
   // подсчет максимального количества заполнения
   function CountMaxFill(Parent: TPointPosition): Byte;
   var i,j: smallint; p: TPointPosition; k: integer;
   begin
    Result := 0;
    for i := Parent.i - 1 to Parent.i + 1 do
      for j := Parent.j - 1 to Parent.j + 1 do begin
        p.i := i; p.j := j;
        if aFindInArray(locPointArr, p, k) then Inc(Result);
      end;
   end;
   // Проверка квадрантов
   function CheckQuads(Parent: TPointPosition): boolean;
   var Count: byte; k: integer;
       q1,q2:TPointPosArray;
       p: TPointPosition;
   // заполнение квадрантов
   procedure FillQuads(out res1, res2: TPointPosArray);
   var p1,p2,p3,p4,p5,p6,p7,p8: TPointPosition;
       q1,q2,q3,q4: TPointPosArray;
   begin
    setlength(q1, 4); setlength(q2, 4); setlength(q3, 4); setlength(q4, 4);
    p1.i := Parent.i - 1; p1.j := Parent.j - 1;
    p2.i := Parent.i - 1; p2.j := Parent.j;
    p3.i := Parent.i - 1; p3.j := Parent.j + 1;
    p4.i := Parent.i;     p4.j := Parent.j - 1;
    p5.i := Parent.i;     p5.j := Parent.j + 1;
    p6.i := Parent.i + 1; p6.j := Parent.j - 1;
    p7.i := Parent.i + 1; p7.j := Parent.j;
    p8.i := Parent.i + 1; p8.j := Parent.j + 1;
    q1[0] := p2; q1[1] := p3; q1[2] := Parent; q1[3] := p5;
    q2[0] := p1; q2[1] := p2; q2[2] := p4; q2[3] := Parent;
    q3[0] := p4; q3[1] := Parent; q3[2] := p6; q3[3] := p7;
    q4[0] := Parent; q4[1] := p5; q4[2] := p7; q4[3] := p8;

    if (pNew.i = p5.i) and (pNew.j = p5.j) then begin
      // 1 and 4
      res1 := q1; res2 := q4;
    end
    else if (pNew.i = p3.i) and (pNew.j = p3.j) then begin
      // 1
      res1 := q1; res2 := nil;
    end
    else if (pNew.i = p2.i) and (pNew.j = p2.j) then begin
      // 1 and 2
      res1 := q1; res2 := q2;
    end
    else if (pNew.i = p1.i) and (pNew.j = p1.j) then begin
      // 2
      res1 := q2; res2 := nil;
    end
    else if (pNew.i = p4.i) and (pNew.j = p4.j) then begin
      // 2 and 3
      res1 := q2; res2 := q3;
    end
    else if (pNew.i = p6.i) and (pNew.j = p6.j) then begin
      // 3
      res1 := q3; res2 := nil;
    end
    else if (pNew.i = p7.i) and (pNew.j = p7.j) then begin
      // 4 and 3
      res1 := q4; res2 := q3;
    end
    else if (pNew.i = p8.i) and (pNew.j = p8.j) then begin
      // 4
      res1 := q4; res2 := nil;
    end
   end;

 begin
  FillQuads(q1,q2);
  Count := 0;
  for p in q1 do if aFindInArray(locPointArr, p, k) then Inc(Count);
  if Count >= 4 then begin
    Result := False;
    Exit;
  end;
  Count := 0;
  for p in q2 do if aFindInArray(locPointArr, p, k) then Inc(Count);
  if Count >= 4 then begin
    Result := False;
    Exit;
  end;
  Result := True;
 end;

 begin
  aAddToArray(locPointArr, pNew);
  //// Parent ////
  // 1. проверка максимального количества заполнения
  if CountMaxFill(Parent) > 4 then begin
    Result := False;
    Exit;
  end;
  // 2. Проверка квадрантов
  if not CheckQuads(Parent) then begin
    Result := False;
    Exit;
  end;
  // 3.

  //// pNew ////
  // 1. проверка максимального количества заполнения
  if CountMaxFill(pNew) > 5 then begin
    Result := False;
    Exit;
  end;
  // 2. Проверка квадрантов
  if not CheckQuads(pNew) then begin
    Result := False;
    Exit;
  end;
  // 3.

  Result := True;
 end;
 // Процедура для рекурсивного вызова обработки следующей связанной точки
 procedure FindForParent(Point: TPointPosition);
 var EstimatedPoints : TPointPosArray;
     PointNew        : TPointPosition;
     k               : integer;
 begin
    Angle := round(ImgParArr[Point.i,Point.j].fi + 90);
    Angle := Angle + ifthen(Angle > 360, -360, 0);
    // определяем предполагаемых соседей
    EstimatedPoints := Estimate3Points(Point, Angle);
    for PointNew in EstimatedPoints do begin
      // минимальная граница
      if ImgParArr[PointNew.i, PointNew.j].p < Th2 then Continue;
      // 1. есть ли в окрестности новой точки пометки?
      if CheckSurroundMarkPoints(PointNew) then Continue;
      // 2. Есть ли новая точка в контуре?
      if aFindInArray(PointArr, PointNew, k) then Continue;
      // 3. Проверка нарушения связей
      if not CheckConnected(Point, PointNew, PointArr) then Continue;
      // если все круто
      aAddToArray(PointArr, PointNew);
      FindForParent(PointNew);
      Break;
    end;
 end; // FindForParent();

 Begin
  // 1. Макса Собела (дифференцирование)
  maskX := OverlayMaskArrToTImageArray(Arr, cSobelMaskX);
  maskY := OverlayMaskArrToTImageArray(Arr, cSobelMaskY);
  aConvertToArray(maskX, maskY, ImgParArr);
  // 2. Округление углов
  RoundAngle;
  // 3. Подавление немаксимумов (поиск максимумов)
  setlength(LocalsMaxPos, 0);
  // 3a. Максимумы по горизонтали
  for i := 0 to High(ImgParArr) do begin
    // поиск локальных максимумов
    aConvertToArray(ImgParArr[i], LineArr);
    LocalsMax := aFindLocalsMax(LineArr);
    for k := 0 to High(LocalsMax) do begin
      if (ImgParArr[i,LocalsMax[k]].p > Th)
      and((ImgParArr[i,LocalsMax[k]].fi = 0)or(ImgParArr[i,LocalsMax[k]].fi = 180)) then begin
        p.i := i; p.j := LocalsMax[k];
        aAddToArray(LocalsMaxPos, p);
      end;
    end;
  end;
  // 3b. Максимумы по вертикали
  for j := 0 to High(ImgParArr[0]) do begin
    // поиск локальных максимумов
    SetLength(LineArr, length(ImgParArr));
    for i := 0 to High(ImgParArr) do
      LineArr[i] := ImgParArr[i,j].p;
    LocalsMax := aFindLocalsMax(LineArr);
    for k := 0 to High(LocalsMax) do begin
      if (ImgParArr[LocalsMax[k],j].p > Th)
      and((ImgParArr[LocalsMax[k],j].fi = 90)or(ImgParArr[LocalsMax[k],j].fi = 270)) then begin
        p.i := LocalsMax[k]; p.j := j;
        aAddToArray(LocalsMaxPos, p);
      end;
    end;
  end;
  // 4. Гистерезисная фильтрация максимальных пикселей
  SetLength(LabelsPosArr, 0);
  for Point in LocalsMaxPos do begin
    if ImgParArr[Point.i,Point.j].p < Th1 then Continue;
    //// инициализация контура
    // новая точка
    setlength(PointArr, 0);
    aAddToArray(PointArr, Point);
    // угол
    Angle := round(ImgParArr[Point.i,Point.j].fi + 90);
    Angle := Angle + ifthen(Angle > 360, -360, 0);
    // определяем предполагаемых соседей
    EstimatedPoints := Estimate3Points(Point, Angle);
    for PointNew in EstimatedPoints do begin
      // минимальная граница
      if ImgParArr[PointNew.i, PointNew.j].p < Th2 then Continue;
      // 1. есть ли в окрестности новой точки пометки?
      if CheckSurroundMarkPoints(PointNew) then Continue;
      // 2. Есть ли новая точка в контуре?
      if aFindInArray(PointArr, PointNew, k) then Continue;
      // 3. Проверка нарушения связей
      if not CheckConnected(Point, PointNew, PointArr) then Continue;
      // если все круто
      aAddToArray(PointArr, PointNew);
      FindForParent(PointNew);
      Break;
    end;
    // противоположная сторона
    Angle := Angle + 180;
    Angle := Angle + ifthen(Angle > 360, -360, 0);
    // определяем предполагаемых соседей
    EstimatedPoints := Estimate3Points(Point, Angle);
    for PointNew in EstimatedPoints do begin
      // минимальная граница
      if ImgParArr[PointNew.i, PointNew.j].p < Th2 then Continue;
      // 1. есть ли в окрестности новой точки пометки?
      if CheckSurroundMarkPoints(PointNew) then Continue;
      // 2. Есть ли новая точка в контуре?
      if aFindInArray(PointArr, PointNew, k) then Continue;
      // 3. Проверка нарушения связей
      if not CheckConnected(Point, PointNew, PointArr) then Continue;
      // если все круто
      aAddToArray(PointArr, PointNew);
      FindForParent(PointNew);
      Break;
    end;
    // помечаем
    for p in PointArr do ImgParArr[p.i,p.j].mark := True;
    aAddToArray(LabelsPosArr, PointArr);
  end;
  // check
  if Length(LabelsPosArr) = 0 then begin
    //Assert(False, 'Null labels find!');
    Result := nil;
    Exit;
  end;
  // обработка результата
  aSetLength(result, Length(Arr), Length(Arr[0]));
  for PointArr in LabelsPosArr do
    for Point in PointArr do
      result[Point.i,Point.j] := MAXBYTE;
 end; // HysteresisCannyFiltration();

// Процедура производящая фильтрацию по методу Кенни
//!Версия работающая через прослеживание границы (гистерезисная фильтрация)
// Параметры:
//  Arr - исходное изображение
//  @Result - - список отфильтрованных точек с градиентом
//  Th - общая граница фильтрации шума
//  Th1, Th2 - пороговые границы (гистерезистный фильтр). NB! Th1 > Th2
 procedure HysteresisCannyFiltration(var Arr: TImageArray; out Result: TPointGradArray; Th, Th1, Th2: Byte); overload;
 Var i, j, Angle                  : Word;
     maskX, maskY                 : TImageArray;
     ImgParArr                    : TPointPar2Array;
     Point, PointNew, p           : TPointPosition;
     PointArr                     : TPointPosArray;
     LabelsPosArr                 : TPointPos2Array;
     LineArr                      : TDWordArray;
     LocalsMax                    : TDCardinalArray;
     LocalsMaxPos, EstimatedPoints: TPointPosArray;
     k                            : integer;
     NewGrad                      : TPointGradient;
 // процедура округления угла в ImgParArr
 procedure RoundAngle;
 var i,j : word;
     grad: single;
 begin
  for i := 0 to High(ImgParArr) do
    for j := 0 to High(ImgParArr[i]) do begin
      grad := ImgParArr[i,j].fi*180/Pi;
      if      (0<=grad)     and (grad<22.5)  then ImgParArr[i,j].fi := 0
      else if (22.5<=grad)  and (grad<67.5)  then ImgParArr[i,j].fi := 45
      else if (67.5<=grad)  and (grad<112.5) then ImgParArr[i,j].fi := 90
      else if (112.5<=grad) and (grad<157.5) then ImgParArr[i,j].fi := 135
      else if (157.5<=grad) and (grad<202.5) then ImgParArr[i,j].fi := 180
      else if (202.5<=grad) and (grad<247.5) then ImgParArr[i,j].fi := 225
      else if (247.5<=grad) and (grad<292.5) then ImgParArr[i,j].fi := 270
      else if (292.5<=grad) and (grad<337.5) then ImgParArr[i,j].fi := 315
      else if (337.5<=grad) and (grad<=360)  then ImgParArr[i,j].fi := 0
      else ImgParArr[i,j].fi := 0;
    end;
 end; // RoundAngle();
 // процедура получения соседних пикселей по ориентации угла
 procedure GetNeighbors(Angle: Word; out p1, p2: TPointPosition);
 begin
   if (Angle = 0)or(Angle = 180) then begin
    // координаты соседей
    p1.i := i;
    p1.j := j - 1;
    p2.i := i;
    p2.j := j + 1;
  end
  else if (Angle = 45)or(Angle = 225)  then begin
    // координаты соседей
    p1.i := i - 1;
    p1.j := j + 1;
    p2.i := i + 1;
    p2.j := j - 1;
  end
  else if (Angle = 90)or(Angle = 270) then begin
    // координаты соседей
    p1.i := i - 1;
    p1.j := j;
    p2.i := i + 1;
    p2.j := j;
  end
  else if (Angle = 135)or(Angle = 315) then begin
    // координаты соседей
    p1.i := i - 1;
    p1.j := j - 1;
    p2.i := i + 1;
    p2.j := j + 1;
  end;
 end; // GetNeighbors();
 // процедура получения соседнего пикселя по ориентации угла
 function GetGradNeighbor(Angle: Word; p: TPointPosition): TPointPosition;
 begin
   if (Angle = 0) or (Angle = 360) then begin
    result.i := p.i;
    result.j := p.j + 1;
  end
  else if Angle = 180 then begin
    result.i := p.i;
    result.j := p.j - 1;
  end
  else if Angle = 45  then begin
    result.i := p.i - 1;
    result.j := p.j + 1;
  end
  else if Angle = 225  then begin
    result.i := p.i + 1;
    result.j := p.j - 1;
  end
  else if Angle = 90 then begin
    result.i := p.i - 1;
    result.j := p.j;
  end
  else if Angle = 270 then begin
    result.i := p.i + 1;
    result.j := p.j;
  end
  else if Angle = 135 then begin
    result.i := p.i - 1;
    result.j := p.j - 1;
  end
  else if Angle = 315 then begin
    result.i := p.i + 1;
    result.j := p.j + 1;
  end
  else Assert(true, 'Angle range error!');
 end; // GetGradNeighbor();
 // Функция поиска максимальной яркости в соседних точках по ориентации угла
 function FindMaxInGradientTrend(p0: TPointPosition; Angle: Word): TPointPosition;
 var p1, p2: TPointPosition;
     tmpArr: TDWordArray;
     index, i : cardinal;
 begin
  GetNeighbors(Angle, p1, p2);
  // записываем точки в массив
  SetLength(tmpArr, 3);
  tmpArr[0] := ImgParArr[p1.i,p1.j].p;
  tmpArr[1] := ImgParArr[p0.i,p0.j].p;
  tmpArr[2] := ImgParArr[p2.i,p2.j].p;
  // получаем максимум
  index     := aIndexOfMaxValue(tmpArr);
  // определяем координату
  if      index = 0 then Result := p1
  else if index = 1 then Result := p0
  else if index = 2 then Result := p2;
  for i := 0 to 2 do
    if tmpArr[index] = ImgParArr[Result.i,Result.j].p then begin
      Result := p0;
      Exit;
    end;
  //?/ проставляем метки
  ImgParArr[p1.i,p1.j].mark := True;
  ImgParArr[p0.i,p0.j].mark := True;
  ImgParArr[p2.i,p2.j].mark := True;
 end; // FindMaxInGradientTrend();
 // получение 3ех точек по направлению от исходной
 function Estimate3Points(Parent: TPointPosition; Angle: integer): TPointPosArray;
 begin
  setlength(Result, 0);
  aAddToArray(Result, GetGradNeighbor(Angle, Parent));
  // +45
  Inc(Angle, 45);
  Angle := Angle + ifthen(Angle > 360, -360, 0);
  aAddToArray(Result, GetGradNeighbor(Angle, Parent));
  // -45
  Dec(Angle, 90);
  Angle := Angle + ifthen(Angle < 0, 360, 0);
  aAddToArray(Result, GetGradNeighbor(Angle, Parent));
 end;
 // Проверка пометок в окрестности исходной точки
 function CheckSurroundMarkPoints(Parent: TPointPosition): boolean;
 var i,j: integer;
 begin
  Result := False;
  for i := Parent.i - 1 to Parent.i + 1 do
    for j := Parent.j - 1 to Parent.j + 1 do
      if ImgParArr[i,j].mark then begin
        Result := True;
        Exit;
      end;
 end;
 // Функция проверки связей
 function CheckConnected(Parent, pNew: TPointPosition; locPointArr: TPointPosArray): Boolean;
   // подсчет максимального количества заполнения
   function CountMaxFill(Parent: TPointPosition): Byte;
   var i,j: smallint; p: TPointPosition; k: integer;
   begin
    Result := 0;
    for i := Parent.i - 1 to Parent.i + 1 do
      for j := Parent.j - 1 to Parent.j + 1 do begin
        p.i := i; p.j := j;
        if aFindInArray(locPointArr, p, k) then Inc(Result);
      end;
   end;
   // Проверка квадрантов
   function CheckQuads(Parent: TPointPosition): boolean;
   var Count: byte; k: integer;
       q1,q2:TPointPosArray;
       p: TPointPosition;
   // заполнение квадрантов
   procedure FillQuads(out res1, res2: TPointPosArray);
   var p1,p2,p3,p4,p5,p6,p7,p8: TPointPosition;
       q1,q2,q3,q4: TPointPosArray;
   begin
    setlength(q1, 4); setlength(q2, 4); setlength(q3, 4); setlength(q4, 4);
    p1.i := Parent.i - 1; p1.j := Parent.j - 1;
    p2.i := Parent.i - 1; p2.j := Parent.j;
    p3.i := Parent.i - 1; p3.j := Parent.j + 1;
    p4.i := Parent.i;     p4.j := Parent.j - 1;
    p5.i := Parent.i;     p5.j := Parent.j + 1;
    p6.i := Parent.i + 1; p6.j := Parent.j - 1;
    p7.i := Parent.i + 1; p7.j := Parent.j;
    p8.i := Parent.i + 1; p8.j := Parent.j + 1;
    q1[0] := p2; q1[1] := p3; q1[2] := Parent; q1[3] := p5;
    q2[0] := p1; q2[1] := p2; q2[2] := p4; q2[3] := Parent;
    q3[0] := p4; q3[1] := Parent; q3[2] := p6; q3[3] := p7;
    q4[0] := Parent; q4[1] := p5; q4[2] := p7; q4[3] := p8;

    if (pNew.i = p5.i) and (pNew.j = p5.j) then begin
      // 1 and 4
      res1 := q1; res2 := q4;
    end
    else if (pNew.i = p3.i) and (pNew.j = p3.j) then begin
      // 1
      res1 := q1; res2 := nil;
    end
    else if (pNew.i = p2.i) and (pNew.j = p2.j) then begin
      // 1 and 2
      res1 := q1; res2 := q2;
    end
    else if (pNew.i = p1.i) and (pNew.j = p1.j) then begin
      // 2
      res1 := q2; res2 := nil;
    end
    else if (pNew.i = p4.i) and (pNew.j = p4.j) then begin
      // 2 and 3
      res1 := q2; res2 := q3;
    end
    else if (pNew.i = p6.i) and (pNew.j = p6.j) then begin
      // 3
      res1 := q3; res2 := nil;
    end
    else if (pNew.i = p7.i) and (pNew.j = p7.j) then begin
      // 4 and 3
      res1 := q4; res2 := q3;
    end
    else if (pNew.i = p8.i) and (pNew.j = p8.j) then begin
      // 4
      res1 := q4; res2 := nil;
    end
   end;

 begin
  FillQuads(q1,q2);
  Count := 0;
  for p in q1 do if aFindInArray(locPointArr, p, k) then Inc(Count);
  if Count >= 4 then begin
    Result := False;
    Exit;
  end;
  Count := 0;
  for p in q2 do if aFindInArray(locPointArr, p, k) then Inc(Count);
  if Count >= 4 then begin
    Result := False;
    Exit;
  end;
  Result := True;
 end;

 begin
  aAddToArray(locPointArr, pNew);
  //// Parent ////
  // 1. проверка максимального количества заполнения
  if CountMaxFill(Parent) > 4 then begin
    Result := False;
    Exit;
  end;
  // 2. Проверка квадрантов
  if not CheckQuads(Parent) then begin
    Result := False;
    Exit;
  end;
  // 3.

  //// pNew ////
  // 1. проверка максимального количества заполнения
  if CountMaxFill(pNew) > 5 then begin
    Result := False;
    Exit;
  end;
  // 2. Проверка квадрантов
  if not CheckQuads(pNew) then begin
    Result := False;
    Exit;
  end;
  // 3.

  Result := True;
 end;
 // Процедура для рекурсивного вызова обработки следующей связанной точки
 procedure FindForParent(Point: TPointPosition);
 var EstimatedPoints : TPointPosArray;
     PointNew        : TPointPosition;
     k               : integer;
 begin
    Angle := round(ImgParArr[Point.i,Point.j].fi + 90);
    Angle := Angle + ifthen(Angle > 360, -360, 0);
    // определяем предполагаемых соседей
    EstimatedPoints := Estimate3Points(Point, Angle);
    for PointNew in EstimatedPoints do begin
      // минимальная граница
      if ImgParArr[PointNew.i, PointNew.j].p < Th2 then Continue;
      // 1. есть ли в окрестности новой точки пометки?
      if CheckSurroundMarkPoints(PointNew) then Continue;
      // 2. Есть ли новая точка в контуре?
      if aFindInArray(PointArr, PointNew, k) then Continue;
      // 3. Проверка нарушения связей
      if not CheckConnected(Point, PointNew, PointArr) then Continue;
      // если все круто
      aAddToArray(PointArr, PointNew);
      FindForParent(PointNew);
      Break;
    end;
 end; // FindForParent();

 Begin
  // 1. Макса Собела (дифференцирование)
  maskX := OverlayMaskArrToTImageArray(Arr, cSobelMaskX);
  maskY := OverlayMaskArrToTImageArray(Arr, cSobelMaskY);
  aConvertToArray(maskX, maskY, ImgParArr);
  // 2. Округление углов
  RoundAngle;
  // 3. Подавление немаксимумов (поиск максимумов)
  setlength(LocalsMaxPos, 0);
  // 3a. Максимумы по горизонтали
  for i := 0 to High(ImgParArr) do begin
    // поиск локальных максимумов
    aConvertToArray(ImgParArr[i], LineArr);
    LocalsMax := aFindLocalsMax(LineArr);
    for k := 0 to High(LocalsMax) do begin
      if (ImgParArr[i,LocalsMax[k]].p > Th)
      and((ImgParArr[i,LocalsMax[k]].fi = 0)or(ImgParArr[i,LocalsMax[k]].fi = 180)) then begin
        p.i := i; p.j := LocalsMax[k];
        aAddToArray(LocalsMaxPos, p);
      end;
    end;
  end;
  // 3b. Максимумы по вертикали
  for j := 0 to High(ImgParArr[0]) do begin
    // поиск локальных максимумов
    SetLength(LineArr, length(ImgParArr));
    for i := 0 to High(ImgParArr) do
      LineArr[i] := ImgParArr[i,j].p;
    LocalsMax := aFindLocalsMax(LineArr);
    for k := 0 to High(LocalsMax) do begin
      if (ImgParArr[LocalsMax[k],j].p > Th)
      and((ImgParArr[LocalsMax[k],j].fi = 90)or(ImgParArr[LocalsMax[k],j].fi = 270)) then begin
        p.i := LocalsMax[k]; p.j := j;
        aAddToArray(LocalsMaxPos, p);
      end;
    end;
  end;
  // 4. Гистерезисная фильтрация максимальных пикселей
  SetLength(LabelsPosArr, 0);
  for Point in LocalsMaxPos do begin
    if ImgParArr[Point.i,Point.j].p < Th1 then Continue;
    //// инициализация контура
    // новая точка
    setlength(PointArr, 0);
    aAddToArray(PointArr, Point);
    // угол
    Angle := round(ImgParArr[Point.i,Point.j].fi + 90);
    Angle := Angle + ifthen(Angle > 360, -360, 0);
    // определяем предполагаемых соседей
    EstimatedPoints := Estimate3Points(Point, Angle);
    for PointNew in EstimatedPoints do begin
      // минимальная граница
      if ImgParArr[PointNew.i, PointNew.j].p < Th2 then Continue;
      // 1. есть ли в окрестности новой точки пометки?
      if CheckSurroundMarkPoints(PointNew) then Continue;
      // 2. Есть ли новая точка в контуре?
      if aFindInArray(PointArr, PointNew, k) then Continue;
      // 3. Проверка нарушения связей
      if not CheckConnected(Point, PointNew, PointArr) then Continue;
      // если все круто
      aAddToArray(PointArr, PointNew);
      FindForParent(PointNew);
      Break;
    end;
    // противоположная сторона
    Angle := Angle + 180;
    Angle := Angle + ifthen(Angle > 360, -360, 0);
    // определяем предполагаемых соседей
    EstimatedPoints := Estimate3Points(Point, Angle);
    for PointNew in EstimatedPoints do begin
      // минимальная граница
      if ImgParArr[PointNew.i, PointNew.j].p < Th2 then Continue;
      // 1. есть ли в окрестности новой точки пометки?
      if CheckSurroundMarkPoints(PointNew) then Continue;
      // 2. Есть ли новая точка в контуре?
      if aFindInArray(PointArr, PointNew, k) then Continue;
      // 3. Проверка нарушения связей
      if not CheckConnected(Point, PointNew, PointArr) then Continue;
      // если все круто
      aAddToArray(PointArr, PointNew);
      FindForParent(PointNew);
      Break;
    end;
    // помечаем
    for p in PointArr do ImgParArr[p.i,p.j].mark := True;
    aAddToArray(LabelsPosArr, PointArr);
  end;
  // check
  if Length(LabelsPosArr) = 0 then begin
    //Assert(False, 'Null labels find!');
    Result := nil;
    Exit;
  end;
  // обработка результата
  SetLength(Result, 0);
  for PointArr in LabelsPosArr do
    for Point in PointArr do begin
      NewGrad.x       := Point.i;
      NewGrad.y       := Point.j;
      NewGrad.length  := ImgParArr[Point.i,Point.j].p;
      NewGrad.degree  := abs(round(ImgParArr[Point.i,Point.j].fi));
      aAddToArray(Result, NewGrad);
    end;
 end; // HysteresisCannyFiltration();

// Функция производящая фильтрацию по методу Кенни в зависимости от фильтра
// Параметры:
//  Arr - исходное изображение
//  CannySett - Настройки фильтрации
// Возвращаемое значение:
//  TImageArray - результат фильтрации в изображении
 function CannyFiltration(var Arr: TImageArray; CannySett: TCannySetting): TImageArray;
 begin
  if (CannySett.FilterType <> fSimple) and (CannySett.FilterType <> fHysteresis) then begin
    CannySett.FilterType := fSimple;
    CannySett.Th         := 100;
  end;
  case CannySett.FilterType of
    fSimple: begin
      Result := SimpleCannyFiltration(Arr, CannySett.Th);
    end;
    fHysteresis: begin
      Result := HysteresisCannyFiltration(Arr, CannySett.Th, CannySett.Th1, CannySett.Th2);
      // пока не будет до конца поправлено
      Result := SimpleCannyFiltration(Result, CannySett.Th);
    end;
  end;
 end; // CannyFiltration();

// Процедура производящая фильтрацию по методу Кенни в зависимости от фильтра
// Параметры:
//  Arr - исходное изображение
//  @Result - список отфильтрованных точек с градиентом
//  *FType - Тип фильтрации
//  *Th - общая граница фильтрации шума
//  *Th1, *Th2 - пороговые границы (гистерезистный фильтр). NB! Th1 > Th2
 procedure CannyFiltration(var Arr: TImageArray; out Result: TPointGradArray; CannySett: TCannySetting);
 Var tmpArr: TImageArray;
 begin
  if (CannySett.FilterType <> fSimple) and (CannySett.FilterType <> fHysteresis) then begin
    CannySett.FilterType := fSimple;
    CannySett.Th         := 100;
  end;
  case CannySett.FilterType of
    fSimple: begin
      SimpleCannyFiltration(Arr, Result, CannySett.Th);
    end;
    fHysteresis: begin
      tmpArr := HysteresisCannyFiltration(Arr, CannySett.Th, CannySett.Th1, CannySett.Th2);
      // пока не будет до конца поправлено
      SimpleCannyFiltration(tmpArr, Result, CannySett.Th);
    end;
  end;
 end; // CannyFiltration();

//////////////////////////////////////////////////////
// LABELS

// Функция стороит массив распределения
//яркостей массива пикселей изображения
// Параметры:
//  Arr - TImageArray. Массив для построения распределения
// Возвращаемое значение:
//  TLevelsArray
 function CreateTLevelsArray(var Arr: TImageArray): TLevelsArray;
 var i,j: integer;
 Begin
  fillchar(Result, Length(Result)*sizeof(Cardinal), 0);
  for i := 0 to High(Arr) do
  begin
    for j := 0 to High(Arr[i]) do
    begin
      Inc(Result[Arr[i,j]]);
    end;
  end;
 End; // CreateTLevelsArray();

//////////////////////////////////////////////////////
// БИНАРИЗАЦИЯ

// Функция находит границу черного цвета в массиве пикселей
//По фильтру mBlackMass (поиск % заполнения массы
//черных пикселей
//  Параметры:
//   Arr        - TImageArray
//   *PercentMass - максимальный % "массы" ограничения
// Возвращаемое значение:
//  Byte
 function FindBlackThresholdFTypeBlackMass(Arr: TImageArray; PercentMass: TPercent = 25): Byte;
 //const PercentMass  = 0.25; // *100% максимальная "масса" ограничения
 var i                  : integer;
     maxMass, summMass  : Cardinal;
     LevelsArray        : TLevelsArray;
 Begin
  Result := 0;
  if PercentMass > 100 then PercentMass := 100;
  // получаем распределение
  LevelsArray := CreateTLevelsArray(Arr);
  // определяем максимальную массу распределения
  maxMass := 0;
  for i := 0 to High(LevelsArray) do Inc(maxMass, LevelsArray[i]);
  maxMass := Round(maxMass*PercentMass/100);
  // ищем границу распределения
  summMass := 0;
  for i := 0 to High(LevelsArray) do
  begin
    Inc(summMass, LevelsArray[i]);
    if summMass >= maxMass then
    begin
      Result := i;
      Break;
    end;
  end;
 End; // FindBlackThresholdFTypeBlackMass();

// Функция находит границу черного цвета в массиве пикселей
//По фильтру mBlackMass (поиск % заполнения массы черных пикселей)
//  Параметры:
//   Arr        - TImageArray.
// Возвращаемое значение:
//  Byte
 function FindBlackThresholdFTypeFindMin(Arr: TImageArray; SmoothSett: TSmoothSetting; SplineType: TSplineType = fAkima): Byte;
 var i, r                         : Integer;
     ReduceArray, LocalsMinReduce : TDCardinalArray;
     DiscPoints                   : TDByteArray;
     LocalsMinApr, LocalsMaxApr   : TDByteArray;
     LevelsArray, LevelsAproxArr  : TLevelsArray;
     DiscPointsLength             : Word;
     XArr, YArr, SplineCoeff      : TDDoubleArray;
     RArr                         : TDDoubleArray;
     imax1, imax2, igmax, k       : Byte;
     newpoint                     : Double;
 // Свертка массива
 procedure FolgingArr();
 var i    : Word;
     first: Boolean;
 begin
  first := True;
  SetLength(ReduceArray, 0);
  SetLength(DiscPoints, 0);
  for i := 0 to High(LevelsArray) do begin
    if LevelsArray[i] <> 0 then begin
      if i = 0 then begin
        first := false;
      end
      else if (first) and (i <> 0) then begin
        aAddToArray(ReduceArray, LevelsArray[i]);
        aAddToArray(DiscPoints, 0);
        first := false;
      end;
      aAddToArray(ReduceArray, LevelsArray[i]);
      aAddToArray(DiscPoints, i);
    end;
  end;
  if DiscPoints[High(DiscPoints)] <> MAXBYTE then begin
    // если последняя не масимум, дублируем
    aAddToArray(ReduceArray, ReduceArray[High(DiscPoints)]);
    aAddToArray(DiscPoints, MAXBYTE);
  end;
 end;
 // Поиск двух наибольших локальных максимумов в массиве
 procedure FindTwoMainLocalMax(out i1, i2: byte);
 var PosPointArr : TPointPosArray;
     Point       : TPointPosition;
     i, HighA    : Word;
 begin
  // выбор двух максимальных знач
  for i := 0 to High(LocalsMaxApr) do begin
    Point.i := LocalsMaxApr[i];
    Point.j := LevelsAproxArr[LocalsMaxApr[i]];
    aAddToArray(PosPointArr, Point);
  end;
  aBubbleSort(PosPointArr, 'j');
  HighA := High(PosPointArr);
  if PosPointArr[HighA - 1].i < PosPointArr[HighA].i then begin
    i1 := PosPointArr[HighA - 1].i;
    i2 := PosPointArr[HighA].i;
  end
  else begin
    i1 := PosPointArr[HighA].i;
    i2 := PosPointArr[HighA - 1].i;
  end;
 end; // FindTwoMainLocalMax();

 Begin
  //Result := 0;
  //// Предварительная обработка ////
  // получаем распределение
  LevelsArray := CreateTLevelsArray(Arr);
  // Сворачиваем массив
  FolgingArr();
  DiscPointsLength := Length(ReduceArray);
  // определяем является ли минимум граничным значением
  LocalsMinReduce := aFindLocalsMin(ReduceArray);
  if Length(LocalsMinReduce) = 1 then begin
    if (LocalsMinReduce[0] = 0)or(LocalsMinReduce[0] + 1 = DiscPointsLength)
      then begin // минимум граничное значение
        igmax := aIndexOfMaxValue(LevelsArray);
        i     := LocalsMinReduce[0];
        Result := min(igmax, i) + round(Abs(igmax - i)/2);
        //Result := MAXBYTE div 2;
        Exit;
      end
    else begin
      Result := LocalsMinReduce[0];
      Exit;
    end;
  end;
  //// Апроксимация ////
  // преобразовние данных
  SetLength(XArr, DiscPointsLength);
  SetLength(YArr, DiscPointsLength);
  for i := 0 to DiscPointsLength - 1 do begin
    XArr[i] := DiscPoints[i];
    YArr[i] := ReduceArray[i];
  end;
  aBuildSpline(XArr, YArr, SplineCoeff, SplineType);
  // апроксимация
  SetLength(RArr, MAXBYTE);
  for i := 0 to High(LevelsAproxArr) do begin
    newpoint := i;
    RArr[i]  := aSplineInterpolation(SplineCoeff, newpoint);
  end;
  // smoothing
  aSmoothing(RArr, SmoothSett);
  for i := 0 to High(LevelsAproxArr) do begin
    LevelsAproxArr[i] := tRoundToByte(RArr[i]);
  end;
  // max, min
  LocalsMaxApr := aFindLocalsMax(LevelsAproxArr);
  LocalsMinApr := aFindLocalsMin(LevelsAproxArr);
  FindTwoMainLocalMax(imax1, imax2);
  igmax := ifthen(LevelsAproxArr[imax1] >= LevelsAproxArr[imax2], imax1, imax2);
  if igmax = imax2 then begin //<= MAXBYTE div 2 then begin
    // left
    for k := imax2 downto imax1 do begin
      // поиск ближайшего минимума
      if aFindInArray(LocalsMinApr, k, r, mBinary, False) then Break;
    end;
    Result := ifthen(LocalsMinApr[r] > imax2, LocalsMinApr[r-1], LocalsMinApr[r]);
  end
  else begin
    // right
    for k := imax1 to imax2 do begin
      // поиск ближайшего минимума
      if aFindInArray(LocalsMinApr, k, r, mBinary, False) then Break;
    end;
    Result := ifthen(LocalsMinApr[r] < imax1, LocalsMinApr[r+1], LocalsMinApr[r]);
  end;
 End;// FindBlackThresholdFTypeFindMin();

// Функция находит границу черного цвета в массиве пикселей
// Работает в зависимости от типа фильтра
//  Параметры:
//   Arr        - TImageArray.
//   *FilterType - TBWFilterType.
//   *MaxThreshold - максимальная граница порога за которую не рекомендуется проходить
//   *MinThreshold - минимальная граница
// Возвращаемое значение:
//  Byte
 function FindTImageArrayBlackThreshold(var Arr: TImageArray; Settings: TBinarizeSetting; CountryIndex: TCountryIndex = RUS): Byte;
                                      {FilterType: TBWFilterType = fBlackMass;
                                        MaxThreshold: Byte = 185; MinThreshold: Byte = 70;
                                        PercentMass: Byte = 25; PrioritySplineType: TSplineType = fAkima): Byte;  }
 Begin
  if (Settings.FilterType <> fBlackMass) and (Settings.FilterType <> fFindMin) then begin
    Settings            := CountrySettings[CountryIndex].BinarSetting;
    Settings.SmoothSett := CountrySettings[CountryIndex].SmoothSetting;
  end;
  Result := 0;
  case Settings.FilterType of
    fBlackMass: Result := FindBlackThresholdFTypeBlackMass(Arr, Settings.PercentMass);
    fFindMin  : Result := FindBlackThresholdFTypeFindMin(Arr, Settings.SmoothSett, Settings.SplineType);
  end;
  // проверка границы
  if Settings.MaxThreshold <= Result then Result := Settings.MaxThreshold
  else if Settings.MinThreshold > Result then Result := Settings.MinThreshold;
 End; // FindTImageArrayBlackThreshold();

// Процедура БИНАРИЗАЦИИ по массиву пикселей и границе
//обрабатывает массив и приводит его к состоящимку только из
//черных и белых цветов
// Параметры:
//  Arr - TImageArray
//  BlackThreshold - Byte. Граница до которой цвет
//считается черным
 procedure MonochromeToBWTImageArray(var Arr: TImageArray; BlackThreshold: byte = 128);
 Var i,j : integer;
 Begin
  for i := 0 to High(Arr) do
  begin
    for j := 0 to High(Arr[i]) do
    begin
      Arr[i,j] := ifthen(Arr[i,j] <= BlackThreshold, 0, 255);
    end;
  end;
 End; // MonochromeToBWTImageArray();


////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ СЕГМЕНТАЦИИ
//

//////////////////////////////////////////////////////
// ДОПОЛНИТЕЛЬНЫЕ ПРОЦЕДУРЫ

// Функция находит границы по определенному признаку
//По индексу метки в массиве меток
// Параметры:
//  LabelsArray - Массив меток
//  LabelIndex  - Индекс метки
// Возвращаемое значение:
//  TMargins - найденные границы
 function DetectMargins(LabelsArray: TImageArray; LabelIndex: word): TMargins;
 var i, j: Word;
 Begin
   // анализ массива, нахождение границ
   with Result do
   begin
    right  := 0;
    buttom := 0;
    left   := Length(LabelsArray[0]);
    top    := Length(LabelsArray);
   end;
   for i := 0 to High(LabelsArray) do
   begin
     for j := 0 to High(LabelsArray[i]) do
     Begin
       if LabelsArray[i,j] = LabelIndex then
       begin
         with Result do
         begin
          if j > right  then right  := j;
          if i > buttom then buttom := i;
          if j < left   then left   := j;
          if i < top    then top    := i;
         end;
       end;
     End;
   end;
 End; // DetectMargins();

// Функция "вырезает" все пиксели в массив 
//TPointPosArray, т.е. хранит список координат 
//пикселей вырезаемой области
// Параметры:
//  LabelsArr  - Массив меток
//  Margin     - Запись границ
//  LabelIndex - обрабатываемый индекс
// Возвращаемое значение:
//  TPointPosArray
 function SegmentMarginsPoint(LabelsArr: TImageArray; Margin: TMargins; LabelIndex: Word): TPointPosArray;
 Var i,j      : Word;
     PointPos : TPointPosition;
 Begin
  SetLength(Result, 0);
  for i := Margin.left to Margin.right do
   for j := Margin.top to Margin.buttom do begin
     if LabelsArr[i,j] = LabelIndex then begin
       PointPos.i := i;
       PointPos.j := j;
       aAddToArray(Result, PointPos);
     end;
   end;
 End; // SegmentMarginsPoint();

// Функция Создает массив флагов/меток/номеров
//объединенных областей по массиву пикселей
// Параметры:
//  Arr - TImageArray. Массив для построения
//  *Threshold - Byte. Значение порога
//  *Upper - Boolean. Граница вверх или вниз
// Возвращаемое значение:
//  TImageArray - где значение это номер области
 function CreateLabelsTImageArray(const Arr: TImageArray; Threshold: byte = 255; Upper: boolean = false): TImageArray;
 Type TPoint       = TPointPosition;
      TLabelsArray = TPointPosArray;
 Var i, j, outind           : integer;
     L, ArrHeight, ArrWidth : Word;
     Point                  : TPoint;
     LabelsArray, TmpLabels : TLabelsArray;
 // Функция нахождения связи пикселей
 function FindConnect(m,n: integer): Boolean;
 var i,j: Integer;
 begin
   for i := m - 1 to m + 1 do
   begin
     for j := n - 1 to n + 1 do
     begin
      if (i<0)or(i>=ArrHeight)or(j<0)or(j>ArrWidth)or((i=m)and(j=n)) then Continue
      else
      begin
        if ((Upper)and(Arr[i,j] > Threshold))or((not Upper)and(Arr[i,j] < Threshold)) then
        begin
          Result := True;
          Exit;
        end;
      end;
     end;
   end;
   Result := False;
 end; // FindConnect();
 // Функция Добавления связынных пикселей в массив
 function AddCoonected(m,n: integer): TLabelsArray;
 var i,j  : integer;
     Point: TPoint;
 begin
   SetLength(Result, 0);
   for i := m - 1 to m + 1 do
   begin
     for j := n - 1 to n + 1 do
     begin
      if (i<0)or(i>=ArrHeight)or(j<0)or(j>ArrWidth)or((i=m)and(j=n)) then Continue
      else begin
        if ((Upper)and(Arr[i,j] > Threshold)) or ((not Upper)and(Arr[i,j] < Threshold))
        then begin
          Point.i := i;
          Point.j := j;
          aAddToArray(Result, Point);
        end
        else Continue;
      end;
     end;
   end;
 end;
 // Функция Добавления связынных пикселей в массив с исключением уже сущ
 function AddCoonectedExcept(m,n: integer): TLabelsArray;
 var i, j, tmp  : integer;
     Point      : TPoint;
 begin
   SetLength(Result, 0);
   for i := m - 1 to m + 1 do
   begin
     for j := n - 1 to n + 1 do
     begin
      if (i<0)or(i>=ArrHeight)or(j<0)or(j>ArrWidth)or((i=m)and(j=n)) then Continue
      else
      begin
        if ((Upper)and(Arr[i,j] > Threshold))or((not Upper)and(Arr[i,j] < Threshold)) then
        begin
          Point.i := i;
          Point.j := j;
          if aFindInArray(LabelsArray, Point, tmp) then Continue;
          aAddToArray(Result, Point);
        end
        else Continue;
      end;
     end;
   end;
 end;
 // Процедура для заполнения связанных точек по родителю
 procedure SetFromParent(var ArrResult: TImageArray; TmpLabels: TLabelsArray);
 var i,j          : integer;
     Point        : TPoint;
     NewTmpLabels : TLabelsArray;
 begin
  for Point in TmpLabels do begin
    i               := Point.i;
    j               := Point.j;
    ArrResult[i,j]  := L;
    // ищем связь
    if not FindConnect(i, j) then Continue;
    NewTmpLabels    := AddCoonectedExcept(i, j);
    if Length(NewTmpLabels) = 0 then Continue;
    aAddFromArray(LabelsArray, NewTmpLabels);
    // вызываем рекурсивно
    try
      SetFromParent(ArrResult, NewTmpLabels);
    except
      Exit;
    end;
  end;
 end;

 Begin
  ArrHeight := Length(Arr);
  ArrWidth  := Length(Arr[0]);
  L := 0;
  aSetLength(Result, ArrHeight, ArrWidth);
  for i := 0 to High(Arr) do begin
    for j := 0 to High(Arr[i]) do begin
      if Arr[i,j] < Threshold then begin
        // новая точка
        Point.i := i;
        Point.j := j;
        if aFindInArray(LabelsArray, Point, outind) then Continue;
        // новая область
        Inc(L);
        aAddToArray(LabelsArray, Point);
        Result[i,j] := L;
        // поиск связанных
        if not FindConnect(i, j) then Continue;
        SetLength(TmpLabels, 0);
        TmpLabels := AddCoonected(i, j);
        if Length(TmpLabels) = 0 then Continue;
        // обработка
        aAddFromArray(LabelsArray, TmpLabels);
        SetFromParent(Result, TmpLabels);
      end;
    end;
  end;
 End; // CreateLabelsTImageArray();

// Создание Массива "массы" областей меток
// Параметры:
//   LabelsArray - Массиф меток связанных областей
// Возвращаемое значение:
//  TDWordArray - Массив, где индекс - номер метки,
//значение - количество метов в массиве
 function CreateLabelsCountArray(LabelsArray: TImageArray): TDWordArray;
 Var i, j, L, maxL: Word;
 Begin
  maxL := 0;
  SetLength(Result, maxL + 1);
  for i := 0 to High(LabelsArray) do
  begin
    for j := 0 to High(LabelsArray[i]) do
    begin
      L := LabelsArray[i,j];
      if maxL < L then
      begin
        maxL := L;
        SetLength(Result, maxL + 1);
      end;
      if L = 0 then Continue;
      Inc(Result[L]);
    end;
  end;
 End; // CreateLabelsCountArray();

//////////////////////////////////////////////////////
// ОСНОВНЫЕ ПРОЦЕДУРЫ

// Функция из битового массива выделяет
//символ основной символ по границе, приводит его к квадратному и
//помещает в новый массив
// Параметры:
//  Arr          - TImageArray. исходный массив
//  *pThreshold  - Byte. Пороговое значение границы
// Возвращаемое значение:
//  TImageArray
 function SegmentMainSymbolToSquareArray(const Arr: TImageArray; Threshold: Byte = 255): TImageArray;
 Var LabelsArray  : TImageArray;
     LabelCountArr: TDWordArray;
     LabelIndex   : Cardinal;
 // Выделения символа в квадратный массив
 procedure SegmentSymbolToSquareArray();
  var right, buttom, left, top, i, j, addPoints, ArrHeigth, ArrWidth: smallint;
      Height, Width: Word;
  begin
    // анализ массива, нахождение границ
    //буквы по пороговому значению
    ArrHeigth := length(LabelsArray);
    ArrWidth  := length(LabelsArray[0]);
    right     := 0;
    buttom    := 0;
    left      := ArrWidth;
    top       := ArrHeigth;
    for i := 0 to High(LabelsArray) do
    begin
      for j := 0 to High(LabelsArray[i]) do
      Begin
        if LabelsArray[i,j] = LabelIndex then
        begin
          if j > right  then right  := j;
          if i > buttom then buttom := i;
          if j < left   then left   := j;
          if i < top    then top    := i;
        end;
      End;
    end;
    // получение квадратных границ
    // получаем нечетное число, чтобы длина 
    //массива была четная
    top    := top    + (buttom - top) mod 2 - 1;
    left   := left   + (right - left) mod 2 - 1;
    Height := buttom - top;
    Width  := right - left;
    if Height > Width then
      begin
        addPoints := (Height - Width) div 2;
        left      := left - addPoints;
        right     := right + addPoints;
        Width     := Height;
      end
    else if Height < Width then
      begin
        addPoints := (Width - Height) div 2;
        buttom    := buttom + addPoints;
        top       := top - addPoints;
        Height    := Width;
      end;
    // запись информации
    aSetLength(Result, Height + 1, Width + 1);
    for i := top to buttom do
      begin
        for j := left to right do
          begin
            if (i<0)or(j<0)or(j>=ArrWidth)or(i>=ArrHeigth) then Result[i - top, j - left] := 255
            else if LabelsArray[i,j] = LabelIndex then Result[i - top, j - left] := Arr[i,j]
            else Result[i - top, j - left] := 255;
          end;
      end;
  end; // SegmentSymbolToSquareArray();

 Begin
  // преобразуем в метки
  LabelsArray   := CreateLabelsTImageArray(Arr, Threshold);
  // находим номер пометки основного символа
  LabelCountArr := CreateLabelsCountArray(LabelsArray);
  LabelIndex    := aIndexOfMaxValue(LabelCountArr);
  // создаем квадратный массив
  SegmentSymbolToSquareArray();
 End; // SegmentMainSymbolToSquareArray();

// Функция из битового массива выделяет
//символ по границе, приводит его к квадратному и
//помещает в новый массив
// Параметры:
//  Arr          - TImageArray. исходный массив
//  *pThreshold  - Byte. Пороговое значение границы
// Возвращаемое значение:
//  TImageArray
 function SegmentSymbolToSquareArray(const Arr: TImageArray; pThreshold: Byte = 255): TImageArray;
  var right, buttom, left, top, i, j, addPoints, ArrHeigth, ArrWidth: smallint;
      Height, Width: Word;
  begin
    // анализ массива, нахождение границ
    //буквы по пороговому значению
    ArrHeigth := length(Arr);
    ArrWidth  := length(Arr[0]);
    right     := 0;
    buttom    := 0;
    left      := ArrWidth;
    top       := ArrHeigth;
    for i := 0 to High(Arr) do
    begin
      for j := 0 to High(Arr[i]) do
      Begin
        if Arr[i,j] < pThreshold then
        begin
          if j > right  then right  := j;
          if i > buttom then buttom := i;
          if j < left   then left   := j;
          if i < top    then top    := i;
        end;
      End;
    end;
    // получение квадратных границ
    // получаем нечетное число, чтобы длина 
    //массива была четная
    top    := top    + (buttom - top) mod 2 - 1;
    left   := left   + (right - left) mod 2 - 1;
    Height := buttom - top;
    Width  := right - left;
    if Height > Width then
      begin
        addPoints := (Height - Width) div 2;
        left      := left - addPoints;
        right     := right + addPoints;
        Width     := Height;
      end
    else if Height < Width then
      begin
        addPoints := (Width - Height) div 2;
        buttom    := buttom + addPoints;
        top       := top - addPoints;
        Height    := Width;
      end;
    // запись информации
    aSetLength(Result, Height + 1, Width + 1);
    for i := top to buttom do
      begin
        for j := left to right do
          begin
            if (i<0) or (j<0) or (j>=ArrWidth) or (i>=ArrHeigth) then Result[i - top, j - left] := 255
            else Result[i - top, j - left] := Arr[i,j];
          end;
      end;
  end; // SegmentSymbolToSquareArray();

// Функция в TImagesArray помещает первые N самых
//больших символов из TImageArray
// Параметры:
//  Arr           - TImageArray;
//  SymbolsNumber - Byte.
// Возвращаемое значение:
//  TImagesArray
 function SegmentNMainSymbolsFromBWTImageArray(const Arr: TImageArray; SymbolsNumber: Byte): TImagesArray;
 Type TIncCountArr   = array[0..1] of Word;
      TLabelCountArr = array of TIncCountArr;
 Var LabelsArray  : TImageArray;
     LabelCountArr: TLabelCountArr;
     i            : Byte;
     LabelIndex   : Word;
     TmpArr       : TImageArray;
 // Создание Массива "весов" меток
 function CreateLabelCountArr(): TLabelCountArr;
 var i,j          : integer;
     L, maxL      : Word;
 begin
  maxL := 0;
  SetLength(Result, maxL + 1);
  for i := 0 to High(LabelsArray) do
  begin
    for j := 0 to High(LabelsArray[i]) do
    begin
      L := LabelsArray[i,j];
      if maxL < L then
      begin
        maxL := L;
        SetLength(Result, maxL + 1);
      end;
      if L = 0 then Continue;
      Inc(Result[L,0]);
      Result[L,1] := L;
    end;
  end;
 end; // CreateLabelCountArr();
// Сортировка Пузырьком
 procedure BubbleSort(var data: TLabelCountArr);
 var i,j: word;
     P: TIncCountArr;
 begin
 for i := 0 to High(data) do
  for j := 0 to High(data)-i do
  if data[j,0] < data[j+1,0] then
    begin
     P        := data[j];
     data[j]  := data[j+1];
     data[j+1]:= P;
    end;
 end; // BubbleSort();
 // Выделения символа в квадратный массив
 function SegmentSymbolToSquareArray(LabelIndex: Word): TImageArray;
  var right, buttom, left, top, i, j, addPoints, ArrHeigth, ArrWidth: smallint;
      Height, Width: Word;
  begin
    // анализ массива, нахождение границ
    //буквы по пороговому значению
    ArrHeigth := length(LabelsArray);
    ArrWidth  := length(LabelsArray[0]);
    right     := 0;
    buttom    := 0;
    left      := ArrWidth;
    top       := ArrHeigth;
    for i := 0 to High(LabelsArray) do
    begin
      for j := 0 to High(LabelsArray[i]) do
      Begin
        if LabelsArray[i,j] = LabelIndex then
        begin
          if j > right  then right  := j;
          if i > buttom then buttom := i;
          if j < left   then left   := j;
          if i < top    then top    := i;
        end;
      End;
    end;
    // получение квадратных границ
    // получаем нечетное число, чтобы длина 
    //массива была четная
    top    := top    + (buttom - top) mod 2 - 1;
    left   := left   + (right - left) mod 2 - 1;
    Height := buttom - top;
    Width  := right - left;
    if Height > Width then
      begin
        addPoints := (Height - Width) div 2;
        left      := left - addPoints;
        right     := right + addPoints;
        Width     := Height;
      end
    else if Height < Width then
      begin
        addPoints := (Width - Height) div 2;
        buttom    := buttom + addPoints;
        top       := top - addPoints;
        Height    := Width;
      end;
    // запись информации
    aSetLength(Result, Height + 1, Width + 1);
    for i := top to buttom do
      begin
        for j := left to right do
          begin
            if (i<0)or(j<0)or(j>=ArrWidth)or(i>=ArrHeigth) then Result[i - top, j - left] := 255
            else if LabelsArray[i,j] = LabelIndex then Result[i - top, j - left] := Arr[i,j]
            else Result[i - top, j - left] := 255;
          end;
      end;
  end; // SegmentSymbolToSquareArray();
 // Добавление нового символа в массив
 procedure AddToTImagesArray(var SymbolsArr: TImagesArray; Arr: TImageArray);
 var newLength: Word;
 begin
  newLength := High(SymbolsArr) + 1;
  SetLength(SymbolsArr, newLength + 1);
  aSetLength(SymbolsArr[newLength], Length(Arr), Length(Arr[0]));
  SymbolsArr[newLength] := Arr;
 end;

 Begin
  // преобразуем в метки
  LabelsArray   := CreateLabelsTImageArray(Arr);
  // находим распределение "весов" символов
  LabelCountArr := CreateLabelCountArr();
  // Сортируем
  BubbleSort(LabelCountArr);
  // Выделяем первые N символов
  for i := 0 to SymbolsNumber - 1 do
  begin
    LabelIndex  := LabelCountArr[i,1];
    TmpArr      := SegmentSymbolToSquareArray(LabelIndex);
    aAddToArray(Result, TmpArr);
  end;
 End; // SegmentNMainSymbols();


////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАСПОЗНАВАНИЯ
//

//////////////////////////////////////////////////////
// ДОПОЛНИТЕЛЬНО

// Функция поиска черного разделителя
//т.е. черного массива пикселей в TImageArray
//Возвращает значение индекса вероятного нахождения разделителя
// Параметры:
//  Arr
// Вовзращаемое значение:
//  Word
 function FindDelimiterLine(Arr: TImageArray; CountryIndex: TCountryIndex = RUS): Word;
 const cCoeffMinBright = 0.10;
 var AverageBrightnessArr, Average3pxBrightnessArr : TBrightnessArray;
     minBright, ImageAverageBrightness, MaxBright  : Byte;
     i, iminBright, LineW, imin, imax              : Word;
     ArrLine                                       : TDByteArray;
     LocalMins                                     : TDWordArray;
 Begin
  // поиск ведется по нескольким признакам //
  SetLength(ArrLine, Length(Arr));
  // получаем значения яркостей
  AverageBrightnessArr   := CreateAverageTBrightnessArray(Arr);
  ImageAverageBrightness := CreateImageAverageBrightness(AverageBrightnessArr);
  //// Основной Признак
  // поиск минимума или абс. нуля
  minBright  := MAXBYTE;
  iminBright := 0;
  for i := 0 to High(AverageBrightnessArr) do
  begin
    // ищем абсолютный ноль
    if AverageBrightnessArr[i] = 0 then begin
      Result := i;
      Exit;
    end;
    // ищем минимум
    if minBright > AverageBrightnessArr[i] then begin
      iminBright := i;
      minBright  := AverageBrightnessArr[i];
    end;
  end;
  // если попали в область считаем, что нашли
  if minBright < cCoeffMinBright*MAXBYTE then begin
    Result := iminBright;
    Exit;
  end;
  //// Признак второго рода
  // через локальные минимумы
  LocalMins := aFindLocalsMin(AverageBrightnessArr);
  // средняя яркость 3 соседних пикселей
  Average3pxBrightnessArr := CreateAverageNpxTBrightnessArray(AverageBrightnessArr, 3);
  LineW     := Round(CountrySettings[CountryIndex].cfLineW*Length(Arr));
  MaxBright := Round(CountrySettings[CountryIndex].cfMaxBright*MAXBYTE);
  for i := 0 to High(LocalMins) do begin
    imin := ifthen(LocalMins[i]-LineW < 0, 0, LocalMins[i]-LineW);
    imax := ifthen(LocalMins[i]+LineW > High(AverageBrightnessArr), High(AverageBrightnessArr), LocalMins[i]+LineW);
    if (AverageBrightnessArr[imax]>MaxBright)
    and (AverageBrightnessArr[imin]>MaxBright)
    and (Average3pxBrightnessArr[imin]>ImageAverageBrightness)
    and (Average3pxBrightnessArr[imax]>ImageAverageBrightness) then
    begin
      Result := LocalMins[i];
      Exit;
    end;
  end;
  Result := 0;
 End; // FindDelimiterLine();

//////////////////////////////////////////////////////
// РАСПОЗНАВАНИЕ СИМВОЛОВ

// Процедура распознования сиволов в
//области массива пикселей
// Использует константы распознавания
// Параметры:
//  ResultArr - Массив результата
//  Arr - обрабатываемый массив
//  SymbolsArr - Массив  записей сивмолов
//  NewLength - Новый размер символа
 procedure RecognizeSymbolsFromBWTImageArray(var ResultArr: TSymbolsArray; Arr: TImageArray;
                                             SymbolsArr: TSymbolsArray; SymbolSize: TSymbolSize;
                                             ResizeType: TResizeType = fBilinearSpline; CountryIndex: TCountryIndex = RUS);
 const cCoeffRightFindArea = 0.15;
       cCoeffPercentRight  = 0.05;
       cCoeffBeginStep     = 0.70;
 var AverageBrightnessArr                     : TBrightnessArray;
     i, di, di2, i0, ik, inew, iLocMax        : Word;
     FirstFlag, SecondFlag, ThirdFlag         : boolean;
     NSymbols, LocBrigth                      : byte;
     LocalMaxArr                              : TDWordArray;
     ImgArr                                   : TImageArray;
     Symbol                                   : TSymbol;
     ImageAverageBrightness                   : Byte;
     Height, Width                            : Word;
 // Процедура проверки границ правильности нахождения максимума
 function CheckBoarders(): Boolean;
 Var LeftFlag, RightFlag                            : Boolean;
     i, AverMinus, SymbSpace                        : word;
     RightConfirmPXb, RightConfirmPXa, ConfirmPXNeed: byte;
 begin
  LeftFlag      := False;
  RightFlag     := False;
  SymbSpace     := Round(CountrySettings[CountryIndex].cfSymbolSpace*Height);
  ConfirmPXNeed := Round(cCoeffPercentRight*Height);
  // left (check in 2 left px) //
  if LocBrigth > AverageBrightnessArr[ifthen(iLocMax - 2 < 0, 0, iLocMax - 2)]
    then LeftFlag := True;
  // check size
  if iLocMax + 1 > High(AverageBrightnessArr) then begin
    if LeftFlag then Result := True
    else Result := False;
    Exit;
  end;
  // right //
  RightConfirmPXa := 0;
  RightConfirmPXb := 0;
  for i := iLocMax to iLocMax + SymbSpace do
  begin
    if i > High(AverageBrightnessArr) then begin
     if (RightConfirmPXa>0)or(RightConfirmPXa>0) then RightFlag := True;
     break;
    end;
    AverMinus := Round(AverageBrightnessArr[i] - AverageBrightnessArr[i]*cCoeffPercentRight);
    if  (AverMinus <= LocBrigth)
    and (AverageBrightnessArr[i] >= MAXBYTE*CountrySettings[CountryIndex].cfMaxBright)
      then begin
       Inc(RightConfirmPXa);
      end;
    if (AverageBrightnessArr[i-1] < AverageBrightnessArr[i])
    and (AverageBrightnessArr[i] > MAXBYTE*CountrySettings[CountryIndex].cfMaxBright)
      then begin
       Inc(RightConfirmPXb);
      end;
    if (RightConfirmPXa >= ConfirmPXNeed)or(RightConfirmPXb >= ConfirmPXNeed)
    then begin
      RightFlag := True;
      Break;
    end;
  end;
  Result := (LeftFlag)and(RightFlag);
 end; // CheckBoarders();
 // Нахождение начала следующего символа
 function FindNextBoarder(): Word;
 var k, AverMinus: word;
 begin
  k := i0;
  AverMinus := Round(LocBrigth - LocBrigth*cCoeffPercentRight);
  repeat
    if (AverMinus > AverageBrightnessArr[k])
    and (AverageBrightnessArr[k] < MAXBYTE*CountrySettings[CountryIndex].cfMaxBright) then Break;
    Inc(k);
  until (k >= ik)or(k >= Width);
  Result := k;
 end; // FindNextBoarder();

 Begin
  //// получаем значения яркостей
  AverageBrightnessArr   := CreateAverageTBrightnessArray(Arr);
  ImageAverageBrightness := CreateImageAverageBrightness(AverageBrightnessArr);
  // параметры массива
  Height := Length(Arr);
  Width  := Length(Arr[0]);
  //// Поиск и выделение символов в окрестности
  // начальные условия
  di        := Round(Height*CountrySettings[CountryIndex].cfSymbolWidth);
  i0        := 0;
  di2       := Round(di/2);
  ik        := di + di2; // в начале берем увеличенный интервал
  NSymbols  := 0;
  // цикл по ~ диапазонам
  repeat
    // поиск предполагаемых границ букв
    LocalMaxArr := aFindLocalsMax(AverageBrightnessArr, i0, ik);
    if Length(LocalMaxArr) = 0 then Break;
    LocBrigth   := 0;
    inew        := 0;
    // слияние (нахождение правильной границы)
    for i := 0 to High(LocalMaxArr) do
    begin
      // nulled
      FirstFlag   := False;
      SecondFlag  := False;
      ThirdFlag   := False;
      // new local max
      iLocMax   := LocalMaxArr[i];
      LocBrigth := AverageBrightnessArr[iLocMax];
      // 1.
      if (i0 + round(di2*cCoeffBeginStep) <= iLocMax)and(iLocMax <= ik) then FirstFlag := True;
      // 2.
      if CheckBoarders() then SecondFlag := True;
      // 3.
      if (ImageAverageBrightness <= LocBrigth)and(LocBrigth>=MAXBYTE*CountrySettings[CountryIndex].cfMaxBright)
        then ThirdFlag := True;
      // Проверка
      if FirstFlag and SecondFlag and ThirdFlag then
      begin
        inew := iLocMax;
        Break;
      end;
    end;
    if inew = 0 then Break;
    //// Распознование
    try
      // Выделение
      ImgArr := SegmentMainSymbolToSquareArray(aCrop(Arr, 0, ifthen(inew - di < 0, 0, inew - di),
                                                             High(Arr), inew + round(cCoeffRightFindArea*di)));
      // изменение размера, BW
      ImgArr := aResize(ImgArr, tGetTSymbolSize(SymbolSize), tGetTSymbolSize(SymbolSize), ResizeType);
    except
      Continue;
    end;
    MonochromeToBWTImageArray(ImgArr, FindTImageArrayBlackThreshold(ImgArr, CountrySettings[CountryIndex].BinarSetting));
    // распознавание
    Symbol := FindAndCompareWithTSymbolsArray(ImgArr, SymbolsArr);
    if Symbol.hit < cAgreeHits then Exit;
    //// добавление
    aAddToArray(ResultArr, Symbol);
    Inc(NSymbols);
    //// Определение новой границы
    // предполагаемые
    i0 := inew + 1;
    ik := i0 + di;
    // ищем "пробел"
    i0 := FindNextBoarder();
    ik := i0 + di;
  until (NSymbols >= CountrySettings[CountryIndex].MaxSymbols)or(i0 > Width - di2);
 end; // RecognizeSymbolsFrommBWTImageArray();

// Функция Распознавания российского
//автомобильного номера
// Параметры:
//  Arr - Исходное изображение
//  SymbolsArr - Массив символов
//  NewLength - Размер нового символа
// Возвращаемое значение
//  TImagesArray
 function RecognizeRUSNumberFromBWTImageArray(Arr: TImageArray; SymbolsArr: TSymbolsArray; SymbolSize: TSymbolSize;
                                              ResizeType: TResizeType = fBilinearSpline): TSymbolsArray;
 Var SeriesWidthMax, SeriesWidthMin, SeriesBorder : Word;
     Height, RegionHeight, tmpLength, i           : Word;
     Symbol                                       : TSymbol;
     SymbolsTmp                                   : TSymbolsArray;
 Begin
  // параметры массива
  Height := Length(Arr);
  // Поиск "разделителя" областей
  SeriesWidthMax := Round(CountrySettings[RUS].cfSeriesMax*Height);
  SeriesWidthMin := Round(CountrySettings[RUS].cfSeriesMin*Height);
  SeriesBorder   := FindDelimiterLine(aCrop(Arr, 0, SeriesWidthMin, High(Arr), SeriesWidthMax));
  if SeriesBorder <> 0 then begin
    SeriesBorder := SeriesWidthMin + SeriesBorder;
    // распознаем блоками
    // 1. Область "Серия + РегНомер"
    RecognizeSymbolsFromBWTImageArray(Result, aCrop(Arr, 0, 0, High(Arr), SeriesBorder), SymbolsArr, SymbolSize);
    aSetLength(Symbol.img, 32, 32);
    Symbol.symbol := '?';
    while Length(Result) < CountrySettings[RUS].MinSeriesSymbols do
      aAddToArray(Result, Symbol);
    // space
    Symbol.symbol := ' ';
    aAddToArray(Result, Symbol);
    tmpLength := Length(Result);
    // 2. Область "Регион"
    // только цифры
    for i := 0 to High(SymbolsArr) do
      if tGetSymbolType(SymbolsArr[i].symbol) = sNumeral then
        aAddToArray(SymbolsTmp, SymbolsArr[i]);
    RegionHeight := Round(CountrySettings[RUS].cfRegionH*Height);
    RecognizeSymbolsFromBWTImageArray(Result, aCrop(Arr, 0, SeriesBorder + 1, RegionHeight, High(Arr[0])), SymbolsTmp, SymbolSize);
    Symbol.symbol := '?';
    while Length(Result) - tmpLength < CountrySettings[RUS].MinRegionSymbols do
      aAddToArray(Result, Symbol);
  end
  else begin
    // граница явно не определена, распознаем
    //через лейблы
  end;
 End; // RecognizeNumberSymbolsFromBWTImageArray();

// Функция в TImagesArray помещает первые N самых
//больших символов из TImageArray
// Параметры:
//  Arr           -
//  SymbolsArr    -
//  SymbolSize    -
//  *ResizeType   -
//  *CountryIndex -
// Возвращаемое значение:
//  TImagesArray
 function RecognizeMainSegmentSymbolsNumberFromBWTImageArray(Arr: TImageArray; SymbolsArr: TSymbolsArray; SymbolSize: TSymbolSize;
                                                             ResizeType: TResizeType = fBilinearSpline; CountryIndex: TCountryIndex = RUS): TSymbolsArray;
 //Const cCoeffPxMargin = 0.1; // отношение ширины границ высоты номера
 Var LabelsArray, ImgArr          : TImageArray;
     LabelCount                   : TDWordArray;
     SymbolH, SymbolW, px, i      : Word;
     MaxLabelsMass, MinLabelsMass : Word;
     Symbol                       : TSymbol;
     SymbMargins                  : TMargins;
     //Xc, Yc                       : Word;
 // Выделения символа в квадратный массив
 function SegmentSymbolToSquareArray(LabelIndex: Word; out Margins: TMargins): TImageArray;
  var right, buttom, left, top, i, j, addPoints, ArrHeigth, ArrWidth: smallint;
      Height, Width: Word;
  begin
    // анализ массива, нахождение границ
    Margins := DetectMargins(LabelsArray, LabelIndex);
    left    := Margins.left;
    right   := Margins.right;
    buttom  := Margins.buttom;
    top     := Margins.top;
    // получение квадратных границ
    // получаем нечетное число, чтобы длина
    //массива была четная
    top    := top    + (buttom - top) mod 2 - 1;
    left   := left   + (right - left) mod 2 - 1;
    Height := buttom - top;
    Width  := right - left;
    if Height > Width then
      begin
        addPoints := (Height - Width) div 2;
        left      := left - addPoints;
        right     := right + addPoints;
        Width     := Height;
      end
    else if Height < Width then
      begin
        addPoints := (Width - Height) div 2;
        buttom    := buttom + addPoints;
        top       := top - addPoints;
        Height    := Width;
      end;
    // запись информации
    ArrHeigth := length(LabelsArray);
    ArrWidth  := length(LabelsArray[0]);
    aSetLength(Result, Height + 1, Width + 1);
    for i := top to buttom do
      begin
        for j := left to right do
          begin
            if (i<0)or(j<0)or(j>=ArrWidth)or(i>=ArrHeigth) then Result[i - top, j - left] := 255
            else if LabelsArray[i,j] = LabelIndex then Result[i - top, j - left] := Arr[i,j]
            else Result[i - top, j - left] := 255;
          end;
      end;
  end; // SegmentSymbolToSquareArray();

 Begin
  SetLength(Result, 0);
  // преобразуем в метки
  LabelsArray := CreateLabelsTImageArray(Arr);
  // находим распределение "весов" символов
  LabelCount  := CreateLabelsCountArray(LabelsArray);
  // ограничения
  SymbolH       := Round(Length(Arr)*CountrySettings[RUS].cfSymbolHeight);
  SymbolW       := Round(Length(Arr)*CountrySettings[RUS].cfSymbolWidth);
  MaxLabelsMass := SymbolH*SymbolW;
  MinLabelsMass := SymbolH;
  px            := Round(CountrySettings[RUS].cfPxMargin*Length(Arr)); 
  // распознавание полученных меток
  for i := 0 to High(LabelCount) do begin
    if (MinLabelsMass < LabelCount[i]) and (LabelCount[i] < MaxLabelsMass) then begin
      ImgArr := SegmentSymbolToSquareArray(i, SymbMargins);
      // проверка границ
      if (SymbMargins.right > High(LabelsArray[0]) - px) or (SymbMargins.left < px)
      or (SymbMargins.buttom > High(LabelsArray) - px) or (SymbMargins.top < px)
        then Continue;
      if SymbolW < SymbMargins.right - SymbMargins.left then Continue;
      // изменение размера, BW
      ImgArr := aResize(ImgArr, tGetTSymbolSize(SymbolSize), tGetTSymbolSize(SymbolSize), ResizeType);
      MonochromeToBWTImageArray(ImgArr, FindTImageArrayBlackThreshold(ImgArr, CountrySettings[RUS].BinarSetting));
      // распознавание
      Symbol := FindAndCompareWithTSymbolsArray(ImgArr, SymbolsArr);
      if Symbol.hit < cAgreeHits then Continue;
      //CalculateCentreOfMassBWTImageArray(Arr, SymbMargins, Xc, Yc);
      Symbol.position := round(SymbMargins.left + (SymbMargins.right - SymbMargins.left)/2);//Xc;//SymbMargins.left;
      // добавление
      aAddToArray(Result, Symbol);
    end;
    if CountrySettings[CountryIndex].MaxSymbols <= Length(Result) then Break;
  end; // for i := 0 to High(LabelCount) do begin
  aBubbleSort(Result);
 End; // SegmentNMainSymbols();

//////////////////////////////////////////////////////
// ПОИСК НОМЕРА

// Функция поиска номера на всем массиве
//пикселей
// Параметры:
//  SArr, Arr     - Масиивы изображений
//  CompareXY     - Массив поиска
//  *FType         - Тип Canny фильтрации
//  *CountryIndex - Тек. страна
 function FindNumberRectangle(var SArr, Arr: TImageArray; out CompareXY: TDWord2Array; CannySett: TCannySetting; CountryIndex: TCountryIndex = RUS): TMargins;
 Var SampleGradArr, OrigGradArr : TPointGradArray;
     SamplePoint, OrigPoint     : TPointGradient;
  // CompareXY                  : TDWord2Array;
     point                      : TPointPosition;
     decX, decY                 : Integer;
 Begin
  if (CannySett.FilterType <> fSimple) and (CannySett.FilterType <> fHysteresis) then CannySett := CountrySettings[CountryIndex].CannySetting;
  //// Sample ////
  // 1. Canny filtration
  CannyFiltration(SArr, SampleGradArr, CannySett);
  //// Img ////
  // 1. Canny filtration
  CannyFiltration(Arr, OrigGradArr, CannySett);
  //// Compare ////
  Setlength(CompareXY, 4000, 4000);
  for SamplePoint in SampleGradArr do
    for OrigPoint in OrigGradArr do
      if OrigPoint.degree = SamplePoint.degree then begin
        decX := OrigPoint.x - SamplePoint.x;
        decY := OrigPoint.y - SamplePoint.y;
        if (decX < 0) or (decY < 0) or (decX >= 4000) or (decY >= 4000) then Continue;
        Inc(CompareXY[decX,decY]);
      end;
  //// max ////
  point       := aIndexOfMaxValue(CompareXY);
  Result.left := point.j;
  Result.top  := point.i;
 End; // FindNumberRectangle();



////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАССИВАМИ ИЗОБРАЖЕНИЙ (TImagesArray)
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ
//

//////////////////////////////////////////////////////
// КОНВЕРТАЦИЯ

// Функция создает массив состоящий из
//массива пикселей каждого из передаваемых 
//символов в строке
// Параметры:
//  Symbol     - Char.    Отрисовываемый символ
//  *Size      - Integer. Размер
//  *FName     - String.  Имя шрифрта
//  *FStyles   - TFontStyles. set of TFontStyle = (fsBold, fsItalic,
//fsUnderline, fsStrikeOut);
//  *SymbolArrLength  - Word. Длина стороны массива
//символа
// Возвращаемое значение:
//  TImagesArray
 function CreateTImagesArrayFromStr(Symbols: String; Size: Integer = 12;
                                     FName: String = 'Tahoma'; FStyles: TFontStyles = [];
                                     SymbolArrLength: Word = 32): TImagesArray;
 Var i, StrLength : Integer;
     Arr, origArr : TImageArray;
     BMPSymbol    : TBitmap;
 Begin
  StrLength := Length(Symbols);
  aSetLength(Result, StrLength, SymbolArrLength, SymbolArrLength);
  for i := 1 to StrLength do
  begin
    BMPSymbol   := iCreateBMPwithFontSymbol(Symbols[i], Size, FName, FStyles);
    iBMPtoArray(BMPSymbol, origArr);
    origArr     := SegmentSymbolToSquareArray(origArr);
    Arr         := aResize(origArr, SymbolArrLength, SymbolArrLength);
    Result[i-1] := Arr;
  end;
 End; // CreateTImagesArrayFromStr();


////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ФИЛЬТРАЦИИ
//

// Процедура по массиву пикселей и границе
//обрабатывает массив и приводит его к состоящимку только из
//черных и белых цветов
// Параметры:
//  Arr - TImagesArray
//  BlackThreshold - Byte. Граница до которой цвет 
//считается черным
 procedure MonochromeToBWTImagesArray(var Arr: TImagesArray; BlackThreshold: byte = 128);
 Var k: integer;
 Begin
  for k := 0 to High(Arr) do
  begin
    MonochromeToBWTImageArray(Arr[k], BlackThreshold);
  end;
 End; // MonochromeToBWTImagesArray();


////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАСПОЗНАВАНИЯ
//

// Функция сравнивает массив пикселей 
//TImageArray с массивом символов TImageArray и 
//находит наиболее соответствующий символ
// Параметры:
//  Arr        - Массив пикселей
//  ArrSymbols - Массив символов для поиска
//  *Threshold - Byte. Граница "размывки" т.е. разницы между двумя
//значениями (пикселями), которые считаются 
//одинаковыми
// Возвращаемое значение:
//  TImageArray
 function FindAndCompareWithTImagesArray(Arr: TImageArray; ArrSymbols: TImagesArray; Threshold: byte = 1): TImageArray;
 Var  i, imax   : word;
      ArrResult : TDDoubleArray;
      maxRes    : Double;
 Begin
  // получение массива результатов
  SetLength(ArrResult, Length(ArrSymbols));
  for i := 0 to High(ArrSymbols) do
  begin
    ArrResult[i] := CompareTImageArray(Arr, ArrSymbols[i], Threshold);
  end;
  // обработка полученных результатов
  maxRes := MinDouble;
  imax   := 0;
  for i := 0 to High(ArrResult) do
  begin
    if ArrResult[i] > maxRes then
    begin
      maxRes := ArrResult[i];
      imax   := i;
    end;
  end;
  Result := ArrSymbols[imax];
 End; // FindAndCompareWithTImagesArray();

// Функция строит соответсвие для массива 
//символов Arr из массива символов ArrSymbols
//возвращает массив в соответсвий для Arr
// Параметры:
//  Arr1, Arr2  - TImagesArray. исходный массив и массив
//для поиска (должны соответстовать размеры 
//входящих массивов пикселей)
//  *Threshold - Byte. Граница "размывки" т.е. разницы между двумя
//значениями (пикселями), которые считаются одинаковыми
// Возвращаемое значение:
//  TImagesArray
 function FindMapForTImagesArray(Arr, ArrSymbols: TImagesArray; Threshold: byte = 1): TImagesArray;
 var i          : word;
     FindSymbol : TImageArray;
 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]), Length(Arr[0,0]));
  for i := 0 to High(Arr) do
  begin
    FindSymbol := FindAndCompareWithTImagesArray(Arr[i], ArrSymbols, Threshold);
    Result[i]  := FindSymbol;
  end;
 End; // FindMapForTImagesArray();



////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАССИВАМИ ЗАПИСЕЙ ИЗОБРАЖЕНИЙ (TSymbolsArray)
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ
//

//////////////////////////////////////////////////////
// КОНВЕРТАЦИЯ

// Функция создает массив состоящий из
//массива пикселей каждого из передаваемых
//символов в строке
// Параметры:
//  Symbols    - String.  Отрисовываемые символы
//  *Size      - Integer. Размер
//  *FName     - String.  Имя шрифрта
//  *FStyles   - TFontStyles. set of TFontStyle = (fsBold, fsItalic,
//fsUnderline, fsStrikeOut);
//  *SymbolArrLength  - Word. Длина стороны массива
//  *BW        - boolean. Определяет бинаризацию массива
//символа
// Возвращаемое значение:
//  TSymbolsArray
 function CreateTSymbolsArrayFromStr(Symbols: String; Size: Integer = 12;
                                     FName: String = 'Tahoma'; FStyles: TFontStyles = [];
                                     SymbolArrLength: Word = 32; BW: boolean = True): TSymbolsArray;
 Var i, StrLength : Integer;
     Arr, origArr : TImageArray;
     BMPSymbol    : TBitmap;
     Rec          : TSymbol;
     BinSett      : TBinarizeSetting;
 Begin
  StrLength := Length(Symbols);
  aSetLength(Result, StrLength);
  for i := 1 to StrLength do
  begin
    BMPSymbol   := iCreateBMPwithFontSymbol(Symbols[i], Size, FName, FStyles);
    iBMPtoArray(BMPSymbol, origArr);
    origArr     := SegmentSymbolToSquareArray(origArr);
    Arr         := aResize(origArr, SymbolArrLength, SymbolArrLength);
    if BW then MonochromeToBWTImageArray(Arr, FindTImageArrayBlackThreshold(Arr, BinSett));
    Rec.img     := Arr;
    Rec.symbol  := Symbols[i];
    Result[i-1] := Rec;
  end;
 End; // CreateTSymbolsArrayFromStr();

//////////////////////////////////////////////////////
// ПРЕОБРАЗОВАНИЕ В МАТРИЦУ

// Функция преобразует в квадратную матрицу указанного размера для каждого
//изображения элемента массива
// Рекомендуется использовать, только для уменьшения размера изображения
// Параметры:
//  Arr         - TSymbolsArray. исходный массив
//  NewLength   - Word. Сторона матрицы (количество точек)
//  *BW         - Boolean. Бинаризовать ли массив?
//  *ResizeType - тип преобразования
 procedure ResizeTSymbolsArray(var Arr: TSymbolsArray; NewLength: Word; BW: boolean = True;
                               ResizeType: TResizeType = fBilinearSpline);
 var i        : word;
     ResizeArr: TImageArray;
     BinSett  : TBinarizeSetting;
 Begin
  for i := 0 to High(Arr) do
  begin
    ResizeArr   := aResize(Arr[i].img, NewLength, NewLength);
    if BW then MonochromeToBWTImageArray(ResizeArr, FindTImageArrayBlackThreshold(ResizeArr, BinSett));
    Arr[i].img := ResizeArr;
  end;
 End; // ResizeTSymbolsArray();


////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ФИЛЬТРАЦИИ
//

// Процедура по массиву пикселей и границе
//обрабатывает массив и приводит его к состоящимку только из
//черных и белых цветов
// Параметры:
//  Arr - TImagesArray
//  BlackThreshold - Byte. Граница до которой цвет 
//считается черным
 procedure MonochromeToBWTSymbolsArray(var Arr: TSymbolsArray; BlackThreshold: byte = 128);
 Var k: integer;
 Begin
  for k := 0 to High(Arr) do
  begin
    MonochromeToBWTImageArray(Arr[k].img, BlackThreshold);
  end;
 End; // MonochromeToBWTSymbolsArray();


////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАСПОЗНАВАНИЯ
//

// Функция сравнивает массив пикселей
//TImageArray с массивом символов TImageArray и 
//находит наиболее соответствующий символ
// Параметры:
//  Arr        - Массив пикселей
//  ArrSymbols - Массив символов для поиска
//  *Threshold - Byte. Граница "размывки" т.е. разницы между двумя
//значениями (пикселями), которые считаются 
//одинаковыми
// Возвращаемое значение:
//  TSymbol
 function FindAndCompareWithTSymbolsArray(Arr: TImageArray; ArrSymbols: TSymbolsArray; Threshold: byte = 1): TSymbol;
 type DoubleArr = array of double;
 Var  i, imax   : word;
      ArrResult : DoubleArr;
      maxRes    : Double;
 Begin
  // получение массива результатов
  SetLength(ArrResult, Length(ArrSymbols));
  for i := 0 to High(ArrSymbols) do begin
    ArrResult[i] := CompareTImageArray(Arr, ArrSymbols[i].img, Threshold);
  end;
  // обработка полученных результатов
  maxRes := MinDouble;
  imax   := 0;
  for i := 0 to High(ArrResult) do
  begin
    if ArrResult[i] > maxRes then
    begin
      maxRes := ArrResult[i];
      imax   := i;
    end;
  end;
  Result     := ArrSymbols[imax];
  Result.hit := maxRes;
 End; // FindAndCompareWithTSymbolsArray();

// Функция строит соответсвие для массива
//символов Arr из массива символов ArrSymbols 
//возвращает массив в соответсвий для Arr
// Параметры:
//  Arr1, Arr2  - TImagesArray. исходный массив и массив
//для поиска (должны соответстовать размеры 
//входящих массивов пикселей)
//  *Threshold - Byte. Граница "размывки" т.е. разницы между двумя
//значениями (пикселями), которые считаются одинаковыми
// Возвращаемое значение:
//  TImagesArray
 function FindMapForTSymbolsArray(Arr: TImagesArray; ArrSymbols: TSymbolsArray; Threshold: byte = 1): TSymbolsArray;
 var i          : word;
     FindSymbol : TSymbol;
 Begin
  aSetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do
  begin
    FindSymbol := FindAndCompareWithTSymbolsArray(Arr[i], ArrSymbols, Threshold);
    Result[i]  := FindSymbol;
  end;
 End; // FindMapForTSymbolsArray();



////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАССИВАМИ ЗАПИСЕЙ ИЗОБРАЖЕНИЙ (TSizeSymbolsArray)
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ
//

//////////////////////////////////////////////////////
// КОНВЕРТАЦИЯ

// Функция создает массив по каждому разамеру TSymbolsSize
//состоящий из TSymbols каждого из передаваемых
//символов в строке
// Параметры:
//  Symbols    - String.  Отрисовываемые символы
//  *Size      - Integer. Размер
//  *FName     - String.  Имя шрифрта
//  *FStyles   - TFontStyles. set of TFontStyle = (fsBold, fsItalic, fsUnderline, fsStrikeOut);
//  *BW        - boolean. Определяет бинаризацию символа
 function CreateTSizeSymbolsArrayFromStr(Symbols: String; Size: Word = 72;
                                          FName: String = 'RoadNumbers'; FStyles: TFontStyles = [];
                                          BW: Boolean = True):
                                          TSizeSymbolsArray;
 Var SizeSymbol   : TSymbolSize;
 Begin
  for SizeSymbol := Low(TSymbolSize) to High(TSymbolSize) do begin
    Result[SizeSymbol] := CreateTSymbolsArrayFromStr(Symbols, Size, FName, FStyles,
                                                     tGetTSymbolSize(SizeSymbol), BW);
  end;
 End; // CreateTSymbolsArrayFromStr();

initialization {Операторы выполняемые один раз при первом обращении к модулю}

finalization {Операторы, выполняемые при любом завершении работы модуля}

end. // ImgLib Unit

