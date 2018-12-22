# BMP180 based USB atmospheric pressure monitor

We initially developed this USB atmospheric pressure monitor to study some operating characteristics of [Bosch BMP180](https://www.bosch-sensortec.com/bst/products/all_products/bmp180) sensor. BMP180 is low cost sensor to measuring barometric pressure and temperature. According to the data sheet this sensor can use to measure pressure ranging between *300hPa* to *1100hPa*. This sensor is introduced couple of years back but still it is popular due to lower cost and simplicity.

We did this unit to test BMP180 sensor more accurately and to study it’s behaviors. This unit is based on PIC18F2550 microcontroller and the main reason to select this MCU is because of it’s built-in USB 2.0 interface.

![Schematic of BMP180 monitor](https://raw.githubusercontent.com/dilshan/bmp180-monitor/master/resources/schematic.jpg)

To display sensor calibration data and it’s readings we did small windows application. This application display and plot temperature and pressure readings captured from the BMP180 sensor.

![BMP180 monitor application](https://raw.githubusercontent.com/dilshan/bmp180-monitor/master/resources/bmp180-app.png)

This unit is programmed to work as a USB HID device and no any special device driver is required to use this device. We test this unit in *Windows 10* environment.
