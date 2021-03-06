/* Main.c file generated by New Project wizard
 * Created by Victoria Oguntosin
 * Created:   Tue May 16 2017
 * Processor: PIC16F876A
 * Compiler:  HI-TECH C for PIC10/12/16
 */

#ifndef _XTAL_FREQ
	// Unless already defined assume 4MHz system frequency
	// This definition is required to calibrate __delay_us() and __delay_ms()
	#define _XTAL_FREQ 4000000L // 4MHz
#endif

#include <htc.h>

// set chip configuration bits	
__CONFIG(FOSC_XT & WDTE_OFF & PWRTE_OFF & BOREN_OFF & LVP_OFF & WRT_OFF & DEBUG_OFF & CPD_OFF & CP_OFF);

void interrupt TMR0INT(void);
void LED_DISPLAY(void);

unsigned char DIS_NUM[4];
unsigned char TMR2_COUNTER;
unsigned int counter;

// Common Anode display
unsigned char LED_DIS[] = {0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0X88,0X83,0XC6,0XA1,0X86,0X8E,0XFF};

void main(void) {
	TRISB = 0x00; // Set RB0-7 as outputs
	TRISC = 0x00; // Set RC0-7 as outputs
	TRISA = 0b00000000; // Set RA0-5 as outputs
	ADCON1 = 0b0110; // turn all of PORTA to digital I/O
	
	OPTION_REG = 0x07;	// 1:256 prescaler
	INTCON = 0xa0;	//GIE = 1; TMR0IE = 1 ; enable all unmaked interrupts, enable TMR0 interrupt
	TMR0 = 0x3d;	// 50ms period
	counter = 0;
	while(1) {     
		DIS_NUM[0] = (unsigned char)(counter/1000);
		DIS_NUM[1] = (unsigned char)((counter%1000)/100);
		DIS_NUM[2] = (unsigned char)((counter%100)/10);
		DIS_NUM[3] = (unsigned char)(counter%10);
		LED_DISPLAY();
	}
}
 
void interrupt TMR0INT(void) {
	TMR0IF = 0;	// clear overflow flag bit when the interrupt occurs
	TMR2_COUNTER++;
	RA0 = !RA0;
	if(TMR2_COUNTER == 2){
		RA2 = !RA2;
		TMR2_COUNTER = 0;
		counter++;		
	}
	TMR0 = 0x3c;	// 50ms period
}	

void LED_DISPLAY(void) {
	unsigned char i, TEMP;
	TEMP = 0x01;	//0b0000 0001	0b0000 0010   0b0000 0100    0b0000 1000
	for(i=0; i<4; i++) {					 
		PORTC = TEMP;                 
		PORTB = LED_DIS[DIS_NUM[i]];
		TEMP <<= 1; 
		__delay_us(200);
	}
}
