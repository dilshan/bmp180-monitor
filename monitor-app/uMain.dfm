object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'BMP180 sensor monitor'
  ClientHeight = 713
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grpSensorTester: TGroupBox
    Left = 8
    Top = 8
    Width = 234
    Height = 97
    Caption = ' Sensor tester '
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 21
      Height = 13
      Caption = 'VID:'
    end
    object Label2: TLabel
      Left = 16
      Top = 59
      Width = 21
      Height = 13
      Caption = 'PID:'
    end
    object txtVid: TEdit
      Left = 43
      Top = 29
      Width = 57
      Height = 21
      TabOrder = 0
      Text = '8420'
    end
    object txtPid: TEdit
      Left = 43
      Top = 56
      Width = 57
      Height = 21
      TabOrder = 1
      Text = 'c'
    end
    object btnConnect: TButton
      Left = 142
      Top = 23
      Width = 75
      Height = 25
      Caption = 'Connect'
      TabOrder = 2
      OnClick = btnConnectClick
    end
    object btnDisconnect: TButton
      Left = 142
      Top = 54
      Width = 75
      Height = 25
      Caption = 'Disconnect'
      TabOrder = 3
      OnClick = btnDisconnectClick
    end
  end
  object grpCalibration: TGroupBox
    Left = 248
    Top = 8
    Width = 385
    Height = 177
    Caption = ' EEPROM calibration coefficients '
    Enabled = False
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 32
      Width = 24
      Height = 13
      Caption = 'AC1:'
    end
    object Label4: TLabel
      Left = 16
      Top = 59
      Width = 24
      Height = 13
      Caption = 'AC4:'
    end
    object Label5: TLabel
      Left = 144
      Top = 32
      Width = 24
      Height = 13
      Caption = 'AC2:'
    end
    object Label6: TLabel
      Left = 144
      Top = 59
      Width = 24
      Height = 13
      Caption = 'AC5:'
    end
    object Label7: TLabel
      Left = 272
      Top = 32
      Width = 24
      Height = 13
      Caption = 'AC3:'
    end
    object Label8: TLabel
      Left = 272
      Top = 59
      Width = 24
      Height = 13
      Caption = 'AC6:'
    end
    object Label9: TLabel
      Left = 16
      Top = 113
      Width = 16
      Height = 13
      Caption = 'B1:'
    end
    object Label10: TLabel
      Left = 144
      Top = 113
      Width = 16
      Height = 13
      Caption = 'B2:'
    end
    object Label11: TLabel
      Left = 16
      Top = 86
      Width = 18
      Height = 13
      Caption = 'MB:'
    end
    object Label12: TLabel
      Left = 144
      Top = 86
      Width = 19
      Height = 13
      Caption = 'MC:'
    end
    object Label13: TLabel
      Left = 272
      Top = 86
      Width = 19
      Height = 13
      Caption = 'MD:'
    end
    object txtAc1: TEdit
      Left = 46
      Top = 29
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object txtAc4: TEdit
      Left = 46
      Top = 56
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 3
    end
    object txtAc2: TEdit
      Left = 174
      Top = 29
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
    object txtAc5: TEdit
      Left = 174
      Top = 56
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 4
    end
    object txtAc3: TEdit
      Left = 302
      Top = 29
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 2
    end
    object txtAc6: TEdit
      Left = 302
      Top = 56
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 5
    end
    object txtB1: TEdit
      Left = 46
      Top = 110
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 9
    end
    object txtB2: TEdit
      Left = 174
      Top = 110
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 10
    end
    object txtMb: TEdit
      Left = 46
      Top = 83
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 6
    end
    object txtMc: TEdit
      Left = 174
      Top = 83
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 7
    end
    object txtMd: TEdit
      Left = 302
      Top = 83
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 8
    end
  end
  object grpSensorData: TGroupBox
    Left = 8
    Top = 111
    Width = 234
    Height = 74
    Caption = ' Sensor readings '
    Enabled = False
    TabOrder = 2
    object Label14: TLabel
      Left = 20
      Top = 32
      Width = 17
      Height = 13
      Caption = 'UP:'
    end
    object Label15: TLabel
      Left = 119
      Top = 32
      Width = 17
      Height = 13
      Caption = 'UT:'
    end
    object txtUp: TEdit
      Left = 43
      Top = 29
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object txtUt: TEdit
      Left = 142
      Top = 29
      Width = 57
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object grpVal: TGroupBox
    Left = 8
    Top = 191
    Width = 625
    Height = 58
    Enabled = False
    TabOrder = 3
    object lblTemp: TLabel
      Left = 169
      Top = 16
      Width = 79
      Height = 25
      Caption = '000.0 C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPa: TLabel
      Left = 423
      Top = 16
      Width = 131
      Height = 25
      Caption = '10000.00 Pa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 20
      Top = 16
      Width = 143
      Height = 25
      Caption = 'Temperature:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 318
      Top = 16
      Width = 99
      Height = 25
      Caption = 'Pressure:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object chtMain: TChart
    Left = 8
    Top = 255
    Width = 625
    Height = 452
    LeftWall.Visible = False
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 4
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object serPa: TFastLineSeries
      LinePen.Color = 10708548
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Data = {
        00190000000000000000A069400000000000A069400000000000205740000000
        00000024400000000000803B4000000000008051400000000000C05740000000
        00005064400000000000F0694000000000009872400000000000507440000000
        0000E06A400000000000206C400000000000C072400000000000787940000000
        0000B87A400000000000087B4000000000000480400000000000308140000000
        0000607D4000000000001880400000000000FC82400000000000988240000000
        00005881400000000000508440}
      Detail = {0000000000}
    end
  end
end
