EESchema Schematic File Version 2  date vie 20 may 2011 00:47:43 ART
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:arduino_shieldsNCL
LIBS:display-lcd-lxd
LIBS:display-lcd
LIBS:Carlolib-dev
LIBS:mi-libreria
LIBS:PCB-cache
EELAYER 25  0
EELAYER END
$Descr A3 16535 11700
Sheet 1 1
Title "Shiel Control de Caudal"
Date "20 may 2011"
Rev "1"
Comp "Rolando - Trellini"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	2850 2750 2850 2950
Wire Wire Line
	8300 4200 9150 4200
Connection ~ 8150 3700
Wire Wire Line
	8150 3950 8150 3650
Wire Wire Line
	6650 5350 7150 5350
Wire Wire Line
	7150 5350 7150 8600
Wire Wire Line
	7150 8600 12100 8600
Wire Wire Line
	12100 8600 12100 7150
Wire Wire Line
	12100 7150 11050 7150
Wire Wire Line
	11050 7550 11800 7550
Wire Wire Line
	11800 7550 11800 8350
Wire Wire Line
	11800 8350 7550 8350
Wire Wire Line
	7550 8350 7550 5750
Wire Wire Line
	7550 5750 6650 5750
Wire Wire Line
	9150 7700 7900 7700
Wire Wire Line
	7900 7700 7900 6150
Wire Wire Line
	7900 6150 7000 6150
Wire Wire Line
	6050 5350 6150 5350
Wire Wire Line
	6050 5750 6150 5750
Wire Wire Line
	6050 6150 6500 6150
Wire Wire Line
	9150 7250 8350 7250
Wire Wire Line
	8350 7250 8350 5450
Wire Wire Line
	8350 5450 6050 5450
Wire Wire Line
	9150 6400 8950 6400
Wire Wire Line
	8950 6400 8950 6350
Wire Wire Line
	8950 6350 6050 6350
Wire Wire Line
	9150 6600 8150 6600
Wire Wire Line
	8150 6600 8150 6050
Wire Wire Line
	8150 6050 6050 6050
Wire Wire Line
	6050 5850 8700 5850
Wire Wire Line
	8700 5850 8700 6850
Wire Wire Line
	8700 6850 9150 6850
Wire Wire Line
	6050 5650 8500 5650
Wire Wire Line
	8500 5650 8500 7050
Wire Wire Line
	8500 7050 9150 7050
Wire Wire Line
	6050 6250 6150 6250
Wire Wire Line
	6050 5950 6150 5950
Wire Wire Line
	6050 5550 6150 5550
Wire Wire Line
	6650 6250 8000 6250
Wire Wire Line
	8000 6250 8000 7450
Wire Wire Line
	8000 7450 9150 7450
Wire Wire Line
	6650 5950 7750 5950
Wire Wire Line
	7750 5950 7750 7900
Wire Wire Line
	7750 7900 9150 7900
Wire Wire Line
	11050 7350 11950 7350
Wire Wire Line
	11950 7350 11950 8450
Wire Wire Line
	11950 8450 7350 8450
Wire Wire Line
	7350 8450 7350 5550
Wire Wire Line
	7350 5550 6650 5550
Wire Wire Line
	8150 3700 9150 3700
Wire Wire Line
	8150 4450 8150 4600
Wire Wire Line
	3000 2750 3000 3000
Wire Wire Line
	3000 3000 3100 3000
$Comp
L +5V #PWR?
U 1 1 4DD5E415
P 3100 3000
F 0 "#PWR?" H 3100 3090 20  0001 C CNN
F 1 "+5V" H 3100 3090 30  0000 C CNN
	1    3100 3000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 4DD5E3F1
P 2850 2950
F 0 "#PWR?" H 2850 2950 30  0001 C CNN
F 1 "GND" H 2850 2880 30  0001 C CNN
	1    2850 2950
	1    0    0    -1  
$EndComp
Text Notes 1050 900  0    100  ~ 0
+5V viene de la placa con el micro (usb o conector). \nEsta placa no se alimenta, se cuelga de la otra.
$Comp
L +5V #PWR?
U 1 1 4DD5E2E6
P 8150 3650
F 0 "#PWR?" H 8150 3740 20  0001 C CNN
F 1 "+5V" H 8150 3740 30  0000 C CNN
	1    8150 3650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 4DD5E2A9
P 8150 4600
F 0 "#PWR?" H 8150 4600 30  0001 C CNN
F 1 "GND" H 8150 4530 30  0001 C CNN
	1    8150 4600
	1    0    0    -1  
$EndComp
$Comp
L POT RV?
U 1 1 4DD5E1F3
P 8150 4200
F 0 "RV?" H 8150 4100 50  0000 C CNN
F 1 "POT" H 8150 4200 50  0000 C CNN
	1    8150 4200
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 4DD5E0AB
P 6400 5350
F 0 "R?" V 6480 5350 50  0000 C CNN
F 1 "R" V 6400 5350 50  0000 C CNN
	1    6400 5350
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 4DD5E0A5
P 6400 5550
F 0 "R?" V 6480 5550 50  0000 C CNN
F 1 "R" V 6400 5550 50  0000 C CNN
	1    6400 5550
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 4DD5E0A1
P 6400 5750
F 0 "R?" V 6480 5750 50  0000 C CNN
F 1 "R" V 6400 5750 50  0000 C CNN
	1    6400 5750
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 4DD5E097
P 6400 5950
F 0 "R?" V 6480 5950 50  0000 C CNN
F 1 "R" V 6400 5950 50  0000 C CNN
	1    6400 5950
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 4DD5E085
P 6750 6150
F 0 "R?" V 6830 6150 50  0000 C CNN
F 1 "R" V 6750 6150 50  0000 C CNN
	1    6750 6150
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 4DD5E070
P 6400 6250
F 0 "R?" V 6480 6250 50  0000 C CNN
F 1 "R" V 6400 6250 50  0000 C CNN
	1    6400 6250
	0    1    1    0   
$EndComp
$Comp
L CONN_11 keypad
U 1 1 4DD5DF03
P 5700 5850
F 0 "keypad" V 5650 5850 60  0000 C CNN
F 1 "CONN_11" V 5750 5850 60  0000 C CNN
	1    5700 5850
	-1   0    0    1   
$EndComp
$Comp
L LCD_HD44870 U?
U 1 1 4DD5A65E
P 3950 2450
F 0 "U?" H 4300 2900 60  0000 C CNN
F 1 "LCD_HD44870" H 3100 2900 60  0000 C CNN
	1    3950 2450
	1    0    0    -1  
$EndComp
$Comp
L ARDUINO_MEGA_SHIELD SHIELD?
U 1 1 4DD58B14
P 10150 5450
F 0 "SHIELD?" H 9750 7950 60  0000 C CNN
F 1 "ARDUINO_MEGA_SHIELD" H 10050 2750 60  0000 C CNN
	1    10150 5450
	1    0    0    -1  
$EndComp
$EndSCHEMATC