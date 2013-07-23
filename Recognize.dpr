program Recognize;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FormRecognize},
  ImgLibArrayExt in 'ImgLibArrayExt.pas',
  ImgLibImageExt in 'ImgLibImageExt.pas',
  ImgLibImpl in 'ImgLibImpl.pas',
  ImgLibTypes in 'ImgLibTypes.pas',
  QPixels in 'QPixels.pas',
  SplineLibBilinear in 'SplineLibBilinear.pas',
  SplineLibLinear in 'SplineLibLinear.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormRecognize, FormRecognize);
  Application.Run;
end.
