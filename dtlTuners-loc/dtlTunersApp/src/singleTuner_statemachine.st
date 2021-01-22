/* DTL Tuners State Machine
# State Machine devoted to control the status and the health of DTL tuners sub-system :
#
# Principal States:
# - Initialization:
# 	* Initialize State Machine when EPICS application starts
# - Self-Check:
#       * Verify HW status (connections, devices\'' health, etc.)
# - Start-Up:
#       * Prepare the sub-system to perform operations - "Zero Current setup"
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

program singleTuner_statemachine

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


/* Ok Status - tuners (cmds) */
int T1_M1_OkStat;
assign T1_M1_OkStat to "{SECTION_NAME}:MC-MCU-00{POSITION}:OkStat";
monitor T1_M1_OkStat;


/* Ok Status - Tanks (cmds)*/
int T1_OkStat;
assign T1_OkStat to "{SECTION_NAME}:MC-MCU:OkStat";
monitor T1_OkStat;


/* Ok Status - 24V */
int T1_24V_OkStat;
assign T1_24V_OkStat to "{SECTION_NAME}:MC-MCU:GS24VPS_OKStat";
monitor T1_24V_OkStat;

/* Ok Status - 48V */
int T1_48V_OkStat;
assign T1_48V_OkStat to "{SECTION_NAME}:MC-MCU:48VPS_OKStat";
monitor T1_48V_OkStat;


/* Switches */
int T1_M1_LimSwitch_IN_OnCmd;
assign T1_M1_LimSwitch_IN_OnCmd to "{SECTION_NAME}:EMR-GS-00{POSITION}:24VPS_OnCmd";
monitor T1_M1_LimSwitch_IN_OnCmd;
int T1_M1_LimSwitch_IN_OnCmd_RB;
assign T1_M1_LimSwitch_IN_OnCmd_RB to "{SECTION_NAME}:EMR-GS-00{POSITION}:24VPS_OnCmd-RB";
monitor T1_M1_LimSwitch_IN_OnCmd_RB;
int T1_M1_LimSwitch_IN_Status;
assign T1_M1_LimSwitch_IN_Status to "{SECTION_NAME}:EMR-GS-00{POSITION}:24VPS_OnStat";
monitor T1_M1_LimSwitch_IN_Status;
int T1_M1_LimSwitch_IN_TemperatureAlarm;
assign T1_M1_LimSwitch_IN_TemperatureAlarm to "{SECTION_NAME}:EMR-GS-00{POSITION}:Tmp-Alrm";
monitor T1_M1_LimSwitch_IN_TemperatureAlarm;
int T1_M1_LimSwitch_IN_LoadAlarm;
assign T1_M1_LimSwitch_IN_LoadAlarm to "{SECTION_NAME}:EMR-GS-00{POSITION}:Load-Alrm";
monitor T1_M1_LimSwitch_IN_LoadAlarm;
int T1_M1_LimSwitch_IN_OverCurrentAlarm;
assign T1_M1_LimSwitch_IN_OverCurrentAlarm to "{SECTION_NAME}:EMR-GS-00{POSITION}:OvrI-Alrm";
monitor T1_M1_LimSwitch_IN_OverCurrentAlarm;
int T1_M1_LimSwitch_IN_ShortCircAlarm;
assign T1_M1_LimSwitch_IN_ShortCircAlarm to "{SECTION_NAME}:EMR-GS-00{POSITION}:ShrtCirc-Alrm";
monitor T1_M1_LimSwitch_IN_ShortCircAlarm;
int T1_M1_LimSwitch_OUT_OnCmd;
assign T1_M1_LimSwitch_OUT_OnCmd to "{SECTION_NAME}:EMR-GS-01{POSITION}:24VPS_OnCmd";
monitor T1_M1_LimSwitch_OUT_OnCmd;
int T1_M1_LimSwitch_OUT_OnCmd_RB;
assign T1_M1_LimSwitch_OUT_OnCmd_RB to "{SECTION_NAME}:EMR-GS-01{POSITION}:24VPS_OnCmd-RB";
monitor T1_M1_LimSwitch_OUT_OnCmd_RB;
int T1_M1_LimSwitch_OUT_Status;
assign T1_M1_LimSwitch_OUT_Status to "{SECTION_NAME}:EMR-GS-01{POSITION}:24VPS_OnStat";
monitor T1_M1_LimSwitch_OUT_Status;
int T1_M1_LimSwitch_OUT_TemperatureAlarm;
assign T1_M1_LimSwitch_OUT_TemperatureAlarm to "{SECTION_NAME}:EMR-GS-01{POSITION}:Tmp-Alrm";
monitor T1_M1_LimSwitch_OUT_TemperatureAlarm;
int T1_M1_LimSwitch_OUT_LoadAlarm;
assign T1_M1_LimSwitch_OUT_LoadAlarm to "{SECTION_NAME}:EMR-GS-01{POSITION}:Load-Alrm";
monitor T1_M1_LimSwitch_OUT_LoadAlarm;
int T1_M1_LimSwitch_OUT_OverCurrentAlarm;
assign T1_M1_LimSwitch_OUT_OverCurrentAlarm to "{SECTION_NAME}:EMR-GS-01{POSITION}:OvrI-Alrm";
monitor T1_M1_LimSwitch_OUT_OverCurrentAlarm;
int T1_M1_LimSwitch_OUT_ShortCircAlarm;
assign T1_M1_LimSwitch_OUT_ShortCircAlarm to "{SECTION_NAME}:EMR-GS-01{POSITION}:ShrtCirc-Alrm";
monitor T1_M1_LimSwitch_OUT_ShortCircAlarm;


