/* Arc Detection State Machine
# State Machine devoted to control the Arc Detection sub-system realted to DTL apparatus:
#
# Principal States:
# - Initialization:
# 	* Initialize State Machine when EPICS application starts
# - Self-Check:
#       * Verify HW status (connections, devices\'' health, etc.)
# - Start-Up:
#       * Prepare the sub-system to perform operations
# - Idle:
#       * Machine is in attendance of external ok
# - Ready-for-operation:
#       * Machine prepared for operation
# - Failure:
#       * Machine goes in safe mode because of HW/SW problems
# - Maintenance:
#       * Status where the machine is under maintenance. Useful to indicate possible operation and works on the apparatus
#
#
# developed by Maurizio Montis | INFN-LNL
# mail: maurizio.montis@lnl.infn.it
*/

program arcDetection_statemachine

/*
# Libraries
*/

%%#include <stdio.h>
%%#include <stdlib.h>
%%#include <string.h>
%%#include <unistd.h>

/*
# Variables and Constants
*/

/* NOTES:
1. RFLPS shall count the total number of arcs detected per each detection point (ADM) [OK]

2. RFLPS shall provide a reset command per each arc counter [OK]

3. RFLPS shall provide test reset commands to the ADM. This command shall be available via EPICS for the DTL Control system {POWER RESET}
*/




/* ARC4 Power Status */ /* 0=NOK | 1=OK */
double power_on_counter = 0;
double Max_power_on = 3;

int T1_Arc_Power_Status;
assign T1_Arc_Power_Status to "";
monitor T1_Arc_Power_Status;
int T2_Arc_Power_Status;
assign T2_Arc_Power_Status to "";
monitor T2_Arc_Power_Status;
int T3_Arc_Power_Status;
assign T3_Arc_Power_Status to "";
monitor T3_Arc_Power_Status;
int T4_Arc_Power_Status;
assign T4_Arc_Power_Status to "";
monitor T4_Arc_Power_Status;
int T5_Arc_Power_Status;
assign T5_Arc_Power_Status to "";
monitor T5_Arc_Power_Status;

/* ARC4 Power Command */
int T1_Arc_Power_Cmd;
assign T1_Arc_Power_Cmd to "";
monitor T1_Arc_Power_Cmd;
int T2_Arc_Power_Cmd;
assign T2_Arc_Power_Cmd to "";
monitor T2_Arc_Power_Cmd;
int T3_Arc_Power_Cmd;
assign T3_Arc_Power_Cmd to "";
monitor T3_Arc_Power_Cmd;
int T4_Arc_Power_Cmd;
assign T4_Arc_Power_Cmd to "";
monitor T4_Arc_Power_Cmd;
int T5_Arc_Power_Cmd;
assign T5_Arc_Power_Cmd to "";
monitor T5_Arc_Power_Cmd;

/* ARC4 Power Reset */
int T1_Arc_Power_Reset;
assign T1_Arc_Power_Reset to "";
monitor T1_Arc_Power_Reset;
int T2_Arc_Power_Reset;
assign T2_Arc_Power_Reset to "";
monitor T2_Arc_Power_Reset;
int T3_Arc_Power_Reset;
assign T3_Arc_Power_Reset to "";
monitor T3_Arc_Power_Reset;
int T4_Arc_Power_Reset;
assign T4_Arc_Power_Reset to "";
monitor T4_Arc_Power_Reset;
int T5_Arc_Power_Reset;
assign T5_Arc_Power_Reset to "";
monitor T5_Arc_Power_Reset;

/* Global Arc Status */ /* 0=NOK | 1=OK */
int T1_Arc_Global_Status;
assign T1_Arc_Global_Status to "";
monitor T1_Arc_Global_Status;
int T2_Arc_Global_Status;
assign T2_Arc_Global_Status to "";
monitor T2_Arc_Global_Status;
int T3_Arc_Global_Status;
assign T3_Arc_Global_Status to "";
monitor T3_Arc_Global_Status;
int T4_Arc_Global_Status;
assign T4_Arc_Global_Status to "";
monitor T4_Arc_Global_Status;
int T5_Arc_Global_Status;
assign T5_Arc_Global_Status to "";
monitor T5_Arc_Global_Status;

/* RF Status */
int T1_RF_Status;
assign T1_RF_Status to "";
monitor T1_RF_Status;
int T2_RF_Status;
assign T2_RF_Status to "";
monitor T2_RF_Status;
int T3_RF_Status;
assign T3_RF_Status to "";
monitor T3_RF_Status;
int T4_RF_Status;
assign T4_RF_Status to "";
monitor T4_RF_Status;
int T5_RF_Status;
assign T5_RF_Status to "";
monitor T5_RF_Status;

