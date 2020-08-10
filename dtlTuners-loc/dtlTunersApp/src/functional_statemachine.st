/* DTL Tuners State Machine 
# State Machine devoted to control the status and the health of DTL tuners sub-system :
#
# Principal States:
# - Initialization:
# 	* Initalize State Machine when EPICS application starts
# - Self-Check:
#       * Verify HW status (connetions, devices\'' health, etc.)
# - Start-Up:
#       * Prepare the sub-system to perform operations - "Zero Current setup"
# - Idle:
#       * Machine is in attendance of external ok
# - Ready-for-operation:
#       * Machine preared for operation
# - Failure:
#       * Machine goes in safe mode because of HW/SW problems
# - Maintenance:
#       * Status where the machine is under maintenance. Useful to indicate possible operation and works on the apparatus
#
#
# developed by Maurizio Montis | INFN-LNL
# mail: maurizio.montis@lnl.infn.it
*/ 

program tuners_statemachine

/*
# Libraries
*/

%%#include <stdio.h>
%%#include <string.h>
%%#include <unistd.h>

/*
# Variables and Constants
*/


/* Driver */ 
/* Switches */ 
int HIGH_LIM_SW_CMD;
assign HIGH_LIM_SW_CMD to "{SECTION_NAME}:EMR-GS-001:24VPS_OnCmd";
monitor HIGH_LIM_SW_CMD;
int LOW_LIM_SW_CMD;
assign LOW_LIM_SW_CMD to "{SECTION_NAME}:EMR-GS-011:24VPS_OnCmd";
monitor LOW_LIM_SW_CMD;

int HIGH_LIM_SW_RB;
assign HIGH_LIM_SW_RB to "{SECTION_NAME}:EMR-GS-001:24VPS_OnCmd-RB";
monitor HIGH_LIM_SW_RB;
int LOW_LIM_SW_RB;
assign LOW_LIM_SW_RB to "{SECTION_NAME}:EMR-GS-011:24VPS_OnCmd-RB";
monitor LOW_LIM_SW_RB;

int HIGH_LIM_SW_TMP_ALRM;
assign HIGH_LIM_SW_TMP_ALRM to "{SECTION_NAME}:EMR-GS-001:Tmp-Alrm";
monitor HIGH_LIM_SW_TMP_ALRM;

int HIGH_LIM_SW_LOAD_ALRM;
assign HIGH_LIM_SW_LOAD_ALRM to "{SECTION_NAME}:EMR-GS-001:Load-Alrm";
monitor HIGH_LIM_SW_LOAD_ALRM;

int HIGH_LIM_SW_OVRI_ALRM;
assign HIGH_LIM_SW_OVRI_ALRM to "{SECTION_NAME}:EMR-GS-001:OvrI-Alrm";
monitor HIGH_LIM_SW_OVRI_ALRM;

int LOW_LIM_SW_TMP_ALRM;
assign LOW_LIM_SW_TMP_ALRM to "{SECTION_NAME}:EMR-GS-011:Tmp-Alrm";
monitor LOW_LIM_SW_TMP_ALRM;

int LOW_LIM_SW_LOAD_ALRM;
assign LOW_LIM_SW_LOAD_ALRM to "{SECTION_NAME}:EMR-GS-011:Load-Alrm";
monitor LOW_LIM_SW_LOAD_ALRM;

int LOW_LIM_SW_OVRI_ALRM;
assign LOW_LIM_SW_OVRI_ALRM to "{SECTION_NAME}:EMR-GS-011:OvrI-Alrm";
monitor LOW_LIM_SW_OVRI_ALRM;

/* Linear Encoder */

/* Axis */ 
int AXIS_T1M1_ERR;
assign AXIS_T1M1_ERR to "{SECTION_NAME}:EMR-SM-001:Err";
monitor AXIS_T1M1_ERR;
int AXIS_T1M1_ERR_RESET;
assign AXIS_T1M1_ERR_RESET to "{SECTION_NAME}:EMR-SM-001:Err-Rst";


/* Debug Mode: */
double DEBUG=1;



/*
# State Machine Definition
*/

ss tuners_statemachine {

/* state INITIALIZATION	*/
	state initialization {
		entry {
			printf("\n\nPreliminary controls executed due to Application Startup - Intialization\n\n");	
		}
	
		when (pvConnectCount()==pvAssignCount()) {
			/* enables DO switches */
			HIGH_LIM_SW_CMD=1;
			LOW_LIM_SW_CMD=1;
			pvPut(HIGH_LIM_SW_CMD);
			pvPut(LOW_LIM_SW_CMD);
			/* reset axis errors */
			AXIS_T1M1_ERR=1;
			pvPut(AXIS_T1M1_ERR);
			sleep(2);
			AXIS_T1M1_ERR=0;
			pvPut(AXIS_T1M1_ERR);
		} state self_check
	}


/* state SELF_CHECK	*/
	state self_check {
		when (delay(60)) {
			printf("\nSELF_CHECK status - ok");
		} state self_check
	}


/* state STARTUP	*/
/* state IDLE   	*/
/* state READY_FOR_OPERATION 	*/
/* state FAILURE	*/
/* state MAINTENANCE	*/






/* end statemachine */
}
