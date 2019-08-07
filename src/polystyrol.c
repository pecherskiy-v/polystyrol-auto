/*
 * buttons.c:
 *	Read the Gertboard buttons. Each one will act as an on/off
 *	tiggle switch for 3 different LEDs
 *
 * Copyright (c) 2012-2013 Gordon Henderson. <projects@drogon.net>
 ***********************************************************************
 * This file is part of wiringPi:
 *	https://projects.drogon.net/raspberry-pi/wiringpi/
 *
 *    wiringPi is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU Lesser General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    wiringPi is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU Lesser General Public License for more details.
 *
 *    You should have received a copy of the GNU Lesser General Public License
 *    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
 ***********************************************************************
 */

#include <stdio.h>
#include <wiringPi.h>

// LED Pin - wiringPi pin 29 is name = GPIO_29 | piname BCM_GPIO 21 | physical 40.
#define	LED_BLINC	29

// LED Pin - wiringPi pin 28 is name = GPIO_28 | piname BCM_GPIO 20 | physical 38.
#define	LED_BUT	28

// LED Pin - wiringPi pin 7 is name = GPIO_07 | piname BCM_GPIO 4 | physical 7.
#define BUTTOMM 7

int leds [28] = { 0 } ;

// scanButton:
//	See if a button is pushed, if so, then flip that LED and
//	wait for the button to be let-go

void scanButton (int button)
{
  if (digitalRead (button) == HIGH)	// Low is pushed
    return ;

  leds [LED_BUT] ^= 1 ; // Invert state
  digitalWrite (4 + button, leds [LED_BUT]) ;

  while (digitalRead (button) == LOW)	// Wait for release
    delay (10) ;
}

int main (void)
{
  printf ("Raspberry Pi Gertboard Button Test\n") ;
  printf ("Raspberry Pi blink\n") ;

  wiringPiSetup () ;

  // Setup the outputs:
  // Pins 40, 38 output:
  pinMode (LED_BLINC, OUTPUT) ;
  digitalWrite (LED_BLINC, 0) ;
  pinMode (LED_BUT, OUTPUT) ;
  digitalWrite (LED_BUT, 0) ;

  // Setup the inputs
  pinMode         (BUTTOMM, INPUT) ;
  pullUpDnControl (BUTTOMM, PUD_UP) ;
  leds [LED_BUT] = 0 ;

  for (;;)
  {
    scanButton (BUTTOMM) ;
    delay (1) ;

    digitalWrite (LED_BLINC, HIGH) ;	// On
    delay (500) ;		// mS
    digitalWrite (LED_BLINC, LOW) ;	// Off
    delay (500) ;

  }
}