/* Arc Counters */
int T1_Arc_Counter_01;
assign T1_Arc_Counter_01 to "";
monitor T1_Arc_Counter_01;
int T1_Arc_Counter_02;
assign T1_Arc_Counter_02 to "";
monitor T1_Arc_Counter_02;
int T1_Arc_Counter_03;
assign T1_Arc_Counter_03 to "";
monitor T1_Arc_Counter_03;
int T1_Arc_Counter_04;
assign T1_Arc_Counter_04 to "";
monitor T1_Arc_Counter_04;
int T2_Arc_Counter_01;
assign T2_Arc_Counter_01 to "";
monitor T2_Arc_Counter_01;
int T2_Arc_Counter_02;
assign T2_Arc_Counter_02 to "";
monitor T2_Arc_Counter_02;
int T2_Arc_Counter_03;
assign T2_Arc_Counter_03 to "";
monitor T2_Arc_Counter_03;
int T2_Arc_Counter_04;
assign T2_Arc_Counter_04 to "";
monitor T2_Arc_Counter_04;
int T3_Arc_Counter_01;
assign T3_Arc_Counter_01 to "";
monitor T3_Arc_Counter_01;
int T3_Arc_Counter_02;
assign T3_Arc_Counter_02 to "";
monitor T3_Arc_Counter_02;
int T3_Arc_Counter_03;
assign T3_Arc_Counter_03 to "";
monitor T3_Arc_Counter_03;
int T3_Arc_Counter_04;
assign T3_Arc_Counter_04 to "";
monitor T3_Arc_Counter_04;
int T4_Arc_Counter_01;
assign T4_Arc_Counter_01 to "";
monitor T4_Arc_Counter_01;
int T4_Arc_Counter_02;
assign T4_Arc_Counter_02 to "";
monitor T4_Arc_Counter_02;
int T4_Arc_Counter_03;
assign T4_Arc_Counter_03 to "";
monitor T4_Arc_Counter_03;
int T4_Arc_Counter_04;
assign T4_Arc_Counter_04 to "";
monitor T4_Arc_Counter_04;
int T5_Arc_Counter_01;
assign T5_Arc_Counter_01 to "";
monitor T5_Arc_Counter_01;
int T5_Arc_Counter_02;
assign T5_Arc_Counter_02 to "";
monitor T5_Arc_Counter_02;
int T5_Arc_Counter_03;
assign T5_Arc_Counter_03 to "";
monitor T5_Arc_Counter_03;
int T5_Arc_Counter_04;
assign T5_Arc_Counter_04 to "";
monitor T5_Arc_Counter_04;

/* Arc Counters Reset */
int T1_Arc_Counter_Reset_01;
assign T1_Arc_Counter_Reset_01 to "";
monitor T1_Arc_Counter_Reset_01;
int T1_Arc_Counter_Reset_02;
assign T1_Arc_Counter_Reset_02 to "";
monitor T1_Arc_Counter_Reset_02;
int T1_Arc_Counter_Reset_03;
assign T1_Arc_Counter_Reset_03 to "";
monitor T1_Arc_Counter_Reset_03;
int T1_Arc_Counter_Reset_04;
assign T1_Arc_Counter_Reset_04 to "";
monitor T1_Arc_Counter_Reset_04;
int T2_Arc_Counter_Reset_01;
assign T2_Arc_Counter_Reset_01 to "";
monitor T2_Arc_Counter_Reset_01;
int T2_Arc_Counter_Reset_02;
assign T2_Arc_Counter_Reset_02 to "";
monitor T2_Arc_Counter_Reset_02;
int T2_Arc_Counter_Reset_03;
assign T2_Arc_Counter_Reset_03 to "";
monitor T2_Arc_Counter_Reset_03;
int T2_Arc_Counter_Reset_04;
assign T2_Arc_Counter_Reset_04 to "";
monitor T2_Arc_Counter_Reset_04;
int T3_Arc_Counter_Reset_01;
assign T3_Arc_Counter_Reset_01 to "";
monitor T3_Arc_Counter_Reset_01;
int T3_Arc_Counter_Reset_02;
assign T3_Arc_Counter_Reset_02 to "";
monitor T3_Arc_Counter_Reset_02;
int T3_Arc_Counter_Reset_03;
assign T3_Arc_Counter_Reset_03 to "";
monitor T3_Arc_Counter_Reset_03;
int T3_Arc_Counter_Reset_04;
assign T3_Arc_Counter_Reset_04 to "";
monitor T3_Arc_Counter_Reset_04;
int T4_Arc_Counter_Reset_01;
assign T4_Arc_Counter_Reset_01 to "";
monitor T4_Arc_Counter_Reset_01;
int T4_Arc_Counter_Reset_02;
assign T4_Arc_Counter_Reset_02 to "";
monitor T4_Arc_Counter_Reset_02;
int T4_Arc_Counter_Reset_03;
assign T4_Arc_Counter_Reset_03 to "";
monitor T4_Arc_Counter_Reset_03;
int T4_Arc_Counter_Reset_04;
assign T4_Arc_Counter_Reset_04 to "";
monitor T4_Arc_Counter_Reset_04;
int T5_Arc_Counter_Reset_01;
assign T5_Arc_Counter_Reset_01 to "";
monitor T5_Arc_Counter_Reset_01;
int T5_Arc_Counter_Reset_02;
assign T5_Arc_Counter_Reset_02 to "";
monitor T5_Arc_Counter_Reset_02;
int T5_Arc_Counter_Reset_03;
assign T5_Arc_Counter_Reset_03 to "";
monitor T5_Arc_Counter_Reset_03;
int T5_Arc_Counter_Reset_04;
assign T5_Arc_Counter_Reset_04 to "";
monitor T5_Arc_Counter_Reset_04;

