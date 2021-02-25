/* Arc Detection State Machine - Tank 1
# State Machine devoted to control the Arc Detection sub-system related to DTL apparatus:
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

program arcDetection_tank010

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

/* MISSING: rearm configuration and parameters */



/* ARC4 Power Status */ /* 0=NOK | 1=OK */
double power_on_counter = 0;
double Max_power_on = 3;

int T1_Arc_Power_Status;
assign T1_Arc_Power_Status to "";
monitor T1_Arc_Power_Status;


/* ARC4 Power Command */
int T1_Arc_Power_Cmd;
assign T1_Arc_Power_Cmd to "";
monitor T1_Arc_Power_Cmd;


/* ARC4 Power Reset */
int T1_Arc_Power_Reset;
assign T1_Arc_Power_Reset to "";
monitor T1_Arc_Power_Reset;


/* Global Arc Status */ /* 0=NOK | 1=OK */
/* PVs provided by dtlArcOkState.db (tuner IOC) */
int T1_Arc_Global_Status;
assign T1_Arc_Global_Status to "{SECTION_NAME}:RFS-AD:OkStat-RB";
monitor T1_Arc_Global_Status;


/* Counts Limits for Global Arc Status */
/* PVs provided by dtlArcOkState.db (tuner IOC) */
double T1_Arc_Global_Counter_Limit;
assign T1_Arc_Global_Counter_Limit to "{SECTION_NAME}:RFS-AD:OkStat-RB.B";
monitor T1_Arc_Global_Counter_Limit;


/* Max Limits for Arc Counts */
/* PVs provided by parametersArcDetection.db (orchestration IOC) */
double DTL_RF_Conditioning_Max_Arcs_Limit;
assign DTL_RF_Conditioning_Max_Arcs_Limit to "DTL:RFS-AD:RFCondArcLim";
monitor DTL_RF_Conditioning_Max_Arcs_Limit;
double DTL_RF_Beam_Operation_Max_Arcs_Limit;
assign DTL_RF_Beam_Operation_Max_Arcs_Limit to "DTL:RFS-AD:RFBeamOpArcLim";
monitor DTL_RF_Beam_Operation_Max_Arcs_Limit;


/* RF Status */
int T1_RF_Status;
assign T1_RF_Status to "";
monitor T1_RF_Status;


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



/* Manual Test Procedure Completed Command*/
int Manual_Test_Done;
assign Manual_Test_Done to "DTL:RFS-AD:TestDone";
monitor Manual_Test_Done;

/* Enable Start Operation - for start-up stage */
int StartOperationCmd;
assign StartOperationCmd to "DTL:RFS-AD:OpRun";
monitor StartOperationCmd;

/* Manual/Auto Control  */
int AutoControlCmd;
assign AutoControlCmd to "DTL:RFS-AD:AutoCmd";
monitor AutoControlCmd;

int AutoControl_ActualStatus;
assign AutoControl_ActualStatus to "DTL:RFS-AD:AutoCmd-RB";
monitor AutoControl_ActualStatus;


/* Maintenance and fault control*/
int MaintenanceReset;
assign MaintenanceReset to "DTL:RFS-AD:MaintenanceRst";
monitor MaintenanceReset;
int FaultReset;
assign FaultReset to "DTL:RFS-AD:FaultRst";
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
assign StateMachineCode to "{SECTION_NAME}:RFS-AD:StateMachine";

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

/* Internal Variables */
int dtl_operation_code_prev=0;

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
			printf("[SEQ ARC DETECTION - TANK 1] All PVs connected\n");
			printf("[SEQ ARC DETECTION - TANK 1] Starting Self Check Process\n");

			/* Actual man|auto control initialization */
			AutoControl_ActualStatus = AutoControlCmd;
			pvPut(AutoControl_ActualStatus);

		} state self_check

	}


