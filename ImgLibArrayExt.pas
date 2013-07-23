{*******************************************************}
{                                                       }
{      Image Library for Bachelor Diploma Project       }
{               MSTU n.a. Bauman, ICS-1                 }
{              GNU GPL 2009, Simkin A.V.                }
{                                                       }
{*******************************************************}
{         Library Version 1.0.a from 21.05.2009         }
{*******************************************************}
{        'Array Extension Works' from 21.05.2009        }
{*******************************************************}
unit ImgLibArrayExt;
 { Модуль работы с типовыми массивами библиотеки }
interface {Открытый интерфейс модуля}

  uses
  ////////////////////////////////////////////////////////////
  // ИСПОЛЬЗУЕМЫЕ ВНЕШНИЕ МОДУЛИ
  //
  Windows,                              // системные модули
  ImgLibTypes;                          // модули библиотеки IMG LIB

  ////////////////////////////////////////////////////////////
  // ОТКРЫТЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
  //
  //////////////////////////////////////////////////////
  // ОСНОВНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ ОБРАБОТКИ МАССИВОВ
  //// ОСНОВНЫЕ И ПРОСТЕЙШИЕ ОПЕРАЦИИ ////
  // УСТАНОВКА РАЗМЕРА
  procedure aSetLength(var Arr: TImageArray; H, W: Word); overload; stdcall;
  procedure aSetLength(var Arr: TImagesArray; K, H, W: Word); overload; stdcall;
  procedure aSetLength(var Arr: TSymbolsArray; K: Word); overload; stdcall;
  procedure aSetLength(var Arr: TPointPar2Array; H, W: Word); overload; stdcall;
  procedure aSetLength(var Arr: TDDouble2Array; H, W: Word); overload; stdcall;
  // ДОБАВЛЕНИЕ НОВОГО ЗНАЧЕНИЯ
  procedure aAddToArray(var Arr: TDByteArray; New: Word); overload; stdcall;
  procedure aAddToArray(var Arr: TDWordArray; New: Word); overload; stdcall;
  procedure aAddToArray(var Arr: TDCardinalArray; New: Cardinal); overload; stdcall;
  procedure aAddToArray(var Arr: TImagesArray; New: TImageArray); overload; stdcall;
  procedure aAddToArray(var Arr: TSymbolsArray; New: TSymbol); overload; stdcall;
  procedure aAddToArray(var Arr: TPointPosArray; New: TPointPosition); overload; stdcall;
  procedure aAddToArray(var Arr: TPointPos2Array; New: TPointPosArray); overload; stdcall;
  procedure aAddToArray(var Arr: TPointGradArray; New: TPointGradient); overload; stdcall;
  // КОПИРОВАНИЕ ДИНАМИЧЕСКИХ МАССИВОВ
  function aDynamicArrayCopy(const A: TDIntegerArray): TDIntegerArray; overload; stdcall;
  function aDynamicArrayCopy(const A: TDDoubleArray): TDDoubleArray; overload; stdcall;
  function aDynamicArrayCopy(const A: TDBooleanArray): TDBooleanArray; overload; stdcall;
  function aDynamicArrayCopy(const A: TDInteger2Array): TDInteger2Array; overload; stdcall;
  function aDynamicArrayCopy(const A: TDDouble2Array): TDDouble2Array; overload; stdcall;
  function aDynamicArrayCopy(const A: TDBoolean2Array): TDBoolean2Array; overload; stdcall;
  procedure aMoveArrayCopy(const Src: TDInteger2Array; out Dest: TDInteger2Array); overload; stdcall;
  procedure aMoveArrayCopy(const Src: TDBoolean2Array; out Dest: TDBoolean2Array); overload; stdcall;
  procedure aMoveArrayCopy(const Src: TDDouble2Array; out Dest: TDDouble2Array); overload; stdcall;
  // ПРОВЕРКА СОРТИРОВКИ
  function aCheckIncSort(var Arr: TDByteArray): Boolean; stdcall;
  function aCheckDecSort(var Arr: TDByteArray): Boolean; stdcall;
  // СОРТИРОВКА
  procedure aBubbleSort(var data: TDWordArray); overload; stdcall;
  procedure aBubbleSort(var data: TSymbolsArray); overload; stdcall;
  procedure aBubbleSort(var data: TPointPosArray; SortRec: Char = 'i'); overload; stdcall;
  procedure aQuickSort(var data: TDByteArray); overload; stdcall;
  procedure aQuickSort(var data: TDWordArray); overload; stdcall;
  procedure aQuickSort(var data: TDCardinalArray); overload; stdcall;
  // ВЫРЕЗАНИЕ
  function aCrop(const Arr: TImageArray; i0, j0, ik, jk: Smallint; Relative: Boolean = False): TImageArray; stdcall;

  //// ОПЕРАЦИИ ПОИСКА ЗНАЧЕНИЯ ////
  // ЛИНЕЙНЫЙ ПОИСК
  function aLinearFind(Arr: TDByteArray; Value: Byte; out FindIndex: Integer): Boolean; overload; stdcall;
  function aLinearFind(Arr: TPointPosArray; Value: TPointPosition; out FindIndex: Integer): Boolean; overload; stdcall;
  // БИНАРНЫЙ ПОИСК
  function aBinaryFind(Arr: TDByteArray; Value: Byte; out FindIndex: Integer; Precision: Boolean = False): Boolean; overload; stdcall;
  function aBinaryFind(Arr: TDCardinalArray; Value: Cardinal; out FindIndex: Integer; Precision: Boolean = False): Boolean; overload; stdcall;
  // ПОИСК ЗНАЧЕНИЯ
  function aFindInArray(var Arr: TPointPosArray; Value: TPointPosition; out FindIndex: Integer): Boolean; overload; stdcall;
  function aFindInArray(var Arr: TDByteArray; Value: Byte; out FindIndex: Integer; FindType: TFindType = mLinear; Precision: Boolean = False): Boolean; overload; stdcall;
  // ПОИСК ИНДЕКСА ГЛОБАЛЬНОГО МАКСИМУМА
  function aIndexOfMaxValue(const Arr: TDWordArray): Cardinal; overload; stdcall;
  function aIndexOfMaxValue(const Arr: TLevelsArray): Byte; overload; stdcall;
  function aIndexOfMaxValue(const Arr: TDDoubleArray): Word; overload; stdcall;
  function aIndexOfMaxValue(const Arr: TDWord2Array): TPointPosition; overload; stdcall;
  // ПОИСК ЛОКАЛЬНЫХ МИНИМУМОВ И МАКСИМУМОВ
  function aFindLocalsMin(const Arr: TDByteArray; i0: Word = 0; ik: Word = 0): TDWordArray; overload; stdcall;
  function aFindLocalsMax(const Arr: TDByteArray; i0: Word = 0; ik: Word = 0): TDWordArray; overload; stdcall;
  function aFindLocalsMin(const Arr: TDWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray; overload; stdcall;
  function aFindLocalsMax(const Arr: TDWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray; overload; stdcall;
  function aFindLocalsMin(const Arr: TDCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray; overload; stdcall;
  function aFindLocalsMax(const Arr: TDCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray; overload; stdcall;
  function aFindLocalsMin(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TDByteArray; overload; stdcall;
  function aFindLocalsMax(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TDByteArray; overload; stdcall;

  //// РАСШИРЕННЫЕ ОПЕРАЦИИ РАБОТЫ С МАССИВАМИ ////
  // ДОБАВЛЕНИЕ НОВЫХ ЗНАЧЕНИЙ
  procedure aAddFromArray(var Arr1: TPointPosArray; Arr2: TPointPosArray); stdcall;
  // НАЛОЖЕНИЕ/СЛОЖЕНИЕ
  function aSuperposition(var Arr1, Arr2: TImageArray; SuperpositionType: TSuperpositionType = mSum): TImageArray; stdcall;

  //// ОПЕРАЦИИ КОНВЕРТАЦИИ ////
  // КОНВЕРТАЦИЯ В ДРУГОЙ МАССИВ
  function aConvertToArray(var Arr: TImageArray): TDDouble2Array; overload; stdcall;
  function aConvertToArray(var Arr: TDDouble2Array): TImageArray; overload; stdcall;
  function aConvertToArray(var Arr: TSymbolsArray): TImagesArray; overload; stdcall;
  function aConvertToArray(var Arr: TImagesArray): TSymbolsArray; overload; stdcall;
  procedure aConvertToArray(var Arr: TImageArray; out Result: TDDouble2Array); overload; stdcall;
  procedure aConvertToArray(var ArrX, ArrY: TImageArray; out Result: TPointPar2Array); overload; stdcall;
  procedure aConvertToArray(var Arr: TPointParArray; out Result: TDWordArray); overload; stdcall;
  procedure aConvertToArray(var Arr: TBrightnessArray; out Result: TImageArray); overload; stdcall;
  procedure aConvertToArray(var Arr: TDByteArray; out Result: TDDoubleArray); overload; stdcall;
  procedure aConvertToArray(var Arr: TDDoubleArray; out Result: TDByteArray); overload; stdcall;
  procedure aConvertToArray(var Arr: TLevelsArray; out Result: TImageArray; maxLevel: Cardinal = 0); overload; stdcall;
  procedure aConvertToArray(var Arr: TDWord2Array; out Result: TImageArray); overload; stdcall;
  procedure aConvertToArray(var Arr: TLevelsArray; out Result: TDDoubleArray); overload; stdcall;
  procedure aConvertToArray(var Arr: TDDoubleArray; out Result: TLevelsArray); overload; stdcall;
  // КОНВЕРТАЦИЯ В СТРОКУ
  function aConvertToString(var Arr: TImageArray; StepLeft: Shortstring = ' '; StepDown: Shortstring = #13#10): String; stdcall;

  //////////////////////////////////////////////////////
  // ПРОЦЕДУРЫ И ФУНКЦИИ МАТЕМАТИЧЕСКОЙ ОБРАБОТКИ
  //// ФИЛЬТРАЦИЯ ////
  // ПОСТРОЕНИЕ КОЭФФИЦИЕНТОВ СПЛАЙНА
  procedure aBuildSpline(var XArr, YArr: TDDoubleArray; out SplineCoeff: TDDoubleArray; SplineType: TSplineType = fCubic); overload; stdcall;
  procedure aBuildSpline(var XArr, YArr: TDDoubleArray; var FArr: TDDouble2Array; out SplineCoeff: TDDoubleArray; SplineType: TSplineType = fBicubic); overload; stdcall;
  // ВЫЧИСЛЕНИЕ ЗНАЧЕНИЯ СПЛАЙНА В ТОЧКЕ
  function aSplineInterpolation(var SplineCoeff: TDDoubleArray; var Value: Double): Double; stdcall;
  function aSplineInterpolation2D(var SplineCoeff: TDDoubleArray; var ValueX, ValueY: Double): Double; stdcall;
  // НЕЛИНЕЙНЫЙ ФИЛЬТР ПО 7 ТОЧКАМ
  procedure aSevenPointNonLinearSmoothing(var ValueArray: TDDoubleArray; Coef: integer); stdcall;
  // НЕЛИНЕЙНЫЙ ФИЛЬТР КУБИЧЕСКИМИ СПЛАЙНАМИ
  procedure aCubicSplineSmoothing(var ValueArray: TDDoubleArray; Dsc: double; Coef: integer); stdcall;
  // СГЛАЖИВАНИЕ
  procedure aSmoothing(var Arr: TDDoubleArray; Settings: TSmoothSetting; CountryIndex: TCountryIndex = RUS); overload; stdcall;
  procedure aSmoothing(var Arr: TDByteArray; Settings: TSmoothSetting; CountryIndex: TCountryIndex = RUS); overload; stdcall;
  procedure aSmoothing(var Arr: TLevelsArray; Settings: TSmoothSetting; CountryIndex: TCountryIndex = RUS); overload; stdcall;
  // НЕЛИНЕЙНОЕ ПРЕОБРАЗОВАНИЕ
  procedure aLinearTrendExclusion(var Arr: TDDoubleArray); stdcall;

  //// ИНТЕГРАЛЬНЫЕ ПРЕОБРАЗОВАНИЯ ////
  // ФУРЬЕ
  procedure aFourierAnalysis(var ValueArray: TDDoubleArray; NumGarmonics: integer); stdcall;
  // ПЛОЩАТЬ ПОД КРИВОЙ
  function aCalculateAreaOfArray(var arr: TDDoubleArray; i0, ik: integer; Method: byte = 1; BindToZero: boolean = true): Double; stdcall;

  //// ПРЕОБРАЗОВАНИЕ РАЗМЕРНОСТИ/МАСШТАБИРОВАНИЕ ////
  // РАСШИРЕНИЕ ГРАНИЦ
  procedure aIncreaseLength(var Arr: TDDoubleArray; SplitValue: integer); stdcall;
  // УМЕНЬШЕНИЕ ГРАНИЦ
  procedure aDecreaseLength(var Arr: TDDoubleArray; SplitValue: integer); stdcall;
  // РАСШИРЕНИЕ МАССИВА
  function aExpandLength(var Arr: TDDoubleArray; ExpandCoef: integer): TDDoubleArray; stdcall;
  // ИЗМЕНЕНИЕ РАЗМЕРА МЕТОДОМ AverageArea
  function aAverageAreaResize(var Arr: TImageArray; NewH, NewW: Word): TImageArray; overload; stdcall;
  function aAverageAreaResize(var Arr: TDDouble2Array; NewH, NewW: Cardinal): TDDouble2Array; overload; stdcall;
  // ИЗМЕНЕНИЕ РАЗМЕРА
  function aResize(var Arr: TDDouble2Array; newH, newW: Cardinal; ResizeType: TResizeType = fBilinearSpline): TDDouble2Array; overload; stdcall;
  function aResize(var Arr: TImageArray; newH, newW: Word; ResizeType: TResizeType = fBilinearSpline): TImageArray; overload; stdcall;
  function aResize(var Arr: TImagesArray; newH, newW: Word; ResizeType: TResizeType = fBilinearSpline): TImagesArray; overload; stdcall;

  //////////////////////////////////////////////////////
  // ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАТРИЦАМИ
  //// ВЫЧИСЛЕНИЕ LU-РАЗЛОЖЕНИЯ ////
  // ПРЯМОЙ ХОД - U
  procedure aMatrixLUDecomp(var Matrix: TDDouble2Array; out U: TDDouble2Array; out IndexArr: TDIntegerArray; out Sign: Integer); stdcall;
  // ОБРАТНЫЙ ХОД
  procedure aMatrixLUBackSubst(var U: TDDouble2Array; var IndexArr: TDIntegerArray; var Result: TDDoubleArray); stdcall;

  //// РЕШЕНИЕ СЛАУ ////
  // РЕШЕНИЕ ЧЕРЕЗ LU-ПРЕОБРАЗОВАНИЯ
   procedure aMatrixSLAUSolve(var Matrix: TDDouble2Array; var XY: TDDoubleArray; out U: TDDouble2Array); stdcall;

  //// РАБОТА С МАТРИЦАМИ ////
  // ОБРАТНАЯ МАТРИЦА
  procedure aMatrixInverse(var Matrix: TDDouble2Array; out Inverse: TDDouble2Array); stdcall;
  // ОПРЕДЕЛИТЕЛЬ МАТРИЦЫ
  function aMatrixDeterminant(var Matrix: TDDouble2Array): Double; stdcall;
  // УМНОЖЕНИЕ МАТРИЦ
  function aMatrixMultiple(var A,B: TDDouble2Array): TDDouble2Array; stdcall;

implementation {Реализация модуля}

  uses
  ////////////////////////////////////////////////////////////
  // ИСПОЛЬЗУЕМЫЕ ВНЕШНИЕ МОДУЛИ
  //
  SysUtils,                             // системные модули
  Math,                                 // дополнительные модули
  SplineLibLinear, SplineLibBilinear;   // внешние модули построения сплайнов

////////////////////////////////////////////////////////////////////////////////
//// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ДОПОЛНИТЕЛЬНЫЕ ПРОСТЕЙШИЕ ОПЕРАЦИИ
//


 
////////////////////////////////////////////////////////////////////////////////
//// ОСНОВНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ОСНОВНЫЕ И ПРОСТЕЙШИЕ ОПЕРАЦИИ
//

//////////////////////////////////////////////////////
// УСТАНОВКА РАЗМЕРА

// Процедура устаналивает размерность массива TImageArray
 procedure aSetLength(var Arr: TImageArray; H, W: Word);
 var i: Word;
 begin
   SetLength(Arr, H);
   for i := 0 to High(Arr) do SetLength(Arr[i], W);
 end; // aSetLength();

// Процедура устанавливает размерность массива TImagesArray
 procedure aSetLength(var Arr: TImagesArray; K, H, W: Word);
 var i: Word;
 begin
   SetLength(Arr, K);
   for i := 0 to High(Arr) do aSetLength(Arr[i], H, W);
 end; // aSetLength();

// Процедура устанавливает размерность массива TSymbolsArray
 procedure aSetLength(var Arr: TSymbolsArray; K: Word);
 begin
   SetLength(Arr, K);
 end; // aSetLength();

// Процедура устанавливает размерность массива TPointPar2Array
 procedure aSetLength(var Arr: TPointPar2Array; H, W: Word);
 var i: word;
 begin
   SetLength(Arr, H);
   for i := 0 to High(Arr) do SetLength(Arr[i], W);
 end; // aSetLength();

// Процедура устанавливает размерность массива TDDouble2Array
 procedure aSetLength(var Arr: TDDouble2Array; H, W: Word);
 begin
   SetLength(Arr, H, W);
 end; // aSetLength();

//////////////////////////////////////////////////////
// ДОБАВЛЕНИЕ НОВОГО ЗНАЧЕНИЯ

// Процедура добавляет новый элемент в массив TDWordArray (увеличивая его размер)
 procedure aAddToArray(var Arr: TDByteArray; New: Word);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// Процедура добавляет новый элемент в массив TDWordArray (увеличивая его размер)
 procedure aAddToArray(var Arr: TDWordArray; New: Word);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// Процедура добавляет новый элемент в массив TDCardinalArray (увеличивая его размер)
 procedure aAddToArray(var Arr: TDCardinalArray; New: Cardinal);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// Процедура добавляет новый элемент в массив TImagesArray (увеличивая его размер)
 procedure aAddToArray(var Arr: TImagesArray; New: TImageArray);
 begin
  SetLength(Arr, Length(Arr) + 1);
  aSetLength(Arr[High(Arr)], Length(New), Length(New[0]));
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// Процедура добавляет новый элемент в массив TSymbolsArray (увеличивая его размер)
 procedure aAddToArray(var Arr: TSymbolsArray; New: TSymbol);
 begin
  aSetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// Процедура добавляет новый элемент в массив TPointPosArray (увеличивая его размер)
 procedure aAddToArray(var Arr: TPointPosArray; New: TPointPosition);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// Процедура добавляет новый элемент в массив TPointPos2Array (увеличивая его размер)
 procedure aAddToArray(var Arr: TPointPos2Array; New: TPointPosArray);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// Процедура добавляет новый элемент в массив TPointGradArray (увеличивая его размер)
 procedure aAddToArray(var Arr: TPointGradArray; New: TPointGradient);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

//////////////////////////////////////////////////////
// КОПИРОВАНИЕ ДИНАМИЧЕСКИХ МАССИВОВ

// Функция копирования динамического массива
 function aDynamicArrayCopy(const A: TDIntegerArray): TDIntegerArray;
 var I: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do
    Result[I]:=A[I];
 end; // aDynamicArrayCopy();

// Функция копирования динамического массива
 function aDynamicArrayCopy(const A: TDDoubleArray): TDDoubleArray;
 var I: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do
    Result[I]:=A[I];
 end; // aDynamicArrayCopy();

// Функция копирования динамического массива
 function aDynamicArrayCopy(const A: TDBooleanArray): TDBooleanArray;
 var I: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do
    Result[I]:=A[I];
 end; // aDynamicArrayCopy();

// Функция копирования динамического массива
 function aDynamicArrayCopy(const A: TDInteger2Array): TDInteger2Array;
 var I,J: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do begin
    SetLength(Result[I], High(A[I])+1);
    for J:=Low(A[I]) to High(A[I]) do
      Result[I,J]:=A[I,J];
  end;
 end; // aDynamicArrayCopy();

// Функция копирования динамического массива
 function aDynamicArrayCopy(const A: TDDouble2Array): TDDouble2Array;
 var I,J: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do begin
    SetLength(Result[I], High(A[I])+1);
    for J:=Low(A[I]) to High(A[I]) do
      Result[I,J]:=A[I,J];
  end;
 end; // aDynamicArrayCopy();

// Функция копирования динамического массива
 function aDynamicArrayCopy(const A: TDBoolean2Array): TDBoolean2Array;
 var I,J: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do begin
    SetLength(Result[I], High(A[I])+1);
    for J:=Low(A[I]) to High(A[I]) do
      Result[I,J]:=A[I,J];
  end;
 end; // aDynamicArrayCopy();

// Процедура копирования динамического двумерного массива
 procedure aMoveArrayCopy(const Src: TDInteger2Array; out Dest: TDInteger2Array);
 var i,n: integer;
 begin
  n := Length(Src);
  for i := 0 to n - 1 do
    Move(Src[i, 0], Dest[i, 0], n*SizeOf(Double));
 end; // aMoveArrayCopy();

// Процедура копирования динамического двумерного массива
 procedure aMoveArrayCopy(const Src: TDBoolean2Array; out Dest: TDBoolean2Array);
 var i,n: integer;
 begin
  n := Length(Src);
  for i := 0 to n - 1 do
    Move(Src[i, 0], Dest[i, 0], n*SizeOf(Double));
 end; // aMoveArrayCopy();

// Процедура копирования динамического двумерного массива
 procedure aMoveArrayCopy(const Src: TDDouble2Array; out Dest: TDDouble2Array);
 var i,n: integer;
 begin
  n := Length(Src);
  for i := 0 to n - 1 do
    Move(Src[i, 0], Dest[i, 0], n*SizeOf(Double));
 end; // aMoveArrayCopy();

//////////////////////////////////////////////////////
// ПРОВЕРКА СОРТИРОВКИ

 // Проверка монотонного возврастания массива
 function aCheckIncSort(var Arr: TDByteArray): Boolean;
 Var i, h: integer;
 Begin
  i := 0;
  h := High(Arr) - 1;
  while (i < h) and (Arr[i] <= Arr[i+1]) do Inc(i);
  if (i = h) and (Arr[i] <= Arr[i+1]) then Result := True
  else Result := False;
 End; // aCheckIncSort();

 // Проверка монотонного убывания массива
 function aCheckDecSort(var Arr: TDByteArray): Boolean;
 Var i, h: integer;
 Begin
  i := 0;
  h := High(Arr) - 1;
  while (i < h) and (Arr[i] >= Arr[i+1]) do Inc(i);
  if (i = h) and (Arr[i] >= Arr[i+1]) then Result := True
  else Result := False;
 End; // aCheckDecSort()

//////////////////////////////////////////////////////
// СОРТИРОВКА

// Сортировка Пузырьком в массиве TDWordArray
 procedure aBubbleSort(var data: TDWordArray);
 var i, j: Integer;
     tmp : Word;
 begin
 for i := 1 to High(data) do
  for j := 0 to High(data) - i do
    if data[j] < data[j+1] then begin
      tmp       := data[j];
      data[j]   := data[j+1];
      data[j+1] := tmp;
    end;
 end; // aBubbleSort();

// Сортировка Пузырьком в массиве TSymbolsArray
 procedure aBubbleSort(var data: TSymbolsArray);
 var i, j: Integer;
     tmp : TSymbol;
 begin
 for i := 1 to High(data) do
  for j := 0 to High(data) - i do
    if data[j].position > data[j+1].position then begin
      tmp       := data[j];
      data[j]   := data[j+1];
      data[j+1] := tmp;
    end;
 end; // aBubbleSort();

// Сортировка Пузырьком в массиве TPointPosArray
 procedure aBubbleSort(var data: TPointPosArray; SortRec: Char = 'i');
 var i, j: Integer;
     tmp : TPointPosition;
 begin
 case SortRec of
  'i': begin
         for i := 1 to High(data) do
          for j := 0 to High(data) - i do
            if data[j].i > data[j+1].i then
              begin
               tmp       := data[j];
               data[j]   := data[j+1];
               data[j+1] := tmp;
              end;
       end;
  'j': begin
         for i := 1 to High(data) do
          for j := 0 to High(data) - i do
            if data[j].j > data[j+1].j then
              begin
               tmp       := data[j];
               data[j]   := data[j+1];
               data[j+1] := tmp;
              end;
       end;
 end;
end; // aBubbleSort();

// Сортировка алгоритмом QuickSort в массиве TDByteArray
 procedure aQuickSort(var data: TDByteArray);
 // Процедура рекурсии
 procedure QSort(var b: TDByteArray; iLo, iHi: Integer);
 var   Lo, Hi: Integer;
       Mid, t: Byte;
 begin
   Lo := iLo;
   Hi := iHi;
   Mid := b[(Lo + Hi) div 2];
   repeat
     while b[Lo] < Mid do Inc(Lo);
     while b[Hi] > Mid do Dec(Hi);
     if Lo <= Hi then begin
       t     := b[Lo];
       b[Lo] := b[Hi];
       b[Hi] := t;
       Inc(Lo);
       Dec(Hi);
     end;
   until Lo > Hi;
   if Hi > iLo then QSort(b, iLo, Hi);
   if Lo < iHi then QSort(b, Lo, iHi);
 end; // QSort();

 begin
  QSort(data, Low(data), High(data));
 end; // aQuickSort();

// Сортировка алгоритмом QuickSort в массиве TDWordArray
 procedure aQuickSort(var data: TDWordArray);
 // Процедура рекурсии
 procedure QSort(var b: TDWordArray; iLo, iHi: Integer);
 var   Lo, Hi: Integer;
       Mid, t: Word;
 begin
   Lo := iLo;
   Hi := iHi;
   Mid := b[(Lo + Hi) div 2];
   repeat
     while b[Lo] < Mid do Inc(Lo);
     while b[Hi] > Mid do Dec(Hi);
     if Lo <= Hi then begin
       t     := b[Lo];
       b[Lo] := b[Hi];
       b[Hi] := t;
       Inc(Lo);
       Dec(Hi);
     end;
   until Lo > Hi;
   if Hi > iLo then QSort(b, iLo, Hi);
   if Lo < iHi then QSort(b, Lo, iHi);
 end; // QSort();

 begin
  QSort(data, Low(data), High(data));
 end; // aQuickSort();

 // Сортировка алгоритмом QuickSort в массиве TDCardinalArray
 procedure aQuickSort(var data: TDCardinalArray);
 // Процедура рекурсии
 procedure QSort(var b: TDCardinalArray; iLo, iHi: Integer);
 var   Lo, Hi: Integer;
       Mid, t: Cardinal;
 begin
   Lo := iLo;
   Hi := iHi;
   Mid := b[(Lo + Hi) div 2];
   repeat
     while b[Lo] < Mid do Inc(Lo);
     while b[Hi] > Mid do Dec(Hi);
     if Lo <= Hi then begin
       t     := b[Lo];
       b[Lo] := b[Hi];
       b[Hi] := t;
       Inc(Lo);
       Dec(Hi);
     end;
   until Lo > Hi;
   if Hi > iLo then QSort(b, iLo, Hi);
   if Lo < iHi then QSort(b, Lo, iHi);
 end; // QSort();

 begin
  QSort(data, Low(data), High(data));
 end; // aQuickSort();



//////////////////////////////////////////////////////
// ВЫРЕЗАНИЕ

// Функция "выразает" указанную область из массива в новый массив
// Параметры
//  Arr - Исходный массив
//  io,j0,ik,jk - Координаты
//  *Relative - Определяет относительно ли границ вычислять координаты
// Возвращаемое значение
//  TImageArray
 function aCrop(const Arr: TImageArray; i0, j0, ik, jk: Smallint; Relative: Boolean = False): TImageArray;
 Var i, j: Word;
 Begin
  if Relative then begin
    ik := High(Arr) - ik;
    jk := High(Arr[0]) - jk;;
  end;
  aSetLength(Result, ik - i0 + 1, jk - j0 + 1);
  // check boarders
  i0 := ifthen(i0 < 0, 0, i0);
  ik := ifthen(ik > High(Arr), High(Arr), ik);
  j0 := ifthen(j0 < 0, 0, j0);
  jk := ifthen(jk > High(Arr[0]), High(Arr[0]), jk);
  // crop
  for i := i0 to ik do
    for j := j0 to jk do Result[i - i0,j - j0] := Arr[i,j];
 End; // aCrop();


////////////////////////////////////////////////////////////
// ОПЕРАЦИИ ПОИСКА ЗНАЧЕНИЯ
//

//////////////////////////////////////////////////////
// ЛИНЕЙНЫЙ ПОИСК

 // Функция последовательного поиска значения в массиве, методом модифицированного быстрого поиска
 function aLinearFind(Arr: TDByteArray; Value: Byte; out FindIndex: Integer): Boolean;
 Var i: Integer;
 Begin // алгоритм описан в "Д. Кнут. Искусство программирования. Том 3. Раздел 6.1"
  // проверка заполненности массива
  if Length(Arr) = 0 then begin
   Result     := False;
   FindIndex  := -1;
   Exit;
  end;
  // добавляем фиктивное значение
  aAddToArray(Arr, Value);
  // инициализация
  i := -1;
  // проверка 0-го индекса
  if Value = Arr[i+1] then begin
    Inc(i);
    Result    := True;
    FindIndex := i;
    Exit;
  end
  else begin
    // основной цикл поиска
    repeat
      Inc(i, 2);
      if Value = Arr[i] then Break;
      if Value = Arr[i+1] then begin
        Inc(i);
        Break;
      end;
    until (False);
  end;
  // конец массива?
  if i < High(Arr) then begin
    Result    := True;
    FindIndex := i;
  end
  else begin // не найдено
   Result     := False;
   FindIndex  := -1;
  end;
 End; // aLinearFind();

 // Функция последовательного поиска значения в массиве, методом модифицированного быстрого поиска
 function aLinearFind(Arr: TPointPosArray; Value: TPointPosition; out FindIndex: Integer): Boolean;
 Var i: Integer;
 Begin // алгоритм описан в "Д. Кнут. Искусство программирования. Том 3. Раздел 6.1"
  // проверка заполненности массива
  if Length(Arr) = 0 then begin
   Result     := False;
   FindIndex  := -1;
   Exit;
  end;
  // добавляем фиктивное значение
  aAddToArray(Arr, Value);
  // инициализация
  i := -1;
  // проверка 0-го индекса
  if (Value.i = Arr[i+1].i) and (Value.j = Arr[i+1].j) then begin
    Inc(i);
    Result    := True;
    FindIndex := i;
    Exit;
  end
  else begin
    // основной цикл поиска
    repeat
      Inc(i, 2);
      if (Value.i = Arr[i].i) and (Value.j = Arr[i].j) then Break;
      if (Value.i = Arr[i+1].i) and (Value.j = Arr[i+1].j) then begin
        Inc(i);
        Break;
      end;
    until (False);
  end;
  // конец массива?
  if i < High(Arr) then begin
    Result    := True;
    FindIndex := i;
  end
  else begin // не найдено
   Result     := False;
   FindIndex  := -1;
  end;
 End; // aLinearFind();

//////////////////////////////////////////////////////
// БИНАРНЫЙ ПОИСК

 // Функция бинарного поиска значения в массиве TDByteArray
 function aBinaryFind(Arr: TDByteArray; Value: Byte; out FindIndex: Integer; Precision: Boolean = False): Boolean;
 // процедура рекурсивного поиска
 function RecursionFind(L, R: Integer): Boolean;
 var M: Integer;
 begin
  if R < L then begin
    Result    := not Precision;
    FindIndex := ifthen(Precision, -1, L);
    Exit;
  end;
  M := (L + R) div 2;
  if Arr[M] = Value then begin
    Result    := True;
    FindIndex := M;
    Exit;
  end;
  if Arr[M] > Value then Result := RecursionFind(L, M - 1)
  else Result := RecursionFind(M + 1, R);
 end; // RecursionFind();

 Begin
  Result := RecursionFind(Low(Arr), High(Arr));
 End; // aBinaryFind();

 // Функция бинарного поиска значения в массиве TDByteArray
 function aBinaryFind(Arr: TDCardinalArray; Value: Cardinal; out FindIndex: Integer; Precision: Boolean = False): Boolean;
 // процедура рекурсивного поиска
 function RecursionFind(L, R: Integer): Boolean;
 var M: Integer;
 begin
  if R < L then begin
    Result    := not Precision;
    FindIndex := ifthen(Precision, -1, L);
    Exit;
  end;
  M := (L + R) div 2;
  if Arr[M] = Value then begin
    Result    := True;
    FindIndex := M;
    Exit;
  end;
  if Arr[M] > Value then Result := RecursionFind(L, M - 1)
  else Result := RecursionFind(M + 1, R);
 end; // RecursionFind();

 Begin
  Result := RecursionFind(Low(Arr), High(Arr));
 End; // aBinaryFind();

//////////////////////////////////////////////////////
// ПОИСК ЗНАЧЕНИЯ

// Функция поиска значения в массиве TPointPosArray
 function aFindInArray(var Arr: TPointPosArray; Value: TPointPosition; out FindIndex: Integer): Boolean;
 Begin
  // just linear find
  Result := aLinearFind(Arr, Value, FindIndex);
 End; // aFindInArray();

// Функция поиска значения в массиве TDByteArray
 function aFindInArray(var Arr: TDByteArray; Value: Byte; out FindIndex: Integer; FindType: TFindType = mLinear; Precision: Boolean = False): Boolean;
 begin
  if FindType = mLinear then Result := aLinearFind(Arr, Value, FindIndex)
  else if FindType = mBinary then Result := aBinaryFind(Arr, Value, FindIndex, Precision)
  else begin // если значение не определено
    if aCheckIncSort(Arr) or aCheckDecSort(Arr)
      then Result := aBinaryFind(Arr, Value, FindIndex, Precision)
    else Result := aLinearFind(Arr, Value, FindIndex);
  end;
 end; // aFindInArray();

//////////////////////////////////////////////////////
// ПОИСК ИНДЕКСА ГЛОБАЛЬНОГО МАКСИМУМА

// Нахождение индекса максимального значения TDWordArray
 function aIndexOfMaxValue(const Arr: TDWordArray): Cardinal;
 var i, imax : Word;
     maxValue: Cardinal;
 begin
  imax     := 0;
  maxValue := 0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 end; // aIndexOfMaxValue();

// Нахождение индекса максимального значения TLevelsArray
 function aIndexOfMaxValue(const Arr: TLevelsArray): Byte;
 var i, imax: Byte;
     maxValue: Cardinal;
 Begin
  imax     := 0;
  maxValue := 0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 End; // aIndexOfMaxValue();

// Нахождение индекса максимального значения TDDoubleArray
 function aIndexOfMaxValue(const Arr: TDDoubleArray): Word;
 var i, imax: integer;
     maxValue: double;
 Begin
  imax     := 0;
  maxValue := 0.0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 End; // aIndexOfMaxValue();

// Нахождение индекса максимального значения TDWord2Array
 function aIndexOfMaxValue(const Arr: TDWord2Array): TPointPosition;
 var i, j: integer;
     maxValue: Word;
 Begin
  maxValue := 0;
  for i := 0 to High(Arr) do
    for j := 0 to High(Arr[i]) do
      if maxValue < Arr[i,j] then begin
       maxValue := Arr[i,j];
       result.i := i;
       result.j := j;
      end;
 End; // aIndexOfMaxValue();

//////////////////////////////////////////////////////
// ПОИСК ЛОКАЛЬНЫХ МИНИМУМОВ И МАКСИМУМОВ

// Нахождение локальных минимумов в массиве TDByteArray
 function aFindLocalsMin(const Arr: TDByteArray; i0: Word = 0; ik: Word = 0): TDWordArray;
 Var i, iMin                : word;
     DecFlag, IncFlag, first: Boolean;
 // проверка счетчика
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMin     := i0;
  first    := True;
  DecFlag  := False;
  repeat
    IncFlag  := False;
    // цикл убывания
    while (Arr[i-1] > Arr[i])and(not CheckInc()) do begin
      iMin := i;
      Inc(i);
      IncFlag := True;
      //if CheckInc() then Break;
    end;
    if IncFlag then begin
      // вышли из цикла убывания
      aAddToArray(Result, iMin);
    end;
    if CheckInc() then Break;
    // цикл возрастания
    while (Arr[i-1] <= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not IncFlag then DecFlag := True;
    end;
    if first and DecFlag then begin
      aAddToArray(Result, iMin);
      first   := False;
      DecFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMin();

// Нахождение локальных максимумов в массиве TDByteArray
 function aFindLocalsMax(const Arr: TDByteArray; i0: Word = 0; ik: Word = 0): TDWordArray;
 var i, iMax                : Word;
     DecFlag, IncFlag, first: Boolean;
 // проверка счетчика
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMax     := i0;
  first   := True;
  IncFlag := False;
  repeat
    DecFlag  := False;
    // цикл возрастания
    while (Arr[i-1] < Arr[i])and(not CheckInc()) do begin
      iMax := i;
      Inc(i);
      DecFlag := True;
    end;
    if DecFlag then begin
      // вышли из цикла убывания
      aAddToArray(Result, iMax);
    end;
    if CheckInc() then Break;
    // цикл убывания
    while (Arr[i-1] >= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not DecFlag then IncFlag := True;
    end;
    if first and IncFlag then begin
     aAddToArray(Result, iMax);
     first   := False;
     IncFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMax();

// Нахождение локальных минимумов в массиве TDByteArray
 function aFindLocalsMin(const Arr: TDWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray;
 Var i, iMin                : Cardinal;
     DecFlag, IncFlag, first: Boolean;
 // проверка счетчика
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMin     := i0;
  first    := True;
  DecFlag  := False;
  repeat
    IncFlag  := False;
    // цикл убывания
    while (Arr[i-1] > Arr[i])and(not CheckInc()) do begin
      iMin := i;
      Inc(i);
      IncFlag := True;
    end;
    if IncFlag then begin
      // вышли из цикла убывания
      aAddToArray(Result, iMin);
    end;
    if CheckInc() then Break;
    // цикл возрастания
    while (Arr[i-1] <= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not IncFlag then DecFlag := True;
    end;
    if first and DecFlag then begin
      aAddToArray(Result, iMin);
      first   := False;
      DecFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMin();

// Нахождение локальных максимумов в массиве TDByteArray
 function aFindLocalsMax(const Arr: TDWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray;
 var i, iMax                : Cardinal;
     DecFlag, IncFlag, first: Boolean;
 // проверка счетчика
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMax     := i0;
  first    := True;
  IncFlag  := False;
  repeat
    DecFlag  := False;
    // цикл возрастания
    while (Arr[i-1] < Arr[i])and(not CheckInc()) do begin
      iMax := i;
      Inc(i);
      DecFlag := True;
    end;
    if DecFlag then begin
      // вышли из цикла убывания
      aAddToArray(Result, iMax);
    end;
    if CheckInc() then Break;
    // цикл убывания
    while (Arr[i-1] >= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not DecFlag then IncFlag := True;
    end;
    if first and IncFlag then begin
     aAddToArray(Result, iMax);
     first   := False;
     IncFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMax();

// Нахождение локальных минимумов в массиве TDCardinalArray
 function aFindLocalsMin(const Arr: TDCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray;
 Var i, iMin                : Cardinal;
     DecFlag, IncFlag, first: Boolean;
 // проверка счетчика
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMin     := i0;
  first    := True;
  DecFlag  := False;
  repeat
    IncFlag  := False;
    // цикл убывания
    while (Arr[i-1] > Arr[i])and(not CheckInc()) do begin
      iMin := i;
      Inc(i);
      IncFlag := True;
    end;
    if IncFlag then begin
      // вышли из цикла убывания
      aAddToArray(Result, iMin);
    end;
    if CheckInc() then Break;
    // цикл возрастания
    while (Arr[i-1] <= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not IncFlag then DecFlag := True;
    end;
    if first and DecFlag then begin
      aAddToArray(Result, iMin);
      first   := False;
      DecFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMin();

// Нахождение локальных максимумов в массиве TDCardinalArray
 function aFindLocalsMax(const Arr: TDCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray;
 var i, iMax                : Cardinal;
     DecFlag, IncFlag, first: Boolean;
 // проверка счетчика
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMax     := i0;
  first    := True;
  IncFlag  := False;
  repeat
    DecFlag  := False;
    // цикл возрастания
    while (Arr[i-1] < Arr[i])and(not CheckInc()) do begin
      iMax := i;
      Inc(i);
      DecFlag := True;
    end;
    if DecFlag then begin
      // вышли из цикла убывания
      aAddToArray(Result, iMax);
    end;
    if CheckInc() then Break;
    // цикл убывания
    while (Arr[i-1] >= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not DecFlag then IncFlag := True;
    end;
    if first and IncFlag then begin
      aAddToArray(Result, iMax);
      first   := False;
      IncFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMax();

// Нахождение локальных минимумов в массиве TLevelsArray
 function aFindLocalsMin(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TDByteArray;
 Var i, iMin                : Word;
     DecFlag, IncFlag, first: Boolean;
 // проверка счетчика
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMin     := i0;
  first    := True;
  DecFlag  := False;
  repeat
    IncFlag  := False;
    // цикл убывания
    while (Arr[i-1] > Arr[i])and(not CheckInc()) do begin
      iMin := i;
      Inc(i);
      IncFlag := True;
      //if CheckInc() then Break;
    end;
    if IncFlag then begin
      // вышли из цикла убывания
      aAddToArray(Result, iMin);
    end;
    if CheckInc() then Break;
    // цикл возрастания
    while (Arr[i-1] <= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not IncFlag then DecFlag := True;
    end;
    if first and DecFlag then begin
      aAddToArray(Result, iMin);
      first   := False;
      DecFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMin();

// Нахождение локальных максимумов в массиве TLevelsArray
 function aFindLocalsMax(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TDByteArray;
 var i, iMax                : Word;
     DecFlag, IncFlag, first: Boolean;
 // проверка счетчика
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i       := i0 + 1;
  iMax    := i0;
  first   := True;
  IncFlag := False;
  repeat
    DecFlag  := False;
    // цикл возрастания
    while (Arr[i-1] < Arr[i])and(not CheckInc()) do begin
      iMax := i;
      Inc(i);
      DecFlag := True;
    end;
    if DecFlag then begin
      // вышли из цикла убывания
      aAddToArray(Result, iMax);
    end;
    if CheckInc() then Break;
    // цикл убывания
    while (Arr[i-1] >= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not DecFlag then IncFlag := True;
    end;
    if first and IncFlag then begin
      aAddToArray(Result, iMax);
      first   := False;
      IncFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMax();


////////////////////////////////////////////////////////////
// РАСШИРЕННЫЕ ОПЕРАЦИИ РАБОТЫ С МАССИВАМИ
//

//////////////////////////////////////////////////////
// ДОБАВЛЕНИЕ НОВЫХ ЗНАЧЕНИЙ

// Процедура добавления(копирования) значений из одного массива в другой исключая имеющиеся
 procedure aAddFromArray(var Arr1: TPointPosArray; Arr2: TPointPosArray);
 Var i: Cardinal;
     index: integer;
 Begin
  for i := 0 to High(Arr2) do begin
    if aFindInArray(Arr1, Arr2[i], index) then Continue;
    aAddToArray(Arr1, Arr2[i]);
  end;
 End; // aAddFromArray();

//////////////////////////////////////////////////////
// НАЛОЖЕНИЕ/СЛОЖЕНИЕ

 function aSuperposition(var Arr1, Arr2: TImageArray; SuperpositionType: TSuperpositionType = mSum): TImageArray;
 var i,j: Word;
 // вычисление значения
 function Superpos: Byte;
 begin
  case SuperpositionType of
    mModuloSum : Result := tRoundToByte(abs(Arr1[i,j])+abs(Arr2[i,j]));
    mSum       : Result := tRoundToByte(Arr1[i,j]+Arr2[i,j]);
  else Result := 0;
  end;
 end;

 Begin
  if (Length(Arr1)<>Length(Arr2))or(Length(Arr1[0])<>Length(Arr2[0])) then Exit;
  aSetLength(Result, Length(Arr1), Length(Arr1[0]));
  for i := 0 to High(Arr1) do
    for j := 0 to High(Arr1[i]) do
      Result[i,j] := Superpos;
 End; // aSuperposition();


////////////////////////////////////////////////////////////
// ОПЕРАЦИИ КОНВЕРТАЦИИ
//

//////////////////////////////////////////////////////
// КОНВЕРТАЦИЯ В ДРУГОЙ МАССИВ

// Функция конвертации TImageArray в TDDouble2Array
 function aConvertToArray(var Arr: TImageArray): TDDouble2Array;
 var i, j: Cardinal;
 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]));
  for i := 0 to High(Arr) do
    for j := 0 to High(Arr[i]) do
      Result[i,j] := Arr[i,j];
 End; // aConvertToArray();

// Функция конвертации TDDouble2Array в TImageArray
 function aConvertToArray(var Arr: TDDouble2Array): TImageArray;
 var i, j: Cardinal;
 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]));
  for i := 0 to High(Arr) do
    for j := 0 to High(Arr[i]) do
      Result[i,j] := tRoundToByte(Arr[i,j]);
 End; // aConvertToArray();

// Функция конвертации TSymbolsArray в TImagesArray
 function aConvertToArray(var Arr: TSymbolsArray): TImagesArray;
 var i: Cardinal;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do Result[i] := Arr[i].img;
 End; // aConvertToArray();

// Функция конвертации TImagesArray в TSymbolsArray
 function aConvertToArray(var Arr: TImagesArray): TSymbolsArray;
 var i: Cardinal;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do Result[i].img := Arr[i];
 End; // aConvertToArray();

// Процедура конвертации TImageArray в TDDouble2Array
 procedure aConvertToArray(var Arr: TImageArray; out Result: TDDouble2Array);
 var i, j: Cardinal;
 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]));
  for i := 0 to High(Arr) do
    for j := 0 to High(Arr[i]) do
      Result[i,j] := Arr[i,j];
 End; // aConvertToArray();

// Процедура конвертации массивов производных TImageArray в TPointPar2Array
 procedure aConvertToArray(var ArrX, ArrY: TImageArray; out Result: TPointPar2Array);
 var i,j : word;
 Begin
  if (length(ArrX)<>length(ArrY))or(length(ArrX[0])<>length(ArrY[0])) then Exit;
  aSetLength(Result, length(ArrX), length(ArrX[0]));
  for i := 0 to High(ArrX) do
    for j := 0 to High(ArrX[0]) do begin
      Result[i,j].gx    := ArrX[i,j];
      Result[i,j].gy    := ArrY[i,j];
      Result[i,j].p     := Abs(ArrX[i,j]) + Abs(ArrY[i,j]);
      Result[i,j].fi    := ArcTan2(ArrY[i,j], ArrX[i,j]);
      Result[i,j].mark  := False;
    end;
 End; // aConvertToArray();

// Процедура конвертации массивов производных TPointParArray в TDWordArray
 procedure aConvertToArray(var Arr: TPointParArray; out Result: TDWordArray);
 var i: word;
 Begin
  SetLength(Result, length(Arr));
  for i := 0 to High(Arr) do begin
    Result[i] := Arr[i].p;
  end;
 End; // aConvertToArray();

// Процедура конвертации массива TBrightnessArray в TImageArray
 procedure aConvertToArray(var Arr: TBrightnessArray; out Result: TImageArray);
 var i,j: word;
 Begin
  aSetLength(Result, MAXBYTE + 1, Length(Arr));
  for i := 0 to High(Arr) do begin
    for j := MAXBYTE downto 0 do begin
      if j <= Arr[i] then Result[j,i] := MAXBYTE
      else Result[j,i] := 0;
    end;
  end;
 End; // aConvertToArray();

// Процедура конвертации TDByteArray в TDDoubleArray
 procedure aConvertToArray(var Arr: TDByteArray; out Result: TDDoubleArray);
 var i: Cardinal;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do
    Result[i] := Arr[i];
 End; // aConvertToArray();

// Процедура конвертации TDDoubleArray в TDByteArray
 procedure aConvertToArray(var Arr: TDDoubleArray; out Result: TDByteArray);
 var i: Cardinal;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do
    Result[i] := tRoundToByte(Arr[i]);
 End; // aConvertToArray();

// Процедура конвертации TLevelsArray в TImageArray
 procedure aConvertToArray(var Arr: TLevelsArray; out Result: TImageArray; maxLevel: Cardinal = 0);
 var i: byte;
     j: cardinal;
 Begin
  if maxLevel = 0 then begin
    maxLevel := Arr[aIndexOfMaxValue(Arr)];
    if      maxLevel > 5000 then maxLevel := round(maxLevel/10)
    else if maxLevel > 2000 then maxLevel := round(maxLevel/5)
    else if maxLevel > 800  then maxLevel := round(maxLevel/2);
    //else if maxLevel > MAXBYTE then maxLevel := MAXBYTE;
  end;
  aSetLength(Result, maxLevel + 1, MAXBYTE + 1);
  for i := 0 to MAXBYTE do
    for j := maxLevel downto 0 do begin
      if maxLevel - j < Arr[i] then Result[j,i] := 0
      else Result[j,i] := MAXBYTE;
    end;
 End; // aConvertToArray();

// Процедура конвертации TDWord2Array в TImageArray
 procedure aConvertToArray(var Arr: TDWord2Array; out Result: TImageArray);
 var i, j, maxValue, right, buttom: Word;
 Begin
  maxValue := Arr[aIndexOfMaxValue(Arr).i, aIndexOfMaxValue(Arr).j];
  right := 0; buttom := 0;
  for i := 0 to High(Arr) do
    for j := 0 to High(Arr) do
      if Arr[i,j] > 0 then begin
        if right < j then right := j;
        if buttom < i then buttom := i;
      end;
  aSetLength(Result, buttom + 1, right + 1);
  for i := 0 to buttom do
    for j := 0 to right do
      Result[i,j] := tRoundToByte(MAXBYTE*(1 - Arr[i,j]/maxValue));
 End; // aConvertToArray();

// Процедура конвертации TLevelsArray в TDDoubleArray
 procedure aConvertToArray(var Arr: TLevelsArray; out Result: TDDoubleArray);
 var i: byte;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to MAXBYTE do
    Result[i] := Arr[i];
 End; // aConvertToArray();

// Процедура конвертации TDDoubleArray в TLevelsArray
 procedure aConvertToArray(var Arr: TDDoubleArray; out Result: TLevelsArray);
 var i: byte;
 Begin
  for i := 0 to MAXBYTE do
    Result[i] := abs(round(Arr[i]));
 End; // aConvertToArray();

//////////////////////////////////////////////////////
// КОНВЕРТАЦИЯ В СТРОКУ

// Функция для конвертации TImageArray в String
 function aConvertToString(var Arr: TImageArray; StepLeft: Shortstring = ' '; StepDown: Shortstring = #13#10): String;
 var i,j       : Cardinal;
     tmpString : String;
     addSym    : Shortstring;
 Begin
  for i := 0 to High(Arr) do Begin
    tmpString := '';
    for j := 0 to High(Arr[i]) do tmpString := tmpString + StepLeft + IntToStr(Arr[i,j]);
    if i <> 0 then addSym := StepDown
    else addSym := '';
    Result := Result + addSym + Trim(tmpString);
  End;
 End; // aConvertToString()

//////////////////////////////////////////////////////
// РАЗНОЕ



////////////////////////////////////////////////////////////////////////////////
//// ПРОЦЕДУРЫ И ФУНКЦИИ МАТЕМАТИЧЕСКОЙ ОБРАБОТКИ
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ФИЛЬТРАЦИЯ
//

//////////////////////////////////////////////////////
// ПОСТРОЕНИЕ КОЭФФИЦИЕНТОВ СПЛАЙНА

// Процедура построения коэффициентов одномерного сплайна
// Параметры:
//  XArr, YArr - Сетка и Значения в точках сетки
//  @SplineCoeff - Вычисленные коэффициенты
//  *SplineType - Тип коэффициентов вычисляемого сплайна
 procedure aBuildSpline(var XArr, YArr: TDDoubleArray; out SplineCoeff: TDDoubleArray; SplineType: TSplineType = fCubic);
 Var DiscPointsLength: Integer;
 Begin
  SetLength(SplineCoeff, 0);
  DiscPointsLength := Length(XArr);
  // проверка ограничения на данные
  if (SplineType = fAkima) and (DiscPointsLength < 5) then SplineType := fCubic;
  // определение коэффициентов сплайна
  case SplineType of
    fLinear : begin
                BuildLinearSpline(XArr, YArr, DiscPointsLength, SplineCoeff);
              end;
    fHermite: begin
                // не работает для данной обработки
                Exit;
              end;
    fCubic  : begin
                BuildCubicSpline(XArr, YArr, DiscPointsLength, 0, 0.0, 0, 0.0, SplineCoeff);
              end;
    fAkima  : begin
                BuildAkimaSpline(XArr, YArr, DiscPointsLength, SplineCoeff);
              end;
  else Exit;
  end;
 End; // aBuildSpline();

// Процедура построения коэффициентов двумерного сплайна
// Параметры:
//  XArr, YArr - Сетка по осям
//  FArr - Значения в сетке
//  @SplineCoeff - Вычисленные коэффициенты
//  *SplineType - Тип коэффициентов вычисляемого сплайна
 procedure aBuildSpline(var XArr, YArr: TDDoubleArray; var FArr: TDDouble2Array; out SplineCoeff: TDDoubleArray; SplineType: TSplineType = fBicubic);
 Begin
  SetLength(SplineCoeff, 0);
  // определение коэффициентов сплайна
  case SplineType of
    fBilinear : begin
                  BuildBilinearSpline(XArr, YArr,FArr, Length(YArr), Length(XArr), SplineCoeff);
                end;
    fBicubic  : begin
                  BuildBicubicSpline(XArr, YArr,FArr, Length(YArr), Length(XArr), SplineCoeff);
                end;
  else Exit;
  end;
 End; // aBuildSpline();

//////////////////////////////////////////////////////
// ВЫЧИСЛЕНИЕ ЗНАЧЕНИЯ СПЛАЙНА В ТОЧКЕ

// Функция вычисления значения в точке одномерного сплайна
// Параметры:
//  SplineCoeff - Вычесленные коэффициенты сплайна
//  Value - точка вычисления
// Возвращаемое значение:
//  Double
 function aSplineInterpolation(var SplineCoeff: TDDoubleArray; var Value: Double): Double;
 Begin
  Result := SplineInterpolation(SplineCoeff, Value);
 End; // aSplineInterpolation();

// Функция вычисления значения в точке двумерного сплайна
// Параметры:
//  SplineCoeff - Вычесленные коэффициенты сплайна
//  ValueX, ValueY - точка вычисления
// Возвращаемое значение:
//  Double
 function aSplineInterpolation2D(var SplineCoeff: TDDoubleArray; var ValueX, ValueY: Double): Double;
 Begin
  Result := SplineInterpolation2D(SplineCoeff, ValueX, ValueY);
 End; // aSplineInterpolation();

//////////////////////////////////////////////////////
// НЕЛИНЕЙНЫЙ ФИЛЬТР ПО 7 ТОЧКАМ

// Процедура нелинейного фильтра по 7 точкам для сглаживания значений массива
// Параметры:
//  ValueArray - обрабатываемый массив
//  Coef       - Дискретизация
//***Инфо***
//Автор:       lookin, lookin@mail.ru, Екатеринбург, 30 апреля 2002 г.
//Доработано:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aSevenPointNonLinearSmoothing(var ValueArray: TDDoubleArray; Coef: integer);
 var j, k, i : integer;
     resv    : array of array of double;
 Begin
  // получение коэффициента сглаживания
  if (Coef = 0) or (Coef = 1) then Exit;
  SetLength(resv, Coef, (Length(ValueArray) div Coef));
  for j := 0 to Coef - 1 do
    for i := 0 to Length(resv[0]) - 1 do
      resv[j][i] := ValueArray[i*Coef + j];
  // вычисление коэффициентов
  for k := 0 to Coef - 1 do
    for j := 0 to Length(resv[0]) - 1 do begin
      if j = 0 then
        resv[k][j] := (39*ValueArray[j*Coef + k] + 8*ValueArray[(j + 1)*Coef + k] -
          4*(ValueArray[(j + 2) * Coef + k] + ValueArray[(j + 3)*Coef + k] - ValueArray[(j + 4) * Coef + k]) +
          ValueArray[(j + 5)*Coef + k] - 2*ValueArray[(j + 6)*Coef + k])/42;
      if j = 1 then
        resv[k][j] := (8*ValueArray[j*Coef + k] +
          19*ValueArray[(j + 1)*Coef + k] + 16*ValueArray[(j + 2)*Coef + k] +
          6*ValueArray[(j + 3)*Coef + k] - 4*ValueArray[(j + 4)*Coef + k] -
          7*ValueArray[(j + 5)*Coef + k] + 4*ValueArray[(j + 6)*Coef + k])/42;
      if j = 2 then
        resv[k][j] := (-4*ValueArray[j*Coef + k] +
          16*ValueArray[(j + 1)*Coef + k] + 19*ValueArray[(j + 2)*Coef + k] +
          12*ValueArray[(j + 3)*Coef + k] + 2*ValueArray[(j + 4)*Coef + k] -
          4*ValueArray[(j + 5)*Coef + k] + ValueArray[(j + 6)*Coef + k])/42;
      if (j > 2) and (j < Length(resv[0]) - 3) then
        resv[k][j] := (7*ValueArray[j*Coef + k] +
        6*(ValueArray[(j - 1)*Coef + k] + ValueArray[(j + 1)*Coef + k]) +
        3*(ValueArray[(j - 2)*Coef + k] + ValueArray[(j + 2)*Coef + k]) -
        2*(ValueArray[(j - 3)*Coef + k] + ValueArray[(j + 3)*Coef + k]))/21;
      if j = Length(resv[0]) - 3 then
        resv[k][j] := (-4*ValueArray[j*Coef + k] +
          16*ValueArray[(j - 1)*Coef + k] + 19*ValueArray[(j - 2)*Coef + k] +
          12*ValueArray[(j - 3)*Coef + k] + 2*ValueArray[(j - 4)*Coef + k] -
          4*ValueArray[(j - 5)*Coef + k] + ValueArray[(j - 6)*Coef + k])/42;
      if j = Length(resv[0]) - 2 then
        resv[k][j] := (8*ValueArray[j*Coef + k] +
          19*ValueArray[(j - 1)*Coef + k] + 16*ValueArray[(j - 2)*Coef + k] +
          6*ValueArray[(j - 3)*Coef + k] - 4*ValueArray[(j - 4)*Coef + k] -
          7*ValueArray[(j - 5)*Coef + k] + 4*ValueArray[(j - 6)*Coef + k])/42;
      if j = Length(resv[0]) - 1 then
        resv[k][j] := (39*ValueArray[j*Coef + k] +
          8*ValueArray[(j - 1)*Coef + k] - 4*ValueArray[(j - 2)*Coef + k] -
          4*ValueArray[(j - 3)*Coef + k] - 4*ValueArray[(j - 4)*Coef + k] +
          ValueArray[(j - 5)*Coef + k] - 2*ValueArray[(j - 6)*Coef + k])/42;
    end;
  // фильтрация
  for j := Coef to Length(resv[0]) - Coef do
    for k := 0 to Coef - 1 do
      ValueArray[j*Coef + k] := resv[k][j];
 End; // SevenPointNonLinearSmoothing();

//////////////////////////////////////////////////////
// НЕЛИНЕЙНЫЙ ФИЛЬТР КУБИЧЕСКИМИ СПЛАЙНАМИ

// Процедура нелинейного фильтра кубическими сплайнами для сглаживания значений массива
// Параметры:
//  ValueArray  - обрабатываемый массив
//  Dsc         - коэффициент сглаживания
//  Coef        - Дискретизация
//Dsc*Coef - шаг фильтрации
//***Инфо***
//Автор:       lookin, lookin@mail.ru, Екатеринбург, 30 апреля 2002 г.
//Доработано:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aCubicSplineSmoothing(var ValueArray: TDDoubleArray; Dsc: double; Coef: integer);
 var j, k, i, N : integer;
     resv       : TDDouble2Array;
     av, h, mi, mj, v1, v2: double;
 begin
  if (Coef = 0) or (Coef = 1) then Exit;
  N := Length(ValueArray);
  SetLength(resv, Coef, N);
  h := Coef*Dsc;
  mi := 0.0; mj := 0.0;
  // вычисление коэфф.
  for k := 0 to Coef - 1 do
    for j := 0 to (N div Coef) - 2 do begin
      if j = 0 then begin
        mi := (4*ValueArray[(j + 1)*Coef + k] - ValueArray[(j + 2)*Coef + k] - 3*ValueArray[j*Coef + k])/2;
        mj := (ValueArray[(j + 2)*Coef + k] - ValueArray[j*Coef + k])/2;
      end;
      if j = (N div Coef) - 2 then begin
        mi := (ValueArray[(j + 1)*Coef + k] - ValueArray[(j - 1)*Coef + k])/2;
        mj := (3*ValueArray[(j + 1)*Coef + k] + ValueArray[(j - 1)*Coef + k] - 4*ValueArray[j*Coef + k])/2;
      end;
      if (j > 0) and (j < ((N div Coef) - 2)) then begin
        mi := (ValueArray[(j + 1)*Coef + k] - ValueArray[(j - 1)*Coef + k])/2;
        mj := (ValueArray[(j + 2)*Coef + k] - ValueArray[j*Coef + k])/2;
      end;
      for i := j*Coef to (j + 1)*Coef do begin
        v1 := ((j + 1)*Coef + k)*Dsc - (i + k)*Dsc;
        v2 := (i + k)*Dsc - (j*Coef + k)*Dsc;
        resv[k][i + k] := (Sqr(v1)*(2*v2 + h)*ValueArray[j*Coef + k] +
          Sqr(v2)*(2*v1 + h)*ValueArray[(j + 1)*Coef + k] + (Sqr(v1)*v2*mi + Sqr(v2)*(-v1)*mj)/2)/h/h/h;
      end;
    end;
  // фильтрация
  for j := Coef to N - 1 - Coef do begin
    av := 0;
    for k := 0 to Coef - 1 do av := av + resv[k][j];
    av := av/Coef;
    ValueArray[j] := av;
  end;
end; // CubicSplineSmoothing();

//////////////////////////////////////////////////////
// СГЛАЖИВАНИЕ

// Процедура фильтрации массива TDDoubleArray в зависимости от параметров
// Параметры:
//  Arr - Обрабатываемый массив
//  *Settings - настройки сглаживания
//  *CountryIndex - настройки региона для распознавания номера
 procedure aSmoothing(var Arr: TDDoubleArray; Settings: TSmoothSetting; CountryIndex: TCountryIndex = RUS);
                    //  Coef: Word; SmoothType: TSmoothingType = fCubicSpline;
                    //  Dsc: Double = 1.0; CycledFilter: Boolean = false);
 Var j: Word;
 Begin
  if (Settings.SmoothType <> fSevenNonLinear) and (Settings.SmoothType <> fCubicSpline) then
    Settings := CountrySettings[CountryIndex].SmoothSetting;
  case Settings.SmoothType of
    fSevenNonLinear: begin
                      if Settings.CycledFilter then
                       for j := 2 to Settings.Coef do
                         aSevenPointNonLinearSmoothing(Arr, j)
                       else
                         aSevenPointNonLinearSmoothing(Arr, Settings.Coef);
                     end;
    fCubicSpline   : begin
                      aCubicSplineSmoothing(Arr, Settings.Dsc, Settings.Coef);
                     end;
  end;
 End; // aSmoothing();

// Процедура фильтрации массива TDByteArray в зависимости от параметров
// Параметры:
//  Arr - Обрабатываемый массив
//  *Settings - настройки сглаживания
//  *CountryIndex - настройки региона для распознавания номера
 procedure aSmoothing(var Arr: TDByteArray; Settings: TSmoothSetting; CountryIndex: TCountryIndex = RUS);
                    //  Coef: Word; SmoothType: TSmoothingType = fCubicSpline;
                    //  Dsc: Double = 1.0; CycledFilter: Boolean = false);
 Var j      : Word;
     tmpArr : TDDoubleArray;
 Begin
  //Внимание! Пока не написаны специально ресемплирование фильтрацией, для других массивов
  //кроме TDDoubleArray, вся конвертация происходит через преобразование массивов
  if (Settings.SmoothType <> fSevenNonLinear) and (Settings.SmoothType <> fCubicSpline) then
    Settings := CountrySettings[CountryIndex].SmoothSetting;
  aConvertToArray(Arr, tmpArr);
  case Settings.SmoothType of
    fSevenNonLinear: begin
                      if Settings.CycledFilter then
                       for j := 2 to Settings.Coef do
                         aSevenPointNonLinearSmoothing(tmpArr, j)
                       else
                         aSevenPointNonLinearSmoothing(tmpArr, Settings.Coef);
                     end;
    fCubicSpline   : begin
                      aCubicSplineSmoothing(tmpArr, Settings.Dsc, Settings.Coef);
                     end;
  end;
  aConvertToArray(tmpArr, Arr);
 End; // aSmoothing();


// Процедура фильтрации массива TLevelsArray в зависимости от параметров
// Параметры:
//  Arr - Обрабатываемый массив
//  *Settings - настройки сглаживания
//  *CountryIndex - настройки региона для распознавания номера
 procedure aSmoothing(var Arr: TLevelsArray; Settings: TSmoothSetting; CountryIndex: TCountryIndex = RUS);
           //           Coef: Word; SmoothType: TSmoothingType = fCubicSpline;
           //           Dsc: Double = 1.0; CycledFilter: Boolean = false);
 Var j      : Word;
     tmpArr : TDDoubleArray;
 Begin
  //Внимание! Пока не написаны специально ресемплирование фильтрацией, для других массивов
  //кроме TDDoubleArray, вся конвертация происходит через преобразование массивов
  if (Settings.SmoothType <> fSevenNonLinear) and (Settings.SmoothType <> fCubicSpline) then
    Settings := CountrySettings[CountryIndex].SmoothSetting;
  aConvertToArray(Arr, tmpArr);
  case Settings.SmoothType of
    fSevenNonLinear: begin
                      if Settings.CycledFilter then
                       for j := 2 to Settings.Coef do
                         aSevenPointNonLinearSmoothing(tmpArr, j)
                       else
                         aSevenPointNonLinearSmoothing(tmpArr, Settings.Coef);
                     end;
    fCubicSpline   : begin
                      aCubicSplineSmoothing(tmpArr, Settings.Dsc, Settings.Coef);
                     end;
  end;
  aConvertToArray(tmpArr, Arr);
 End; // aSmoothing();

//////////////////////////////////////////////////////
// НЕЛИНЕЙНОЕ ПРЕОБРАЗОВАНИЕ

// Процедура исключения линейной составляющей из массива
//т.е. если в массиве имеется линейная функция, она будет преобразована
// Параметры:
//  Arr - массив к преобразованию
//***Инфо***
//Автор:       lookin, lookin@mail.ru, Екатеринбург, 30 апреля 2002 г.
//Доработано:  Simkin A.V., simkin.av@gmail.com, 22.04.2009
 procedure aLinearTrendExclusion(var Arr: TDDoubleArray);
 var i, N      : Integer;
     b0, b1, nx: Double;
 begin
  N := Length(Arr);
  nx := 0;
  for i := 0 to N - 1 do nx := nx + (i + 1)*Arr[i];
  b0 := (2*(2*N + 1)*Sum(Arr) - 6*nx)/(N*(N - 1));
  b1 := (12*nx - 6*(N + 1)*Sum(Arr))/(N*(N - 1)*(N + 1));
  for i := 0 to N - 1 do Arr[i] := Arr[i] - (b0 + i*b1);
 end; // aLinearTrendExclusion();


////////////////////////////////////////////////////////////
// ИНТЕГРАЛЬНЫЕ ПРЕОБРАЗОВАНИЯ
//

//////////////////////////////////////////////////////
// ФУРЬЕ

//Процедура гармонического синтеза Фурье
// Параметры:
//  ValueArray   - обрабатываемый массив
//  NumGarmonics - число гармоник
//***Инфо***
//Автор:       lookin, lookin@mail.ru, Екатеринбург, 30 апреля 2002 г.
//Доработано:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aFourierAnalysis(var ValueArray: TDDoubleArray; NumGarmonics: integer);
 Var i, j, N        : integer;
     yn, ap, bp     : double;
     AFCoef, BFCoef : TDDoubleArray;
 Begin
  N := Length(ValueArray);
  SetLength(AFCoef, NumGarmonics);
  SetLength(BFCoef, NumGarmonics);
  AFCoef[0] := Sum(ValueArray)/N;
  BFCoef[0] := 0;
  for i := 1 to NumGarmonics - 1 do begin
    AFCoef[i] := 0;
    BFCoef[i] := 0;
    for j := 0 to N - 1 do begin
      AFCoef[i] := AFCoef[i] + ValueArray[j] * cos(Pi* i * j * 2 / N);
      BFCoef[i] := BFCoef[i] + ValueArray[j] * sin(Pi * i * j * 2 / N);
    end;
    AFCoef[i] := AFCoef[i] * 2 / N;
    BFCoef[i] := BFCoef[i] * 2 / N;
  end;
  for j := 0 to N - 1 do begin
    //yn := 0;
    ap := 0;
    bp := 0;
    for i := 1 to NumGarmonics - 1 do begin
      ap := ap + AFCoef[i] * cos(2 * Pi * i * (j / N));
      bp := bp + BFCoef[i] * sin(2 * Pi * i * (j / N));
    end;
    yn := AFCoef[0] + ap + bp;
    ValueArray[j] := yn;
  end;
 End; // aFourierAnalysis();

//////////////////////////////////////////////////////
// ПЛОЩАТЬ ПОД КРИВОЙ

// Функция вычисление площади под кривой, получаемой данными из массива
// т.е. численного интегрирования
// Параметры:
//  arr         - Исходный массив
//  i0, ik      - Границы
//  *Method     - метод расчета 1..4
//  *BindToZero - делить ли на ноль
//***Инфо***
//Автор:       lookin, lookin@mail.ru, Екатеринбург, 30 апреля 2002 г.
//Доработано:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 function aCalculateAreaOfArray(var arr: TDDoubleArray; i0, ik: integer; Method: byte = 1; BindToZero: boolean = true): Double;
 Var i        : Integer;
     sq, subv : Double;
 Begin
  if arr = nil then Result := 0
  else begin
    sq := 0;
    if BindToZero then subv := (arr[ik] + arr[i0])/2
    else subv := 0;
    for i := i0 to ik - 1 do begin
      if Method = 1 then
        sq := sq + Abs(arr[i] - subv) + (Abs(arr[i+1] - subv) - Abs(arr[i] - subv))/2;
      if Method = 2 then
        sq := sq + Abs(arr[i] - subv) + (Abs(arr[i + 1] - subv) - Abs(arr[i] - subv))/2 - 1/(48*Power(0.5, 1.5));
      if Method = 3 then
        if (i mod 2) = 1 then
          sq := sq + 2 * Abs(arr[i] - subv);
      if Method = 4 then
        if (i mod 2) = 1 then
          sq := sq + 2*Abs(arr[i] - subv) - 1/(96*Power(0.5, 1.5));
    end;
    Result := sq;
  end;
 End; // aCalculateAreaOfArray();


////////////////////////////////////////////////////////////
// ПРЕОБРАЗОВАНИЕ РАЗМЕРНОСТИ/МАСШТАБИРОВАНИЕ
//

//////////////////////////////////////////////////////
// РАСШИРЕНИЕ ГРАНИЦ

// Процедура расширения массива заданным числом точек справа и слева
// Параметры:
//  Arr        - Обрабатываемый массив
//  SplitValue - количество точек
//***Инфо***
//Автор:       lookin, lookin@mail.ru, Екатеринбург, 30 апреля 2002 г.
//Доработано:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aIncreaseLength(var Arr: TDDoubleArray; SplitValue: integer);
 var sv, N, i: integer;
     bv, ev  : double;
 Begin
  N := Length(Arr);
  sv := 10*SplitValue;
  bv := 0;
  ev := 0;
  for i := 0 to 9 do bv := bv + Arr[i];
  bv := bv/10;
  for i := N - 1 downto N - 10 do ev := ev + Arr[i];
  ev := ev/10;
  SetLength(Arr, N + sv);
  for i := N - 1 downto 0 do Arr[i + trunc(sv/2)] := Arr[i];
  for i := trunc(sv/2) - 1 downto 0 do Arr[i] := bv;
  for i := N + trunc(sv/2) to N + sv - 1 do Arr[i] := ev;
 End; // aIncreaseLength();

//////////////////////////////////////////////////////
// УМЕНЬШЕНИЕ ГРАНИЦ

// Процедура сокращения массива заданным числом точек справа и слева
// Параметры:
//  Arr        - Обрабатываемый массив
//  SplitValue - количество точек
//***Инфо***
//Автор:       lookin, lookin@mail.ru, Екатеринбург, 30 апреля 2002 г.
//Доработано:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aDecreaseLength(var Arr: TDDoubleArray; SplitValue: integer);
 Var sv, N, i: integer;
 Begin
  N := Length(Arr);
  sv := 10*SplitValue;
  for i := 0 to N - sv - 1 do Arr[i] := Arr[i + trunc(sv / 2)];
  SetLength(Arr, N - sv);
 End; // aDecreaseLength();

//////////////////////////////////////////////////////
// РАСШИРЕНИЕ МАССИВА

// Функция расширение массива заданным числом точек между 2-мя соседними точками
// Параметры:
//  Arr        - Обрабатываемый массив
//  ExpandCoef - количество точек
//***Инфо***
//Автор:       lookin, lookin@mail.ru, Екатеринбург, 30 апреля 2002 г.
//Доработано:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 function aExpandLength(var Arr: TDDoubleArray; ExpandCoef: integer): TDDoubleArray;
 var i, k, N, sub: integer;
     diap: double;
 begin
  N   := Length(Arr);
  sub := ExpandCoef - 1;
  SetLength(Result, N*ExpandCoef - sub);
  for i := 0 to N - 1 do begin
    Result[i*ExpandCoef] := Arr[i];
    if i <> 0 then begin
      diap := (Result[i*ExpandCoef] - Result[(i - 1)*ExpandCoef]);
      for k := 0 to ExpandCoef - 1 do
        Result[(i - 1)*ExpandCoef + k] := Result[(i - 1)*ExpandCoef] + diap*(k/ExpandCoef);
    end;
  end;
 end; // aExpandLength();

//////////////////////////////////////////////////////
// ИЗМЕНЕНИЕ РАЗМЕРА МЕТОДОМ AverageArea

// Функция изменения размера массива методом Среднего в области пикселей
// Рекомендуется использовать, только для уменьшения размера изображения (dx,dy>1)
// Параметры:
//  Arr         - Исходный массив
//  NewH, NewW  - Новые размеры массива
// Возвращаемое значение:
//  TImageArray
 function aAverageAreaResize(var Arr: TImageArray; NewH, NewW: Word): TImageArray;
 var x0, x1, y0, y1, dx, dy : single; // координаты исходного массива
     x, y, px, py, points   : integer;
     Grey                   : Cardinal;
     ArrHeight, ArrWidth    : Word;
 // правильное округление
 function MyRound(x: Double): Integer;
  begin
    Result := Trunc(x);
    if Frac(x) >= 0.5 then
      if x >= 0 then Result := Result + 1
      else Result := Result - 1;
  end;

 Begin
  aSetLength(Result, NewH, NewW);
  ArrHeight := Length(Arr);
  ArrWidth  := Length(Arr[0]);
  // Вычисления размеры семплируемой области в исходном массиве
  dx        := ArrWidth/NewW;
  dy        := ArrHeight/NewH;
  // if (dx<1)or(dy<1) then // желательно использовать другой алгоритм
  // обработка
  y1 := 0;
  for y := 0 to NewH - 1 do
   begin
    // Определяем начальные и конечные
    //координаты по Высоте в исходном массиве
    y0 := y1;
    y1 := y0 + dy;
    x1 := 0;
    for x := 0 to NewW - 1 do
    begin
     // Определяем начальные и конечные
     //координаты по Ширине в исходном массиве
     x0 := x1;
     x1 := x0 + dx;
     // Вычисляем средний результат в области
     Grey   := 0;
     points := 0;
     for py := MyRound(y0) to MyRound(y1) do
      begin
       for px := MyRound(x0) to MyRound(x1) do
        begin
         Inc(points);
         if (px >= ArrWidth)or(py >= ArrHeight) then Inc(Grey, 255)
         else Inc(Grey, Arr[px,py]);
        end;
      end;
     Result[x,y] := ifthen(points = 0, 255, MyRound(Grey/points));
    end;
   end;
 End; // aAverageAreaResize();

// Функция изменения размера массива методом Среднего в области пикселей
// Рекомендуется использовать, только для уменьшения размера изображения (dx,dy>1)
// Параметры:
//  Arr         - Исходный массив
//  NewH, NewW  - Новые размеры массива
// Возвращаемое значение:
//  TImageArray
 function aAverageAreaResize(var Arr: TDDouble2Array; NewH, NewW: Cardinal): TDDouble2Array;
 var x0, x1, y0, y1, dx, dy : Double; // координаты исходного массива
     x, y, px, py, points   : integer;
     Grey                   : Double;
     ArrHeight, ArrWidth    : integer;
 // правильное округление
 function MyRound(x: Double): Integer;
  begin
    Result := Trunc(x);
    if Frac(x) >= 0.5 then
      if x >= 0 then Result := Result + 1
      else Result := Result - 1;
  end;

 Begin
  aSetLength(Result, NewH, NewW);
  ArrHeight := Length(Arr);
  ArrWidth  := Length(Arr[0]);
  // Вычисления размеры семплируемой области в исходном массиве
  dx        := ArrWidth/NewW;
  dy        := ArrHeight/NewH;
  // if (dx<1)or(dy<1) then // желательно использовать другой алгоритм
  // обработка
  y1 := 0.0;
  for y := 0 to NewH - 1 do
   begin
    // Определяем начальные и конечные
    //координаты по Высоте в исходном массиве
    y0 := y1;
    y1 := y0 + dy;
    x1 := 0.0;
    for x := 0 to NewW - 1 do
    begin
     // Определяем начальные и конечные
     //координаты по Ширине в исходном массиве
     x0 := x1;
     x1 := x0 + dx;
     // Вычисляем средний результат в области
     Grey   := 0.0;
     points := 0;
     for py := MyRound(y0) to MyRound(y1) do
      begin
       for px := MyRound(x0) to MyRound(x1) do
        begin
         Inc(points);
         if (px >= ArrWidth)or(py >= ArrHeight) then Grey := Grey + 255//Inc(Grey, 255)
         else Grey := Grey +  Arr[px,py];//Inc(Grey, Arr[px,py]);
        end;
      end;
     Result[x,y] := ifthen(points = 0, 255, MyRound(Grey/points));
    end;
   end;
 End; // aAverageAreaResize();

//////////////////////////////////////////////////////
// ИЗМЕНЕНИЕ РАЗМЕРА

// Функция изменения размера массива по указанному типу преобразования
// Параметры:
//  Arr         - обрабатываемый массив
//  newH, newW  - новая размерность
//  *ResizeType - тип преобразования
// Возвращаемое значение:
//  Массив в новой размерности
 function aResize(var Arr: TDDouble2Array; newH, newW: Cardinal; ResizeType: TResizeType = fBilinearSpline): TDDouble2Array;
 Begin
  aSetLength(Result, newH, newW);
  case ResizeType of
    fAverageArea    : Result := aAverageAreaResize(Arr, newH, newW);
    fBilinearSpline : BilinearResampleCartesian(Arr, Length(Arr), Length(Arr[0]), Result, newH, newW);
    fBicubicSpline  : BicubicResampleCartesian(Arr, Length(Arr), Length(Arr[0]), Result, newH, newW);
    fBiakimaSpline  : BiakimaResampleCartesian(Arr, Length(Arr), Length(Arr[0]), Result, newH, newW);
  end;
 End; // aResize();

// Функция изменения размера массива по указанному типу преобразования
// Параметры:
//  Arr         - обрабатываемый массив
//  newH, newW  - новая размерность
//  *ResizeType - тип преобразования
// Возвращаемое значение:
//  Массив в новой размерности
 function aResize(var Arr: TImageArray; newH, newW: Word; ResizeType: TResizeType = fBilinearSpline): TImageArray;
 Var tmp: TDDouble2Array;
 Begin
  //Внимание! Пока не написаны специально ресемплирование фильтрацией, для других массивов
  //кроме TDDouble2Array, вся конвертация происходит через преобразование массивов
  aSetLength(Result, newH, newW);
  case ResizeType of
    fAverageArea    : Result := aAverageAreaResize(Arr, newH, newW);
    fBilinearSpline : begin
                        BilinearResampleCartesian(aConvertToArray(Arr), Length(Arr), Length(Arr[0]), tmp, newH, newW);
                        Result := aConvertToArray(tmp);
                      end;
    fBicubicSpline  : begin
                        BicubicResampleCartesian(aConvertToArray(Arr), Length(Arr), Length(Arr[0]), tmp, newH, newW);
                        Result := aConvertToArray(tmp);
                      end;
    fBiakimaSpline  : begin
                        BiakimaResampleCartesian(aConvertToArray(Arr), Length(Arr), Length(Arr[0]), tmp, newH, newW);
                        Result := aConvertToArray(tmp);
                      end;
  end;
 End; // aResize();

// Функция изменения размера массива по указанному типу преобразования
// Параметры:
//  Arr         - обрабатываемый массив
//  newH, newW  - новая размерность
//  *ResizeType - тип преобразования
// Возвращаемое значение:
//  Массив в новой размерности
 function aResize(var Arr: TImagesArray; newH, newW: Word; ResizeType: TResizeType = fBilinearSpline): TImagesArray;
 var i        : Cardinal;
     ResizeArr: TImageArray;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do
  begin
    ResizeArr := aResize(Arr[i], newH, newW, ResizeType);
    Result[i] := ResizeArr;
  end;
 End; // aResize();



////////////////////////////////////////////////////////////////////////////////
//// ПРОЦЕДУРЫ И ФУНКЦИИ РАБОТЫ С МАТРИЦАМИ
////////////////////////////////////////////////////////////////////////////////
//***Инфо***
//Автор:       MBo
//Доработано:  Simkin A.V., simkin.av@gmail.com, 18.05.2009
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ВЫЧИСЛЕНИЕ LU-РАЗЛОЖЕНИЯ
//

//////////////////////////////////////////////////////
// ПРЯМОЙ ХОД - U

// Процедура "прямого хода" - вычисления верхней треугольной U-матрицы для матрицы типа TDDouble2Array
 procedure aMatrixLUDecomp(var Matrix: TDDouble2Array; out U: TDDouble2Array; out IndexArr: TDIntegerArray; out Sign: Integer);
 var n, k, j, imax, i : Integer;
     sum, dum, big    : Double;
     VV               : TDDoubleArray;
     DumPtr           : Pointer;
 begin
  n := Length(Matrix);
  U := aDynamicArrayCopy(Matrix);
  SetLength(VV, n);
  SetLength (IndexArr, n);
  Sign := 1;
  imax := 1;
  for i := 0 to n - 1 do begin
    big := 0;
    for j := 0 to n - 1 do
      if (abs(Matrix[i, j]) > big) then big := Abs(Matrix[i, j]);
    if (big = 0.0) then raise Exception.Create('Stopped. Matrix is singular!!!');
    VV[i] := 1/big;
  end;
  for j := 0 to n - 1 do begin
    for i := 0 to j - 1 do begin
      sum := Matrix[i, j];
      for k := 0 to i - 1 do sum := sum - Matrix[i, k]*Matrix[k, j];
      U[i, j] := sum;
    end;
    big := 0;
    for i := j to n - 1 do begin
      sum := U[i, j];
      for k := 0 to j - 1 do sum := sum - U[i, k]*U[k, j];
      U[i, j] := sum;
      dum     := VV[i]*abs(sum);
      if (dum > big) then begin
        big   := dum;
        imax  := i;
      end;
    end;
    if j <> imax then begin
      DumPtr           := Pointer(U[imax]);
      Pointer(U[imax]) := Pointer(U[j]);
      Pointer(U[j])    := DumPtr;
      Sign             := -Sign;
      VV[imax]         := VV[j]
    end;
    IndexArr[j]        := imax;
    if U[j, j] = 0 then U[j, j] := MinDouble;
    if j <> n - 1 then begin
      dum := 1/U[j, j];
      for i := j + 1 to n - 1 do U[i, j] := U[i, j]*dum;
    end;
  end;
 end; // aMatrixLUDecomp();

//////////////////////////////////////////////////////
// ОБРАТНЫЙ ХОД

// Процедура "обратного хода" - вычисления ФСР для матрицы типа TDDouble2Array
 procedure aMatrixLUBackSubst(var U: TDDouble2Array; var IndexArr: TDIntegerArray; var Result: TDDoubleArray);
 var n, j, ip, k, i: Integer;
     sum            : Double;
 begin
  n := Length(U);
  k := -1;
  for i := 0 to n - 1 do begin
    ip          := IndexArr[i];
    sum         := Result[ip];
    Result[ip]  := Result[i];
    if k <> -1 then
      for j := k to i - 1 do
        sum := sum - U[i, j]*Result[j]
    else if sum <> 0.0 then k := i;
    Result[i] := sum;
  end;
  for i := n - 1 downto 0 do begin
    sum := Result[i];
    if i < n - 1 then
      for j := i + 1 to n - 1 do
        sum := sum - U[i, j]*Result[j];
    Result[i] := sum/U[i, i];
  end;
 end; // aMatrixLUBackSubst();


////////////////////////////////////////////////////////////
// РЕШЕНИЕ СЛАУ
//

//////////////////////////////////////////////////////
// РЕШЕНИЕ ЧЕРЕЗ LU-РАЗЛОЖЕНИЕ

// Процедура решения СЛАУ в матричном виде с помощью LU-разложение
// Параметры:
//  Matr  - СЛАУ в Матричном виде
//  XY    - на входе - правые части (коэф. Bi); на выходе - вектор решений
 procedure aMatrixSLAUSolve(var Matrix: TDDouble2Array; var XY: TDDoubleArray; out U: TDDouble2Array);
 var IndexArr : TDIntegerArray;
     Sign     : Integer;
 begin
  aMatrixLUDecomp(Matrix, U, IndexArr, Sign);
  aMatrixLUBackSubst(U, IndexArr, XY);
 end; // aMatrixSLAUSolve();


////////////////////////////////////////////////////////////
// ЛИНЕЙНАЯ АЛГЕБРА
//

//////////////////////////////////////////////////////
// ОБРАТНАЯ МАТРИЦА

// Процедура вычисления обратной матрицы типа TDDouble2Array
 procedure aMatrixInverse(var Matrix: TDDouble2Array; out Inverse: TDDouble2Array);
 var n, i, j  : Integer;
     IndexArr : TDIntegerArray;
     Col      : TDDoubleArray;
     Sign     : Integer;
     U        : TDDouble2Array;
 begin
  if Length(Matrix)<>Length(Matrix[0]) then raise Exception.Create('Stopped. Matrix is not square!');
  n := Length(Matrix);
  SetLength(IndexArr, n);
  SetLength(Col, n);
  aSetLength(U, n, n);
  aSetLength(Inverse, n, n);
  aMatrixLUDecomp(Matrix, U, IndexArr, Sign);
  for j := 0 to n - 1 do begin
    for i := 0 to n - 1 do Col[i] := 0;
    Col[j] := 1;
    aMatrixLUBackSubst(U, IndexArr, Col);
    for i := 0 to n - 1 do
      Inverse[i, j] := Col[i];
  end;
 end; // aMatrixInverse();

//////////////////////////////////////////////////////
// ОПРЕДЕЛИТЕЛЬ МАТРИЦЫ

// Процедура вычисления детерминанта матрицы типа TDDouble2Array
 function aMatrixDeterminant(var Matrix: TDDouble2Array): Double;
 var n, j : Integer;
     Indx : TDIntegerArray;
     Sign : Integer;
     U    : TDDouble2Array;
 begin
  n := Length(Matrix);
  SetLength(Indx, n);
  aMatrixLUDecomp(Matrix, U, Indx, Sign);
  Result := Sign;
  for j := 0 to n - 1 do
    Result := Result*U[j, j];
 end; // aMatrixDeterminant();

//////////////////////////////////////////////////////
// УМНОЖЕНИЕ МАТРИЦ

// Функция перемножения двух матриц типа TDDouble2Array
 function aMatrixMultiple(var A,B: TDDouble2Array): TDDouble2Array;
 var i,j,k: integer;
 begin
  if Length(A[0])<> Length(B) then raise Exception.Create('Stopped. Not possible multiple matrix!!!');
  aSetLength(Result, Length(A), Length(B[0]));
  for i := 0 to High(Result) do
    for j := 0 to High(Result[i]) do
      for k := 0 to High(A[0]) do Result[i,j] := Result[i,j] + A[i,k]*B[k,j];
 end; // aMatrixMultiple();


end. // ImgLibArrayExt