/* Last Arc Time Stamp */
float T1_Arc_Last_Timestamp_01;
assign T1_Arc_Last_Timestamp_01 to "";
monitor T1_Arc_Last_Timestamp_01;
float T1_Arc_Last_Timestamp_02;
assign T1_Arc_Last_Timestamp_02 to "";
monitor T1_Arc_Last_Timestamp_02;
float T1_Arc_Last_Timestamp_03;
assign T1_Arc_Last_Timestamp_03 to "";
monitor T1_Arc_Last_Timestamp_03;
float T1_Arc_Last_Timestamp_04;
assign T1_Arc_Last_Timestamp_04 to "";
monitor T1_Arc_Last_Timestamp_04;
float T2_Arc_Last_Timestamp_01;
assign T2_Arc_Last_Timestamp_01 to "";
monitor T2_Arc_Last_Timestamp_01;
float T2_Arc_Last_Timestamp_02;
assign T2_Arc_Last_Timestamp_02 to "";
monitor T2_Arc_Last_Timestamp_02;
float T2_Arc_Last_Timestamp_03;
assign T2_Arc_Last_Timestamp_03 to "";
monitor T2_Arc_Last_Timestamp_03;
float T2_Arc_Last_Timestamp_04;
assign T2_Arc_Last_Timestamp_04 to "";
monitor T2_Arc_Last_Timestamp_04;
float T3_Arc_Last_Timestamp_01;
assign T3_Arc_Last_Timestamp_01 to "";
monitor T3_Arc_Last_Timestamp_01;
float T3_Arc_Last_Timestamp_02;
assign T3_Arc_Last_Timestamp_02 to "";
monitor T3_Arc_Last_Timestamp_02;
float T3_Arc_Last_Timestamp_03;
assign T3_Arc_Last_Timestamp_03 to "";
monitor T3_Arc_Last_Timestamp_03;
float T3_Arc_Last_Timestamp_04;
assign T3_Arc_Last_Timestamp_04 to "";
monitor T3_Arc_Last_Timestamp_04;
float T4_Arc_Last_Timestamp_01;
assign T4_Arc_Last_Timestamp_01 to "";
monitor T4_Arc_Last_Timestamp_01;
float T4_Arc_Last_Timestamp_02;
assign T4_Arc_Last_Timestamp_02 to "";
monitor T4_Arc_Last_Timestamp_02;
float T4_Arc_Last_Timestamp_03;
assign T4_Arc_Last_Timestamp_03 to "";
monitor T4_Arc_Last_Timestamp_03;
float T4_Arc_Last_Timestamp_04;
assign T4_Arc_Last_Timestamp_04 to "";
monitor T4_Arc_Last_Timestamp_04;
float T5_Arc_Last_Timestamp_01;
assign T5_Arc_Last_Timestamp_01 to "";
monitor T5_Arc_Last_Timestamp_01;
float T5_Arc_Last_Timestamp_02;
assign T5_Arc_Last_Timestamp_02 to "";
monitor T5_Arc_Last_Timestamp_02;
float T5_Arc_Last_Timestamp_03;
assign T5_Arc_Last_Timestamp_03 to "";
monitor T5_Arc_Last_Timestamp_03;
float T5_Arc_Last_Timestamp_04;
assign T5_Arc_Last_Timestamp_04 to "";
monitor T5_Arc_Last_Timestamp_04;

/* Arc Test Internal Command - Check */
int T1_Arc_Test_Internal_Cmd_Check_01;
assign T1_Arc_Test_Internal_Cmd_Check_01 to "";
monitor T1_Arc_Test_Internal_Cmd_Check_01;
int T1_Arc_Test_Internal_Cmd_Check_02;
assign T1_Arc_Test_Internal_Cmd_Check_02 to "";
monitor T1_Arc_Test_Internal_Cmd_Check_02;
int T1_Arc_Test_Internal_Cmd_Check_03;
assign T1_Arc_Test_Internal_Cmd_Check_03 to "";
monitor T1_Arc_Test_Internal_Cmd_Check_03;
int T1_Arc_Test_Internal_Cmd_Check_04;
assign T1_Arc_Test_Internal_Cmd_Check_04 to "";
monitor T1_Arc_Test_Internal_Cmd_Check_04;
int T2_Arc_Test_Internal_Cmd_Check_01;
assign T2_Arc_Test_Internal_Cmd_Check_01 to "";
monitor T2_Arc_Test_Internal_Cmd_Check_01;
int T2_Arc_Test_Internal_Cmd_Check_02;
assign T2_Arc_Test_Internal_Cmd_Check_02 to "";
monitor T2_Arc_Test_Internal_Cmd_Check_02;
int T2_Arc_Test_Internal_Cmd_Check_03;
assign T2_Arc_Test_Internal_Cmd_Check_03 to "";
monitor T2_Arc_Test_Internal_Cmd_Check_03;
int T2_Arc_Test_Internal_Cmd_Check_04;
assign T2_Arc_Test_Internal_Cmd_Check_04 to "";
monitor T2_Arc_Test_Internal_Cmd_Check_04;
int T3_Arc_Test_Internal_Cmd_Check_01;
assign T3_Arc_Test_Internal_Cmd_Check_01 to "";
monitor T3_Arc_Test_Internal_Cmd_Check_01;
int T3_Arc_Test_Internal_Cmd_Check_02;
assign T3_Arc_Test_Internal_Cmd_Check_02 to "";
monitor T3_Arc_Test_Internal_Cmd_Check_02;
int T3_Arc_Test_Internal_Cmd_Check_03;
assign T3_Arc_Test_Internal_Cmd_Check_03 to "";
monitor T3_Arc_Test_Internal_Cmd_Check_03;
int T3_Arc_Test_Internal_Cmd_Check_04;
assign T3_Arc_Test_Internal_Cmd_Check_04 to "";
monitor T3_Arc_Test_Internal_Cmd_Check_04;
int T4_Arc_Test_Internal_Cmd_Check_01;
assign T4_Arc_Test_Internal_Cmd_Check_01 to "";
monitor T4_Arc_Test_Internal_Cmd_Check_01;
int T4_Arc_Test_Internal_Cmd_Check_02;
assign T4_Arc_Test_Internal_Cmd_Check_02 to "";
monitor T4_Arc_Test_Internal_Cmd_Check_02;
int T4_Arc_Test_Internal_Cmd_Check_03;
assign T4_Arc_Test_Internal_Cmd_Check_03 to "";
monitor T4_Arc_Test_Internal_Cmd_Check_03;
int T4_Arc_Test_Internal_Cmd_Check_04;
assign T4_Arc_Test_Internal_Cmd_Check_04 to "";
monitor T4_Arc_Test_Internal_Cmd_Check_04;
int T5_Arc_Test_Internal_Cmd_Check_01;
assign T5_Arc_Test_Internal_Cmd_Check_01 to "";
monitor T5_Arc_Test_Internal_Cmd_Check_01;
int T5_Arc_Test_Internal_Cmd_Check_02;
assign T5_Arc_Test_Internal_Cmd_Check_02 to "";
monitor T5_Arc_Test_Internal_Cmd_Check_02;
int T5_Arc_Test_Internal_Cmd_Check_03;
assign T5_Arc_Test_Internal_Cmd_Check_03 to "";
monitor T5_Arc_Test_Internal_Cmd_Check_03;
int T5_Arc_Test_Internal_Cmd_Check_04;
assign T5_Arc_Test_Internal_Cmd_Check_04 to "";
monitor T5_Arc_Test_Internal_Cmd_Check_04;

