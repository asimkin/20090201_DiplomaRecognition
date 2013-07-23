{*******************************************************}
{                                                       }
{      Image Library for Bachelor Diploma Project       }
{               MSTU n.a. Bauman, ICS-1                 }
{              GNU GPL 2009, Simkin A.V.                }
{                                                       }
{*******************************************************}
{         Library Version 1.0.a from 21.05.2009         }
{*******************************************************}
{   'Variables, Constantes and Types' from 21.06.2009   }
{*******************************************************}
unit ImgLibTypes;
 { Модуль объявления типов, констант и переменных библиотеки }
interface {Открытый интерфейс модуля}

  uses
  ////////////////////////////////////////////////////////////
  // ИСПОЛЬЗУЕМЫЕ ВНЕШНИЕ МОДУЛИ
  //
  Windows, SysUtils; // системные модули

  type
  ////////////////////////////////////////////////////////////
  // ЭКСПОРТИРУЕМЫЕ ТИПЫ
  //
    //////////////////////////////////////////////////////
    // ОБЩИЕ И ОСНОВНЫЕ ТИПЫ
    //// Основыне численные типы ////
    // Основные типы
    TPercent = 0..100;
    // Указатели на основные типы
    PDouble = ^Double;
    //// Типовые и Основные массивы библиотеки ////
    // Типовые массивы
    TDBooleanArray      = array of Boolean;
    TDBoolean2Array     = array of TDBooleanArray;
    TDByteArray         = array of Byte;
    TDWordArray         = array of Word;
    TDWord2Array        = array of TDWordArray;
    TDCardinalArray     = array of Cardinal;
    TDIntegerArray      = array of LongInt;
    TDInteger2Array     = array of TDIntegerArray;
    TDDoubleArray       = array of Double;
    TDDouble2Array      = array of TDDoubleArray;
    TDStringArray       = array of String;
    TDString2Array      = array of TDStringArray;
    // Основные массивы (хранят различную информацию по изображению) //
    TImageArray         = array of TDByteArray;           // "Изображение" или Массив пикселей 8 битового изображения (монохромного)
    TImagesArray        = array of TImageArray;           // Массив изображений или массив массива пикселей
    TLevelsArray        = array[0..MAXBYTE] of Cardinal;  // Массив распределения яркости изображения
    TBrightnessArray    = TDByteArray;                    // Массив значений яркостей изображения
    // Дополнительные массивы для обработки изображений
    TMaskArray          = array[0..4, 0..4] of Smallint; // Массив масски для наложения на изображение

    //// Основные записи библиотеки ////
    // Записи изображений
    TSymbol             = Record //запись символа
      img      : TImageArray; // изображение
      symbol   : Char;        // Соответсвующий символ
      hit      : Double;      // *100%, процент совпавших пикселей
      position : Word;        // позиция символа в оригинальном массиве
    End; // TSymbol
    // Записи параметров областей
    TPointPosition      = Record // Запись двухкоординатной Точки
      i, j: Cardinal // хранит 2 любых значения
    End; // TPointPosition
    TPointParameters    = Record // Запись Параметров точки
      gx,gy : Byte;    // градиент
      p     : Word;    // длина sqrt(gx^2+gy^2)
      fi    : Single;  // угол arctan2(gy,gx)
      mark  : Boolean; // пометка
    End; // TPointParameters
    TPointGradient      = Record // Запись градиента
      x,y   : Word;    // положение
      length: Word;    // длина sqrt(gx^2+gy^2)
      degree: Word;    // угол arctan2(gy,gx) in degree
    End; // TPointGradient
    TMargins = Record // Запись границ какой либо области
        right, buttom, left, top: Word;
    End; // TMargins

    //// Массивы Основных записей ////
    TSymbolsArray       = array of TSymbol;          // Массив содержащий записи символов
    TPointPosArray      = array of TPointPosition;   // Массив координат
    TPointPos2Array     = array of TPointPosArray;   // Массив массива координат
    TPointParArray      = array of TPointParameters; // Массив параметров координат
    TPointPar2Array     = array of TPointParArray;   // Двумерный массив параметров кординат
    TPointGradArray     = array of TPointGradient;   // Массив содержащий записи градиента
    TPointGrad2Array    = array of TPointGradArray;  // Двумерный массив записей градиента

    //////////////////////////////////////////////////////
    // ДОПОЛНИТЕЛЬНЫЕ ТИПЫ
    //// Основные типы работы с массивами ////
    // Перечисляемые типы
    TSymbolType         = (sNumeral, sLetter); // Типы символа - т.е. цифра или буква
    TFindType           = (mLinear, mBinary); // Вариации алгоритма поиска в массиве
    TBWFilterType       = (fBlackMass, fFindMin);  // Типы BW Фильтра
    TSplineType         = (fLinear, fHermite, fCubic, fAkima, fBilinear, fBicubic, fBiakima); // Типы апроксимации
    TSmoothingType      = (fSevenNonLinear, fCubicSpline); // Типы сглаживания массива
    TResizeType         = (fAverageArea, fBilinearSpline, fBicubicSpline, fBiakimaSpline); // Типы фильтрации при изменении размера
    TSuperpositionType  = (mModuloSum, mSum); // Типы наложения/сложения массивов
    TOverlayMaskType    = (mSobel, mGaussuanBlur); // Типы масок наложения

    //////////////////////////////////////////////////////
    // ТИПЫ РАСПОЗНАВАНИЯ
    //// Перечисляемые типы ////
    TSymbolSize         = (s32, s16, s8);         // Перечисление размеров стороны символа (матрицы для распознавания)
    TCountryIndex       = (RUS);                  // Типы индекса страны номера
    TCannyFilterType    = (fSimple, fHysteresis); // Типы фильтрации по Canny
    //// Записи ////
    TCannySetting       = Record // Запись настроек CannyFiltration
      Th: Byte;                        // Общий порог
      case FilterType: TCannyFilterType of
        fSimple    : (
                      );
        fHysteresis: (
                      Th1, Th2: byte;  // Пороги гистерезисной фильтрации, NB! Th1>Th2
                      );
    End; // TCannySetting
    TSmoothSetting      = Record // Запись настроек сглаживания
      Coef  : Word;                              // Дискретизация
      case SmoothType: TSmoothingType of         // Тип сглаживания
        fSevenNonLinear : (
                           CycledFilter: Boolean; // запускать ли фильтр в цикле
                           );
        fCubicSpline    : (
                           Dsc: Double;          // коэффициент сглаживания
                           );
    End; // TSmoothSetting
    TBinarizeSetting    = Record // Запись настроек бинаризации
      MaxThreshold, MinThreshold: Byte;
      case FilterType: TBWFilterType of
        fBlackMass: (
                     PercentMass: TPercent;      // максимальный % "массы" ограничения
                     );
        fFindMin  : (
                     SmoothSett: TSmoothSetting; // Настройки сглаживания гистограммы яркости (TLevelsArray)
                     SplineType: TSplineType;    // Тип сплайна для апроксимации
                     );
    End; // TBinarizeSetting
    TRecognizeSetting   = Record // Запись настроек региона для распознавания номера
      MaxSymbols    : Byte;     // Максимальное количетсво символов в области распознавания
      MinSymbols    : Byte;     // Минимальное количетсво символов в области распознавания
      cfMaxRectangle: Double;   // Максимальное отношение ширины номера к высоте
      cfMinRectangle: Double;   // Минимальное отношение ширины номера к высоте
      cfSymbolWidth : Double;   // Соотношение ширины символа к высоте номера
      cfSymbolHeight: Double;   // Соотношение высоты символа к высоте номера
      cfSymbolSpace : Double;   // Соотношение ширины области пробела к высоте номера
      cfMaxBright   : Double;   // *100%, Значение в % от максимальной яркости удовлетворительной для нахождения максимума
      cfPxMargin    : Double;   // Соотношение высоты номера к длине граничной области (толщина контура)
      ResizeType    : TResizeType; // Тип изменения размера
      CannySetting  : TCannySetting; // Настройки Canny Filtration
      SmoothSetting : TSmoothSetting; // Настройки сглаживания
      BinarSetting  : TBinarizeSetting;
      case CountryIndex: TCountryIndex of // вариантная часть записи
       RUS: ( // код региона (Россия)
             MinSeriesSymbols: Byte; // Минимальное кол. символов в области серии
             MinRegionSymbols: Byte; // Минимальное кол. символов в области региона
             cfSeriesMax: Double;    // Соотношение max ширины области серий к высоте номера
             cfSeriesMin: Double;    // Соотношение min ширины области серий к высоте номера
             cfRegionH: Double;      // Соотношение ширины области региона к высоте номера
             cfRegionW: Double;      // Соотношение высоты области региона к ее ширине
             cfLineW  : Double;      // Соотношение ширины области линии к высоте номера
             );
    End; // TRecognizeSetting
    //// Массивы ////
    TSizeSymbolsArray   = array[TSymbolSize] of TSymbolsArray; // Массив содержащий изображения символов по каждому размеру матрицы
    TCountrySettings    = array[TCountryIndex] of TRecognizeSetting; //массив настроек распознавания по каждой стране

  const
  ////////////////////////////////////////////////////////////
  // ОТКРЫТЫЕ КОНСТАНТЫ МОДУЛЯ
  //
    // Параметры распознавания //
    cAgreeHits          = 0.75; // *100%, Значение, при котором символ считается распознаным
    // Типовые маски //
    cSobelMaskX   : TMaskArray = ((0,0,0,0,0),(0,1,0,-1,0),(0,2,0,-2,0),(0,1,0,-1,0),(0,0,0,0,0));
    cSobelMaskY   : TMaskArray = ((0,0,0,0,0),(0,1,2,1,0),(0,0,0,0,0),(0,-1,-2,-1,0),(0,0,0,0,0));
    cGaussuanBlur : TMaskArray = ((2,4,5,4,2),(4,9,12,9,4),(5,12,15,12,5),(4,9,12,9,4),(2,4,5,4,2));

  Var
  ////////////////////////////////////////////////////////////
  // ОТКРЫТЫЕ ПЕРЕМЕННЫЕ МОДУЛЯ
  //
    // Параметры распознавания //
    CountrySettings: TCountrySettings;

  ////////////////////////////////////////////////////////////
  // ОТКРЫТЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
  //
  //////////////////////////////////////////////////////
  // ПРОЦЕДУРЫ И ФУНКЦИИ ОБРАБОТКИ ТИПОВ
  //// ОБЩИЕ И ОСНОВНЫЕ ТИПЫ ////
  function tRoundToByte(Value: Double): Byte; overload; stdcall;
  function tRoundToByte(Value: Integer): Byte; overload; stdcall;
  function tGetSymbolType(Symbol: Char): TSymbolType; stdcall;
  //// ТИПЫ РАСПОЗНАВАНИЯ ////
  function tGetTSymbolSize(SymbolSize: TSymbolSize): Word; stdcall;

