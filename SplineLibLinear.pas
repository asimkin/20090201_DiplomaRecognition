(*************************************************************************
Copyright (c) 2007, Sergey Bochkanov (ALGLIB project).

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

- Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

- Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer listed
  in this license in the documentation and/or other materials
  provided with the distribution.

- Neither the name of the copyright holders nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*************************************************************************)
{*******************************************************}
{          Modify and Adaptive by Simkin A.V.           }
{                         to                            }
{      Image Library for Bachelor Diploma Project       }
{               MSTU n.a. Bauman, ICS-1                 }
{              GNU GPL 2009, Simkin A.V.                }
{                                                       }
{*******************************************************}
{                      24.04.2009                       }
{*******************************************************}
unit SplineLibLinear;
interface
uses Math, SysUtils, ImgLibTypes;

procedure BuildLinearSpline(X : TDDoubleArray;
     Y : TDDoubleArray;
     N : Integer;
     var C : TDDoubleArray);
procedure BuildCubicSpline(X : TDDoubleArray;
     Y : TDDoubleArray;
     N : Integer;
     BoundLType : Integer;
     BoundL : Double;
     BoundRType : Integer;
     BoundR : Double;
     var C : TDDoubleArray);
procedure BuildHermiteSpline(X : TDDoubleArray;
     Y : TDDoubleArray;
     D : TDDoubleArray;
     N : Integer;
     var C : TDDoubleArray);
procedure BuildAkimaSpline(X : TDDoubleArray;
     Y : TDDoubleArray;
     N : Integer;
     var C : TDDoubleArray);
function SplineInterpolation(const C : TDDoubleArray; X : Double):Double;
procedure SplineDifferentiation(const C : TDDoubleArray;
     X : Double;
     var S : Double;
     var DS : Double;
     var D2S : Double);
procedure SplineCopy(const C : TDDoubleArray; var CC : TDDoubleArray);
procedure SplineUnpack(const C : TDDoubleArray;
     var N : Integer;
     var Tbl : TDDouble2Array);
procedure SplineLinTransX(var C : TDDoubleArray; A : Double; B : Double);
procedure SplineLinTransY(var C : TDDoubleArray; A : Double; B : Double);
function SplineIntegration(const C : TDDoubleArray; X : Double):Double;
procedure Spline3BuildTable(N : Integer;
     const DiffN : Integer;
     x : TDDoubleArray;
     y : TDDoubleArray;
     const BoundL : Double;
     const BoundR : Double;
     var ctbl : TDDouble2Array);
function Spline3Interpolate(N : Integer;
     const c : TDDouble2Array;
     const X : Double):Double;

implementation

uses ImgLibArrayExt;

procedure HeapSortPoints(var X : TDDoubleArray;
     var Y : TDDoubleArray;
     N : Integer);forward;
procedure HeapSortDPoints(var X : TDDoubleArray;
     var Y : TDDoubleArray;
     var D : TDDoubleArray;
     N : Integer);forward;
procedure SolveTridiagonal(A : TDDoubleArray;
     B : TDDoubleArray;
     C : TDDoubleArray;
     D : TDDoubleArray;
     N : Integer;
     var X : TDDoubleArray);forward;
function DiffThreePoint(T : Double;
     X0 : Double;
     F0 : Double;
     X1 : Double;
     F1 : Double;
     X2 : Double;
     F2 : Double):Double;forward;


