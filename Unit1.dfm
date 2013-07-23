object FormRecognize: TFormRecognize
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'FormRecognize'
  ClientHeight = 615
  ClientWidth = 1097
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object LabelXY: TLabel
    Left = 400
    Top = 100
    Width = 61
    Height = 13
    Caption = 'X: nn, Y: mm'
  end
  object Label1: TLabel
    Left = 481
    Top = 21
    Width = 45
    Height = 13
    Caption = 'Max level'
  end
  object ScrollBoxOrig: TScrollBox
    Left = 143
    Top = 119
    Width = 481
    Height = 370
    TabOrder = 0
    object ImageOrig: TImage
      Left = 0
      Top = 0
      Width = 476
      Height = 365
      AutoSize = True
      Proportional = True
    end
  end
  object GroupBoxPref: TGroupBox
    Left = 0
    Top = 0
    Width = 137
    Height = 102
    Caption = 'Symbols preferences'
    TabOrder = 1
    object LabelFont: TLabel
      Left = 3
      Top = 74
      Width = 67
      Height = 13
      Caption = 'Chose Font...'
    end
    object ButtonFront: TButton
      Left = 3
      Top = 43
      Width = 49
      Height = 25
      Caption = 'Front'
      TabOrder = 0
      OnClick = ButtonFrontClick
    end
    object ButtonCreate: TButton
      Left = 85
      Top = 43
      Width = 49
      Height = 25
      Caption = 'Create'
      TabOrder = 1
      OnClick = ButtonCreateClick
    end
    object EditSymbols: TEdit
      Left = 3
      Top = 16
      Width = 128
      Height = 21
      TabOrder = 2
      Text = '1234567890ABCEHKMOPCTXY'
    end
  end
  object GroupBoxNumber: TGroupBox
    Left = 143
    Top = 0
    Width = 250
    Height = 113
    Caption = 'Chose Image'
    TabOrder = 2
    object EditOpenImage: TEdit
      Left = 3
      Top = 16
      Width = 212
      Height = 21
      TabOrder = 0
      Text = 'Chose image file'
    end
    object ButtonChoseImage: TButton
      Left = 221
      Top = 14
      Width = 26
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = ButtonChoseImageClick
    end
    object ButtonRecognize: TButton
      Left = 141
      Top = 74
      Width = 75
      Height = 25
      Caption = 'Recognize'
      TabOrder = 2
      OnClick = ButtonRecognizeClick
    end
    object EditSampleImage: TEdit
      Left = 3
      Top = 43
      Width = 212
      Height = 21
      TabOrder = 3
      Text = 'Chose sample image file'
    end
    object ButtonChoseSampleImage: TButton
      Left = 221
      Top = 43
      Width = 26
      Height = 25
      Caption = '...'
      TabOrder = 4
      OnClick = ButtonChoseSampleImageClick
    end
    object bRefresh: TButton
      Left = 222
      Top = 74
      Width = 25
      Height = 25
      Caption = 'R'
      TabOrder = 5
      OnClick = bRefreshClick
    end
    object bAllInDir: TButton
      Left = 86
      Top = 74
      Width = 49
      Height = 25
      Caption = 'AllInDir'
      TabOrder = 6
      OnClick = bAllInDirClick
    end
  end
  object ScrollBoxFin: TScrollBox
    Left = 625
    Top = 119
    Width = 472
    Height = 370
    TabOrder = 3
    object ImageFin: TImage
      Left = -1
      Top = -3
      Width = 468
      Height = 368
      AutoSize = True
      Proportional = True
    end
  end
  object bAverBright: TButton
    Left = 400
    Top = 8
    Width = 75
    Height = 25
    Caption = 'AverBright'
    TabOrder = 4
    OnClick = bAverBrightClick
  end
  object bSaveRightImg: TButton
    Left = 481
    Top = 70
    Width = 56
    Height = 43
    Caption = 'Save'
    TabOrder = 5
    OnClick = bSaveRightImgClick
  end
  object bLevels: TButton
    Left = 400
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Levels'
    TabOrder = 6
    OnClick = bLevelsClick
  end
  object bFindNumber: TButton
    Left = 400
    Top = 70
    Width = 75
    Height = 25
    Caption = 'FindNumber'
    TabOrder = 7
    OnClick = bFindNumberClick
  end
  object EditMaxLevel: TEdit
    Left = 481
    Top = 40
    Width = 56
    Height = 24
    TabOrder = 8
    Text = '0'
  end
  object GroupBoxSmooth: TGroupBox
    Left = 543
    Top = 0
    Width = 202
    Height = 113
    Caption = 'Smooth'
    TabOrder = 9
    object Label2: TLabel
      Left = 131
      Top = 22
      Width = 11
      Height = 12
      Caption = 'Cf'
    end
    object Label3: TLabel
      Left = 125
      Top = 44
      Width = 17
      Height = 13
      Caption = 'Dsc'
    end
    object RadioGroupSmooth: TRadioGroup
      Left = 3
      Top = 40
      Width = 116
      Height = 70
      Caption = 'Type'
      ItemIndex = 0
      Items.Strings = (
        'CubicSpline'
        'SevenNonLinear')
      TabOrder = 0
    end
    object CheckBoxEnableSmooth: TCheckBox
      Left = 11
      Top = 17
      Width = 88
      Height = 17
      Caption = 'EnableSmooth'
      TabOrder = 1
    end
    object EditSmoothCoeff: TEdit
      Left = 148
      Top = 17
      Width = 44
      Height = 21
      TabOrder = 2
      Text = '5'
    end
    object EditSmoothDsc: TEdit
      Left = 148
      Top = 42
      Width = 44
      Height = 21
      TabOrder = 3
      Text = '1,0'
    end
    object CheckBoxSmoothCycled: TCheckBox
      Left = 125
      Top = 69
      Width = 58
      Height = 17
      Caption = 'Cycled'
      TabOrder = 4
    end
  end
  object GroupBoxCanny: TGroupBox
    Left = 751
    Top = 0
    Width = 197
    Height = 113
    Caption = 'Canny'
    TabOrder = 10
    object GroupBoxCannyThreshold: TGroupBox
      Left = 95
      Top = 8
      Width = 98
      Height = 102
      Caption = 'CannyThreshold'
      TabOrder = 0
      object Label4: TLabel
        Left = 3
        Top = 24
        Width = 12
        Height = 13
        Caption = 'Th'
      end
      object Label5: TLabel
        Left = 3
        Top = 51
        Width = 18
        Height = 13
        Caption = 'Th1'
      end
      object Label6: TLabel
        Left = 3
        Top = 75
        Width = 18
        Height = 13
        Caption = 'Th2'
      end
      object EditCannyTh: TEdit
        Left = 25
        Top = 21
        Width = 64
        Height = 21
        TabOrder = 0
        Text = '100'
      end
      object EditCannyTh1: TEdit
        Left = 24
        Top = 48
        Width = 65
        Height = 21
        TabOrder = 1
        Text = '200'
      end
      object EditCannyTh2: TEdit
        Left = 24
        Top = 75
        Width = 65
        Height = 21
        TabOrder = 2
        Text = '50'
      end
    end
    object RadioGroupCanny: TRadioGroup
      Left = 3
      Top = 46
      Width = 86
      Height = 62
      Caption = 'FilterType'
      ItemIndex = 0
      Items.Strings = (
        'Simple'
        'Hysteresis')
      TabOrder = 1
    end
    object bCanny: TButton
      Left = 3
      Top = 15
      Width = 86
      Height = 25
      Caption = 'Canny'
      TabOrder = 2
      OnClick = bCannyClick
    end
  end
  object GroupBoxBinarization: TGroupBox
    Left = 0
    Top = 104
    Width = 137
    Height = 125
    Caption = 'Binarization'
    TabOrder = 11
    object Label7: TLabel
      Left = 66
      Top = 22
      Width = 12
      Height = 13
      Caption = 'Th'
    end
    object Label8: TLabel
      Left = 95
      Top = 48
      Width = 38
      Height = 13
      Caption = 'Mass %'
    end
    object Label9: TLabel
      Left = 3
      Top = 101
      Width = 58
      Height = 13
      Caption = 'Max, Min Th'
    end
    object bBinarize: TButton
      Left = 3
      Top = 17
      Width = 48
      Height = 25
      Caption = 'Binarize'
      TabOrder = 0
      OnClick = bBinarizeClick
    end
    object EditBinarizeTh: TEdit
      Left = 84
      Top = 19
      Width = 46
      Height = 21
      TabOrder = 1
      Text = '?'
    end
    object RadioGroupBinarization: TRadioGroup
      Left = 3
      Top = 46
      Width = 86
      Height = 49
      Caption = 'Type'
      ItemIndex = 0
      Items.Strings = (
        'BlackMass'
        'FindMin')
      TabOrder = 2
    end
    object EditBinarizMass: TEdit
      Left = 93
      Top = 67
      Width = 41
      Height = 21
      TabOrder = 3
      Text = '25'
    end
    object EditBinarizeMax: TEdit
      Left = 66
      Top = 101
      Width = 32
      Height = 20
      TabOrder = 4
      Text = '185'
    end
    object EditBinarizeMin: TEdit
      Left = 104
      Top = 101
      Width = 28
      Height = 20
      TabOrder = 5
      Text = '70'
    end
  end
  object RadioGroupSplineType: TRadioGroup
    Left = 0
    Top = 231
    Width = 66
    Height = 62
    Caption = 'SplineType'
    ItemIndex = 2
    Items.Strings = (
      'Linear'
      'Cubic'
      'Akima')
    TabOrder = 12
  end
  object GroupBoxOverlayMask: TGroupBox
    Left = 950
    Top = 0
    Width = 147
    Height = 113
    Caption = 'OverlayMask'
    TabOrder = 13
    object Label10: TLabel
      Left = 110
      Top = 10
      Width = 25
      Height = 13
      Caption = 'Scale'
    end
    object Label11: TLabel
      Left = 110
      Top = 61
      Width = 28
      Height = 13
      Caption = 'Bright'
    end
    object RadioGroupMaskType: TRadioGroup
      Left = 4
      Top = 17
      Width = 100
      Height = 57
      Caption = 'MaskType'
      ItemIndex = 0
      Items.Strings = (
        'SobelMask'
        'GaussuanBlur')
      TabOrder = 0
    end
    object bOverlaymask: TButton
      Left = 4
      Top = 80
      Width = 100
      Height = 25
      Caption = 'Overlay'
      TabOrder = 1
      OnClick = bOverlaymaskClick
    end
    object EditMaskScale: TEdit
      Left = 110
      Top = 29
      Width = 27
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object EditBrightFlush: TEdit
      Left = 110
      Top = 80
      Width = 27
      Height = 21
      TabOrder = 3
      Text = '0'
    end
  end
  object GroupBoxRecognize: TGroupBox
    Left = 0
    Top = 299
    Width = 137
    Height = 185
    Caption = 'Recognize'
    TabOrder = 14
    object Label12: TLabel
      Left = 8
      Top = 24
      Width = 44
      Height = 13
      Caption = 'Universal'
    end
    object Label13: TLabel
      Left = 8
      Top = 48
      Width = 44
      Height = 13
      Caption = 'RUS Num'
    end
    object EditNumber1: TEdit
      Left = 56
      Top = 20
      Width = 78
      Height = 21
      TabOrder = 0
      Text = '?'
    end
    object bRecognize: TButton
      Left = 77
      Top = 74
      Width = 57
      Height = 23
      Caption = 'Recognize'
      TabOrder = 1
      OnClick = bRecognizeClick
    end
    object EditNumber2: TEdit
      Left = 56
      Top = 47
      Width = 78
      Height = 21
      TabOrder = 2
      Text = '?'
    end
    object ListBoxHistory: TListBox
      Left = 0
      Top = 103
      Width = 137
      Height = 82
      ItemHeight = 13
      TabOrder = 3
    end
    object bHistoryClear: TButton
      Left = 3
      Top = 74
      Width = 29
      Height = 23
      Caption = 'Clear'
      TabOrder = 4
      OnClick = bHistoryClearClick
    end
    object bCopyToClip: TButton
      Left = 38
      Top = 74
      Width = 33
      Height = 23
      Caption = 'Copy'
      TabOrder = 5
      OnClick = bCopyToClipClick
    end
  end
  object RadioGroupSymbSize: TRadioGroup
    Left = 72
    Top = 231
    Width = 65
    Height = 62
    Caption = 'SbSize'
    ItemIndex = 1
    Items.Strings = (
      '32'
      '16'
      '8')
    TabOrder = 15
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 490
    Width = 265
    Height = 125
    Caption = 'Average Bright'
    TabOrder = 16
    object ImageAverBright: TImage
      Left = 3
      Top = 16
      Width = 256
      Height = 100
      Proportional = True
      Stretch = True
    end
  end
  object GroupBox2: TGroupBox
    Left = 271
    Top = 490
    Width = 266
    Height = 124
    Caption = 'Levels'
    TabOrder = 17
    object ImageLevels: TImage
      Left = 3
      Top = 16
      Width = 256
      Height = 100
      Proportional = True
      Stretch = True
    end
  end
  object GroupBox3: TGroupBox
    Left = 543
    Top = 490
    Width = 193
    Height = 124
    Caption = 'Image'
    TabOrder = 18
    object Label14: TLabel
      Left = 101
      Top = 36
      Width = 7
      Height = 13
      Caption = 'H'
    end
    object Label15: TLabel
      Left = 101
      Top = 63
      Width = 10
      Height = 13
      Caption = 'W'
    end
    object bInterpolate: TButton
      Left = 3
      Top = 90
      Width = 94
      Height = 27
      Caption = 'Interpolate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      WordWrap = True
      OnClick = bInterpolateClick
    end
    object RadioGroupResizeType: TRadioGroup
      Left = 3
      Top = 11
      Width = 94
      Height = 73
      Caption = 'ResizeType'
      ItemIndex = 1
      Items.Strings = (
        'AverageArea'
        'Bilinear'
        'Bicubic'
        'Biakima')
      TabOrder = 1
    end
    object EditH: TEdit
      Left = 114
      Top = 34
      Width = 68
      Height = 21
      TabOrder = 2
      OnChange = EditHChange
    end
    object EditW: TEdit
      Left = 114
      Top = 61
      Width = 68
      Height = 21
      TabOrder = 3
      OnChange = EditWChange
    end
    object CheckBoxIntProp: TCheckBox
      Left = 103
      Top = 13
      Width = 87
      Height = 17
      Caption = 'Proportional'
      TabOrder = 4
    end
    object CheckBoxMonochrome: TCheckBox
      Left = 103
      Top = 88
      Width = 87
      Height = 17
      Caption = 'Monochrome'
      TabOrder = 5
    end
  end
  object GroupBox4: TGroupBox
    Left = 739
    Top = 490
    Width = 196
    Height = 63
    Caption = 'Perfomance'
    TabOrder = 19
    object LabelPerfomance: TLabel
      Left = 3
      Top = 39
      Width = 68
      Height = 13
      Caption = 'Speed: ??? ms'
    end
    object Label16: TLabel
      Left = 167
      Top = 16
      Width = 13
      Height = 13
      Caption = 'ms'
    end
    object CheckBoxPerfomEnable: TCheckBox
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Enable'
      TabOrder = 0
    end
    object EditPerfomance: TEdit
      Left = 72
      Top = 12
      Width = 89
      Height = 21
      TabOrder = 1
      Text = '?'
    end
  end
  object RadioGroupRecType: TRadioGroup
    Left = 739
    Top = 559
    Width = 154
    Height = 55
    Caption = 'RecognizeType'
    ItemIndex = 0
    Items.Strings = (
      'Segmentation (Universal)'
      'Character (RUS)')
    TabOrder = 20
  end
  object FontDialog: TFontDialog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -96
    Font.Name = 'RoadNumbers'
    Font.Style = []
    Left = 104
    Top = 72
  end
  object OpenDialog: TOpenDialog
    Filter = 'image|*.bmp;*.jpg'
    Left = 152
    Top = 72
  end
  object SaveDialog: TSaveDialog
    Filter = 'bmp|*.bmp'
    Left = 184
    Top = 72
  end
end
