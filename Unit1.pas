unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, clipbrd,
  ImgLibTypes, ImgLibArrayExt, ImgLibImageExt, ImgLibImpl;

type
  TFormRecognize = class(TForm)
    ScrollBoxOrig: TScrollBox;
    GroupBoxPref: TGroupBox;
    LabelFont: TLabel;
    ButtonFront: TButton;
    ButtonCreate: TButton;
    EditSymbols: TEdit;
    FontDialog: TFontDialog;
    GroupBoxNumber: TGroupBox;
    EditOpenImage: TEdit;
    ButtonChoseImage: TButton;
    ButtonRecognize: TButton;
    EditSampleImage: TEdit;
    ButtonChoseSampleImage: TButton;
    OpenDialog: TOpenDialog;
    ImageOrig: TImage;
    ScrollBoxFin: TScrollBox;
    ImageFin: TImage;
    bAverBright: TButton;
    SaveDialog: TSaveDialog;
    bSaveRightImg: TButton;
    bLevels: TButton;
    bFindNumber: TButton;
    LabelXY: TLabel;
    EditMaxLevel: TEdit;
    GroupBoxSmooth: TGroupBox;
    RadioGroupSmooth: TRadioGroup;
    CheckBoxEnableSmooth: TCheckBox;
    EditSmoothCoeff: TEdit;
    EditSmoothDsc: TEdit;
    CheckBoxSmoothCycled: TCheckBox;
    GroupBoxCanny: TGroupBox;
    GroupBoxCannyThreshold: TGroupBox;
    EditCannyTh: TEdit;
    EditCannyTh1: TEdit;
    EditCannyTh2: TEdit;
    RadioGroupCanny: TRadioGroup;
    bCanny: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBoxBinarization: TGroupBox;
    bBinarize: TButton;
    Label7: TLabel;
    EditBinarizeTh: TEdit;
    RadioGroupBinarization: TRadioGroup;
    EditBinarizMass: TEdit;
    Label8: TLabel;
    EditBinarizeMax: TEdit;
    Label9: TLabel;
    EditBinarizeMin: TEdit;
    RadioGroupSplineType: TRadioGroup;
    GroupBoxOverlayMask: TGroupBox;
    RadioGroupMaskType: TRadioGroup;
    bOverlaymask: TButton;
    EditMaskScale: TEdit;
    Label10: TLabel;
    EditBrightFlush: TEdit;
    Label11: TLabel;
    GroupBoxRecognize: TGroupBox;
    EditNumber1: TEdit;
    bRecognize: TButton;
    EditNumber2: TEdit;
    RadioGroupSymbSize: TRadioGroup;
    bRefresh: TButton;
    GroupBox1: TGroupBox;
    ImageAverBright: TImage;
    GroupBox2: TGroupBox;
    ImageLevels: TImage;
    Label12: TLabel;
    Label13: TLabel;
    GroupBox3: TGroupBox;
    bInterpolate: TButton;
    RadioGroupResizeType: TRadioGroup;
    Label14: TLabel;
    EditH: TEdit;
    EditW: TEdit;
    Label15: TLabel;
    CheckBoxIntProp: TCheckBox;
    CheckBoxMonochrome: TCheckBox;
    ListBoxHistory: TListBox;
    bHistoryClear: TButton;
    bCopyToClip: TButton;
    bAllInDir: TButton;
    GroupBox4: TGroupBox;
    CheckBoxPerfomEnable: TCheckBox;
    LabelPerfomance: TLabel;
    RadioGroupRecType: TRadioGroup;
    EditPerfomance: TEdit;
    Label16: TLabel;
    procedure ButtonFrontClick(Sender: TObject);
    procedure ButtonCreateClick(Sender: TObject);
    procedure ButtonChoseImageClick(Sender: TObject);
    procedure bAverBrightClick(Sender: TObject);
    procedure bSaveRightImgClick(Sender: TObject);
    procedure bLevelsClick(Sender: TObject);
    procedure bFindNumberClick(Sender: TObject);
    procedure ButtonChoseSampleImageClick(Sender: TObject);
    procedure bCannyClick(Sender: TObject);
    procedure bBinarizeClick(Sender: TObject);
    procedure bOverlaymaskClick(Sender: TObject);
    procedure bRecognizeClick(Sender: TObject);
    procedure bRefreshClick(Sender: TObject);
    procedure bInterpolateClick(Sender: TObject);
    procedure EditHChange(Sender: TObject);
    procedure EditWChange(Sender: TObject);
    procedure bHistoryClearClick(Sender: TObject);
    procedure bCopyToClipClick(Sender: TObject);
    procedure ButtonRecognizeClick(Sender: TObject);
    procedure bAllInDirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRecognize : TFormRecognize;
  SymbolsArray  : TSizeSymbolsArray;
  NumberArray   : TSymbolsArray;
  BMP           : TBitmap;
  BMP_BW        : TBitmap;
  KPorp         : Double;
  