/* Arc Test External Command - Check */
int T1_Arc_Test_External_Cmd_Check_01;
assign T1_Arc_Test_External_Cmd_Check_01 to "";
monitor T1_Arc_Test_External_Cmd_Check_01;
int T1_Arc_Test_External_Cmd_Check_02;
assign T1_Arc_Test_External_Cmd_Check_02 to "";
monitor T1_Arc_Test_External_Cmd_Check_02;
int T1_Arc_Test_External_Cmd_Check_03;
assign T1_Arc_Test_External_Cmd_Check_03 to "";
monitor T1_Arc_Test_External_Cmd_Check_03;
int T1_Arc_Test_External_Cmd_Check_04;
assign T1_Arc_Test_External_Cmd_Check_04 to "";
monitor T1_Arc_Test_External_Cmd_Check_04;
int T2_Arc_Test_External_Cmd_Check_01;
assign T2_Arc_Test_External_Cmd_Check_01 to "";
monitor T2_Arc_Test_External_Cmd_Check_01;
int T2_Arc_Test_External_Cmd_Check_02;
assign T2_Arc_Test_External_Cmd_Check_02 to "";
monitor T2_Arc_Test_External_Cmd_Check_02;
int T2_Arc_Test_External_Cmd_Check_03;
assign T2_Arc_Test_External_Cmd_Check_03 to "";
monitor T2_Arc_Test_External_Cmd_Check_03;
int T2_Arc_Test_External_Cmd_Check_04;
assign T2_Arc_Test_External_Cmd_Check_04 to "";
monitor T2_Arc_Test_External_Cmd_Check_04;
int T3_Arc_Test_External_Cmd_Check_01;
assign T3_Arc_Test_External_Cmd_Check_01 to "";
monitor T3_Arc_Test_External_Cmd_Check_01;
int T3_Arc_Test_External_Cmd_Check_02;
assign T3_Arc_Test_External_Cmd_Check_02 to "";
monitor T3_Arc_Test_External_Cmd_Check_02;
int T3_Arc_Test_External_Cmd_Check_03;
assign T3_Arc_Test_External_Cmd_Check_03 to "";
monitor T3_Arc_Test_External_Cmd_Check_03;
int T3_Arc_Test_External_Cmd_Check_04;
assign T3_Arc_Test_External_Cmd_Check_04 to "";
monitor T3_Arc_Test_External_Cmd_Check_04;
int T4_Arc_Test_External_Cmd_Check_01;
assign T4_Arc_Test_External_Cmd_Check_01 to "";
monitor T4_Arc_Test_External_Cmd_Check_01;
int T4_Arc_Test_External_Cmd_Check_02;
assign T4_Arc_Test_External_Cmd_Check_02 to "";
monitor T4_Arc_Test_External_Cmd_Check_02;
int T4_Arc_Test_External_Cmd_Check_03;
assign T4_Arc_Test_External_Cmd_Check_03 to "";
monitor T4_Arc_Test_External_Cmd_Check_03;
int T4_Arc_Test_External_Cmd_Check_04;
assign T4_Arc_Test_External_Cmd_Check_04 to "";
monitor T4_Arc_Test_External_Cmd_Check_04;
int T5_Arc_Test_External_Cmd_Check_01;
assign T5_Arc_Test_External_Cmd_Check_01 to "";
monitor T5_Arc_Test_External_Cmd_Check_01;
int T5_Arc_Test_External_Cmd_Check_02;
assign T5_Arc_Test_External_Cmd_Check_02 to "";
monitor T5_Arc_Test_External_Cmd_Check_02;
int T5_Arc_Test_External_Cmd_Check_03;
assign T5_Arc_Test_External_Cmd_Check_03 to "";
monitor T5_Arc_Test_External_Cmd_Check_03;
int T5_Arc_Test_External_Cmd_Check_04;
assign T5_Arc_Test_External_Cmd_Check_04 to "";
monitor T5_Arc_Test_External_Cmd_Check_04;

