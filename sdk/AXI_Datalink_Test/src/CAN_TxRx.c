/*
 * CAN_TxRx.c
 *
 *  Created on: Jun 15, 2018
 *      Author: Ainstein Zhenyu Hu
 */





#include "xparameters.h"




/// CAN bus driver
#include "xcanps.h"
#include "xcanps_hw.h"
#include "main.h"


void CAN_Reconfig(){
	CAN_Config = XCanPs_LookupConfig(XPAR_PS7_CAN_0_DEVICE_ID);
	XCanPs_CfgInitialize(&canps, CAN_Config, CAN_Config->BaseAddr);
	XCanPs_SetBaudRatePrescaler(&canps, TEST_BRPR_BAUD_PRESCALAR);
	XCanPs_SetBitTiming(&canps, TEST_BTR_SYNCJUMPWIDTH, TEST_BTR_SECOND_TIMESEGMENT, TEST_BTR_FIRST_TIMESEGMENT);
	XCanPs_EnterMode(&canps, XCANPS_MODE_NORMAL);
}