implementation

{$R *.dfm}

function GetNextFileName(Path: string): string;
const
  ListFileName = 'ListFile.lst';
  FileMask = '*.*';
  var
  SearchRec: TSearchRec;
begin
  with TStringList.Create do
  begin
    if FileExists(ListFileName) then
    begin
      LoadFromFile(ListFileName);
    end;
    if FindFirst(IncludeTrailingBackslash(Path) + FileMask,
      faAnyFile and not faDirectory,
      SearchRec) = 0 then
    begin
      // Редкий случай, когда цикл repeat..until
      // на что-то годится
      repeat
        Result := SearchRec.Name;
        if (FindNext(SearchRec) <> 0) then
        begin
          Clear;
        end;
      until (IndexOf(Result) = -1);
      Add(Result);
      FindClose(SearchRec);
    end
    else
    begin
      Result := '';
    end;
    SaveToFile(ListFileName);
    Free;
  end;
end;

procedure PutStringIntoClipBoard(const Str: WideString);
var
  Size: Integer;
  Data: THandle;
  DataPtr: Pointer;
begin
  Size := Length(Str);
  if Size = 0 then
    exit;
  if not IsClipboardFormatAvailable(CF_UNICODETEXT) then
    Clipboard.AsText := Str
  else
  begin
    Size := Size shl 1 + 2;
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, Size);
    try
      DataPtr := GlobalLock(Data);
      try
        Move(Pointer(Str)^, DataPtr^, Size);
        Clipboard.SetAsHandle(CF_UNICODETEXT, Data);
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  end;
end;



function GetBinarizType(): TBWFilterType;
begin
  if FormRecognize.RadioGroupBinarization.ItemIndex = 0 then Result := fBlackMass
  else Result := fFindMin;
end;

function GetSplineType(): TSplineType;
begin
  if FormRecognize.RadioGroupBinarization.ItemIndex = 0 then Result := fLinear
  else if FormRecognize.RadioGroupBinarization.ItemIndex = 1 then Result := fCubic
  else Result := fAkima;
end;

function GetCannyFType(): TCannyFilterType;
begin
  if FormRecognize.RadioGroupCanny.ItemIndex = 0 then Result := fSimple
  else Result := fHysteresis;
end;

procedure GetCannyTh(out Th, Th1, Th2: byte);
begin
  Th  := tRoundToByte(StrToInt(FormRecognize.EditCannyTh.Text));
  Th1 := tRoundToByte(StrToInt(FormRecognize.EditCannyTh1.Text));
  Th2 := tRoundToByte(StrToInt(FormRecognize.EditCannyTh2.Text));
end;

function GetCannySett(): TCannySetting;
var FType: TCannyFilterType;
    Th, Th1, Th2: byte;
begin
  FType := GetCannyFType();
  GetCannyTh(Th, Th1, Th2);
  Result.FilterType := FType;
  Result.Th         := Th;
  Result.Th1        := Th1;
  Result.Th2        := Th2;
end;

function GetSmoothType(): TSmoothingType;
begin
  if FormRecognize.RadioGroupSmooth.ItemIndex = 0 then Result := fCubicSpline
  else Result := fSevenNonLinear;