/* Arc Test External Command - ADTT */
int T1_Arc_Test_External_Cmd_01;
assign T1_Arc_Test_External_Cmd_01 to "";
monitor T1_Arc_Test_External_Cmd_01;
int T1_Arc_Test_External_Cmd_02;
assign T1_Arc_Test_External_Cmd_02 to "";
monitor T1_Arc_Test_External_Cmd_02;
int T1_Arc_Test_External_Cmd_03;
assign T1_Arc_Test_External_Cmd_03 to "";
monitor T1_Arc_Test_External_Cmd_03;
int T1_Arc_Test_External_Cmd_04;
assign T1_Arc_Test_External_Cmd_04 to "";
monitor T1_Arc_Test_External_Cmd_04;
int T2_Arc_Test_External_Cmd_01;
assign T2_Arc_Test_External_Cmd_01 to "";
monitor T2_Arc_Test_External_Cmd_01;
int T2_Arc_Test_External_Cmd_02;
assign T2_Arc_Test_External_Cmd_02 to "";
monitor T2_Arc_Test_External_Cmd_02;
int T2_Arc_Test_External_Cmd_03;
assign T2_Arc_Test_External_Cmd_03 to "";
monitor T2_Arc_Test_External_Cmd_03;
int T2_Arc_Test_External_Cmd_04;
assign T2_Arc_Test_External_Cmd_04 to "";
monitor T2_Arc_Test_External_Cmd_04;
int T3_Arc_Test_External_Cmd_01;
assign T3_Arc_Test_External_Cmd_01 to "";
monitor T3_Arc_Test_External_Cmd_01;
int T3_Arc_Test_External_Cmd_02;
assign T3_Arc_Test_External_Cmd_02 to "";
monitor T3_Arc_Test_External_Cmd_02;
int T3_Arc_Test_External_Cmd_03;
assign T3_Arc_Test_External_Cmd_03 to "";
monitor T3_Arc_Test_External_Cmd_03;
int T3_Arc_Test_External_Cmd_04;
assign T3_Arc_Test_External_Cmd_04 to "";
monitor T3_Arc_Test_External_Cmd_04;
int T4_Arc_Test_External_Cmd_01;
assign T4_Arc_Test_External_Cmd_01 to "";
monitor T4_Arc_Test_External_Cmd_01;
int T4_Arc_Test_External_Cmd_02;
assign T4_Arc_Test_External_Cmd_02 to "";
monitor T4_Arc_Test_External_Cmd_02;
int T4_Arc_Test_External_Cmd_03;
assign T4_Arc_Test_External_Cmd_03 to "";
monitor T4_Arc_Test_External_Cmd_03;
int T4_Arc_Test_External_Cmd_04;
assign T4_Arc_Test_External_Cmd_04 to "";
monitor T4_Arc_Test_External_Cmd_04;
int T5_Arc_Test_External_Cmd_01;
assign T5_Arc_Test_External_Cmd_01 to "";
monitor T5_Arc_Test_External_Cmd_01;
int T5_Arc_Test_External_Cmd_02;
assign T5_Arc_Test_External_Cmd_02 to "";
monitor T5_Arc_Test_External_Cmd_02;
int T5_Arc_Test_External_Cmd_03;
assign T5_Arc_Test_External_Cmd_03 to "";
monitor T5_Arc_Test_External_Cmd_03;
int T5_Arc_Test_External_Cmd_04;
assign T5_Arc_Test_External_Cmd_04 to "";
monitor T5_Arc_Test_External_Cmd_04;

/* Test Internal Status */  /* 0=NOK | 1=OK */
int T1_Arc_Test_Internal_Status_01;
assign T1_Arc_Test_Internal_Status_01 to "";
monitor T1_Arc_Test_Internal_Status_01;
int T1_Arc_Test_Internal_Status_02;
assign T1_Arc_Test_Internal_Status_02 to "";
monitor T1_Arc_Test_Internal_Status_02;
int T1_Arc_Test_Internal_Status_03;
assign T1_Arc_Test_Internal_Status_03 to "";
monitor T1_Arc_Test_Internal_Status_03;
int T1_Arc_Test_Internal_Status_04;
assign T1_Arc_Test_Internal_Status_04 to "";
monitor T1_Arc_Test_Internal_Status_04;
int T2_Arc_Test_Internal_Status_01;
assign T2_Arc_Test_Internal_Status_01 to "";
monitor T2_Arc_Test_Internal_Status_01;
int T2_Arc_Test_Internal_Status_02;
assign T2_Arc_Test_Internal_Status_02 to "";
monitor T2_Arc_Test_Internal_Status_02;
int T2_Arc_Test_Internal_Status_03;
assign T2_Arc_Test_Internal_Status_03 to "";
monitor T2_Arc_Test_Internal_Status_03;
int T2_Arc_Test_Internal_Status_04;
assign T2_Arc_Test_Internal_Status_04 to "";
monitor T2_Arc_Test_Internal_Status_04;
int T3_Arc_Test_Internal_Status_01;
assign T3_Arc_Test_Internal_Status_01 to "";
monitor T3_Arc_Test_Internal_Status_01;
int T3_Arc_Test_Internal_Status_02;
assign T3_Arc_Test_Internal_Status_02 to "";
monitor T3_Arc_Test_Internal_Status_02;
int T3_Arc_Test_Internal_Status_03;
assign T3_Arc_Test_Internal_Status_03 to "";
monitor T3_Arc_Test_Internal_Status_03;
int T3_Arc_Test_Internal_Status_04;
assign T3_Arc_Test_Internal_Status_04 to "";
monitor T3_Arc_Test_Internal_Status_04;
int T4_Arc_Test_Internal_Status_01;
assign T4_Arc_Test_Internal_Status_01 to "";
monitor T4_Arc_Test_Internal_Status_01;
int T4_Arc_Test_Internal_Status_02;
assign T4_Arc_Test_Internal_Status_02 to "";
monitor T4_Arc_Test_Internal_Status_02;
int T4_Arc_Test_Internal_Status_03;
assign T4_Arc_Test_Internal_Status_03 to "";
monitor T4_Arc_Test_Internal_Status_03;
int T4_Arc_Test_Internal_Status_04;
assign T4_Arc_Test_Internal_Status_04 to "";
monitor T4_Arc_Test_Internal_Status_04;
int T5_Arc_Test_Internal_Status_01;
assign T5_Arc_Test_Internal_Status_01 to "";
monitor T5_Arc_Test_Internal_Status_01;
int T5_Arc_Test_Internal_Status_02;
assign T5_Arc_Test_Internal_Status_02 to "";
monitor T5_Arc_Test_Internal_Status_02;
int T5_Arc_Test_Internal_Status_03;
assign T5_Arc_Test_Internal_Status_03 to "";
monitor T5_Arc_Test_Internal_Status_03;
int T5_Arc_Test_Internal_Status_04;
assign T5_Arc_Test_Internal_Status_04 to "";
monitor T5_Arc_Test_Internal_Status_04;