/* state SELF_CHECK	*/
	state self_check {
		entry {
				printf("\n[SEQ ARC DETECTION - TANK 1] Enter in SELF CHECK status\n");
				StateMachineCode=10;
				pvPut(StateMachineCode);
		}

    /* Error: ADM is OFF with  power_on_counter < Max_power_on */
		when ( ((T1_Arc_Power_Status == 0) || (T2_Arc_Power_Status == 0) || (T3_Arc_Power_Status == 0) || (T4_Arc_Power_Status == 0) || (T5_Arc_Power_Status == 0)) && (power_on_counter < Max_power_on)  ) {
      printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more devices are OFF \n");
      printf("[SEQ ARC DETECTION - TANK 1] Try to power on devices \n");

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
      printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more devices are OFF \n");
      printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

		} state failure

		/* Error: Global Status is NOK */
		when ( (T1_Arc_Global_Status == 0) || (T2_Arc_Global_Status == 0) || (T3_Arc_Global_Status == 0) || (T4_Arc_Global_Status == 0) || (T5_Arc_Global_Status == 0) ) {
      printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more Global Status are NOK \n");
      printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

		} state failure

		/* Error: Internal Command Check is NOK */
		when ( (T1_Arc_Test_Internal_Cmd_Check_01 == 0) || (T1_Arc_Test_Internal_Cmd_Check_02 == 0) || (T1_Arc_Test_Internal_Cmd_Check_03 == 0) || (T1_Arc_Test_Internal_Cmd_Check_04 == 0) || (T2_Arc_Test_Internal_Cmd_Check_01 == 0) || (T2_Arc_Test_Internal_Cmd_Check_02 == 0) || (T2_Arc_Test_Internal_Cmd_Check_03 == 0) || (T2_Arc_Test_Internal_Cmd_Check_04 == 0) || (T3_Arc_Test_Internal_Cmd_Check_01 == 0) || (T3_Arc_Test_Internal_Cmd_Check_02 == 0) || (T3_Arc_Test_Internal_Cmd_Check_03 == 0) || (T3_Arc_Test_Internal_Cmd_Check_04 == 0) || (T4_Arc_Test_Internal_Cmd_Check_01 == 0) || (T4_Arc_Test_Internal_Cmd_Check_02 == 0) || (T4_Arc_Test_Internal_Cmd_Check_03 == 0) || (T4_Arc_Test_Internal_Cmd_Check_04 == 0) || (T5_Arc_Test_Internal_Cmd_Check_01 == 0) || (T5_Arc_Test_Internal_Cmd_Check_02 == 0) || (T5_Arc_Test_Internal_Cmd_Check_03 == 0) || (T5_Arc_Test_Internal_Cmd_Check_04 == 0) ) {
			printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more Internal Command Checks are NOK \n");
			printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

		} state failure

		/* Error: External Command Check is NOK */
		when ( (T1_Arc_Test_External_Cmd_Check_01 == 0) || (T1_Arc_Test_External_Cmd_Check_02 == 0) || (T1_Arc_Test_External_Cmd_Check_03 == 0) || (T1_Arc_Test_External_Cmd_Check_04 == 0) || (T2_Arc_Test_External_Cmd_Check_01 == 0) || (T2_Arc_Test_External_Cmd_Check_02 == 0) || (T2_Arc_Test_External_Cmd_Check_03 == 0) || (T2_Arc_Test_External_Cmd_Check_04 == 0) || (T3_Arc_Test_External_Cmd_Check_01 == 0) || (T3_Arc_Test_External_Cmd_Check_02 == 0) || (T3_Arc_Test_External_Cmd_Check_03 == 0) || (T3_Arc_Test_External_Cmd_Check_04 == 0) || (T4_Arc_Test_External_Cmd_Check_01 == 0) || (T4_Arc_Test_External_Cmd_Check_02 == 0) || (T4_Arc_Test_External_Cmd_Check_03 == 0) || (T4_Arc_Test_External_Cmd_Check_04 == 0) || (T5_Arc_Test_External_Cmd_Check_01 == 0) || (T5_Arc_Test_External_Cmd_Check_02 == 0) || (T5_Arc_Test_External_Cmd_Check_03 == 0) || (T5_Arc_Test_External_Cmd_Check_04 == 0) ) {
			printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more External Command Checks are NOK \n");
			printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

		} state failure

		/* Error: External Status is NOK */
		when ( (T1_Arc_Test_External_Status_01 == 0) || (T1_Arc_Test_External_Status_02 == 0) || (T1_Arc_Test_External_Status_03 == 0) || (T1_Arc_Test_External_Status_04 == 0) || (T2_Arc_Test_External_Status_01 == 0) || (T2_Arc_Test_External_Status_02 == 0) || (T2_Arc_Test_External_Status_03 == 0) || (T2_Arc_Test_External_Status_04 == 0) || (T3_Arc_Test_External_Status_01 == 0) || (T3_Arc_Test_External_Status_02 == 0) || (T3_Arc_Test_External_Status_03 == 0) || (T3_Arc_Test_External_Status_04 == 0) || (T4_Arc_Test_External_Status_01 == 0) || (T4_Arc_Test_External_Status_02 == 0) || (T4_Arc_Test_External_Status_03 == 0) || (T4_Arc_Test_External_Status_04 == 0) || (T5_Arc_Test_External_Status_01 == 0) || (T5_Arc_Test_External_Status_02 == 0) || (T5_Arc_Test_External_Status_03 == 0) || (T5_Arc_Test_External_Status_04 == 0) ) {
			printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more External Status are NOK \n");
			printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

		} state failure


    /* no error in any line */
    when ( (T1_Arc_Power_Status == 1) && (T2_Arc_Power_Status == 1) && (T3_Arc_Power_Status == 1) && (T4_Arc_Power_Status == 1) && (T5_Arc_Power_Status == 1) && (T1_Arc_Global_Status == 1) && (T2_Arc_Global_Status == 1) && (T3_Arc_Global_Status == 1) && (T4_Arc_Global_Status == 1) && (T5_Arc_Global_Status == 1) && (T1_Arc_Test_Internal_Cmd_Check_01 == 1) && (T1_Arc_Test_Internal_Cmd_Check_02 == 1) && (T1_Arc_Test_Internal_Cmd_Check_03 == 1) && (T1_Arc_Test_Internal_Cmd_Check_04 == 1) && (T2_Arc_Test_Internal_Cmd_Check_01 == 1) && (T2_Arc_Test_Internal_Cmd_Check_02 == 1) && (T2_Arc_Test_Internal_Cmd_Check_03 == 1) && (T2_Arc_Test_Internal_Cmd_Check_04 == 1) && (T3_Arc_Test_Internal_Cmd_Check_01 == 1) && (T3_Arc_Test_Internal_Cmd_Check_02 == 1) && (T3_Arc_Test_Internal_Cmd_Check_03 == 1) && (T3_Arc_Test_Internal_Cmd_Check_04 == 1) && (T4_Arc_Test_Internal_Cmd_Check_01 == 1) && (T4_Arc_Test_Internal_Cmd_Check_02 == 1) && (T4_Arc_Test_Internal_Cmd_Check_03 == 1) && (T4_Arc_Test_Internal_Cmd_Check_04 == 1) && (T5_Arc_Test_Internal_Cmd_Check_01 == 1) && (T5_Arc_Test_Internal_Cmd_Check_02 == 1) && (T5_Arc_Test_Internal_Cmd_Check_03 == 1) && (T5_Arc_Test_Internal_Cmd_Check_04 == 1) && (T1_Arc_Test_External_Cmd_Check_01 == 1) && (T1_Arc_Test_External_Cmd_Check_02 == 1) && (T1_Arc_Test_External_Cmd_Check_03 == 1) && (T1_Arc_Test_External_Cmd_Check_04 == 1) && (T2_Arc_Test_External_Cmd_Check_01 == 1) && (T2_Arc_Test_External_Cmd_Check_02 == 1) && (T2_Arc_Test_External_Cmd_Check_03 == 1) && (T2_Arc_Test_External_Cmd_Check_04 == 1) && (T3_Arc_Test_External_Cmd_Check_01 == 1) && (T3_Arc_Test_External_Cmd_Check_02 == 1) && (T3_Arc_Test_External_Cmd_Check_03 == 1) && (T3_Arc_Test_External_Cmd_Check_04 == 1) && (T4_Arc_Test_External_Cmd_Check_01 == 1) && (T4_Arc_Test_External_Cmd_Check_02 == 1) && (T4_Arc_Test_External_Cmd_Check_03 == 1) && (T4_Arc_Test_External_Cmd_Check_04 == 1) && (T5_Arc_Test_External_Cmd_Check_01 == 1) && (T5_Arc_Test_External_Cmd_Check_02 == 1) && (T5_Arc_Test_External_Cmd_Check_03 == 1) && (T5_Arc_Test_External_Cmd_Check_04 == 1) && (T1_Arc_Test_Internal_Status_01 == 1) && (T1_Arc_Test_Internal_Status_02 == 1) && (T1_Arc_Test_Internal_Status_03 == 1) && (T1_Arc_Test_Internal_Status_04 == 1) && (T2_Arc_Test_Internal_Status_01 == 1) && (T2_Arc_Test_Internal_Status_02 == 1) && (T2_Arc_Test_Internal_Status_03 == 1) && (T2_Arc_Test_Internal_Status_04 == 1) && (T3_Arc_Test_Internal_Status_01 == 1) && (T3_Arc_Test_Internal_Status_02 == 1) && (T3_Arc_Test_Internal_Status_03 == 1) && (T3_Arc_Test_Internal_Status_04 == 1) && (T4_Arc_Test_Internal_Status_01 == 1) && (T4_Arc_Test_Internal_Status_02 == 1) && (T4_Arc_Test_Internal_Status_03 == 1) && (T4_Arc_Test_Internal_Status_04 == 1) && (T5_Arc_Test_Internal_Status_01 == 1) && (T5_Arc_Test_Internal_Status_02 == 1) && (T5_Arc_Test_Internal_Status_03 == 1) && (T5_Arc_Test_Internal_Status_04 == 1) ) {

      printf("[SEQ ARC DETECTION - TANK 1] Self Check Passed. \n");

    } state start_up

  }


