/*------------------------------------------------------------------------------
BMP180 sensor monitoring firmware.
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
------------------------------------------------------------------------------*/

#define SENSOR_ADDRESS 0xEE

#define SENSOR_REG_AC1 0xAA
#define SENSOR_REG_AC2 0xAC
#define SENSOR_REG_AC3 0xAE
#define SENSOR_REG_AC4 0xB0
#define SENSOR_REG_AC5 0xB2
#define SENSOR_REG_AC6 0xB4
#define SENSOR_REG_B1 0xB6
#define SENSOR_REG_B2 0xB8
#define SENSOR_REG_MB 0xBA
#define SENSOR_REG_MC 0xBC
#define SENSOR_REG_MD 0xBE

#define SENSOR_READ_MSB 0xF6
#define SENSOR_READ_LSB 0xF7
#define SENSOR_READ_XLSB 0xF8
#define SENSOR_READ_ID 0xD0

#define SENSOR_ID 0x55

#define SENSOR_CONTROL_REG 0xF4
#define SENSOR_CMD_TEMPRATURE 0x2E
#define SENSOR_CMD_PRESURE 0x34

#define OSS_CONFIG 3

void initSystem();

signed char sensorReadByte(unsigned char address);
signed int sensorReadWord(unsigned char address);

void sensorCalibrationData();
unsigned int sensorTempratureData();
unsigned long sensorPresureData(unsigned char Oss);

signed int CAL_b1 = 0;
signed int CAL_b2 = 0;
signed long CAL_b5 = 0;

signed int CAL_mb = 0;
signed int CAL_mc = 0;
signed int CAL_md = 0;

signed int CAL_ac1 = 0;
signed int CAL_ac2 = 0;
signed int CAL_ac3 = 0;

unsigned int CAL_ac4 = 0;
unsigned int CAL_ac5 = 0;
unsigned int CAL_ac6 = 0;

unsigned char readbuff[64] absolute 0x500;
unsigned char writebuff[64] absolute 0x540;