/* Test External Status */  /* 0=NOK | 1=OK */
int T1_Arc_Test_External_Status_01;
assign T1_Arc_Test_External_Status_01 to "";
monitor T1_Arc_Test_External_Status_01;
int T1_Arc_Test_External_Status_02;
assign T1_Arc_Test_External_Status_02 to "";
monitor T1_Arc_Test_External_Status_02;
int T1_Arc_Test_External_Status_03;
assign T1_Arc_Test_External_Status_03 to "";
monitor T1_Arc_Test_External_Status_03;
int T1_Arc_Test_External_Status_04;
assign T1_Arc_Test_External_Status_04 to "";
monitor T1_Arc_Test_External_Status_04;
int T2_Arc_Test_External_Status_01;
assign T2_Arc_Test_External_Status_01 to "";
monitor T2_Arc_Test_External_Status_01;
int T2_Arc_Test_External_Status_02;
assign T2_Arc_Test_External_Status_02 to "";
monitor T2_Arc_Test_External_Status_02;
int T2_Arc_Test_External_Status_03;
assign T2_Arc_Test_External_Status_03 to "";
monitor T2_Arc_Test_External_Status_03;
int T2_Arc_Test_External_Status_04;
assign T2_Arc_Test_External_Status_04 to "";
monitor T2_Arc_Test_External_Status_04;
int T3_Arc_Test_External_Status_01;
assign T3_Arc_Test_External_Status_01 to "";
monitor T3_Arc_Test_External_Status_01;
int T3_Arc_Test_External_Status_02;
assign T3_Arc_Test_External_Status_02 to "";
monitor T3_Arc_Test_External_Status_02;
int T3_Arc_Test_External_Status_03;
assign T3_Arc_Test_External_Status_03 to "";
monitor T3_Arc_Test_External_Status_03;
int T3_Arc_Test_External_Status_04;
assign T3_Arc_Test_External_Status_04 to "";
monitor T3_Arc_Test_External_Status_04;
int T4_Arc_Test_External_Status_01;
assign T4_Arc_Test_External_Status_01 to "";
monitor T4_Arc_Test_External_Status_01;
int T4_Arc_Test_External_Status_02;
assign T4_Arc_Test_External_Status_02 to "";
monitor T4_Arc_Test_External_Status_02;
int T4_Arc_Test_External_Status_03;
assign T4_Arc_Test_External_Status_03 to "";
monitor T4_Arc_Test_External_Status_03;
int T4_Arc_Test_External_Status_04;
assign T4_Arc_Test_External_Status_04 to "";
monitor T4_Arc_Test_External_Status_04;
int T5_Arc_Test_External_Status_01;
assign T5_Arc_Test_External_Status_01 to "";
monitor T5_Arc_Test_External_Status_01;
int T5_Arc_Test_External_Status_02;
assign T5_Arc_Test_External_Status_02 to "";
monitor T5_Arc_Test_External_Status_02;
int T5_Arc_Test_External_Status_03;
assign T5_Arc_Test_External_Status_03 to "";
monitor T5_Arc_Test_External_Status_03;
int T5_Arc_Test_External_Status_04;
assign T5_Arc_Test_External_Status_04 to "";
monitor T5_Arc_Test_External_Status_04;