(*************************************************************************
Построение таблицы коэффициентов кусочно-линейного сплайна

Входные параметры:
    X           -   абсциссы, массив с нумерацией элементов [0..N-1]
    Y           -   значения функции,
                    массив с нумерацией элементов [0..N-1]
    N           -   число точек, N>=2

Выходные параметры:
    C           -   таблица коэффициентов сплайна для использования в
                    подпрограмме SplineInterpolation

  -- ALGLIB PROJECT --
     Copyright 24.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure BuildLinearSpline(X : TDDoubleArray;
     Y : TDDoubleArray;
     N : Integer;
     var C : TDDoubleArray);
var
    I : Integer;
    TblSize : Integer;
begin
    X := aDynamicArrayCopy(X);
    Y := aDynamicArrayCopy(Y);
    Assert(N>=2, 'BuildLinearSpline: N<2!');
    
    //
    // Sort points
    //
    HeapSortPoints(X, Y, N);
    
    //
    // Fill C:
    //  C[0]            -   length(C)
    //  C[1]            -   type(C):
    //                      3 - general cubic spline
    //  C[2]            -   N
    //  C[3]...C[3+N-1] -   x[i], i = 0...N-1
    //  C[3+N]...C[3+N+(N-1)*4-1] - coefficients table
    //
    TblSize := 3+N+(N-1)*4;
    SetLength(C, TblSize-1+1);
    C[0] := TblSize;
    C[1] := 3;
    C[2] := N;
    I:=0;
    while I<=N-1 do
    begin
        C[3+I] := X[I];
        Inc(I);
    end;
    I:=0;
    while I<=N-2 do
    begin
        C[3+N+4*I+0] := Y[I];
        C[3+N+4*I+1] := (Y[I+1]-Y[I])/(X[I+1]-X[I]);
        C[3+N+4*I+2] := 0;
        C[3+N+4*I+3] := 0;
        Inc(I);
    end;
end;


(*************************************************************************
Построение таблицы коэффициентов кубического сплайна

Входные параметры:
    X           -   абсциссы, массив с нумерацией элементов [0..N-1]
    Y           -   значения функции,
                    массив с нумерацией элементов [0..N-1]
    N           -   число точек, N>=2
    BoundLType  -   тип граничного условия (левая граница)
    BoundL      -   значение первой (или второй, в зависимости от
                    BoundType) производной сплайна на левой границе
    BoundRType  -   тип граничного условия (правая граница)
    BoundR      -   значение первой (или второй, в зависимости от
                    BoundType) производной сплайна на правой границе

Выходные параметры:
    C           -   таблица коэффициентов сплайна для использования в
                    подпрограмме SplineInterpolation

Параметры BoundLType/BoundRType задают тип граничного условия и  принимают
следующие значения:
    * 0, что соответствует граничному условию типа "сплайн, завершающийся
      параболой" (при этом значения BoundL/BoundR игнорируются).
    * 1, что соответствует граничному условию для первой производной
    * 2, что соответствует граничному условию для второй производной

  -- ALGLIB PROJECT --
     Copyright 23.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure BuildCubicSpline(X : TDDoubleArray;
     Y : TDDoubleArray;
     N : Integer;
     BoundLType : Integer;
     BoundL : Double;
     BoundRType : Integer;
     BoundR : Double;
     var C : TDDoubleArray);
var
    A1 : TDDoubleArray;
    A2 : TDDoubleArray;
    A3 : TDDoubleArray;
    B : TDDoubleArray;
    D : TDDoubleArray;
    I : Integer;
    //TblSize : Integer;
    //Delta : Double;
    //Delta2 : Double;
    //Delta3 : Double;
begin
    X := aDynamicArrayCopy(X);
    Y := aDynamicArrayCopy(Y);
    Assert(N>=2, 'BuildCubicSpline: N<2!');
    Assert((BoundLType=0) or (BoundLType=1) or (BoundLType=2), 'BuildCubicSpline: incorrect BoundLType!');
    Assert((BoundRType=0) or (BoundRType=1) or (BoundRType=2), 'BuildCubicSpline: incorrect BoundRType!');
    SetLength(A1, N-1+1);
    SetLength(A2, N-1+1);
    SetLength(A3, N-1+1);
    SetLength(B, N-1+1);
    
    //
    // Special case:
    // * N=2
    // * parabolic terminated boundary condition on both ends
    //
    if (N=2) and (BoundLType=0) and (BoundRType=0) then
    begin
        
        //
        // Change task type
        //
        BoundLType := 2;
        BoundL := 0;
        BoundRType := 2;
        BoundR := 0;
    end;
    
    //
    //
    // Sort points
    //
    HeapSortPoints(X, Y, N);
    
    //
    // Left boundary conditions
    //
    if BoundLType=0 then
    begin
        A1[0] := 0;
        A2[0] := 1;
        A3[0] := 1;
        B[0] := 2*(Y[1]-Y[0])/(X[1]-X[0]);
    end;
    if BoundLType=1 then
    begin
        A1[0] := 0;
        A2[0] := 1;
        A3[0] := 0;
        B[0] := BoundL;
    end;
    if BoundLType=2 then
    begin
        A1[0] := 0;
        A2[0] := 2;
        A3[0] := 1;
        B[0] := 3*(Y[1]-Y[0])/(X[1]-X[0])-0.5*BoundL*(X[1]-X[0]);
    end;
    
    //
    // Central conditions
    //
    I:=1;
    while I<=N-2 do
    begin
        A1[I] := X[I+1]-X[I];
        A2[I] := 2*(X[I+1]-X[I-1]);
        A3[I] := X[I]-X[I-1];
        B[I] := 3*(Y[I]-Y[I-1])/(X[I]-X[I-1])*(X[I+1]-X[I])+3*(Y[I+1]-Y[I])/(X[I+1]-X[I])*(X[I]-X[I-1]);
        Inc(I);
    end;
    
    //
    // Right boundary conditions
    //
    if BoundRType=0 then
    begin
        A1[N-1] := 1;
        A2[N-1] := 1;
        A3[N-1] := 0;
        B[N-1] := 2*(Y[N-1]-Y[N-2])/(X[N-1]-X[N-2]);
    end;
    if BoundRType=1 then
    begin
        A1[N-1] := 0;
        A2[N-1] := 1;
        A3[N-1] := 0;
        B[N-1] := BoundR;
    end;
    if BoundRType=2 then
    begin
        A1[N-1] := 1;
        A2[N-1] := 2;
        A3[N-1] := 0;
        B[N-1] := 3*(Y[N-1]-Y[N-2])/(X[N-1]-X[N-2])+0.5*BoundR*(X[N-1]-X[N-2]);
    end;
    
    //
    // Solve
    //
    SolveTridiagonal(A1, A2, A3, B, N, D);
    
    //
    // Now problem is reduced to the cubic Hermite spline
    //
    BuildHermiteSpline(X, Y, D, N, C);
end;


(*************************************************************************
Построение таблицы коэффициентов сплайна Эрмита

Входные параметры:
    X           -   абсциссы, массив с нумерацией элементов [0..N-1]
    Y           -   значения функции,
                    массив с нумерацией элементов [0..N-1]
    D           -   значения производной,
                    массив с нумерацией элементов [0..N-1]
    N           -   число точек, N>=2

Выходные параметры:
    C           -   таблица коэффициентов сплайна для использования в
                    подпрограмме SplineInterpolation

  -- ALGLIB PROJECT --
     Copyright 23.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure BuildHermiteSpline(X : TDDoubleArray;
     Y : TDDoubleArray;
     D : TDDoubleArray;
     N : Integer;
     var C : TDDoubleArray);
var
    I : Integer;
    TblSize : Integer;
    Delta : Double;
    Delta2 : Double;
    Delta3 : Double;
begin
    X := aDynamicArrayCopy(X);
    Y := aDynamicArrayCopy(Y);
    D := aDynamicArrayCopy(D);
    Assert(N>=2, 'BuildHermiteSpline: N<2!');
    
    //
    // Sort points
    //
    HeapSortDPoints(X, Y, D, N);
    
    //
    // Fill C:
    //  C[0]            -   length(C)
    //  C[1]            -   type(C):
    //                      3 - general cubic spline
    //  C[2]            -   N
    //  C[3]...C[3+N-1] -   x[i], i = 0...N-1
    //  C[3+N]...C[3+N+(N-1)*4-1] - coefficients table
    //
    TblSize := 3+N+(N-1)*4;
    SetLength(C, TblSize-1+1);
    C[0] := TblSize;
    C[1] := 3;
    C[2] := N;
    I:=0;
    while I<=N-1 do
    begin
        C[3+I] := X[I];
        Inc(I);
    end;
    I:=0;
    while I<=N-2 do
    begin
        Delta := X[I+1]-X[I];
        Delta2 := Sqr(Delta);
        Delta3 := Delta*Delta2;
        C[3+N+4*I+0] := Y[I];
        C[3+N+4*I+1] := D[I];
        C[3+N+4*I+2] := (3*(Y[I+1]-Y[I])-2*D[I]*Delta-D[I+1]*Delta)/Delta2;
        C[3+N+4*I+3] := (2*(Y[I]-Y[I+1])+D[I]*Delta+D[I+1]*Delta)/Delta3;
        Inc(I);
    end;
end;


(*************************************************************************
Построение таблицы коэффициентов сплайна Акимы

Входные параметры:
    X           -   абсциссы, массив с нумерацией элементов [0..N-1]
    Y           -   значения функции,
                    массив с нумерацией элементов [0..N-1]
    N           -   число точек, N>=5

Выходные параметры:
    C           -   таблица коэффициентов сплайна для использования в
                    подпрограмме SplineInterpolation

  -- ALGLIB PROJECT --
     Copyright 24.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure BuildAkimaSpline(X : TDDoubleArray;
     Y : TDDoubleArray;
     N : Integer;
     var C : TDDoubleArray);
var
    I : Integer;
    D : TDDoubleArray;
    W : TDDoubleArray;
    Diff : TDDoubleArray;
begin
    X := aDynamicArrayCopy(X);
    Y := aDynamicArrayCopy(Y);
    Assert(N>=5, 'BuildAkimaSpline: N<5!');
    
    //
    // Sort points
    //
    HeapSortPoints(X, Y, N);
    
    //
    // Prepare W (weights), Diff (divided differences)
    //
    SetLength(W, N-2+1);
    SetLength(Diff, N-2+1);
    I:=0;
    while I<=N-2 do
    begin
        Diff[I] := (Y[I+1]-Y[I])/(X[I+1]-X[I]);
        Inc(I);
    end;
    I:=1;
    while I<=N-2 do
    begin
        W[I] := Abs(Diff[I]-Diff[I-1]);
        Inc(I);
    end;
    
    //
    // Prepare Hermite interpolation scheme
    //
    SetLength(D, N-1+1);
    I:=2;
    while I<=N-3 do
    begin
        if Abs(W[I-1])+Abs(W[I+1])<>0 then
        begin
            D[I] := (W[I+1]*Diff[I-1]+W[I-1]*Diff[I])/(W[I+1]+W[I-1]);
        end
        else
        begin
            D[I] := ((X[I+1]-X[I])*Diff[I-1]+(X[I]-X[I-1])*Diff[I])/(X[I+1]-X[I-1]);
        end;
        Inc(I);
    end;
    D[0] := DiffThreePoint(X[0], X[0], Y[0], X[1], Y[1], X[2], Y[2]);
    D[1] := DiffThreePoint(X[1], X[0], Y[0], X[1], Y[1], X[2], Y[2]);
    D[N-2] := DiffThreePoint(X[N-2], X[N-3], Y[N-3], X[N-2], Y[N-2], X[N-1], Y[N-1]);
    D[N-1] := DiffThreePoint(X[N-1], X[N-3], Y[N-3], X[N-2], Y[N-2], X[N-1], Y[N-1]);
    
    //
    // Build Akima spline using Hermite interpolation scheme
    //
    BuildHermiteSpline(X, Y, D, N, C);
end;


(*************************************************************************
Вычисление интерполирующего сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.
    X   -   точка, в которой вычисляется значение сплайна

Результат:
    значение сплайна в точке X

  -- ALGLIB PROJECT --
     Copyright 23.06.2007 by Bochkanov Sergey
*************************************************************************)
function SplineInterpolation(const C : TDDoubleArray; X : Double):Double;
var
    N : Integer;
    L : Integer;
    R : Integer;
    M : Integer;
begin
    Assert(Round(C[1])=3, 'SplineInterpolation: incorrect C!');
    N := Round(C[2]);
    
    //
    // Binary search in the [ x[0], ..., x[n-2] ] (x[n-1] is not included)
    //
    L := 3;
    R := 3+N-2+1;
    while L<>R-1 do
    begin
        M := (L+R) div 2;
        if C[M]>=X then
        begin
            R := M;
        end
        else
        begin
            L := M;
        end;
    end;
    
    //
    // Interpolation
    //
    X := X-C[L];
    M := 3+N+4*(L-3);
    Result := C[M]+X*(C[M+1]+X*(C[M+2]+X*C[M+3]));
end;


(*************************************************************************
Дифференцирование сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.
    X   -   точка, в которой вычисляется значение сплайна

Выходные параметры:
    S   -   значение сплайна в точке X
    DS  -   первая производная в точке X
    D2S -   вторая производная в точке X

  -- ALGLIB PROJECT --
     Copyright 24.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure SplineDifferentiation(const C : TDDoubleArray;
     X : Double;
     var S : Double;
     var DS : Double;
     var D2S : Double);
var
    N : Integer;
    L : Integer;
    R : Integer;
    M : Integer;
begin
    Assert(Round(C[1])=3, 'SplineInterpolation: incorrect C!');
    N := Round(C[2]);
    
    //
    // Binary search
    //
    L := 3;
    R := 3+N-2+1;
    while L<>R-1 do
    begin
        M := (L+R) div 2;
        if C[M]>=X then
        begin
            R := M;
        end
        else
        begin
            L := M;
        end;
    end;
    
    //
    // Differentiation
    //
    X := X-C[L];
    M := 3+N+4*(L-3);
    S := C[M]+X*(C[M+1]+X*(C[M+2]+X*C[M+3]));
    DS := C[M+1]+2*X*C[M+2]+3*Sqr(X)*C[M+3];
    D2S := 2*C[M+2]+6*X*C[M+3];
end;


(*************************************************************************
Копирование

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.

Выходные параметры:
    CC  -   копия сплайна
    

  -- ALGLIB PROJECT --
     Copyright 29.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure SplineCopy(const C : TDDoubleArray; var CC : TDDoubleArray);
{var
    S : Integer;  }
begin
    CC := aDynamicArrayCopy(C);
    {S := Round(C[0]);
    SetLength(CC, S-1+1);
    APVMove(@CC[0], 0, S-1, @C[0], 0, S-1); }
end;


(*************************************************************************
Распаковка сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.

Выходные параметры:
    N   -   число точек, на основе которых был построен сплайн
    Tbl -   таблица коэффициентов сплайна. Массив с нумерацией элементов
            [0..N-2, 0..5].
            Для I = 0..N-2:
                Tbl[I,0] = X[i]
                Tbl[I,1] = X[i+1]
                Tbl[I,2] = C0
                Tbl[I,3] = C1
                Tbl[I,4] = C2
                Tbl[I,5] = C3
            Сплайн имеет вид:
                t = x-x[i]
                S(x) = C0 + C1*t + C2*t^2 + C3*t^3

  -- ALGLIB PROJECT --
     Copyright 29.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure SplineUnpack(const C : TDDoubleArray;
     var N : Integer;
     var Tbl : TDDouble2Array);
var
    I : Integer;
begin
    Assert(Round(C[1])=3, 'SplineUnpack: incorrect C!');
    N := Round(C[2]);
    SetLength(Tbl, N-2+1, 5+1);
    
    //
    // Fill
    //
    I:=0;
    while I<=N-2 do
    begin
        Tbl[I,0] := C[3+I];
        Tbl[I,1] := C[3+I+1];
        Tbl[I,2] := C[3+N+4*I];
        Tbl[I,3] := C[3+N+4*I+1];
        Tbl[I,4] := C[3+N+4*I+2];
        Tbl[I,5] := C[3+N+4*I+3];
        Inc(I);
    end;
end;


(*************************************************************************
Линейная замена аргумента сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна S(x).
    A, B-   коэффициенты преобразования x = A*t + B

Выходные параметры:
    C   -   преобразованный сплайн

  -- ALGLIB PROJECT --
     Copyright 30.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure SplineLinTransX(var C : TDDoubleArray; A : Double; B : Double);
var
    I : Integer;
    N : Integer;
    V : Double;
    DV : Double;
    D2V : Double;
    X : TDDoubleArray;
    Y : TDDoubleArray;
    D : TDDoubleArray;
begin
    Assert(Round(C[1])=3, 'SplineLinTransX: incorrect C!');
    N := Round(C[2]);
    
    //
    // Special case: A=0
    //
    if A=0 then
    begin
        V := SplineInterpolation(C, B);
        I:=0;
        while I<=N-2 do
        begin
            C[3+N+4*I] := V;
            C[3+N+4*I+1] := 0;
            C[3+N+4*I+2] := 0;
            C[3+N+4*I+3] := 0;
            Inc(I);
        end;
        Exit;
    end;
    
    //
    // General case: A<>0.
    // Unpack, X, Y, dY/dX.
    // Scale and pack again.
    //
    SetLength(X, N-1+1);
    SetLength(Y, N-1+1);
    SetLength(D, N-1+1);
    I:=0;
    while I<=N-1 do
    begin
        X[I] := C[3+I];
        SplineDifferentiation(C, X[I], V, DV, D2V);
        X[I] := (X[I]-B)/A;
        Y[I] := V;
        D[I] := A*DV;
        Inc(I);
    end;
    BuildHermiteSpline(X, Y, D, N, C);
end;


(*************************************************************************
Линейное преобразование сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна S(x).
    A, B-   коэффициенты преобразования S2(x) = A*S(x) + B

Выходные параметры:
    C   -   преобразованный сплайн

  -- ALGLIB PROJECT --
     Copyright 30.06.2007 by Bochkanov Sergey
*************************************************************************)
procedure SplineLinTransY(var C : TDDoubleArray; A : Double; B : Double);
var
    I : Integer;
    N : Integer;
    //V : Double;
    //DV : Double;
    //D2V : Double;
    //X : TDDoubleArray;
    //Y : TDDoubleArray;
    //D : TDDoubleArray;
begin
    Assert(Round(C[1])=3, 'SplineLinTransX: incorrect C!');
    N := Round(C[2]);
    
    //
    // Special case: A=0
    //
    I:=0;
    while I<=N-2 do
    begin
        C[3+N+4*I] := A*C[3+N+4*I]+B;
        C[3+N+4*I+1] := A*C[3+N+4*I+1];
        C[3+N+4*I+2] := A*C[3+N+4*I+2];
        C[3+N+4*I+3] := A*C[3+N+4*I+3];
        Inc(I);
    end;
end;


(*************************************************************************
Вычисление определенного интеграла от сплайна

Входные параметры:
    C   -   массив коэффициентов, вычисленный подпрограммой для
            построения сплайна.
    X   -   точка, в которой вычисляется интеграл

Результат:
    значение интеграла на отрезке [A, X], где A - левая граница интервала,
    на котором построен сплайн.

  -- ALGLIB PROJECT --
     Copyright 23.06.2007 by Bochkanov Sergey
*************************************************************************)
function SplineIntegration(const C : TDDoubleArray; X : Double):Double;
var
    N : Integer;
    I : Integer;
    L : Integer;
    R : Integer;
    M : Integer;
    W : Double;
begin
    Assert(Round(C[1])=3, 'SplineIntegration: incorrect C!');
    N := Round(C[2]);
    
    //
    // Binary search in the [ x[0], ..., x[n-2] ] (x[n-1] is not included)
    //
    L := 3;
    R := 3+N-2+1;
    while L<>R-1 do
    begin
        M := (L+R) div 2;
        if C[M]>=X then
        begin
            R := M;
        end
        else
        begin
            L := M;
        end;
    end;
    
    //
    // Integration
    //
    Result := 0;
    I:=3;
    while I<=L-1 do
    begin
        W := C[I+1]-C[I];
        M := 3+N+4*(I-3);
        Result := Result+C[M]*W;
        Result := Result+C[M+1]*Sqr(W)/2;
        Result := Result+C[M+2]*Sqr(W)*W/3;
        Result := Result+C[M+3]*Sqr(Sqr(W))/4;
        Inc(I);
    end;
    W := X-C[L];
    M := 3+N+4*(L-3);
    Result := Result+C[M]*W;
    Result := Result+C[M+1]*Sqr(W)/2;
    Result := Result+C[M+2]*Sqr(W)*W/3;
    Result := Result+C[M+3]*Sqr(Sqr(W))/4;
end;


(*************************************************************************
Obsolete subroutine, left for backward compatibility.
*************************************************************************)
procedure Spline3BuildTable(N : Integer;
     const DiffN : Integer;
     x : TDDoubleArray;
     y : TDDoubleArray;
     const BoundL : Double;
     const BoundR : Double;
     var ctbl : TDDouble2Array);
var
    C : Boolean;
    //E : Integer;
    G : Integer;
    Tmp : Double;
    nxm1 : Integer;
    I : Integer;
    J : Integer;
    DX : Double;
    DXJ : Double;
    DYJ : Double;
    DXJP1 : Double;
    DYJP1 : Double;
    DXP : Double;
    //DYP : Double;
    YPPA : Double;
    YPPB : Double;
    PJ : Double;
    b1 : Double;
    b2 : Double;
    b3 : Double;
    b4 : Double;
begin
    x := aDynamicArrayCopy(x);
    y := aDynamicArrayCopy(y);
    N := N-1;
    g := (n+1) div 2;
    repeat
        i := g;
        repeat
            j := i-g;
            c := True;
            repeat
                if x[j]<=x[j+g] then
                begin
                    c := False;
                end
                else
                begin
                    Tmp := x[j];
                    x[j] := x[j+g];
                    x[j+g] := Tmp;
                    Tmp := y[j];
                    y[j] := y[j+g];
                    y[j+g] := Tmp;
                end;
                j := j-1;
            until  not ((j>=0) and C);
            i := i+1;
        until  not (i<=n);
        g := g div 2;
    until  not (g>0);
    SetLength(ctbl, 4+1, N+1);
    N := N+1;
    if DiffN=1 then
    begin
        b1 := 1;
        b2 := 6/(x[1]-x[0])*((y[1]-y[0])/(x[1]-x[0])-BoundL);
        b3 := 1;
        b4 := 6/(x[n-1]-x[n-2])*(BoundR-(y[n-1]-y[n-2])/(x[n-1]-x[n-2]));
    end
    else
    begin
        b1 := 0;
        b2 := 2*BoundL;
        b3 := 0;
        b4 := 2*BoundR;
    end;
    nxm1 := n-1;
    if n>=2 then
    begin
        if n>2 then
        begin
            dxj := x[1]-x[0];
            dyj := y[1]-y[0];
            j := 2;
            while j<=nxm1 do
            begin
                dxjp1 := x[j]-x[j-1];
                dyjp1 := y[j]-y[j-1];
                dxp := dxj+dxjp1;
                ctbl[1,j-1] := dxjp1/dxp;
                ctbl[2,j-1] := 1-ctbl[1,j-1];
                ctbl[3,j-1] := 6*(dyjp1/dxjp1-dyj/dxj)/dxp;
                dxj := dxjp1;
                dyj := dyjp1;
                j := j+1;
            end;
        end;
        ctbl[1,0] := -b1/2;
        ctbl[2,0] := b2/2;
        if n<>2 then
        begin
            j := 2;
            while j<=nxm1 do
            begin
                pj := ctbl[2,j-1]*ctbl[1,j-2]+2;
                ctbl[1,j-1] := -ctbl[1,j-1]/pj;
                ctbl[2,j-1] := (ctbl[3,j-1]-ctbl[2,j-1]*ctbl[2,J-2])/pj;
                j := j+1;
            end;
        end;
        yppb := (b4-b3*ctbl[2,nxm1-1])/(b3*ctbl[1,nxm1-1]+2);
        i := 1;
        while i<=nxm1 do
        begin
            j := n-i;
            yppa := ctbl[1,j-1]*yppb+ctbl[2,j-1];
            dx := x[j]-x[j-1];
            ctbl[3,j-1] := (yppb-yppa)/dx/6;
            ctbl[2,j-1] := yppa/2;
            ctbl[1,j-1] := (y[j]-y[j-1])/dx-(ctbl[2,j-1]+ctbl[3,j-1]*dx)*dx;
            yppb := yppa;
            i := i+1;
        end;
        i:=1;
        while i<=n do
        begin
            ctbl[0,i-1] := y[i-1];
            ctbl[4,i-1] := x[i-1];
            Inc(i);
        end;
    end;
end;


(*************************************************************************
Obsolete subroutine, left for backward compatibility.
*************************************************************************)
function Spline3Interpolate(N : Integer;
     const c : TDDouble2Array;
     const X : Double):Double;
var
    I : Integer;
    L : Integer;
    Half : Integer;
    First : Integer;
    Middle : Integer;
begin
    N := N-1;
    L := N;
    First := 0;
    while L>0 do
    begin
        Half := L div 2;
        Middle := First+Half;
        if C[4,Middle]<X then
        begin
            First := Middle+1;
            L := L-Half-1;
        end
        else
        begin
            L := Half;
        end;
    end;
    I := First-1;
    if I<0 then
    begin
        I := 0;
    end;
    Result := c[0,I]+(X-c[4,i])*(C[1,I]+(X-c[4,i])*(C[2,I]+C[3,i]*(X-c[4,i])));
end;


(*************************************************************************
Internal subroutine. Heap sort.
*************************************************************************)
procedure HeapSortPoints(var X : TDDoubleArray;
     var Y : TDDoubleArray;
     N : Integer);
var
    I : Integer;
    J : Integer;
    K : Integer;
    T : Integer;
    Tmp : Double;
    IsAscending : Boolean;
    IsDescending : Boolean;
begin
    
    //
    // Test for already sorted set
    //
    IsAscending := True;
    IsDescending := True;
    I:=1;
    while I<=N-1 do
    begin
        IsAscending := IsAscending and (X[I]>X[I-1]);
        IsDescending := IsDescending and (X[I]<X[I-1]);
        Inc(I);
    end;
    if IsAscending then
    begin
        Exit;
    end;
    if IsDescending then
    begin
        I:=0;
        while I<=N-1 do
        begin
            J := N-1-I;
            if J<=I then
            begin
                Break;
            end;
            Tmp := X[I];
            X[I] := X[J];
            X[J] := Tmp;
            Tmp := Y[I];
            Y[I] := Y[J];
            Y[J] := Tmp;
            Inc(I);
        end;
        Exit;
    end;
    
    //
    // Special case: N=1
    //
    if N=1 then
    begin
        Exit;
    end;
    
    //
    // General case
    //
    i := 2;
    repeat
        t := i;
        while t<>1 do
        begin
            k := t div 2;
            if X[k-1]>=X[t-1] then
            begin
                t := 1;
            end
            else
            begin
                Tmp := X[k-1];
                X[k-1] := X[t-1];
                X[t-1] := Tmp;
                Tmp := Y[k-1];
                Y[k-1] := Y[t-1];
                Y[t-1] := Tmp;
                t := k;
            end;
        end;
        i := i+1;
    until  not (i<=n);
    i := n-1;
    repeat
        Tmp := X[i];
        X[i] := X[0];
        X[0] := Tmp;
        Tmp := Y[i];
        Y[i] := Y[0];
        Y[0] := Tmp;
        t := 1;
        while t<>0 do
        begin
            k := 2*t;
            if k>i then
            begin
                t := 0;
            end
            else
            begin
                if k<i then
                begin
                    if X[k]>X[k-1] then
                    begin
                        k := k+1;
                    end;
                end;
                if X[t-1]>=X[k-1] then
                begin
                    t := 0;
                end
                else
                begin
                    Tmp := X[k-1];
                    X[k-1] := X[t-1];
                    X[t-1] := Tmp;
                    Tmp := Y[k-1];
                    Y[k-1] := Y[t-1];
                    Y[t-1] := Tmp;
                    t := k;
                end;
            end;
        end;
        i := i-1;
    until  not (i>=1);
end;


(*************************************************************************
Internal subroutine. Heap sort.
*************************************************************************)
procedure HeapSortDPoints(var X : TDDoubleArray;
     var Y : TDDoubleArray;
     var D : TDDoubleArray;
     N : Integer);
var
    I : Integer;
    J : Integer;
    K : Integer;
    T : Integer;
    Tmp : Double;
    IsAscending : Boolean;
    IsDescending : Boolean;
begin
    
    //
    // Test for already sorted set
    //
    IsAscending := True;
    IsDescending := True;
    I:=1;
    while I<=N-1 do
    begin
        IsAscending := IsAscending and (X[I]>X[I-1]);
        IsDescending := IsDescending and (X[I]<X[I-1]);
        Inc(I);
    end;
    if IsAscending then
    begin
        Exit;
    end;
    if IsDescending then
    begin
        I:=0;
        while I<=N-1 do
        begin
            J := N-1-I;
            if J<=I then
            begin
                Break;
            end;
            Tmp := X[I];
            X[I] := X[J];
            X[J] := Tmp;
            Tmp := Y[I];
            Y[I] := Y[J];
            Y[J] := Tmp;
            Tmp := D[I];
            D[I] := D[J];
            D[J] := Tmp;
            Inc(I);
        end;
        Exit;
    end;
    
    //
    // Special case: N=1
    //
    if N=1 then
    begin
        Exit;
    end;
    
    //
    // General case
    //
    i := 2;
    repeat
        t := i;
        while t<>1 do
        begin
            k := t div 2;
            if X[k-1]>=X[t-1] then
            begin
                t := 1;
            end
            else
            begin
                Tmp := X[k-1];
                X[k-1] := X[t-1];
                X[t-1] := Tmp;
                Tmp := Y[k-1];
                Y[k-1] := Y[t-1];
                Y[t-1] := Tmp;
                Tmp := D[k-1];
                D[k-1] := D[t-1];
                D[t-1] := Tmp;
                t := k;
            end;
        end;
        i := i+1;
    until  not (i<=n);
    i := n-1;
    repeat
        Tmp := X[i];
        X[i] := X[0];
        X[0] := Tmp;
        Tmp := Y[i];
        Y[i] := Y[0];
        Y[0] := Tmp;
        Tmp := D[i];
        D[i] := D[0];
        D[0] := Tmp;
        t := 1;
        while t<>0 do
        begin
            k := 2*t;
            if k>i then
            begin
                t := 0;
            end
            else
            begin
                if k<i then
                begin
                    if X[k]>X[k-1] then
                    begin
                        k := k+1;
                    end;
                end;
                if X[t-1]>=X[k-1] then
                begin
                    t := 0;
                end
                else
                begin
                    Tmp := X[k-1];
                    X[k-1] := X[t-1];
                    X[t-1] := Tmp;
                    Tmp := Y[k-1];
                    Y[k-1] := Y[t-1];
                    Y[t-1] := Tmp;
                    Tmp := D[k-1];
                    D[k-1] := D[t-1];
                    D[t-1] := Tmp;
                    t := k;
                end;
            end;
        end;
        i := i-1;
    until  not (i>=1);
end;


(*************************************************************************
Internal subroutine. Tridiagonal solver.
*************************************************************************)
procedure SolveTridiagonal(A : TDDoubleArray;
     B : TDDoubleArray;
     C : TDDoubleArray;
     D : TDDoubleArray;
     N : Integer;
     var X : TDDoubleArray);
var
    K : Integer;
    T : Double;
begin
    A := aDynamicArrayCopy(A);
    B := aDynamicArrayCopy(B);
    C := aDynamicArrayCopy(C);
    D := aDynamicArrayCopy(D);
    SetLength(X, N-1+1);
    A[0] := 0;
    C[N-1] := 0;
    K:=1;
    while K<=N-1 do
    begin
        T := A[K]/B[K-1];
        B[K] := B[K]-T*C[K-1];
        D[K] := D[K]-T*D[K-1];
        Inc(K);
    end;
    X[N-1] := D[N-1]/B[N-1];
    K:=N-2;
    while K>=0 do
    begin
        X[K] := (D[K]-C[K]*X[K+1])/B[K];
        Dec(K);
    end;
end;


(*************************************************************************
Internal subroutine. Three-point differentiation
*************************************************************************)
function DiffThreePoint(T : Double;
     X0 : Double;
     F0 : Double;
     X1 : Double;
     F1 : Double;
     X2 : Double;
     F2 : Double):Double;
var
    A : Double;
    B : Double;
begin
    T := T-X0;
    X1 := X1-X0;
    X2 := X2-X0;
    A := (F2-F0-X2/X1*(F1-F0))/(Sqr(X2)-X1*X2);
    B := (F1-F0-A*Sqr(X1))/X1;
    Result := 2*A*T+B;
end;


end.