implementation {Реализация модуля}

////////////////////////////////////////////////////////////////////////////////
//// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ НАЧАЛЬНОГО ЗАПОЛНЕНИЯ ДАННЫХ
//

// Процедура заполнения переменной CountrySettings начальными значениями
 procedure FillCountrySettings(); safecall;
 Var RecognizeSetting: TRecognizeSetting;
 Begin
  // RUS //
  with RecognizeSetting do begin
    CountryIndex      := RUS;
    with CannySetting do begin
      FilterType      := fSimple;
      Th              := 100;
    end;
    with SmoothSetting do begin
      SmoothType      := fCubicSpline;
      Coef            := 5;
      Dsc             := 1.0;
    end;
    with BinarSetting do begin
      MaxThreshold    := 185;
      MinThreshold    := 70;
      FilterType      := fBlackMass;
      PercentMass     := 25;
      SmoothSett      := SmoothSetting;
    end;
    MaxSymbols        := 9;
    MinSymbols        := 8;
    cfMaxRectangle    := 5.5;
    cfMinRectangle    := 4.0;
    MinSeriesSymbols  := 5;
    MinRegionSymbols  := 2;
    cfSymbolHeight    := 0.80;
    cfSymbolWidth     := 0.60; // 0.55
    cfSymbolSpace     := 0.20;
    cfSeriesMax       := 4.0;
    cfSeriesMin       := 3.0;
    cfMaxBright       := 0.88;
    cfRegionH         := 0.70;
    cfRegionW         := 2.0;
    cfLineW           := 0.08;
    cfPxMargin        := 0.06;
    ResizeType        := fBilinearSpline;
  end;
  CountrySettings[RUS] := RecognizeSetting;
 End; // FillCountrySettings();



