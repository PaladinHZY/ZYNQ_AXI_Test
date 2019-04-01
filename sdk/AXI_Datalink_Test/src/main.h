#include "xparameters.h"
#include "xcanps.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "xgpio.h"
#include "xuartps.h"
#include "stdio.h"
#include "sleep.h"
#include "xuartps_hw.h"

#ifdef XPAR_INTC_0_DEVICE_ID
#include "xintc.h"
#else
#include "xscugic.h"
#endif














/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#ifdef XPAR_INTC_0_DEVICE_ID
#define INTC		XIntc
#define CAN_DEVICE_ID		XPAR_XCANPS_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_INTC_0_DEVICE_ID
#define CAN_INTR_VEC_ID		XPAR_INTC_0_CANPS_0_VEC_ID
#else
#define INTC		XScuGic
#define CAN_DEVICE_ID		XPAR_XCANPS_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define CAN_INTR_VEC_ID		XPAR_XCANPS_0_INTR
#endif
/* Maximum CAN frame length in word */
#define XCANPS_MAX_FRAME_SIZE_IN_WORDS (XCANPS_MAX_FRAME_SIZE / sizeof(u32))

#define FRAME_DATA_LENGTH	8 /* Frame Data field length */

/*
 * Message Id Constant.
 */
#define TEST_MESSAGE_ID		0x00090002
#define STD_ID 0x002
#define EXD_ID 0x00090002
/*
 * The Baud Rate Prescaler Register (BRPR) and Bit Timing Register (BTR)
 * are setup such that CAN baud rate equals 40Kbps, assuming that the
 * the CAN clock is 24MHz. The user needs to modify these values based on
 * the desired baud rate and the CAN clock frequency. For more information
 * see the CAN 2.0A, CAN 2.0B, ISO 11898-1 specifications.
 */

/*
 * Timing parameters to be set in the Bit Timing Register (BTR).
 * These values are for a 40 Kbps baudrate assuming the CAN input clock
 * frequency is 24 MHz.
 */
#define TEST_BTR_SYNCJUMPWIDTH		3
#define TEST_BTR_SECOND_TIMESEGMENT	2
#define TEST_BTR_FIRST_TIMESEGMENT	7

/*
 * The Baud rate Prescalar value in the Baud Rate Prescaler Register
 * needs to be set based on the input clock  frequency to the CAN core and
 * the desired CAN baud rate.
 * This value is for a 40 Kbps baudrate assuming the CAN input clock frequency
 * is 24 MHz.
 */
#define TEST_BRPR_BAUD_PRESCALAR	1

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

int CanPsIntrExample(INTC *IntcInstPtr,
			XCanPs *CanInstPtr,
			u16 CanDeviceId,
			u16 CanIntrId);
//static void Config(XCanPs *InstancePtr);
//static void SendFrame(XCanPs *InstancePtr);
//
//static void SendHandler(void *CallBackRef);
//static void RecvHandler(void *CallBackRef);
//static void ErrorHandler(void *CallBackRef, u32 ErrorMask);
//static void EventHandler(void *CallBackRef, u32 Mask);
//
//static int SetupInterruptSystem(INTC *IntcInstancePtr,
//				XCanPs *CanInstancePtr,
//				u16 CanIntrId);
void CAN_Reconfig();







XGpio gpio,gpio_init;
u32 btn, led;
XUartPs UartPs;
XUartPs_Config 	UartPs_Config;
u8 data[3];
XUartPs_Config *Config;
XCanPs canps;
XCanPs_Config *CAN_Config;
//static XCanPs CanInstance;
u32 CAN_sending_data[XCANPS_MAX_FRAME_SIZE_IN_WORDS];
u32 CAN_receiving_data[XCANPS_MAX_FRAME_SIZE_IN_WORDS];
u8 UART_receiving_data[12];

unsigned long int First_data, Second_data;
int status;