end;

function GetResizeType(): TResizeType;
begin
  if FormRecognize.RadioGroupResizeType.ItemIndex = 0 then Result := fAverageArea
  else if FormRecognize.RadioGroupResizeType.ItemIndex = 1 then Result := fBilinearSpline
  else if FormRecognize.RadioGroupResizeType.ItemIndex = 2 then Result := fBicubicSpline
  else Result := fBiakimaSpline;
end;

function GetSmoothSett(): TSmoothSetting;
begin
  Result.SmoothType   := GetSmoothType();
  Result.CycledFilter := FormRecognize.CheckBoxEnableSmooth.Checked;
  Result.Coef         := round(StrToInt(FormRecognize.EditSmoothCoeff.Text));
  Result.Dsc          := StrToFloat(FormRecognize.EditSmoothDsc.Text);
end;

function GetBinarSett(): TBinarizeSetting;
begin
  Result.MaxThreshold := tRoundToByte(StrToInt(FormRecognize.EditBinarizeMax.Text));
  Result.MinThreshold := tRoundToByte(StrToInt(FormRecognize.EditBinarizeMin.Text));
  Result.FilterType   := GetBinarizType();
  Result.PercentMass  := StrToInt(FormRecognize.EditBinarizMass.Text);
  Result.SmoothSett   := GetSmoothSett();
  Result.SplineType   := GetSplineType();
end;

function GetMaskType(): TOverlayMaskType;
begin
  if FormRecognize.RadioGroupMaskType.ItemIndex = 0 then Result := mSobel
  else Result := mGaussuanBlur;
end;

function GetSymSizeType(): TSymbolSize;
begin
  if FormRecognize.RadioGroupSymbSize.ItemIndex = 0 then Result := s32
  else if FormRecognize.RadioGroupSymbSize.ItemIndex = 1 then Result := s16
  else Result := s8;
end; // GetSymSizeType();

procedure TFormRecognize.bAllInDirClick(Sender: TObject);
var fname, fdir, fullname: TFileName;
    tmpBMP : TBitmap;
    ImgArr : TImageArray;
    Th: byte;
    Res : TSymbolsArray;
    i: word;
    text : string;
    bTime, eTime: TDateTime;
    h, m, s, ms: word;
begin
  if CheckBoxPerfomEnable.Checked then bTime := GetTime;

  tmpBMP := TBitmap.Create;
  fname := EditOpenImage.Text;
  fullname := '';
  fdir := ExtractFileDir(EditOpenImage.Text);
  while fullname <> EditOpenImage.Text do
  begin
    fname := GetNextFileName(fdir);
    fullname := fdir + '\' + fname;
    // bw
    tmpBMP.Free;
    try
      tmpBMP := iOpenFromFile(fullname);
    except
      raise Exception.Create('Error! Open file');
      Exit;
    end;
    iBMPtoArray(tmpBMP, ImgArr);
    Th := FindTImageArrayBlackThreshold(ImgArr, GetBinarSett());
    MonochromeToBWTImageArray(ImgArr, Th);
    if RadioGroupRecType.ItemIndex = 0 then begin
      try
        SetLength(Res, 0);
        Res := RecognizeMainSegmentSymbolsNumberFromBWTImageArray(ImgArr, SymbolsArray[GetSymSizeType()], GetSymSizeType(), GetResizeType());
      except
        ListBoxHistory.Items.Append('');
        Continue;
      end
    end
    else begin
      try
        SetLength(Res, 0);
        Res := RecognizeRUSNumberFromBWTImageArray(ImgArr, SymbolsArray[GetSymSizeType()], GetSymSizeType(), GetResizeType());
      except
        ListBoxHistory.Items.Append('');
        Continue;
      end;
    end;
    text := '';
    for i := 0 to high(Res) do
      text := text + Res[i].symbol;
    ListBoxHistory.Items.Append(text);
  end;
  if CheckBoxPerfomEnable.Checked then begin
    eTime := GetTime - bTime;
    decodetime(eTime, h, m, s, ms);
    LabelPerfomance.Caption := 'Speed: ' + IntToStr(h) + ' h,' + IntToStr(s) + ' s,' + IntToStr(ms) + ' ms';
    EditPerfomance.Text := IntToStr(s*1000 + ms);
  end;
  DeleteFile('ListFile.lst');