/* state STARTUP	*/
state start_up {
  entry {
    printf("\n[SEQ ARC DETECTION - TANK 1] Enter in START UP status\n");
		StateMachineCode=30;
    pvPut(StateMachineCode);

  }

	/* Error: ADM is OFF with  power_on_counter >= Max_power_on */
	when ( ((T1_Arc_Power_Status == 0) || (T2_Arc_Power_Status == 0) || (T3_Arc_Power_Status == 0) || (T4_Arc_Power_Status == 0) || (T5_Arc_Power_Status == 0)) && (power_on_counter >= Max_power_on)  ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more devices are OFF \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: Global Status is NOK */
	when ( (T1_Arc_Global_Status == 0) || (T2_Arc_Global_Status == 0) || (T3_Arc_Global_Status == 0) || (T4_Arc_Global_Status == 0) || (T5_Arc_Global_Status == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more Global Status are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: Internal Command Check is NOK */
	when ( (T1_Arc_Test_Internal_Cmd_Check_01 == 0) || (T1_Arc_Test_Internal_Cmd_Check_02 == 0) || (T1_Arc_Test_Internal_Cmd_Check_03 == 0) || (T1_Arc_Test_Internal_Cmd_Check_04 == 0) || (T2_Arc_Test_Internal_Cmd_Check_01 == 0) || (T2_Arc_Test_Internal_Cmd_Check_02 == 0) || (T2_Arc_Test_Internal_Cmd_Check_03 == 0) || (T2_Arc_Test_Internal_Cmd_Check_04 == 0) || (T3_Arc_Test_Internal_Cmd_Check_01 == 0) || (T3_Arc_Test_Internal_Cmd_Check_02 == 0) || (T3_Arc_Test_Internal_Cmd_Check_03 == 0) || (T3_Arc_Test_Internal_Cmd_Check_04 == 0) || (T4_Arc_Test_Internal_Cmd_Check_01 == 0) || (T4_Arc_Test_Internal_Cmd_Check_02 == 0) || (T4_Arc_Test_Internal_Cmd_Check_03 == 0) || (T4_Arc_Test_Internal_Cmd_Check_04 == 0) || (T5_Arc_Test_Internal_Cmd_Check_01 == 0) || (T5_Arc_Test_Internal_Cmd_Check_02 == 0) || (T5_Arc_Test_Internal_Cmd_Check_03 == 0) || (T5_Arc_Test_Internal_Cmd_Check_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more Internal Command Checks are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: External Command Check is NOK */
	when ( (T1_Arc_Test_External_Cmd_Check_01 == 0) || (T1_Arc_Test_External_Cmd_Check_02 == 0) || (T1_Arc_Test_External_Cmd_Check_03 == 0) || (T1_Arc_Test_External_Cmd_Check_04 == 0) || (T2_Arc_Test_External_Cmd_Check_01 == 0) || (T2_Arc_Test_External_Cmd_Check_02 == 0) || (T2_Arc_Test_External_Cmd_Check_03 == 0) || (T2_Arc_Test_External_Cmd_Check_04 == 0) || (T3_Arc_Test_External_Cmd_Check_01 == 0) || (T3_Arc_Test_External_Cmd_Check_02 == 0) || (T3_Arc_Test_External_Cmd_Check_03 == 0) || (T3_Arc_Test_External_Cmd_Check_04 == 0) || (T4_Arc_Test_External_Cmd_Check_01 == 0) || (T4_Arc_Test_External_Cmd_Check_02 == 0) || (T4_Arc_Test_External_Cmd_Check_03 == 0) || (T4_Arc_Test_External_Cmd_Check_04 == 0) || (T5_Arc_Test_External_Cmd_Check_01 == 0) || (T5_Arc_Test_External_Cmd_Check_02 == 0) || (T5_Arc_Test_External_Cmd_Check_03 == 0) || (T5_Arc_Test_External_Cmd_Check_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more External Command Checks are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: External Status is NOK */
	when ( (T1_Arc_Test_External_Status_01 == 0) || (T1_Arc_Test_External_Status_02 == 0) || (T1_Arc_Test_External_Status_03 == 0) || (T1_Arc_Test_External_Status_04 == 0) || (T2_Arc_Test_External_Status_01 == 0) || (T2_Arc_Test_External_Status_02 == 0) || (T2_Arc_Test_External_Status_03 == 0) || (T2_Arc_Test_External_Status_04 == 0) || (T3_Arc_Test_External_Status_01 == 0) || (T3_Arc_Test_External_Status_02 == 0) || (T3_Arc_Test_External_Status_03 == 0) || (T3_Arc_Test_External_Status_04 == 0) || (T4_Arc_Test_External_Status_01 == 0) || (T4_Arc_Test_External_Status_02 == 0) || (T4_Arc_Test_External_Status_03 == 0) || (T4_Arc_Test_External_Status_04 == 0) || (T5_Arc_Test_External_Status_01 == 0) || (T5_Arc_Test_External_Status_02 == 0) || (T5_Arc_Test_External_Status_03 == 0) || (T5_Arc_Test_External_Status_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more External Status are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure


	/* Execute chosen configuration [man|auto] */
  when ( (StartOperationCmd == 1) ) {
      if ( (AutoControl_ActualStatus == 0) && (AutoControl_ActualStatus == AutoControlCmd) ) {
        printf("[SEQ ARC DETECTION - TANK 1] Start Control Operations in MANUAL Mode\n");
				printf("[SEQ ARC DETECTION - TANK 1] Manual Test Procedure \n");

      }
      else if ( (AutoControl_ActualStatus == 1) && (AutoControl_ActualStatus == AutoControlCmd) ) {
        printf("[SEQ ARC DETECTION - TANK 1] Start Control Operations in AUTOMATIC Mode\n");
				printf("[SEQ ARC DETECTION - TANK 1] Automatic Test Procedure \n");

      }
      else if ( (AutoControl_ActualStatus == 1) && (AutoControl_ActualStatus != AutoControlCmd) ) {
        printf("[SEQ ARC DETECTION - TANK 1] Updated control configuration\n");
        printf("[SEQ ARC DETECTION - TANK 1] Start Control Operations in MANUAL Mode\n");
        AutoControl_ActualStatus = AutoControlCmd;
        pvPut(AutoControl_ActualStatus);
				printf("[SEQ ARC DETECTION - TANK 1] Manual Test Procedure \n");
      }
      else if ( (AutoControl_ActualStatus == 0) && (AutoControl_ActualStatus != AutoControlCmd) ) {
        printf("[SEQ ARC DETECTION - TANK 1] Updated control configuration\n");
        printf("[SEQ ARC DETECTION - TANK 1] Start Control Operations in AUTOMATIC Mode\n");
        AutoControl_ActualStatus = AutoControlCmd;
        pvPut(AutoControl_ActualStatus);
				printf("[SEQ ARC DETECTION - TANK 1] Automatic Test Procedure \n");
      }
      else {
        printf("[SEQ ARC DETECTION - TANK 1] This message should not appear :)\n");
      }
  } state test_check


}


/* internal state TEST CHECK */
state test_check {
	entry {
		printf("\n[SEQ ARC DETECTION - TANK 1] Enter in TEST CHECK status (internal status)\n");

	}

	/* Error: ADM is OFF with  power_on_counter >= Max_power_on */
	when ( ((T1_Arc_Power_Status == 0) || (T2_Arc_Power_Status == 0) || (T3_Arc_Power_Status == 0) || (T4_Arc_Power_Status == 0) || (T5_Arc_Power_Status == 0)) && (power_on_counter >= Max_power_on)  ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more devices are OFF \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: Global Status is NOK */
	when ( (T1_Arc_Global_Status == 0) || (T2_Arc_Global_Status == 0) || (T3_Arc_Global_Status == 0) || (T4_Arc_Global_Status == 0) || (T5_Arc_Global_Status == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more Global Status are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: Internal Command Check is NOK */
	when ( (T1_Arc_Test_Internal_Cmd_Check_01 == 0) || (T1_Arc_Test_Internal_Cmd_Check_02 == 0) || (T1_Arc_Test_Internal_Cmd_Check_03 == 0) || (T1_Arc_Test_Internal_Cmd_Check_04 == 0) || (T2_Arc_Test_Internal_Cmd_Check_01 == 0) || (T2_Arc_Test_Internal_Cmd_Check_02 == 0) || (T2_Arc_Test_Internal_Cmd_Check_03 == 0) || (T2_Arc_Test_Internal_Cmd_Check_04 == 0) || (T3_Arc_Test_Internal_Cmd_Check_01 == 0) || (T3_Arc_Test_Internal_Cmd_Check_02 == 0) || (T3_Arc_Test_Internal_Cmd_Check_03 == 0) || (T3_Arc_Test_Internal_Cmd_Check_04 == 0) || (T4_Arc_Test_Internal_Cmd_Check_01 == 0) || (T4_Arc_Test_Internal_Cmd_Check_02 == 0) || (T4_Arc_Test_Internal_Cmd_Check_03 == 0) || (T4_Arc_Test_Internal_Cmd_Check_04 == 0) || (T5_Arc_Test_Internal_Cmd_Check_01 == 0) || (T5_Arc_Test_Internal_Cmd_Check_02 == 0) || (T5_Arc_Test_Internal_Cmd_Check_03 == 0) || (T5_Arc_Test_Internal_Cmd_Check_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more Internal Command Checks are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: External Command Check is NOK */
	when ( (T1_Arc_Test_External_Cmd_Check_01 == 0) || (T1_Arc_Test_External_Cmd_Check_02 == 0) || (T1_Arc_Test_External_Cmd_Check_03 == 0) || (T1_Arc_Test_External_Cmd_Check_04 == 0) || (T2_Arc_Test_External_Cmd_Check_01 == 0) || (T2_Arc_Test_External_Cmd_Check_02 == 0) || (T2_Arc_Test_External_Cmd_Check_03 == 0) || (T2_Arc_Test_External_Cmd_Check_04 == 0) || (T3_Arc_Test_External_Cmd_Check_01 == 0) || (T3_Arc_Test_External_Cmd_Check_02 == 0) || (T3_Arc_Test_External_Cmd_Check_03 == 0) || (T3_Arc_Test_External_Cmd_Check_04 == 0) || (T4_Arc_Test_External_Cmd_Check_01 == 0) || (T4_Arc_Test_External_Cmd_Check_02 == 0) || (T4_Arc_Test_External_Cmd_Check_03 == 0) || (T4_Arc_Test_External_Cmd_Check_04 == 0) || (T5_Arc_Test_External_Cmd_Check_01 == 0) || (T5_Arc_Test_External_Cmd_Check_02 == 0) || (T5_Arc_Test_External_Cmd_Check_03 == 0) || (T5_Arc_Test_External_Cmd_Check_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more External Command Checks are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: External Status is NOK */
	when ( (T1_Arc_Test_External_Status_01 == 0) || (T1_Arc_Test_External_Status_02 == 0) || (T1_Arc_Test_External_Status_03 == 0) || (T1_Arc_Test_External_Status_04 == 0) || (T2_Arc_Test_External_Status_01 == 0) || (T2_Arc_Test_External_Status_02 == 0) || (T2_Arc_Test_External_Status_03 == 0) || (T2_Arc_Test_External_Status_04 == 0) || (T3_Arc_Test_External_Status_01 == 0) || (T3_Arc_Test_External_Status_02 == 0) || (T3_Arc_Test_External_Status_03 == 0) || (T3_Arc_Test_External_Status_04 == 0) || (T4_Arc_Test_External_Status_01 == 0) || (T4_Arc_Test_External_Status_02 == 0) || (T4_Arc_Test_External_Status_03 == 0) || (T4_Arc_Test_External_Status_04 == 0) || (T5_Arc_Test_External_Status_01 == 0) || (T5_Arc_Test_External_Status_02 == 0) || (T5_Arc_Test_External_Status_03 == 0) || (T5_Arc_Test_External_Status_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more External Status are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Test procedure in manual mode */
	when ( (AutoControl_ActualStatus == 0) && (Manual_Test_Done == 1) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Manual Test Procedure Completed \n");

	} state ready_for_operation

	/* Test procedure in automatic mode */
	when ( AutoControl_ActualStatus == 1 ) {
		printf("[SEQ ARC DETECTION - TANK 1] Starting Automatic Test Procedure \n");
		T1_Arc_Test_External_Cmd_01=1;
		pvPut(T1_Arc_Test_External_Cmd_01);
		T1_Arc_Test_External_Cmd_02=1;
		pvPut(T1_Arc_Test_External_Cmd_02);
		T1_Arc_Test_External_Cmd_03=1;
		pvPut(T1_Arc_Test_External_Cmd_03);
		T1_Arc_Test_External_Cmd_04=1;
		pvPut(T1_Arc_Test_External_Cmd_04);
		T2_Arc_Test_External_Cmd_01=1;
		pvPut(T2_Arc_Test_External_Cmd_01);
		T2_Arc_Test_External_Cmd_02=1;
		pvPut(T2_Arc_Test_External_Cmd_02);
		T2_Arc_Test_External_Cmd_03=1;
		pvPut(T2_Arc_Test_External_Cmd_03);
		T2_Arc_Test_External_Cmd_04=1;
		pvPut(T2_Arc_Test_External_Cmd_04);
		T3_Arc_Test_External_Cmd_01=1;
		pvPut(T3_Arc_Test_External_Cmd_01);
		T3_Arc_Test_External_Cmd_02=1;
		pvPut(T3_Arc_Test_External_Cmd_02);
		T3_Arc_Test_External_Cmd_03=1;
		pvPut(T3_Arc_Test_External_Cmd_03);
		T3_Arc_Test_External_Cmd_04=1;
		pvPut(T3_Arc_Test_External_Cmd_04);
		T4_Arc_Test_External_Cmd_01=1;
		pvPut(T4_Arc_Test_External_Cmd_01);
		T4_Arc_Test_External_Cmd_02=1;
		pvPut(T4_Arc_Test_External_Cmd_02);
		T4_Arc_Test_External_Cmd_03=1;
		pvPut(T4_Arc_Test_External_Cmd_03);
		T4_Arc_Test_External_Cmd_04=1;
		pvPut(T4_Arc_Test_External_Cmd_04);
		T5_Arc_Test_External_Cmd_01=1;
		pvPut(T5_Arc_Test_External_Cmd_01);
		T5_Arc_Test_External_Cmd_02=1;
		pvPut(T5_Arc_Test_External_Cmd_02);
		T5_Arc_Test_External_Cmd_03=1;
		pvPut(T5_Arc_Test_External_Cmd_03);
		T5_Arc_Test_External_Cmd_04=1;
		pvPut(T5_Arc_Test_External_Cmd_04);
		/* Reset test button */
		T1_Arc_Test_External_Cmd_01=0;
		pvPut(T1_Arc_Test_External_Cmd_01);
		T1_Arc_Test_External_Cmd_02=0;
		pvPut(T1_Arc_Test_External_Cmd_02);
		T1_Arc_Test_External_Cmd_03=0;
		pvPut(T1_Arc_Test_External_Cmd_03);
		T1_Arc_Test_External_Cmd_04=0;
		pvPut(T1_Arc_Test_External_Cmd_04);
		T2_Arc_Test_External_Cmd_01=0;
		pvPut(T2_Arc_Test_External_Cmd_01);
		T2_Arc_Test_External_Cmd_02=0;
		pvPut(T2_Arc_Test_External_Cmd_02);
		T2_Arc_Test_External_Cmd_03=0;
		pvPut(T2_Arc_Test_External_Cmd_03);
		T2_Arc_Test_External_Cmd_04=0;
		pvPut(T2_Arc_Test_External_Cmd_04);
		T3_Arc_Test_External_Cmd_01=0;
		pvPut(T3_Arc_Test_External_Cmd_01);
		T3_Arc_Test_External_Cmd_02=0;
		pvPut(T3_Arc_Test_External_Cmd_02);
		T3_Arc_Test_External_Cmd_03=0;
		pvPut(T3_Arc_Test_External_Cmd_03);
		T3_Arc_Test_External_Cmd_04=0;
		pvPut(T3_Arc_Test_External_Cmd_04);
		T4_Arc_Test_External_Cmd_01=0;
		pvPut(T4_Arc_Test_External_Cmd_01);
		T4_Arc_Test_External_Cmd_02=0;
		pvPut(T4_Arc_Test_External_Cmd_02);
		T4_Arc_Test_External_Cmd_03=0;
		pvPut(T4_Arc_Test_External_Cmd_03);
		T4_Arc_Test_External_Cmd_04=0;
		pvPut(T4_Arc_Test_External_Cmd_04);
		T5_Arc_Test_External_Cmd_01=0;
		pvPut(T5_Arc_Test_External_Cmd_01);
		T5_Arc_Test_External_Cmd_02=0;
		pvPut(T5_Arc_Test_External_Cmd_02);
		T5_Arc_Test_External_Cmd_03=0;
		pvPut(T5_Arc_Test_External_Cmd_03);
		T5_Arc_Test_External_Cmd_04=0;
		pvPut(T5_Arc_Test_External_Cmd_04);

	} state test_results

}

/* internal state TEST RESULTS */
state test_results {
	entry {
		printf("\n[SEQ ARC DETECTION - TANK 1] Enter in TEST RESULTS status (internal status)\n");

	}

	when ( (T1_Arc_Test_Internal_Status_01 == 0) || (T1_Arc_Test_Internal_Status_02 == 0) || (T1_Arc_Test_Internal_Status_03 == 0) || (T1_Arc_Test_Internal_Status_04 == 0) || (T2_Arc_Test_Internal_Status_01 == 0) || (T2_Arc_Test_Internal_Status_02 == 0) || (T2_Arc_Test_Internal_Status_03 == 0) || (T2_Arc_Test_Internal_Status_04 == 0) || (T3_Arc_Test_Internal_Status_01 == 0) || (T3_Arc_Test_Internal_Status_02 == 0) || (T3_Arc_Test_Internal_Status_03 == 0) || (T3_Arc_Test_Internal_Status_04 == 0) || (T4_Arc_Test_Internal_Status_01 == 0) || (T4_Arc_Test_Internal_Status_02 == 0) || (T4_Arc_Test_Internal_Status_03 == 0) || (T4_Arc_Test_Internal_Status_04 == 0) || (T5_Arc_Test_Internal_Status_01 == 0) || (T5_Arc_Test_Internal_Status_02 == 0) || (T5_Arc_Test_Internal_Status_03 == 0) || (T5_Arc_Test_Internal_Status_04 == 0) || (T1_Arc_Test_External_Status_01 == 0) || (T1_Arc_Test_External_Status_02 == 0) || (T1_Arc_Test_External_Status_03 == 0) || (T1_Arc_Test_External_Status_04 == 0) || (T2_Arc_Test_External_Status_01 == 0) || (T2_Arc_Test_External_Status_02 == 0) || (T2_Arc_Test_External_Status_03 == 0) || (T2_Arc_Test_External_Status_04 == 0) || (T3_Arc_Test_External_Status_01 == 0) || (T3_Arc_Test_External_Status_02 == 0) || (T3_Arc_Test_External_Status_03 == 0) || (T3_Arc_Test_External_Status_04 == 0) || (T4_Arc_Test_External_Status_01 == 0) || (T4_Arc_Test_External_Status_02 == 0) || (T4_Arc_Test_External_Status_03 == 0) || (T4_Arc_Test_External_Status_04 == 0) || (T5_Arc_Test_External_Status_01 == 0) || (T5_Arc_Test_External_Status_02 == 0) || (T5_Arc_Test_External_Status_03 == 0) || (T5_Arc_Test_External_Status_04 == 0) ) {
	printf("[SEQ ARC DETECTION - TANK 1] Error System Status: one or more channel are NOT OK Status \n");
	printf("[SEQ ARC DETECTION - TANK 1] Test Procedure not passed: go to FAILURE \n");

	} state failure

	when ( (T1_Arc_Test_Internal_Status_01 == 1) && (T1_Arc_Test_Internal_Status_02 == 1) && (T1_Arc_Test_Internal_Status_03 == 1) && (T1_Arc_Test_Internal_Status_04 == 1) && (T2_Arc_Test_Internal_Status_01 == 1) && (T2_Arc_Test_Internal_Status_02 == 1) && (T2_Arc_Test_Internal_Status_03 == 1) && (T2_Arc_Test_Internal_Status_04 == 1) && (T3_Arc_Test_Internal_Status_01 == 1) && (T3_Arc_Test_Internal_Status_02 == 1) && (T3_Arc_Test_Internal_Status_03 == 1) && (T3_Arc_Test_Internal_Status_04 == 1) && (T4_Arc_Test_Internal_Status_01 == 1) && (T4_Arc_Test_Internal_Status_02 == 1) && (T4_Arc_Test_Internal_Status_03 == 1) && (T4_Arc_Test_Internal_Status_04 == 1) && (T5_Arc_Test_Internal_Status_01 == 1) && (T5_Arc_Test_Internal_Status_02 == 1) && (T5_Arc_Test_Internal_Status_03 == 1) && (T5_Arc_Test_Internal_Status_04 == 1) && (T1_Arc_Test_External_Status_01 == 1) && (T1_Arc_Test_External_Status_02 == 1) && (T1_Arc_Test_External_Status_03 == 1) && (T1_Arc_Test_External_Status_04 == 1) && (T2_Arc_Test_External_Status_01 == 1) && (T2_Arc_Test_External_Status_02 == 1) && (T2_Arc_Test_External_Status_03 == 1) && (T2_Arc_Test_External_Status_04 == 1) && (T3_Arc_Test_External_Status_01 == 1) && (T3_Arc_Test_External_Status_02 == 1) && (T3_Arc_Test_External_Status_03 == 1) && (T3_Arc_Test_External_Status_04 == 1) && (T4_Arc_Test_External_Status_01 == 1) && (T4_Arc_Test_External_Status_02 == 1) && (T4_Arc_Test_External_Status_03 == 1) && (T4_Arc_Test_External_Status_04 == 1) && (T5_Arc_Test_External_Status_01 == 1) && (T5_Arc_Test_External_Status_02 == 1) && (T5_Arc_Test_External_Status_03 == 1) && (T5_Arc_Test_External_Status_04 == 1) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Test Procedure passed: go to READY FOR OPERATION \n");

	} state ready_for_operation

}


/* state IDLE   	*/  /* not used */


/* state READY_FOR_OPERATION 	*/
state ready_for_operation {

	entry {
		printf("\n[SEQ ARC DETECTION - TANK 1] Enter in READY FOR OPERATION status\n");
		StateMachineCode=40;
		pvPut(StateMachineCode);

		/* Save last DTL Operation Stage */
		dtl_operation_code_prev=dtlOperationalCode;

		/* Set Max Arc Count Limits */
		/* Operation state: RF Conditioning */
		if (dtlOperationalCode == 202) {
			T1_Arc_Global_Counter_Limit=DTL_RF_Conditioning_Max_Arcs_Limit;
			T2_Arc_Global_Counter_Limit=DTL_RF_Conditioning_Max_Arcs_Limit;
			T3_Arc_Global_Counter_Limit=DTL_RF_Conditioning_Max_Arcs_Limit;
			T4_Arc_Global_Counter_Limit=DTL_RF_Conditioning_Max_Arcs_Limit;
			T5_Arc_Global_Counter_Limit=DTL_RF_Conditioning_Max_Arcs_Limit;
		}
		/* Operation state: Beam Operation (worst case) */
		else {
			T1_Arc_Global_Counter_Limit=DTL_RF_Beam_Operation_Max_Arcs_Limit;
			T2_Arc_Global_Counter_Limit=DTL_RF_Beam_Operation_Max_Arcs_Limit;
			T3_Arc_Global_Counter_Limit=DTL_RF_Beam_Operation_Max_Arcs_Limit;
			T4_Arc_Global_Counter_Limit=DTL_RF_Beam_Operation_Max_Arcs_Limit;
			T5_Arc_Global_Counter_Limit=DTL_RF_Beam_Operation_Max_Arcs_Limit;
		}

	}

	/* Error: ADM is OFF with  power_on_counter >= Max_power_on */
	when ( ((T1_Arc_Power_Status == 0) || (T2_Arc_Power_Status == 0) || (T3_Arc_Power_Status == 0) || (T4_Arc_Power_Status == 0) || (T5_Arc_Power_Status == 0)) && (power_on_counter >= Max_power_on)  ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more devices are OFF \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: Global Status is NOK */
	when ( (T1_Arc_Global_Status == 0) || (T2_Arc_Global_Status == 0) || (T3_Arc_Global_Status == 0) || (T4_Arc_Global_Status == 0) || (T5_Arc_Global_Status == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more Global Status are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: Internal Command Check is NOK */
	when ( (T1_Arc_Test_Internal_Cmd_Check_01 == 0) || (T1_Arc_Test_Internal_Cmd_Check_02 == 0) || (T1_Arc_Test_Internal_Cmd_Check_03 == 0) || (T1_Arc_Test_Internal_Cmd_Check_04 == 0) || (T2_Arc_Test_Internal_Cmd_Check_01 == 0) || (T2_Arc_Test_Internal_Cmd_Check_02 == 0) || (T2_Arc_Test_Internal_Cmd_Check_03 == 0) || (T2_Arc_Test_Internal_Cmd_Check_04 == 0) || (T3_Arc_Test_Internal_Cmd_Check_01 == 0) || (T3_Arc_Test_Internal_Cmd_Check_02 == 0) || (T3_Arc_Test_Internal_Cmd_Check_03 == 0) || (T3_Arc_Test_Internal_Cmd_Check_04 == 0) || (T4_Arc_Test_Internal_Cmd_Check_01 == 0) || (T4_Arc_Test_Internal_Cmd_Check_02 == 0) || (T4_Arc_Test_Internal_Cmd_Check_03 == 0) || (T4_Arc_Test_Internal_Cmd_Check_04 == 0) || (T5_Arc_Test_Internal_Cmd_Check_01 == 0) || (T5_Arc_Test_Internal_Cmd_Check_02 == 0) || (T5_Arc_Test_Internal_Cmd_Check_03 == 0) || (T5_Arc_Test_Internal_Cmd_Check_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more Internal Command Checks are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: External Command Check is NOK */
	when ( (T1_Arc_Test_External_Cmd_Check_01 == 0) || (T1_Arc_Test_External_Cmd_Check_02 == 0) || (T1_Arc_Test_External_Cmd_Check_03 == 0) || (T1_Arc_Test_External_Cmd_Check_04 == 0) || (T2_Arc_Test_External_Cmd_Check_01 == 0) || (T2_Arc_Test_External_Cmd_Check_02 == 0) || (T2_Arc_Test_External_Cmd_Check_03 == 0) || (T2_Arc_Test_External_Cmd_Check_04 == 0) || (T3_Arc_Test_External_Cmd_Check_01 == 0) || (T3_Arc_Test_External_Cmd_Check_02 == 0) || (T3_Arc_Test_External_Cmd_Check_03 == 0) || (T3_Arc_Test_External_Cmd_Check_04 == 0) || (T4_Arc_Test_External_Cmd_Check_01 == 0) || (T4_Arc_Test_External_Cmd_Check_02 == 0) || (T4_Arc_Test_External_Cmd_Check_03 == 0) || (T4_Arc_Test_External_Cmd_Check_04 == 0) || (T5_Arc_Test_External_Cmd_Check_01 == 0) || (T5_Arc_Test_External_Cmd_Check_02 == 0) || (T5_Arc_Test_External_Cmd_Check_03 == 0) || (T5_Arc_Test_External_Cmd_Check_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more External Command Checks are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	/* Error: External Status is NOK */
	when ( (T1_Arc_Test_External_Status_01 == 0) || (T1_Arc_Test_External_Status_02 == 0) || (T1_Arc_Test_External_Status_03 == 0) || (T1_Arc_Test_External_Status_04 == 0) || (T2_Arc_Test_External_Status_01 == 0) || (T2_Arc_Test_External_Status_02 == 0) || (T2_Arc_Test_External_Status_03 == 0) || (T2_Arc_Test_External_Status_04 == 0) || (T3_Arc_Test_External_Status_01 == 0) || (T3_Arc_Test_External_Status_02 == 0) || (T3_Arc_Test_External_Status_03 == 0) || (T3_Arc_Test_External_Status_04 == 0) || (T4_Arc_Test_External_Status_01 == 0) || (T4_Arc_Test_External_Status_02 == 0) || (T4_Arc_Test_External_Status_03 == 0) || (T4_Arc_Test_External_Status_04 == 0) || (T5_Arc_Test_External_Status_01 == 0) || (T5_Arc_Test_External_Status_02 == 0) || (T5_Arc_Test_External_Status_03 == 0) || (T5_Arc_Test_External_Status_04 == 0) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Error ADM systems: one or more External Status are NOK \n");
		printf("[SEQ ARC DETECTION - TANK 1] System not passed self check: go to FAILURE \n");

	} state failure

	when (StartOperationCmd = 0) {

		/* Stop operations for arc detection system */
		printf("[SEQ ARC DETECTION - TANK 1] System stopped to operate by  user \n");
		printf("[SEQ ARC DETECTION - TANK 1] System  goes to STARTUP \n");

	} state start_up


	when ( (dtlOperationalCode == 202) && (dtlOperationalCode != dtl_operation_code_prev) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Main System operation changed to RF CONDITIONING. \n");
		printf("[SEQ ARC DETECTION - TANK 1] System reload arc detection parameters  \n");

	} state ready_for_operation

	when ( (dtlOperationalCode == 303) && (dtlOperationalCode != dtl_operation_code_prev) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Main System operation changed to RF STARTUP. \n");
		printf("[SEQ ARC DETECTION - TANK 1] System reload arc detection parameters  \n");

	} state ready_for_operation


	/* NOTES: */
  /* Case of Operation: RF Conditioning */
  /*
  Conditions:
   - Frequency Follower mode is ON (ff mode ON)
	 - Arcs may appear: limits on magnitude and frequency
  */
  /* Case of Operation: RF start-up and Ready for Beam */
  /*
  Conditions:
   - Fixed Frequency
   - Frequency detuning in range [-D_f, +D_f]
	 - No arcs permitted
  */

	/* Conditions managed in Main DTL State Machine */

}


/* state FAILURE	*/
state failure {

	entry {
			printf("\n[SEQ ARC DETECTION - TANK 1] Enter in FAILURE status\n");
			StateMachineCode=50;
			pvPut(StateMachineCode);

			/* Start Operations reset - in case of unexpected fault the command remains enabled */
			StartOperationCmd=0;
			pvPut(StartOperationCmd);
	}

	/* System should provide an healthy status to confirm failure reset */
	when ( (FaultReset == 1) && (T1_Arc_Power_Status == 1) && (T2_Arc_Power_Status == 1) && (T3_Arc_Power_Status == 1) && (T4_Arc_Power_Status == 1) && (T5_Arc_Power_Status == 1) && (T1_Arc_Global_Status == 1) && (T2_Arc_Global_Status == 1) && (T3_Arc_Global_Status == 1) && (T4_Arc_Global_Status == 1) && (T5_Arc_Global_Status == 1) && (T1_Arc_Test_Internal_Cmd_Check_01 == 1) && (T1_Arc_Test_Internal_Cmd_Check_02 == 1) && (T1_Arc_Test_Internal_Cmd_Check_03 == 1) && (T1_Arc_Test_Internal_Cmd_Check_04 == 1) && (T2_Arc_Test_Internal_Cmd_Check_01 == 1) && (T2_Arc_Test_Internal_Cmd_Check_02 == 1) && (T2_Arc_Test_Internal_Cmd_Check_03 == 1) && (T2_Arc_Test_Internal_Cmd_Check_04 == 1) && (T3_Arc_Test_Internal_Cmd_Check_01 == 1) && (T3_Arc_Test_Internal_Cmd_Check_02 == 1) && (T3_Arc_Test_Internal_Cmd_Check_03 == 1) && (T3_Arc_Test_Internal_Cmd_Check_04 == 1) && (T4_Arc_Test_Internal_Cmd_Check_01 == 1) && (T4_Arc_Test_Internal_Cmd_Check_02 == 1) && (T4_Arc_Test_Internal_Cmd_Check_03 == 1) && (T4_Arc_Test_Internal_Cmd_Check_04 == 1) && (T5_Arc_Test_Internal_Cmd_Check_01 == 1) && (T5_Arc_Test_Internal_Cmd_Check_02 == 1) && (T5_Arc_Test_Internal_Cmd_Check_03 == 1) && (T5_Arc_Test_Internal_Cmd_Check_04 == 1) && (T1_Arc_Test_External_Cmd_Check_01 == 1) && (T1_Arc_Test_External_Cmd_Check_02 == 1) && (T1_Arc_Test_External_Cmd_Check_03 == 1) && (T1_Arc_Test_External_Cmd_Check_04 == 1) && (T2_Arc_Test_External_Cmd_Check_01 == 1) && (T2_Arc_Test_External_Cmd_Check_02 == 1) && (T2_Arc_Test_External_Cmd_Check_03 == 1) && (T2_Arc_Test_External_Cmd_Check_04 == 1) && (T3_Arc_Test_External_Cmd_Check_01 == 1) && (T3_Arc_Test_External_Cmd_Check_02 == 1) && (T3_Arc_Test_External_Cmd_Check_03 == 1) && (T3_Arc_Test_External_Cmd_Check_04 == 1) && (T4_Arc_Test_External_Cmd_Check_01 == 1) && (T4_Arc_Test_External_Cmd_Check_02 == 1) && (T4_Arc_Test_External_Cmd_Check_03 == 1) && (T4_Arc_Test_External_Cmd_Check_04 == 1) && (T5_Arc_Test_External_Cmd_Check_01 == 1) && (T5_Arc_Test_External_Cmd_Check_02 == 1) && (T5_Arc_Test_External_Cmd_Check_03 == 1) && (T5_Arc_Test_External_Cmd_Check_04 == 1) && (T1_Arc_Test_Internal_Status_01 == 1) && (T1_Arc_Test_Internal_Status_02 == 1) && (T1_Arc_Test_Internal_Status_03 == 1) && (T1_Arc_Test_Internal_Status_04 == 1) && (T2_Arc_Test_Internal_Status_01 == 1) && (T2_Arc_Test_Internal_Status_02 == 1) && (T2_Arc_Test_Internal_Status_03 == 1) && (T2_Arc_Test_Internal_Status_04 == 1) && (T3_Arc_Test_Internal_Status_01 == 1) && (T3_Arc_Test_Internal_Status_02 == 1) && (T3_Arc_Test_Internal_Status_03 == 1) && (T3_Arc_Test_Internal_Status_04 == 1) && (T4_Arc_Test_Internal_Status_01 == 1) && (T4_Arc_Test_Internal_Status_02 == 1) && (T4_Arc_Test_Internal_Status_03 == 1) && (T4_Arc_Test_Internal_Status_04 == 1) && (T5_Arc_Test_Internal_Status_01 == 1) && (T5_Arc_Test_Internal_Status_02 == 1) && (T5_Arc_Test_Internal_Status_03 == 1) && (T5_Arc_Test_Internal_Status_04 == 1) ) {
		printf("[SEQ ARC DETECTION - TANK 1] Failure Stage reset by Operator. \n");
		printf("[SEQ ARC DETECTION - TANK 1] Reset conditions satisfied.\n");

		/* Reset FaultReset command */
		FaultReset=0;
		pvPut(FaultReset);

	} state maintenance

}

/* state MAINTENANCE	*/
state maintenance {

	entry {
			printf("\n[SEQ ARC DETECTION - TANK 1] Enter in MAINTENANCE status\n");
			StateMachineCode=60;
			pvPut(StateMachineCode);
	}

	/* System should provide an healthy status to confirm maintenance reset */
	when ( (MaintenanceReset == 1) && (T1_Arc_Power_Status == 1) && (T2_Arc_Power_Status == 1) && (T3_Arc_Power_Status == 1) && (T4_Arc_Power_Status == 1) && (T5_Arc_Power_Status == 1) && (T1_Arc_Global_Status == 1) && (T2_Arc_Global_Status == 1) && (T3_Arc_Global_Status == 1) && (T4_Arc_Global_Status == 1) && (T5_Arc_Global_Status == 1) && (T1_Arc_Test_Internal_Cmd_Check_01 == 1) && (T1_Arc_Test_Internal_Cmd_Check_02 == 1) && (T1_Arc_Test_Internal_Cmd_Check_03 == 1) && (T1_Arc_Test_Internal_Cmd_Check_04 == 1) && (T2_Arc_Test_Internal_Cmd_Check_01 == 1) && (T2_Arc_Test_Internal_Cmd_Check_02 == 1) && (T2_Arc_Test_Internal_Cmd_Check_03 == 1) && (T2_Arc_Test_Internal_Cmd_Check_04 == 1) && (T3_Arc_Test_Internal_Cmd_Check_01 == 1) && (T3_Arc_Test_Internal_Cmd_Check_02 == 1) && (T3_Arc_Test_Internal_Cmd_Check_03 == 1) && (T3_Arc_Test_Internal_Cmd_Check_04 == 1) && (T4_Arc_Test_Internal_Cmd_Check_01 == 1) && (T4_Arc_Test_Internal_Cmd_Check_02 == 1) && (T4_Arc_Test_Internal_Cmd_Check_03 == 1) && (T4_Arc_Test_Internal_Cmd_Check_04 == 1) && (T5_Arc_Test_Internal_Cmd_Check_01 == 1) && (T5_Arc_Test_Internal_Cmd_Check_02 == 1) && (T5_Arc_Test_Internal_Cmd_Check_03 == 1) && (T5_Arc_Test_Internal_Cmd_Check_04 == 1) && (T1_Arc_Test_External_Cmd_Check_01 == 1) && (T1_Arc_Test_External_Cmd_Check_02 == 1) && (T1_Arc_Test_External_Cmd_Check_03 == 1) && (T1_Arc_Test_External_Cmd_Check_04 == 1) && (T2_Arc_Test_External_Cmd_Check_01 == 1) && (T2_Arc_Test_External_Cmd_Check_02 == 1) && (T2_Arc_Test_External_Cmd_Check_03 == 1) && (T2_Arc_Test_External_Cmd_Check_04 == 1) && (T3_Arc_Test_External_Cmd_Check_01 == 1) && (T3_Arc_Test_External_Cmd_Check_02 == 1) && (T3_Arc_Test_External_Cmd_Check_03 == 1) && (T3_Arc_Test_External_Cmd_Check_04 == 1) && (T4_Arc_Test_External_Cmd_Check_01 == 1) && (T4_Arc_Test_External_Cmd_Check_02 == 1) && (T4_Arc_Test_External_Cmd_Check_03 == 1) && (T4_Arc_Test_External_Cmd_Check_04 == 1) && (T5_Arc_Test_External_Cmd_Check_01 == 1) && (T5_Arc_Test_External_Cmd_Check_02 == 1) && (T5_Arc_Test_External_Cmd_Check_03 == 1) && (T5_Arc_Test_External_Cmd_Check_04 == 1) && (T1_Arc_Test_Internal_Status_01 == 1) && (T1_Arc_Test_Internal_Status_02 == 1) && (T1_Arc_Test_Internal_Status_03 == 1) && (T1_Arc_Test_Internal_Status_04 == 1) && (T2_Arc_Test_Internal_Status_01 == 1) && (T2_Arc_Test_Internal_Status_02 == 1) && (T2_Arc_Test_Internal_Status_03 == 1) && (T2_Arc_Test_Internal_Status_04 == 1) && (T3_Arc_Test_Internal_Status_01 == 1) && (T3_Arc_Test_Internal_Status_02 == 1) && (T3_Arc_Test_Internal_Status_03 == 1) && (T3_Arc_Test_Internal_Status_04 == 1) && (T4_Arc_Test_Internal_Status_01 == 1) && (T4_Arc_Test_Internal_Status_02 == 1) && (T4_Arc_Test_Internal_Status_03 == 1) && (T4_Arc_Test_Internal_Status_04 == 1) && (T5_Arc_Test_Internal_Status_01 == 1) && (T5_Arc_Test_Internal_Status_02 == 1) && (T5_Arc_Test_Internal_Status_03 == 1) && (T5_Arc_Test_Internal_Status_04 == 1)  ) {
		printf("[SEQ ARC DETECTION - TANK 1] Maintenance Stage reset by Operator. \n");
		printf("[SEQ ARC DETECTION - TANK 1] Reset conditions satisfied.\n");

		/* Reset MaintenanceReset command */
		MaintenanceReset=0;
		pvPut(MaintenanceReset);

	} state initialization

}

/* end statemachine */
}