/* Last Execution Time Stamp - Internal */
float T1_Last_Internal_Exec_Timestamp_01;
assign T1_Last_Internal_Exec_Timestamp_01 to "";
monitor T1_Last_Internal_Exec_Timestamp_01;
float T1_Last_Internal_Exec_Timestamp_02;
assign T1_Last_Internal_Exec_Timestamp_02 to "";
monitor T1_Last_Internal_Exec_Timestamp_02;
float T1_Last_Internal_Exec_Timestamp_03;
assign T1_Last_Internal_Exec_Timestamp_03 to "";
monitor T1_Last_Internal_Exec_Timestamp_03;
float T1_Last_Internal_Exec_Timestamp_04;
assign T1_Last_Internal_Exec_Timestamp_04 to "";
monitor T1_Last_Internal_Exec_Timestamp_04;
float T2_Last_Internal_Exec_Timestamp_01;
assign T2_Last_Internal_Exec_Timestamp_01 to "";
monitor T2_Last_Internal_Exec_Timestamp_01;
float T2_Last_Internal_Exec_Timestamp_02;
assign T2_Last_Internal_Exec_Timestamp_02 to "";
monitor T2_Last_Internal_Exec_Timestamp_02;
float T2_Last_Internal_Exec_Timestamp_03;
assign T2_Last_Internal_Exec_Timestamp_03 to "";
monitor T2_Last_Internal_Exec_Timestamp_03;
float T2_Last_Internal_Exec_Timestamp_04;
assign T2_Last_Internal_Exec_Timestamp_04 to "";
monitor T2_Last_Internal_Exec_Timestamp_04;
float T3_Last_Internal_Exec_Timestamp_01;
assign T3_Last_Internal_Exec_Timestamp_01 to "";
monitor T3_Last_Internal_Exec_Timestamp_01;
float T3_Last_Internal_Exec_Timestamp_02;
assign T3_Last_Internal_Exec_Timestamp_02 to "";
monitor T3_Last_Internal_Exec_Timestamp_02;
float T3_Last_Internal_Exec_Timestamp_03;
assign T3_Last_Internal_Exec_Timestamp_03 to "";
monitor T3_Last_Internal_Exec_Timestamp_03;
float T3_Last_Internal_Exec_Timestamp_04;
assign T3_Last_Internal_Exec_Timestamp_04 to "";
monitor T3_Last_Internal_Exec_Timestamp_04;
float T4_Last_Internal_Exec_Timestamp_01;
assign T4_Last_Internal_Exec_Timestamp_01 to "";
monitor T4_Last_Internal_Exec_Timestamp_01;
float T4_Last_Internal_Exec_Timestamp_02;
assign T4_Last_Internal_Exec_Timestamp_02 to "";
monitor T4_Last_Internal_Exec_Timestamp_02;
float T4_Last_Internal_Exec_Timestamp_03;
assign T4_Last_Internal_Exec_Timestamp_03 to "";
monitor T4_Last_Internal_Exec_Timestamp_03;
float T4_Last_Internal_Exec_Timestamp_04;
assign T4_Last_Internal_Exec_Timestamp_04 to "";
monitor T4_Last_Internal_Exec_Timestamp_04;
float T5_Last_Internal_Exec_Timestamp_01;
assign T5_Last_Internal_Exec_Timestamp_01 to "";
monitor T5_Last_Internal_Exec_Timestamp_01;
float T5_Last_Internal_Exec_Timestamp_02;
assign T5_Last_Internal_Exec_Timestamp_02 to "";
monitor T5_Last_Internal_Exec_Timestamp_02;
float T5_Last_Internal_Exec_Timestamp_03;
assign T5_Last_Internal_Exec_Timestamp_03 to "";
monitor T5_Last_Internal_Exec_Timestamp_03;
float T5_Last_Internal_Exec_Timestamp_04;
assign T5_Last_Internal_Exec_Timestamp_04 to "";
monitor T5_Last_Internal_Exec_Timestamp_04;

/* Last Execution Time Stamp - External */
float T1_Last_External_Exec_Timestamp_01;
assign T1_Last_External_Exec_Timestamp_01 to "";
monitor T1_Last_External_Exec_Timestamp_01;
float T1_Last_External_Exec_Timestamp_02;
assign T1_Last_External_Exec_Timestamp_02 to "";
monitor T1_Last_External_Exec_Timestamp_02;
float T1_Last_External_Exec_Timestamp_03;
assign T1_Last_External_Exec_Timestamp_03 to "";
monitor T1_Last_External_Exec_Timestamp_03;
float T1_Last_External_Exec_Timestamp_04;
assign T1_Last_External_Exec_Timestamp_04 to "";
monitor T1_Last_External_Exec_Timestamp_04;
float T2_Last_External_Exec_Timestamp_01;
assign T2_Last_External_Exec_Timestamp_01 to "";
monitor T2_Last_External_Exec_Timestamp_01;
float T2_Last_External_Exec_Timestamp_02;
assign T2_Last_External_Exec_Timestamp_02 to "";
monitor T2_Last_External_Exec_Timestamp_02;
float T2_Last_External_Exec_Timestamp_03;
assign T2_Last_External_Exec_Timestamp_03 to "";
monitor T2_Last_External_Exec_Timestamp_03;
float T2_Last_External_Exec_Timestamp_04;
assign T2_Last_External_Exec_Timestamp_04 to "";
monitor T2_Last_External_Exec_Timestamp_04;
float T3_Last_External_Exec_Timestamp_01;
assign T3_Last_External_Exec_Timestamp_01 to "";
monitor T3_Last_External_Exec_Timestamp_01;
float T3_Last_External_Exec_Timestamp_02;
assign T3_Last_External_Exec_Timestamp_02 to "";
monitor T3_Last_External_Exec_Timestamp_02;
float T3_Last_External_Exec_Timestamp_03;
assign T3_Last_External_Exec_Timestamp_03 to "";
monitor T3_Last_External_Exec_Timestamp_03;
float T3_Last_External_Exec_Timestamp_04;
assign T3_Last_External_Exec_Timestamp_04 to "";
monitor T3_Last_External_Exec_Timestamp_04;
float T4_Last_External_Exec_Timestamp_01;
assign T4_Last_External_Exec_Timestamp_01 to "";
monitor T4_Last_External_Exec_Timestamp_01;
float T4_Last_External_Exec_Timestamp_02;
assign T4_Last_External_Exec_Timestamp_02 to "";
monitor T4_Last_External_Exec_Timestamp_02;
float T4_Last_External_Exec_Timestamp_03;
assign T4_Last_External_Exec_Timestamp_03 to "";
monitor T4_Last_External_Exec_Timestamp_03;
float T4_Last_External_Exec_Timestamp_04;
assign T4_Last_External_Exec_Timestamp_04 to "";
monitor T4_Last_External_Exec_Timestamp_04;
float T5_Last_External_Exec_Timestamp_01;
assign T5_Last_External_Exec_Timestamp_01 to "";
monitor T5_Last_External_Exec_Timestamp_01;
float T5_Last_External_Exec_Timestamp_02;
assign T5_Last_External_Exec_Timestamp_02 to "";
monitor T5_Last_External_Exec_Timestamp_02;
float T5_Last_External_Exec_Timestamp_03;
assign T5_Last_External_Exec_Timestamp_03 to "";
monitor T5_Last_External_Exec_Timestamp_03;
float T5_Last_External_Exec_Timestamp_04;
assign T5_Last_External_Exec_Timestamp_04 to "";
monitor T5_Last_External_Exec_Timestamp_04;