int T1_M1_LimSwitch_IN_NC_LimStat;
assign T1_M1_LimSwitch_IN_NC_LimStat to "{SECTION_NAME}:EMR-GS-00{POSITION}:NCLimStat";
monitor T1_M1_LimSwitch_IN_NC_LimStat;
int T1_M1_LimSwitch_IN_NO_LimStat;
assign T1_M1_LimSwitch_IN_NO_LimStat to "{SECTION_NAME}:EMR-GS-00{POSITION}:NOLimStat";
monitor T1_M1_LimSwitch_IN_NO_LimStat;
int T1_M1_LimSwitch_OUT_NC_LimStat;
assign T1_M1_LimSwitch_OUT_NC_LimStat to "{SECTION_NAME}:EMR-GS-01{POSITION}:NCLimStat";
monitor T1_M1_LimSwitch_OUT_NC_LimStat;
int T1_M1_LimSwitch_OUT_NO_LimStat;
assign T1_M1_LimSwitch_OUT_NO_LimStat to "{SECTION_NAME}:EMR-GS-01{POSITION}:NOLimStat";
monitor T1_M1_LimSwitch_OUT_NO_LimStat;


/* Linear Encoders - Position*/
double Lin_Enc_Position_Res = 6;  // [millimiters]  -- VALUE FOR TEST

double T1_M1_LinEnc_Position;
assign T1_M1_LinEnc_Position to "{SECTION_NAME}:EMR-GT-00{POSITION}:Pos";
monitor T1_M1_LinEnc_Position;

int T1_M1_LinEnc_HLimAlrm;
assign T1_M1_LinEnc_HLimAlrm to "{SECTION_NAME}:EMR-GT-00{POSITION}:HLim-Alrm";
monitor T1_M1_LinEnc_HLimAlrm;


/* Linear Encoders - Status*/
/*
int T1_M1_LinEnc_Stat;
assign T1_M1_LinEnc_Stat to "{SECTION_NAME}:EMR-GT-00{POSITION}:Stat";
monitor T1_M1_LinEnc_Stat;

*/

/* Linear Encoders - Error Alarm*/
int T1_M1_LinEnc_ErrorAlrm;
assign T1_M1_LinEnc_ErrorAlrm to "{SECTION_NAME}:EMR-GT-00{POSITION}:Err-Alrm";
monitor T1_M1_LinEnc_ErrorAlrm;