end;

procedure TFormRecognize.bAverBrightClick(Sender: TObject);
var ImgArr1, ImgArr2 : TImageArray;
    BMP              : TBitmap;
    BrightArr        : TBrightnessArray;
    ByteArr          : TDByteArray;
begin
  BMP       := TBitmap.Create;
  BMP.Assign(ImageOrig.Picture.Bitmap);
  iBMPtoArray(BMP, ImgArr1);
  BrightArr := CreateAverageTBrightnessArray(ImgArr1);
  ByteArr   := BrightArr;
  if CheckBoxEnableSmooth.Checked then aSmoothing(ByteArr, GetSmoothSett());
  aConvertToArray(ByteArr, ImgArr2);
  ImgArr1 := aResize(ImgArr2, round(Length(ImgArr2)/3), Length(ImgArr2[0]));
  ImageFin.Picture.Bitmap.Assign(iArrayToBMP(ImgArr1));
end;

procedure TFormRecognize.bSaveRightImgClick(Sender: TObject);
var sFileName : TFileName;
    BMP       : TBitmap;
begin
  if SaveDialog.Execute then sFileName := SaveDialog.FileName;
  if sFileName <> '' then begin
    sFileName := sFileName + '.bmp';
    BMP := TBitmap.Create;
    BMP.Assign(ImageFin.Picture.Bitmap);
    BMP.SaveToFile(sFileName);
  end;
end;

procedure TFormRecognize.bFindNumberClick(Sender: TObject);
Var BMP               : TBitmap;
    SArr, OArr, ImgArr: TImageArray;
    IncXY             : TDWord2Array;
    Cord              : TMargins;
begin
  BMP := TBitmap.Create;
  BMP.Assign(ImageOrig.Picture.Bitmap);
  iBMPtoArray(BMP, OArr);

  BMP.Free;
  BMP := iOpenFromFile(EditSampleImage.Text);
  iBMPtoArray(BMP, SArr);

  Cord := FindNumberRectangle(SArr, OArr, IncXY, GetCannySett(), RUS);

  aConvertToArray(IncXY, ImgArr);
  ImageFin.Picture.Bitmap.Assign(iArrayToBMP(ImgArr));

  LabelXY.Caption := 'X: ' + IntToStr(Cord.left) + '; Y: ' + IntToStr(Cord.top);
end;

procedure TFormRecognize.bHistoryClearClick(Sender: TObject);
begin
  ListBoxHistory.Items.Clear;
end;

procedure TFormRecognize.bInterpolateClick(Sender: TObject);
var BMPInt: TBitmap;
    bTime, eTime: TDateTime;
    h, m, s, ms: word;
begin
  if CheckBoxPerfomEnable.Checked then bTime := GetTime;
  BMPInt := iResize(BMP, StrToInt(EditH.Text), StrToInt(EditW.Text), GetResizeType(), CheckBoxMonochrome.Checked);
  if CheckBoxPerfomEnable.Checked then begin
    eTime := GetTime - bTime;
    decodetime(eTime, h, m, s, ms);
    LabelPerfomance.Caption := 'Speed: ' + IntToStr(h) + ' h,' + IntToStr(s) + ' s,' + IntToStr(ms) + ' ms';
    EditPerfomance.Text := IntToStr(s*1000 + ms);
  end;
  ImageFin.Picture.Bitmap.Assign(BMPInt);
end;

procedure TFormRecognize.bLevelsClick(Sender: TObject);
var ImgArr1, ImgArr2 : TImageArray;
    BMP              : TBitmap;
    LevelsArr        : TLevelsArray;
