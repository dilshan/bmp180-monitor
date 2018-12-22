{-------------------------------------------------------------------------------
BMP180 sensor monitoring application.
Copyright © 2018 Dilshan R Jayakody. [jayakody2000lk@gmail.com]

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-------------------------------------------------------------------------------}

unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine, HIDctrlIntf,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls, VCLTee.Series, Math;

type
  TfrmMain = class(TForm)
    grpSensorTester: TGroupBox;
    Label1: TLabel;
    txtVid: TEdit;
    Label2: TLabel;
    txtPid: TEdit;
    btnConnect: TButton;
    btnDisconnect: TButton;
    grpCalibration: TGroupBox;
    Label3: TLabel;
    txtAc1: TEdit;
    Label4: TLabel;
    txtAc4: TEdit;
    Label5: TLabel;
    txtAc2: TEdit;
    Label6: TLabel;
    txtAc5: TEdit;
    Label7: TLabel;
    txtAc3: TEdit;
    Label8: TLabel;
    txtAc6: TEdit;
    Label9: TLabel;
    txtB1: TEdit;
    Label10: TLabel;
    txtB2: TEdit;
    Label11: TLabel;
    txtMb: TEdit;
    Label12: TLabel;
    txtMc: TEdit;
    Label13: TLabel;
    txtMd: TEdit;
    grpSensorData: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    txtUp: TEdit;
    txtUt: TEdit;
    grpVal: TGroupBox;
    lblTemp: TLabel;
    lblPa: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    chtMain: TChart;
    serPa: TFastLineSeries;
    procedure btnConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
  private
    isConnected: Boolean;
  public
    procedure updateData(data : THIDbuffer);
    procedure setUIState(state: Boolean; isConnected: Boolean);
    property isDeviceConnected : Boolean read isConnected write isConnected;
  end;

var
  frmMain: TfrmMain;
  hidList: THIDdeviceList;

procedure hidReaderCallback(data : THIDbuffer); stdcall;
Procedure hidReaderEventCallback;  stdcall;

implementation

{$R *.dfm}

procedure TfrmMain.btnDisconnectClick(Sender: TObject);
begin
  if Length(hidList) > 0 then
  begin
    // Close HID USB device.
    HIDcloseDevice(hidList[0]);

    // Update device connection status to false and reset UI.
    frmMain.isDeviceConnected := false;
    frmMain.setUIState(false, false);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Setup callback routines and update device connection state.
  setUIState(false, false);
  isConnected := false;
  serPa.Clear;

  HIDsetEventHandler(@hidReaderCallback);
  USBsetEventHandler(@hidReaderEventCallback);
end;

procedure TfrmMain.setUIState(state: Boolean; isConnected: Boolean);
begin
  chtMain.Enabled := state;
  txtAc1.Enabled := state;
  txtAc2.Enabled := state;
  txtAc3.Enabled := state;
  txtAc4.Enabled := state;
  txtAc5.Enabled := state;
  txtAc6.Enabled := state;
  txtMb.Enabled := state;
  txtMc.Enabled := state;
  txtMd.Enabled := state;
  txtUp.Enabled := state;
  txtUt.Enabled := state;
  txtB1.Enabled := state;
  txtB2.Enabled := state;

  grpCalibration.Enabled := state;
  grpSensorData.Enabled := state;
  grpVal.Enabled := state;

  btnConnect.Enabled := not isConnected;
  btnDisconnect.Enabled := isConnected;

  txtVid.Enabled := btnConnect.Enabled;
  txtPid.Enabled := btnConnect.Enabled;
end;

procedure TfrmMain.updateData(data : THIDbuffer);
var
  b1Val, b2Val : Int16;
  mbVal, mcVal, mdVal : Int16;
  ac1Val, ac2Val, ac3Val : Int16;
  ac4Val, ac5Val, ac6Val : UInt16;
  tempTU, tempPU : UInt32;

  c3, c4, c5, c6, mc, md, x0, x1, x2, y0, y1, y2, p0, p1, p2, b1 : extended;
  tu, pu : extended;
  a, temp : extended;
  s, x, y, z, presure: extended;