/* Linear Encoders - Limit Alarm*/
int T1_M1_LinEnc_LLimAlrm;
assign T1_M1_LinEnc_LLimAlrm to "{SECTION_NAME}:EMR-GT-00{POSITION}:LLim-Alrm";
monitor T1_M1_LinEnc_LLimAlrm;


/* Linear Encoders - Online Status  */
int T1_M1_LinEnc_Online;
assign T1_M1_LinEnc_Online to "{SECTION_NAME}:EMR-GT-00{POSITION}:ConnStat";
monitor T1_M1_LinEnc_Online;


/* Motor - PID control enable command */
int T1_M1_PID_Enable;
assign T1_M1_PID_Enable to "{SECTION_NAME}:EMR-SM-00{POSITION}:CtrlPID-En";
monitor T1_M1_PID_Enable;



/* Motor - Position */
double T1_M1_Axis_Position;
assign T1_M1_Axis_Position to "{SECTION_NAME}:EMR-SM-00{POSITION}.VAL";
monitor T1_M1_Axis_Position;


/* Motor - Enable */
int T1_M1_Axis_Enable;
assign T1_M1_Axis_Enable to "{SECTION_NAME}:EMR-SM-00{POSITION}.CNEN";
monitor T1_M1_Axis_Enable;

/* Motor - Direction */
int T1_M1_Axis_Direction;
assign T1_M1_Axis_Direction to "{SECTION_NAME}:EMR-SM-00{POSITION}.DIR";
monitor T1_M1_Axis_Direction;


/* Motor - Offset */
int T1_M1_Axis_Offset;
assign T1_M1_Axis_Offset to "{SECTION_NAME}:EMR-SM-00{POSITION}.OFF";
monitor T1_M1_Axis_Offset;


/* Motor - Set Offset */
int T1_M1_Axis_SetOffset;
assign T1_M1_Axis_SetOffset to "{SECTION_NAME}:EMR-SM-00{POSITION}.SET";
monitor T1_M1_Axis_SetOffset;



/* Motor - Miss position */
int Error_Missing_Counter = 0;
int Max_Missing_Counter = 3;

int T1_M1_Axis_Missing;
assign T1_M1_Axis_Missing to "{SECTION_NAME}:EMR-SM-00{POSITION}.MISS";
monitor T1_M1_Axis_Missing;


/* Motor - Stop */
int T1_M1_Axis_Stop;
assign T1_M1_Axis_Stop to "{SECTION_NAME}:EMR-SM-00{POSITION}.STOP";
monitor T1_M1_Axis_Stop;


/* Motor - Reset Error */
int T1_M1_Axis_ErrorReset;
assign T1_M1_Axis_ErrorReset to "{SECTION_NAME}:EMR-SM-00{POSITION}:Err-Rst";
monitor T1_M1_Axis_ErrorReset;


/* Motor - Error */
int T1_M1_Axis_Error;
assign T1_M1_Axis_Error to "{SECTION_NAME}:EMR-SM-00{POSITION}:Err";
monitor T1_M1_Axis_Error;


/* Motor Driver Online */
int T1_M1_Driver_Online;
assign T1_M1_Driver_Online to "{SECTION_NAME}:MC-MCU-00{POSITION}:online";
monitor T1_M1_Driver_Online;


/* Motor Driver Warning */
int T1_M1_Driver_WarningAlrm;
assign T1_M1_Driver_WarningAlrm to "{SECTION_NAME}:MC-MCU-00{POSITION}:Drv-Wrn-Alrm";
monitor T1_M1_Driver_WarningAlrm;


/* Motor Driver Error Alarm */
int T1_M1_Driver_ErrorAlrm;
assign T1_M1_Driver_ErrorAlrm to "{SECTION_NAME}:MC-MCU-00{POSITION}:Drv-Err-Alrm";
monitor T1_M1_Driver_ErrorAlrm;


/* Motor Driver Stall Alarm */
int T1_M1_Driver_StallAlrm;
assign T1_M1_Driver_StallAlrm to "{SECTION_NAME}:MC-MCU-00{POSITION}:Drv-Stl-Alrm";
monitor T1_M1_Driver_StallAlrm;