begin
  BMP := TBitmap.Create;
  BMP.Assign(ImageOrig.Picture.Bitmap);
  iBMPtoArray(BMP, ImgArr1);

  LevelsArr := CreateTLevelsArray(ImgArr1);
  if CheckBoxEnableSmooth.Checked then aSmoothing(LevelsArr, GetSmoothSett());///round(StrToInt(EditSmoothCoeff.Text)), GetSmoothType(), StrToFloat(EditSmoothDsc.Text), CheckBoxSmoothCycled.Enabled);
  aConvertToArray(LevelsArr, ImgArr2, strtoint(EditMaxLevel.text));

  ImgArr1 := aResize(ImgArr2, 100, Length(ImgArr2[0]));
  ImageFin.Picture.Bitmap.Assign(iArrayToBMP(ImgArr1));
end;

procedure TFormRecognize.bOverlaymaskClick(Sender: TObject);
var BMP              : TBitmap;
    ImgArr1,ImgArr2  : TImageArray;
begin
  BMP := TBitmap.Create;
  BMP.Assign(ImageOrig.Picture.Bitmap);
  iBMPtoArray(BMP, ImgArr1);

  ImgArr2 := OverlayMaskTypeToTImageArray(ImgArr1, GetMaskType, StrToInt(EditMaskScale.Text), StrToInt(EditBrightFlush.Text));

  ImageFin.Picture.Bitmap.Assign(iArrayToBMP(ImgArr2));
end;

procedure TFormRecognize.bRecognizeClick(Sender: TObject);
var //BMP              : TBitmap;
    ImgArr1          : TImageArray;
    Res1, Res2      : TSymbolsArray;
    i                : Integer;
begin
  {BMP := TBitmap.Create;
  BMP.Assign(ImageOrig.Picture.Bitmap);}
  iBMPtoArray(BMP_BW, ImgArr1);
  try
    Res1 := RecognizeMainSegmentSymbolsNumberFromBWTImageArray(ImgArr1, SymbolsArray[GetSymSizeType()], GetSymSizeType(), GetResizeType());
  except
  end;
  try
    Res2 := RecognizeRUSNumberFromBWTImageArray(ImgArr1, SymbolsArray[GetSymSizeType()], GetSymSizeType(), GetResizeType());
  except
  end;
  EditNumber1.Text := '';
  EditNumber2.Text := '';
  for i := 0 to high(Res1) do
    EditNumber1.Text := EditNumber1.Text + Res1[i].symbol;
  for i := 0 to high(Res2) do
    EditNumber2.Text := EditNumber2.Text + Res2[i].symbol;

  ListBoxHistory.Items.Append(EditNumber1.Text + ' | ' + EditNumber2.Text);
end;

procedure TFormRecognize.bRefreshClick(Sender: TObject);
var ImgArr1, ImgArr2 : TImageArray;
    BrightArr        : TBrightnessArray;
    ByteArr          : TDByteArray;
    LevelsArr        : TLevelsArray;
    Th               : Byte;
begin
  BMP     := TBitmap.Create;
  BMP_BW  := TBitmap.Create;
  try
    BMP := iOpenFromFile(EditOpenImage.Text)
  except
    raise Exception.Create('Error! Open file');
    Exit;
  end;
  EditW.Text := IntToStr(BMP.Width);
  EditH.Text := IntToStr(BMP.Height);
  KPorp      := BMP.Height/BMP.Width;
   
  // ImageAverBright
  iBMPtoArray(BMP, ImgArr1);
  BrightArr := CreateAverageTBrightnessArray(ImgArr1);
  ByteArr   := BrightArr;
  if CheckBoxEnableSmooth.Checked then aSmoothing(ByteArr, GetSmoothSett());
  aConvertToArray(ByteArr, ImgArr2);
  ImgArr1 := aResize(ImgArr2, 100, 255, GetResizeType());
  ImageAverBright.Picture.Bitmap.Assign(iArrayToBMP(ImgArr1));

  // ImageLevels
  iBMPtoArray(BMP, ImgArr1);
  LevelsArr := CreateTLevelsArray(ImgArr1);
  if CheckBoxEnableSmooth.Checked then aSmoothing(LevelsArr, GetSmoothSett());
  aConvertToArray(LevelsArr, ImgArr2, strtoint(EditMaxLevel.text));
  ImgArr1 := aResize(ImgArr2, 100, 255);
  ImageLevels.Picture.Bitmap.Assign(iArrayToBMP(ImgArr1));

  // BMP_BW
  iBMPtoArray(BMP, ImgArr1);
  Th := FindTImageArrayBlackThreshold(ImgArr1, GetBinarSett());
  EditBinarizeTh.Text := IntToStr(Th);
  MonochromeToBWTImageArray(ImgArr1, Th);
  BMP_BW := iArrayToBMP(ImgArr1);

