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

#include "bmp180_tester.h"

void main()
{
   unsigned long presureData = 0;
   unsigned int tempData = 0;
   unsigned char fillPos = 0;

   // Initialize MCU with USB and I2C.
   initSystem();
   Delay_ms(100);

   while(1)
   {
      // Check availability of the sensor with device id.
      if(sensorReadByte(SENSOR_READ_ID) == SENSOR_ID)
      {
         // Load calibration data from BMP180 sensor.
         PORTA = 0x01;
         sensorCalibrationData();
         Delay_ms(100);

         while(1)
         {
            // Collect data from BMP180 sensor.
            tempData = sensorTempratureData();
            presureData = sensorPresureData(OSS_CONFIG);

            writebuff[0] = 0xD2;

            // Fill sensor calibration values into USB buffer.
            writebuff[1] = CAL_b1 & 0x00FF;
            writebuff[2] = (CAL_b1 >> 8) & 0x00FF;
            
            writebuff[3] = CAL_b2 & 0x00FF;
            writebuff[4] = (CAL_b2 >> 8) & 0x00FF;

            writebuff[5] = CAL_mb & 0x00FF;
            writebuff[6] = (CAL_mb >> 8) & 0x00FF;

            writebuff[7] = CAL_mc & 0x00FF;
            writebuff[8] = (CAL_mc >> 8) & 0x00FF;

            writebuff[9] = CAL_md & 0x00FF;
            writebuff[10] = (CAL_md >> 8) & 0x00FF;

            writebuff[11] = CAL_ac1 & 0x00FF;
            writebuff[12] = (CAL_ac1 >> 8) & 0x00FF;

            writebuff[13] = CAL_ac2 & 0x00FF;
            writebuff[14] = (CAL_ac2 >> 8) & 0x00FF;

            writebuff[15] = CAL_ac3 & 0x00FF;
            writebuff[16] = (CAL_ac3 >> 8) & 0x00FF;

            writebuff[17] = CAL_ac4 & 0x00FF;
            writebuff[18] = (CAL_ac4 >> 8) & 0x00FF;

            writebuff[19] = CAL_ac5 & 0x00FF;
            writebuff[20] = (CAL_ac5 >> 8) & 0x00FF;

            writebuff[21] = CAL_ac6 & 0x00FF;
            writebuff[22] = (CAL_ac6 >> 8) & 0x00FF;

            // Fill current temprature value into USB buffer.
            writebuff[23] = tempData & 0x00FF;
            writebuff[24] = (tempData >> 8) & 0x00FF;

            // Fill current air presure value into USB buffer.
            writebuff[25] = presureData & 0x00FF;
            writebuff[26] = (presureData >> 8) & 0x00FF;
            writebuff[27] = (presureData >> 16) & 0x00FF;

            // Fill remaining buffer with zeros.
            for(fillPos = 28; fillPos < 64; fillPos++)
            {
               writebuff[fillPos] = 0x00;
            }

            // Send buffer to host device.
            while(!HID_Write(&writebuff, 64));
            Delay_ms(100);
         }
      }

      Delay_ms(50);
   }
}

void interrupt()
{
   USB_Interrupt_Proc();
}

void initSystem()
{
   // Disable ADC and enable digital I/O.
   ADCON0 = 0x00;
   ADCON1 |= 0x0F;
   CMCON  |= 7;

   PORTA = 0x00;
   TRISA = 0x00;

   // Enable USB and I2C.
   HID_Enable(&readbuff, &writebuff);
   I2C1_Init(100000);
}

signed char sensorReadByte(unsigned char address)
{
   unsigned char temp = 0;

   I2C1_Start();
   I2C1_Wr(SENSOR_ADDRESS);
   I2C1_Wr(address);
   I2C1_Start();
   I2C1_Wr(SENSOR_ADDRESS + 1);
   temp = I2C1_Rd(0);
   I2C1_Stop();

   return temp;
}

signed int sensorReadWord(unsigned char address)
{
   unsigned char highByte = 0;
   unsigned char lowByte = 0;

   I2C1_Start();
   I2C1_Wr(SENSOR_ADDRESS);
   I2C1_Wr(address);
   I2C1_Start();
   I2C1_Wr(SENSOR_ADDRESS + 1);
   highByte = I2C1_Rd(1);
   lowByte = I2C1_Rd(0);
   I2C1_Stop();

   return ((highByte << 8) | lowByte);
}

void sensorSetRegValue(unsigned char address, unsigned char value)
{
   I2C1_Start();
   I2C1_Wr(SENSOR_ADDRESS);
   I2C1_Wr(address);
   I2C1_Wr(value);
   I2C1_Stop();
}

void sensorCalibrationData()
{
   CAL_b1 = sensorReadWord(SENSOR_REG_B1);
   CAL_b2 = sensorReadWord(SENSOR_REG_B2);

   CAL_mb = sensorReadWord(SENSOR_REG_MB);
   CAL_mc = sensorReadWord(SENSOR_REG_MC);
   CAL_md = sensorReadWord(SENSOR_REG_MD);

   CAL_ac1 = sensorReadWord(SENSOR_REG_AC1);
   CAL_ac2 = sensorReadWord(SENSOR_REG_AC2);
   CAL_ac3 = sensorReadWord(SENSOR_REG_AC3);
   CAL_ac4 = sensorReadWord(SENSOR_REG_AC4);
   CAL_ac5 = sensorReadWord(SENSOR_REG_AC5);
   CAL_ac6 = sensorReadWord(SENSOR_REG_AC6);
}

unsigned int sensorTempratureData()
{
   unsigned int ut = 0;

   sensorSetRegValue(SENSOR_CONTROL_REG, SENSOR_CMD_TEMPRATURE);
   Delay_ms(5);
   return (unsigned int)sensorReadWord(SENSOR_READ_MSB);
}

unsigned long sensorPresureData(unsigned char Oss)
{
   unsigned char msbValue = 0;
   unsigned char lsbValue = 0;
   unsigned char xlsbValue = 0;
   unsigned char regStatus = 0;

   sensorSetRegValue(SENSOR_CONTROL_REG, (SENSOR_CMD_PRESURE + (Oss << 6)));

   // Wait to finish the conversion based on Oss value.
   switch(Oss)
   {
      case 0x00:
         Delay_ms(5);
         break;
      case 0x01:
         Delay_ms(8);
         break;
      case 0x02:
         Delay_ms(14);
         break;
      case 0x03:
         Delay_ms(26);
         break;
      default:
         Delay_ms(5);
         break;
   }

   // Read MSB, LSB and XLSB
   msbValue = sensorReadByte(SENSOR_READ_MSB);
   lsbValue = sensorReadByte(SENSOR_READ_LSB);
   xlsbValue = sensorReadByte(SENSOR_READ_XLSB);

   return (unsigned long)((unsigned long)msbValue) | ((unsigned long)lsbValue << 8) | ((unsigned long)xlsbValue << 16);
}