/* Motor Driver Synchronization Alarm */
int T1_M1_Driver_SyncAlrm;
assign T1_M1_Driver_SyncAlrm to "{SECTION_NAME}:MC-MCU-00{POSITION}:Drv-SyncErr-Alrm";
monitor T1_M1_Driver_SyncAlrm;


/* Manual/Auto Control  */
int AutoControlCmd;
assign AutoControlCmd to "DTL:MC-MCU:AutoCmd";
monitor AutoControlCmd;

int AutoControl_ActualStatus;
assign AutoControl_ActualStatus to "DTL:MC-MCU:AutoCmd-RB";
monitor AutoControl_ActualStatus;

/* Enable Tuners - SDIS trigger */
int Enable_Tuners;
assign Enable_Tuners to "DTL:EMR-SM:EnCmd";
monitor Enable_Tuners;

/* Start and Stop Operations */
int StartOperationCmd;
assign StartOperationCmd to "DTL:MC-MCU:OpRun";
monitor StartOperationCmd;
int StopOperationCmd;
assign StopOperationCmd to "DTL:MC-MCU:OpStop";
monitor StopOperationCmd;

/* Maintenance and fault control*/
int MaintenanceReset;
assign MaintenanceReset to "DTL:MC-MCU:MaintenanceRst";
monitor MaintenanceReset;
int FaultReset;
assign FaultReset to "DTL:MC-MCU:FaultRst";
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
assign StateMachineCode to "DTL:MC-MCU:StateMachine";

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

char buffer[200];

/*
# State Machine Definition
*/

