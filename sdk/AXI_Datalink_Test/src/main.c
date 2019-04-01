/*
 * main.c
 *
 *  Created on: Jun 8, 2018
 *      Author: Ainstein Zhenyu Hu
 */


/*
 * main.c
 *
 *  Created on: Jun 7, 2018
 *      Author: Ainstein Zhenyu Hu
 */

#include "main.h"


#define CAN_MODE
//#define UART
//#define ULANDINGC1
#define US_D1

u8 *FramePtr;
int ext_id;
int alt_data;
int snr_data;
int header_index;

int main()
{
	// GPIO Initialization
	XGpio_Initialize(&gpio, XPAR_AXI_GPIO_0_DEVICE_ID);
	XGpio_SetDataDirection(&gpio, 2, 0x00000000); // set LED GPIO channel tristates to All Output
	XGpio_SetDataDirection(&gpio, 1, 0xFFFFFFFF); // set BTN GPIO channel tristates to All Input

	//
	XGpio_Initialize(&gpio_init, XPAR_AXI_GPIO_1_DEVICE_ID);
	XGpio_SetDataDirection(&gpio_init, 1, 0x00000000); // set LED GPIO channel tristates to All Output


	/// UART_0 Initialization
	Config = XUartPs_LookupConfig(XPAR_PS7_UART_0_DEVICE_ID);
	XUartPs_CfgInitialize (&UartPs, Config, Config->BaseAddress);
	XUartPs_SetBaudRate(&UartPs, 115200);
	XUartPs_SelfTest(&UartPs);

	XCanPs  *CanInstPtr = &canps;
	///CAN_0 Initialization
	CAN_Config = XCanPs_LookupConfig(XPAR_PS7_CAN_0_DEVICE_ID);
	XCanPs_CfgInitialize(CanInstPtr, CAN_Config, CAN_Config->BaseAddr);
	XCanPs_SelfTest(CanInstPtr);
	XCanPs_EnterMode(CanInstPtr, XCANPS_MODE_CONFIG);
	while(XCanPs_GetMode(CanInstPtr) != XCANPS_MODE_CONFIG);
	XCanPs_SetBaudRatePrescaler(CanInstPtr, TEST_BRPR_BAUD_PRESCALAR);
	XCanPs_SetBitTiming(CanInstPtr, TEST_BTR_SYNCJUMPWIDTH, TEST_BTR_SECOND_TIMESEGMENT, TEST_BTR_FIRST_TIMESEGMENT);


	//init en
	XGpio_DiscreteWrite(&gpio_init, 1, 0xffffffff);
	usleep(100000);
//	XGpio_DiscreteWrite(&gpio_init, 1, 0x00000000);


	while (1){
		xil_printf("Let's begin!");
	}
	// DEFAULT UART --- UART 1
	xil_printf("Let's begin!");

	#ifdef CAN_MODE
		XCanPs_EnterMode(&canps, XCANPS_MODE_NORMAL);
		while(XCanPs_GetMode(&canps) != XCANPS_MODE_NORMAL);

		for (int i = 0; i < XCANPS_MAX_FRAME_SIZE_IN_WORDS; i++){
			CAN_receiving_data[i] = 0;
		}
		while (1){
			XGpio_DiscreteWrite(&gpio, 2, 0xffffffff);
			// CAN Receiver
			while (XCanPs_IsRxEmpty(CanInstPtr) == TRUE);
			status = XCanPs_Recv(CanInstPtr, CAN_receiving_data);
			if (status == 0){
			#ifdef US_D1
				ext_id = (((int)CAN_receiving_data[0]) >> 1) & 0x00090002;
				snr_data = ((((int)CAN_receiving_data[2]) & 0xff000000) >> 24) + ((((int)CAN_receiving_data[2]) & 0x00ff0000) >> 16)*256;
				alt_data = ((((int)CAN_receiving_data[2]) & 0x0000ff00) >> 8) + (((int)CAN_receiving_data[2]) & 0x000000ff)*256;
			#else
				ext_id = (((int)CAN_receiving_data[0]) >> 1) & 0x00090002;
				snr_data = ((((int)CAN_receiving_data[2]) & 0xff000000) >> 24) + ((((int)CAN_receiving_data[2]) & 0x00ff0000) >> 16)*256;
				alt_data = ((((int)CAN_receiving_data[2]) & 0x0000ff00) >> 8) + (((int)CAN_receiving_data[2]) & 0x000000ff)*256;
			#endif
				printf("ID: %#.8x, Altitude Data: %d, SNR Data: %d\n\r", ext_id, alt_data, snr_data);
			}
		}
	#endif

	#ifdef	UART
		while(1){
			// UART Receiver
			for (int i = 0; i < 12; i++){
				UART_receiving_data[i] = XUartPs_RecvByte(XPAR_PS7_UART_0_BASEADDR);
			}
			for (header_index = 0; header_index < 12; header_index++){
				if (*(UART_receiving_data + header_index) == 0xfe && *(UART_receiving_data + header_index + 1) == 0x00){
					break;
				}
			}

			#ifdef	US_D1
				alt_data = *(UART_receiving_data+header_index+2) + *(UART_receiving_data+header_index+3) *256;
				snr_data = *(UART_receiving_data+header_index+4);
				if (snr_data == 0)
					printf("Altitude Data: %d, SNR Data: No SNR Available!", alt_data);
				else
					printf("Altitude Data: %d, SNR Data: %d\n\r", alt_data, snr_data);
			#endif
		}
	#endif

	return 0;

}