end;

procedure TFormRecognize.bBinarizeClick(Sender: TObject);
var BMP              : TBitmap;
    ImgArr1          : TImageArray;
    Th               : Byte;
begin
  BMP := TBitmap.Create;
  BMP.Assign(ImageOrig.Picture.Bitmap);
  iBMPtoArray(BMP, ImgArr1);

  Th := FindTImageArrayBlackThreshold(ImgArr1, GetBinarSett());
  EditBinarizeTh.Text := IntToStr(Th);
  MonochromeToBWTImageArray(ImgArr1, Th);

  ImageFin.Picture.Bitmap.Assign(iArrayToBMP(ImgArr1));
end;

procedure TFormRecognize.bCannyClick(Sender: TObject);
var BMP              : TBitmap;
    ImgArr1, ImgArr2 : TImageArray;
    Th, Th1, Th2     : Byte;
begin
  BMP := TBitmap.Create;
  BMP.Assign(ImageOrig.Picture.Bitmap);
  iBMPtoArray(BMP, ImgArr1);

  GetCannyTh(Th, Th1, Th2);
  ImgArr2 := CannyFiltration(ImgArr1, GetCannySett());

  ImageFin.Picture.Bitmap.Assign(iArrayToBMP(ImgArr2));
end;

procedure TFormRecognize.bCopyToClipClick(Sender: TObject);
begin
  PutStringIntoClipBoard(ListBoxHistory.Items.Text);
end;

procedure TFormRecognize.ButtonChoseImageClick(Sender: TObject);
var FileName : String;
    BMP      : TBitmap;
begin
  If OpenDialog.Execute Then begin
    EditOpenImage.Text := OpenDialog.FileName;
    If EditOpenImage.Text <> '' Then
      Begin
        FileName  := EditOpenImage.Text;
        BMP       := iOpenFromFile(FileName);
        ImageOrig.Picture.Bitmap.Assign(BMP);
        bRefreshClick(Sender);
      End;
  end;
end;

procedure TFormRecognize.ButtonChoseSampleImageClick(Sender: TObject);
begin
  If OpenDialog.Execute Then EditSampleImage.Text := OpenDialog.FileName;
end;

procedure TFormRecognize.ButtonCreateClick(Sender: TObject);
begin
  if EditSymbols.Text = '' then Exit;
  SymbolsArray := CreateTSizeSymbolsArrayFromStr(EditSymbols.Text);
end;

procedure TFormRecognize.ButtonFrontClick(Sender: TObject);
begin
  if FontDialog.Execute then
    LabelFont.Caption := 'Name: ' + FontDialog.Font.Name + #13#10 +
                         'Size: ' + inttostr(FontDialog.Font.Size);
end;


procedure TFormRecognize.ButtonRecognizeClick(Sender: TObject);
begin
  bRecognizeClick(Sender);
end;

procedure TFormRecognize.EditHChange(Sender: TObject);
begin
  if CheckBoxIntProp.Checked then EditW.Text := IntToStr(Round(StrToInt(EditH.Text)/KPorp));
end;

procedure TFormRecognize.EditWChange(Sender: TObject);
begin
  if CheckBoxIntProp.Checked then EditH.Text := IntToStr(Round(StrToInt(EditW.Text)*KPorp));
end;

procedure TFormRecognize.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DeleteFile('ListFile.lst');
end;

end.