ss singleTuner_statemachine {

/* state INITIALIZATION	*/
	state initialization {
		entry {
			printf("\n\nPreliminary controls executed due to Application Startup - Intialization\n\n");
			StateMachineCode=0;
			pvPut(StateMachineCode);
		}

		when (pvConnectCount()==pvAssignCount()) {
			printf("[SEQ TUNERS] All PVs connected\n");
			printf("[SEQ TUNERS] Starting Self Check Process\n");

      /* Actual man|auto control initialization */
      AutoControl_ActualStatus = AutoControlCmd;
      pvPut(AutoControl_ActualStatus);

			/* System pre-configuration */
			T1_M1_LimSwitch_IN_OnCmd=1;
			pvPut(T1_M1_LimSwitch_IN_OnCmd);

			T1_M1_LimSwitch_OUT_OnCmd=1;
			pvPut(T1_M1_LimSwitch_OUT_OnCmd);
			sleep(5);

			/* Reset Error Motor */
			T1_M1_Axis_ErrorReset=1;
			pvPut(T1_M1_Axis_ErrorReset);

      /* Set Correct Motor Direction */
      T1_M1_Axis_Direction=0;
			pvPut(T1_M1_Axis_Direction);
			sleep(10);

		} state self_check

	}


/* state SELF_CHECK	*/
	state self_check {
		entry {
				printf("\n[SEQ TUNERS] Enter in SELF CHECK status\n");
				StateMachineCode=10;
				pvPut(StateMachineCode);
		}

    /* Error in limit switches: Temperature */
		when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: temperature module problem in one or more lines \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

		} state failure

    /* Error in limit switches: Load */
		when ( (T1_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M1_LimSwitch_OUT_LoadAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: load problem in one or more lines \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

		} state failure

    /* Error in limit switches: Over Current */
		when ( (T1_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: over current problem in one or more lines \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in limit switches: Short Circuit */
		when ( (T1_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: short circuit problem in one or more lines \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in limit switches: NC or NO line closed for each tuner system */
		when ( ( (T1_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) ) {
      printf("[SEQ TUNERS] Error in limit switches: one or more lines not proper connected (NC or NO) \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: module is offline */
		when ( (T1_M1_LinEnc_Online == 0) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more modules are not online \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: error alarm */
		when ( (T1_M1_LinEnc_ErrorAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more modules are in error \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: low limit alarm */
		when ( (T1_M1_LinEnc_LLimAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more lines are below HW low limit \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: high limit alarm */
		when ( (T1_M1_LinEnc_HLimAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more lines are above HW high limit \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motors */
		when ( (T1_M1_Axis_Error == 1)  ) {
      printf("[SEQ TUNERS] Error in tuners axes: one or more motors are in error \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module not online */
		when ( (T1_M1_Driver_Online == 0) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are not online \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module warning alarm */
/* to remove		when ( (T1_M1_Driver_WarningAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in warning status \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure
*/

    /* Error in motor driver: module error alarm */
		when ( (T1_M1_Driver_ErrorAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in error status \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module stall alarm */
		when ( (T1_M1_Driver_StallAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in stall status \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module synchronization alarm */
    when ( (T1_M1_Driver_SyncAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in synchronization error status \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure


    /* no error in any line */
    when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && (T1_M1_LinEnc_ErrorAlrm == 0) && (T1_M1_Axis_Error == 0) && (T1_M1_Driver_ErrorAlrm == 0) && (T1_M1_Driver_StallAlrm == 0) && (T1_M1_Driver_SyncAlrm == 0) ) {

      printf("[SEQ TUNERS] Self Check Passed. \n");

      /* Enable Tuners OK Status */
      T1_M1_OkStat=1;
      pvPut(T1_M1_OkStat);

      /* Enable Tank OK Status */
      T1_OkStat=1;
      pvPut(T1_OkStat);

      printf("[SEQ TUNERS] System set homing position (tuners extracted) \n");
      /* Enable tuners drivers */
			T1_M1_Axis_Enable=1;
			pvPut(T1_M1_Axis_Enable);


    } state start_up

  }


/* state STARTUP	*/
state start_up {
  entry {
    printf("\n[SEQ TUNERS] Enter in START UP status\n");
    StateMachineCode=30;
    pvPut(StateMachineCode);

    /* Set axis offset to zero (0 mm) */
    T1_M1_Axis_Offset=0;
    pvPut(T1_M1_Axis_Offset);

    T1_M1_Axis_SetOffset=1;
    pvPut(T1_M1_Axis_SetOffset);
    sleep(10);
    T1_M1_Axis_SetOffset=0;
    pvPut(T1_M1_Axis_SetOffset);
    
    /* Disable tuners PID control */
    T1_M1_PID_Enable=0;
    pvPut(T1_M1_PID_Enable);

    /* Tuners in home position (0 mm) */
    T1_M1_Axis_Position=0;
    pvPut(T1_M1_Axis_Position);

  }

  /* Error in limit switches: Temperature */
  when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) ) {
    printf("[SEQ TUNERS] Error in limit switches: temperature module problem in one or more lines \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Load */
  when ( (T1_M1_LimSwitch_IN_LoadAlarm == 1 )|| (T1_M1_LimSwitch_OUT_LoadAlarm == 1 ) ) {
    printf("[SEQ TUNERS] Error in limit switches: load problem in one or more lines \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Over Current */
  when ( (T1_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) ) {
    printf("[SEQ TUNERS] Error in limit switches: over current problem in one or more lines \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Short Circuit */
  when ( (T1_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) ) {
    printf("[SEQ TUNERS] Error in limit switches: short circuit problem in one or more lines \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: NC or NO line closed for each tuner system */
  when ( ( (T1_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) ) {
    printf("[SEQ TUNERS] Error in limit switches: one or more lines not proper connected (NC or NO) \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: module is offline */
  when ( (T1_M1_LinEnc_Online == 0) ) {
    printf("[SEQ TUNERS] Error in linear encoders: one or more modules are not online \n");
    printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: error alarm */
  when ( (T1_M1_LinEnc_ErrorAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in linear encoders: one or more modules are in error \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: low limit alarm */
  when ( (T1_M1_LinEnc_LLimAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in linear encoders: one or more lines are below HW low limit \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: high limit alarm */
  when ( (T1_M1_LinEnc_HLimAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in linear encoders: one or more lines are above HW high limit \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motors */
  when ( (T1_M1_Axis_Error == 1) ) {
    printf("[SEQ TUNERS] Error in tuners axes: one or more motors are in error \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module not online */
  when ( (T1_M1_Driver_Online == 0) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are not online \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module warning alarm */
/*  when ( (T1_M1_Driver_WarningAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in warning status \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure
*/

  /* Error in motor driver: module error alarm */
  when ( (T1_M1_Driver_ErrorAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in error status \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module stall alarm */
  when ( (T1_M1_Driver_StallAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in stall status \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module synchronization alarm */
  when ( (T1_M1_Driver_SyncAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in synchronization error status \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor axis: devices have MISS error with number of times > Max number accepted*/
  when ( (T1_M1_Axis_Missing == 1) && (Error_Missing_Counter>Max_Missing_Counter) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in missing error status \n");
    printf("[SEQ TUNERS] System not ok for many times: go to FAILURE \n");

    /* reset missing counter */
    Error_Missing_Counter=0;

  } state failure

  /* Error in motor axis: devices have MISS error with number of times <= Max number accepted*/
  when ( (T1_M1_Axis_Missing == 1) && (Error_Missing_Counter<=Max_Missing_Counter) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in missing error status \n");
    printf("[SEQ TUNERS] System not ok: Try to reset axis and restart procedure \n");
    printf("[SEQ TUNERS] MISS field has value %d\n ", T1_M1_Axis_Missing);
    //printf("%s", buffer);
    /* Reset Error Motors */
    printf("[SEQ TUNERS] - Reset Errors \n");
    T1_M1_Axis_ErrorReset=1;
    pvPut(T1_M1_Axis_ErrorReset);
    /* Wait 4 seconds before next operation */
    sleep(4);

    /* Stop Motors */
    printf("[SEQ TUNERS] - Stop Motors \n");
    T1_M1_Axis_Stop=1;
    pvPut(T1_M1_Axis_Stop);
    /* Wait 4 seconds before next operation */
    sleep(4);
    /* Enable Axis */
    printf("[SEQ TUNERS] - Re-enable Motors \n");
    T1_M1_Axis_Enable=1;
    pvPut(T1_M1_Axis_Enable);

    ++Error_Missing_Counter;
  } state start_up

  when ( (T1_M1_Axis_Offset !=0 ) ) {
    printf("[SEQ TUNERS] Error in motor axis: one or more axis have position offset not to Zero \n");
    printf("[SEQ TUNERS] System not ok: retry to set offset position\n");

  } state start_up


  /* Error in motor position: devices are not in home position */
  when( ( (T1_M1_LinEnc_Position - T1_M1_Axis_Position) > Lin_Enc_Position_Res ) ) {
    printf("[SEQ TUNERS] Error in motor axis: one or more axis are not in home position \n");
    printf("[SEQ TUNERS] System not ok: retry to set home position\n");

  } state start_up


  /* no error in any line */
  when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && (T1_M1_LinEnc_ErrorAlrm == 0) && (T1_M1_Axis_Error == 0) && (T1_M1_Driver_ErrorAlrm == 0) && (T1_M1_Driver_StallAlrm == 0) && (T1_M1_Driver_SyncAlrm == 0) ) {
    printf("[SEQ TUNERS] System enabled and ready for operation. \n");
    printf("[SEQ TUNERS] Go to idle status \n");

  } state idle

}


/* state IDLE   	*/
state idle {

	entry {
    printf("\n[SEQ TUNERS] Enter in IDLE status\n");
    StateMachineCode=20;
    pvPut(StateMachineCode);
    /* Reset Stop Operation Command */
    StopOperationCmd=0;
    pvPut(StopOperationCmd);
  }

  /* Error in limit switches: Temperature */
  when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: temperature module problem in one or more lines \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Load */
  when ( (T1_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M1_LimSwitch_OUT_LoadAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: load problem in one or more lines \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Over Current */
  when ( (T1_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: over current problem in one or more lines \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Short Circuit */
  when ( (T1_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: short circuit problem in one or more lines \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: NC or NO line closed for each tuner system */
  when ( ( (T1_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) ) {
      printf("[SEQ TUNERS] Error in limit switches: one or more lines not proper connected (NC or NO) \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: module is offline */
  when ( (T1_M1_LinEnc_Online == 0) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more modules are not online \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: error alarm */
  when ( (T1_M1_LinEnc_ErrorAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more modules are in error \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motors */
  when ( (T1_M1_Axis_Error == 1) ) {
    printf("[SEQ TUNERS] Error in tuners axes: one or more motors are in error \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module not online */
  when ( (T1_M1_Driver_Online == 0) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are not online \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module warning alarm */
/*  when ( (T1_M1_Driver_WarningAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in warning status \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure
*/

  /* Error in motor driver: module error alarm */
  when ( (T1_M1_Driver_ErrorAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in error status \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module stall alarm */
  when ( (T1_M1_Driver_StallAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in stall status \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module synchronization alarm */
  when ( (T1_M1_Driver_SyncAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in synchronization error status \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Execute chosen configuration [man|auto] */
  when ( (StartOperationCmd == 1) ) {
      if ( (AutoControl_ActualStatus == 0) && (AutoControl_ActualStatus == AutoControlCmd) ) {
        printf("[SEQ TUNERS] Start Control Operations in MANUAL Mode\n");
      }
      else if ( (AutoControl_ActualStatus == 1) && (AutoControl_ActualStatus == AutoControlCmd) ) {
        printf("[SEQ TUNERS] Start Control Operations in AUTOMATIC Mode\n");
      }
      else if ( (AutoControl_ActualStatus == 1) && (AutoControl_ActualStatus != AutoControlCmd) ) {
        printf("[SEQ TUNERS] Updated control configuration\n");
        printf("[SEQ TUNERS] Start Control Operations in MANUAL Mode\n");
        AutoControl_ActualStatus = AutoControlCmd;
        pvPut(AutoControl_ActualStatus);
      }
      else if ( (AutoControl_ActualStatus == 0) && (AutoControl_ActualStatus != AutoControlCmd) ) {
        printf("[SEQ TUNERS] Updated control configuration\n");
        printf("[SEQ TUNERS] Start Control Operations in AUTOMATIC Mode\n");
        AutoControl_ActualStatus = AutoControlCmd;
        pvPut(AutoControl_ActualStatus);
      }
      else {
        printf("[SEQ TUNERS] This message should not appear :)\n");
      }
  } state ready_for_operation

}



/* state READY_FOR_OPERATION 	*/
state ready_for_operation {

	entry {
		printf("\n[SEQ TUNERS] Enter in READY FOR OPERATION status\n");
		StateMachineCode=40;
		pvPut(StateMachineCode);
		}

    /* Error in limit switches: Temperature */
    when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M1_LimSwitch_OUT_TemperatureAlarm == 1 )  ) {
        printf("[SEQ TUNERS] Error in limit switches: temperature module problem in one or more lines \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in limit switches: Load */
    when ( (T1_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M1_LimSwitch_OUT_LoadAlarm == 1 ) ) {
        printf("[SEQ TUNERS] Error in limit switches: load problem in one or more lines \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in limit switches: Over Current */
    when ( (T1_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) ) {
        printf("[SEQ TUNERS] Error in limit switches: over current problem in one or more lines \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in limit switches: Short Circuit */
    when ( (T1_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) ) {
        printf("[SEQ TUNERS] Error in limit switches: short circuit problem in one or more lines \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in limit switches: NC or NO line closed for each tuner system */
    when ( ( (T1_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) ) {
        printf("[SEQ TUNERS] Error in limit switches: one or more lines not proper connected (NC or NO) \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: module is offline */
    when ( (T1_M1_LinEnc_Online == 0) ) {
        printf("[SEQ TUNERS] Error in linear encoders: one or more modules are not online \n");
        printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: error alarm */
    when ( (T1_M1_LinEnc_ErrorAlrm == 1) ) {
        printf("[SEQ TUNERS] Error in linear encoders: one or more modules are in error \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in motors */
    when ( (T1_M1_Axis_Error == 1) ) {
      printf("[SEQ TUNERS] Error in tuners axes: one or more motors are in error \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module not online */
    when ( (T1_M1_Driver_Online == 0) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are not online \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module warning alarm */
/*    when ( (T1_M1_Driver_WarningAlrm == 1) ) {
        printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in warning status \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure
*/

    /* Error in motor driver: module error alarm */
    when ( (T1_M1_Driver_ErrorAlrm == 1) ) {
        printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in error status \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module stall alarm */
    when ( (T1_M1_Driver_StallAlrm == 1) ) {
        printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in stall status \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module synchronization alarm */
    when ( (T1_M1_Driver_SyncAlrm == 1) ) {
        printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in synchronization error status \n");
        printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

    } state failure


  /* Stop Operation (for every mode of operation) */
  when ( StopOperationCmd == 1 ) {
      printf("[SEQ TUNERS] Stop Control Operations. System goes back to Idle Status.\n");
      StartOperationCmd=0;
      pvPut(StartOperationCmd);
  } state idle

  /* Possibility to modify [MAN|AUTO] control during operations without changing state*/
  when ( AutoControl_ActualStatus != AutoControlCmd ) {
      AutoControl_ActualStatus = AutoControlCmd;
      pvPut(AutoControl_ActualStatus);
      if ( AutoControl_ActualStatus == 0 ) {
        printf("[SEQ TUNERS] Control Configuration changed to MANUAL .\n");
      }
      else if ( AutoControl_ActualStatus == 1 ) {
        printf("[SEQ TUNERS] Control Configuration changed to AUTOMATIC.\n");
      }
  } state ready_for_operation

  /* NOTES: */
  /* Case of Operation: RF Conditioning */
  /*
  Conditions:
   - Tuners are OFF
   - (tuners extracted --> home position)
   - Frequency Follower mode is ON (ff mode ON)
  */
  /* Case of Operation: Ready for Beam */
  /*
  Conditions:
   - Tuners are ON
   - Tuners are in closed loop
   - Fixed Frequency
   - Frequency detuning in range [-D_f, +D_f]
  */

  /* Configurations done in DTL Orchestration State Machine  */
}


/* state FAILURE	*/
state failure {

	entry {
			printf("\n[SEQ TUNERS] Enter in FAILURE status\n");
			StateMachineCode=50;
			pvPut(StateMachineCode);

      /* Reset Tuners OK Status */
      T1_M1_OkStat=0;
      pvPut(T1_M1_OkStat);

      /* Reset Tank OK Status */
      T1_OkStat=0;
      pvPut(T1_OkStat);

	}

  /* System should provide an healthy status to confirm failure reset */
  when ( (FaultReset == 1) && (T1_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T1_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && (T1_M1_LinEnc_ErrorAlrm == 0) && (T1_M1_Axis_Error == 0)  && (T1_M1_Driver_ErrorAlrm == 0) && (T1_M1_Driver_StallAlrm == 0) && (T1_M1_Driver_SyncAlrm == 0) ) {
    printf("[SEQ TUNERS] Failure Stage reset by Operator. \n");
    printf("[SEQ TUNERS]  Reset conditions satisfied.\n");

    /* Reset FaultReset command */
    FaultReset=0;
    pvPut(FaultReset);

  } state maintenance

}

/* state MAINTENANCE	*/
state maintenance {

	entry {
			printf("\n[SEQ TUNERS] Enter in MAINTENANCE status\n");
			StateMachineCode=60;
			pvPut(StateMachineCode);
	}

  /* System should provide an healthy status to confirm maintenance reset */
  when ( (MaintenanceReset == 1) && (T1_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T1_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && (T1_M1_LinEnc_ErrorAlrm == 0) && (T1_M1_Axis_Error == 0) && (T1_M1_Driver_WarningAlrm == 0) && (T1_M1_Driver_ErrorAlrm == 0) && (T1_M1_Driver_StallAlrm == 0) && (T1_M1_Driver_SyncAlrm == 0) ) {
    printf("[SEQ TUNERS] Maintenance Stage reset by Operator. \n");
    printf("[SEQ TUNERS]  Reset conditions satisfied.\n");

    /* reset Error_Missing_Counter */
    Error_Missing_Counter=0;

    /* Reset MaintenanceReset command */
    MaintenanceReset=0;
    pvPut(MaintenanceReset);

  } state initialization

}

/* end statemachine */
}