/* Maintenance and fault control*/
int MaintenanceReset;
assign MaintenanceReset to "";
monitor MaintenanceReset;
int FaultReset;
assign FaultReset to "";
monitor FaultReset;

/*
# Stages Code:
# 	0  -> INIT
# 	10 -> SELF-CHECK
# 	20 -> IDLE
# 	30 -> START-UP
# 	40 -> READY FOR OPERATION
# 	50 -> FAILURE
# 	60 -> MAINTENANCE
*/
int StateMachineCode;
assign StateMachineCode to "";

/*
# DTL Operational State Machine Code:
# 	0   -> INIT
# 	101 -> STAND-BY
# 	202 -> RF CONDITIONING
# 	303 -> RF START-UP
# 	404 -> READY FOR OPERATION
# 	505 -> NO ACCELERATED BEAM
# 	606 -> MAINTENANCE
*/
int dtlOperationalCode;
assign dtlOperationalCode to "DTL::StateMachine";
monitor dtlOperationalCode;



/* Debug Mode: */
double DEBUG=1;



/*
# State Machine Definition
*/

ss arcDetection_statemachine {

/* state INITIALIZATION	*/
	state initialization {
		entry {
			printf("\n\nPreliminary controls executed due to Application Startup - Intialization\n\n");
			StateMachineCode=0;
			pvPut(StateMachineCode);
		}

		when (pvConnectCount()==pvAssignCount()) {
			printf("[SEQ ARC DETECTION] All PVs connected\n");
			printf("[SEQ ARC DETECTION] Starting Self Check Process\n");

		} state self_check

	}


/* state SELF_CHECK	*/
	state self_check {
		entry {
				printf("\n[SEQ ARC DETECTION] Enter in SELF CHECK status\n");
				StateMachineCode=10;
				pvPut(StateMachineCode);
		}

    /* Error: ADM is OFF with  power_on_counter < Max_power_on */
		when ( ((T1_Arc_Power_Status == 0) || (T2_Arc_Power_Status == 0) || (T3_Arc_Power_Status == 0) || (T4_Arc_Power_Status == 0) || (T5_Arc_Power_Status == 0)) && (power_on_counter < Max_power_on)  ) {
      printf("[SEQ ARC DETECTION] Error ADM systems: one or more devices are OFF \n");
      printf("[SEQ ARC DETECTION] Try to power on devices \n");

			/* Power on devices */
			T1_Arc_Power_Cmd=1;
			pvPut(T1_Arc_Power_Cmd);
			T2_Arc_Power_Cmd=1;
			pvPut(T2_Arc_Power_Cmd);
			T3_Arc_Power_Cmd=1;
			pvPut(T3_Arc_Power_Cmd);
			T4_Arc_Power_Cmd=1;
			pvPut(T4_Arc_Power_Cmd);
			T5_Arc_Power_Cmd=1;
			pvPut(T5_Arc_Power_Cmd);
			++power_on_counter;

		} state self_check

		/* Error: ADM is OFF with  power_on_counter >= Max_power_on */
		when ( ((T1_Arc_Power_Status == 0) || (T2_Arc_Power_Status == 0) || (T3_Arc_Power_Status == 0) || (T4_Arc_Power_Status == 0) || (T5_Arc_Power_Status == 0)) && (power_on_counter >= Max_power_on)  ) {
      printf("[SEQ ARC DETECTION] Error ADM systems: one or more devices are OFF \n");
      printf("[SEQ ARC DETECTION] System not passed self check: go to FAILURE \n");

		} state failure



    /* no error in any line */
    when ( ...  ) {

      printf("[SEQ ARC DETECTION] Self Check Passed. \n");
      printf("[SEQ ARC DETECTION] System set homing position (tuners extracted) \n");


    } state start_up

  }


/* state STARTUP	*/
state start_up {
  entry {
    printf("\n[SEQ ARC DETECTION] Enter in START UP status\n");
    StateMachineCode=30;
    pvPut(StateMachineCode);


  }

	/* */
	when () {

	}



}


/* state IDLE   	*/
state idle {

	entry {
    printf("\n[SEQ ARC DETECTION] Enter in IDLE status\n");
    StateMachineCode=20;
    pvPut(StateMachineCode);
  }

	/* */
	when () {

	}


}



/* state READY_FOR_OPERATION 	*/
state ready_for_operation {

	entry {
		printf("\n[SEQ ARC DETECTION] Enter in READY FOR OPERATION status\n");
		StateMachineCode=40;
		pvPut(StateMachineCode);
		}


	/* */
	when () {

	}

}


/* state FAILURE	*/
state failure {

	entry {
			printf("\n[SEQ ARC DETECTION] Enter in FAILURE status\n");
			StateMachineCode=50;
			pvPut(StateMachineCode);
	}

	/* */
	when () {

	}

/* state MAINTENANCE	*/
state maintenance {

	entry {
			printf("\n[SEQ ARC DETECTION] Enter in MAINTENANCE status\n");
			StateMachineCode=60;
			pvPut(StateMachineCode);
	}

	/* */
	when () {

	}


/* end statemachine */
}
