
//cppcheck-suppress unCompleteInclude
#include "Capnography/stm32l1xx.h"



typedef    unsigned char				uint8;
typedef    signed char					int8;
typedef    unsigned short				uint16;
typedef    signed short					int16;
typedef    unsigned long				uint32;
typedef    signed long					int32;
typedef    unsigned long long           uint64;
typedef    signed long long             int64;
typedef    unsigned char				Uchar;
typedef    signed short					Int;
typedef    signed long					Word;


#define GPIO_Pin_2                 ((uint16_t)0x0004)  /*!< Pin 2 selected */

#define LED_TP2_PORT    GPIOB
#define LED_TP2_PIN     GPIO_Pin_2


void Delay10us(int32 num )
{
	   for (int32 i=num; i>0; i--);
}

//only add this comment for test commit
int main()
{
	  
int test=2;
	  RCC->AHBENR  |= (1<< 1);
	    GPIOB ->MODER |= (1<<4);
	      GPIOB->OTYPER &= ~(1<<2);
	        GPIOB->OSPEEDR |= (1<<5);
		  GPIOB->PUPDR &= ~((1<<4) | (1<<5));
		   
		    while(1)
			      {
				          GPIOB->BSRRL |=(1<<2);
					   
					      Delay10us(400000);
					        
					          GPIOB->BSRRH |=(1<<2);
						     
						      Delay10us(100000);
						        }
		      return 0;
}