begin
  if(data[0] = $d2) then
  begin
    // Get calibration values from the sensor.
    b1Val := data[1] or (data[2] shl 8);
    b2Val := data[3] or (data[4] shl 8);

    mbVal := data[5] or (data[6] shl 8);
    mcVal := data[7] or (data[8] shl 8);
    mdVal := data[9] or (data[10] shl 8);

    ac1Val := data[11] or (data[12] shl 8);
    ac2Val := data[13] or (data[14] shl 8);
    ac3Val := data[15] or (data[16] shl 8);

    ac4Val := data[17] or (data[18] shl 8);
    ac5Val := data[19] or (data[20] shl 8);
    ac6Val := data[21] or (data[22] shl 8);

    // Get temprature value from sensor.
    tempTU := data[23] or (data[24] shl 8);

    // Get presure values from sensor.
    tempPU := data[26] or (data[25] shl 8) or (data[27] shl 8);

    txtB1.Text := IntToHex(b1Val, 4);
    txtB2.Text := IntToHex(b2Val, 4);

    txtMb.Text := IntToStr(mbVal);
    txtMc.Text := IntToStr(mcVal);
    txtMd.Text := IntToStr(mdVal);

    txtAc1.Text := IntToStr(ac1Val);
    txtAc2.Text := IntToStr(ac2Val);
    txtAc3.Text := IntToStr(ac3Val);

    txtAc4.Text := UIntToStr(ac4Val);
    txtAc5.Text := UIntToStr(ac5Val);
    txtAc6.Text := UIntToStr(ac6Val);

    txtUt.Text := UIntToStr(tempTU);
    txtUp.Text := UIntToStr(tempPU);

    // Setup coefficients to calculate temprature and presure.
    c3 := 160.0 * Power(2, -15) * ac3Val;
    c4 := Power(10, -3) * Power(2, -15) * ac4Val;
    b1 := Power(160, 2) * Power(2, -30) * b1Val;
    c5 := (Power(2, -15) / 160) * ac5Val;
    c6 := ac6Val;
    mc := (Power(2, 11) / Power(160, 2)) * mcVal;
    md := mdVal / 160.0;
    x0 := ac1Val;
    x1 := 160.0 * Power(2, -13) * ac2Val;
    x2 := Power(160, 2) * Power(2, -25) * b2Val;
    y0 := c4 * Power(2, 15);
    y1 := c4 * c3;
	  y2 := c4 * b1;
    p0 := (3791.0 - 8.0) / 1600.0;
	  p1 := 1.0 - 7357.0 * Power(2, -20);
	  p2 := 3038.0 * 100.0 * Power(2, -36);

    // Convert sensor readings to floating point values.
    tu := data[23] + (data[24] * 256.0);
    pu := data[26] + (data[25] * 256.0) + (data[27] / 256.0);

    // Calculate temprature.
    a := c5 * (tu - c6);
	  temp := a + (mc / (a + md));

    lblTemp.Caption := FormatFloat('0.####', temp) + ' °C';

    // Calculate air presure.
    s := temp - 25.0;
  	x := (x2 * Power(s, 2)) + (x1 * s) + x0;
	  y := (y2 * Power(s, 2)) + (y1 * s) + y0;
	  z := (pu - x) / y;
	  presure := (p2 * Power(z, 2)) + (p1 * z) + p0;

    lblPa.Caption := FormatFloat('0.####', presure) + ' hPa';

    // Plot values in graph and limit graph points to 2000 readings.
    if(serPa.Count > 2000) then
    begin
      serPa.Delete(0, 10, true);
    end;

    serPa.Add(presure);
  end;
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
var
  usbVid, usbPid: string;
  vidNum, pidNum : Integer;
  deviceCount: byte;
begin
  usbVid := Trim(txtVid.Text);
  usbPid := Trim(txtPid.Text);

  // Check for empty VID and PID values.
  if((usbVid = '') or (usbPid = '')) then
  begin
    MessageBox(Application.Handle, 'Specify device VID and PID to connect!', PWideChar(Application.Title), MB_OK + MB_ICONHAND);
    exit;
  end;

  vidNum := StrToIntDef('$' + usbVid, -1);
  pidNum := StrToIntDef('$' + usbPid, -1);

  // Check for valid VID and PID values.
  if((vidNum = -1) or (pidNum = -1)) then
  begin
    MessageBox(Application.Handle, 'Invalid VID or PID!', PWideChar(Application.Title), MB_OK + MB_ICONHAND);
    exit;
  end;

  // Check availability of device with specified VID and PID.
  deviceCount := 0;
  HIDscanForDevices(hidList, deviceCount, vidNum, pidNum);

  if(deviceCount < 1) then
  begin
    MessageBox(Application.Handle, 'Unable to find device with specified VID and PID', PWideChar(Application.Title), MB_OK + MB_ICONWARNING);
    exit;
  end;

  // Open device with specified VID and PID.
  if HIDopenDevice(hidList[0]) then
  begin
    serPa.Clear;
    setUIState(true, true);
    isConnected := true;
  end
  else
  begin
    MessageBox(Application.Handle, 'Unable to open specified USB device!', PWideChar(Application.Title), MB_OK + MB_ICONWARNING);
  end;

end;

procedure hidReaderCallback(data : THIDbuffer); stdcall;
begin
  frmMain.updateData(data);
end;

Procedure hidReaderEventCallback;  stdcall;
begin
  // Handle USB connect and disconnect events.
  if frmMain.isDeviceConnected then
  begin
    frmMain.isDeviceConnected := false;
    frmMain.setUIState(false, false);
  end;
end;

end.