////////////////////////////////////////////////////////////////////////////////
//// ПРОЦЕДУРЫ И ФУНКЦИИ ОБРАБОТКИ ТИПОВ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ОБЩИЕ И ОСНОВНЫЕ ТИПЫ
//

// Функция правильного округление к байту
 function tRoundToByte(Value: Double): Byte;
 Begin
  if Value < 0 then Result := 0
  else if Value > MAXBYTE then Result := MAXBYTE
  else Result := Round(Value);
 End; // tRoundToByte();

// Функция правильного округление к байту
 function tRoundToByte(Value: Integer): Byte;
 Begin
  if Value < 0 then Result := 0
  else if Value > MAXBYTE then Result := MAXBYTE
  else Result := Round(Value);
 End; // tRoundToByte();

// Функция
 function tGetSymbolType(Symbol: Char): TSymbolType;
 const cNumerals = '1234567890';
 Var SymbStr: ShortString;
 Begin
  SymbStr := Symbol + '';
  if Pos(SymbStr, cNumerals) = 0 then Result := sLetter
  else Result := sNumeral;
 End; // tSymbolType();


////////////////////////////////////////////////////////////
// ТИПЫ РАСПОЗНАВАНИЯ
//

// Функция возвращает значение размера для TSymbolSize
// !Функция может работать во втором варианте (см. комментарии)
// Параметры:
//  SymbolSize - Значение перечисляемого типа
// Возвращаемое значение:
//  Word - Значение размера
 function tGetTSymbolSize(SymbolSize: TSymbolSize): Word;
 //var S: String;
 begin
   Result := 0;
   // 1ый вариант работы (более быстрый)
   case SymbolSize of
    s32: Result := 32;
    s16: Result := 16;
    s8 : Result := 8;
   end;
   {// 2ой вариант работы  // требует unit "TypInfo" в uses
   S      := GetEnumName(TypeInfo(TSymbolSize), Ord(SymbolSize));
   Result := StrToInt(Copy(S, 2, Length(S) - 1)); }
 end; // GetTSymbolSize();


initialization {Операторы выполняемые один раз при первом обращении к модулю}

 // заполняем переменную CountrySettings
 FillCountrySettings();

finalization {Операторы, выполняемые при любом завершении работы модуля}

end. // ImgLibTypes
