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


/* Ok Status - tuners */
int T1_M1_OkStat;
assign T1_M1_OkStat to "DTL-010:MC-MCU-001:OkStat-RB";
monitor T1_M1_OkStat;
int T1_M2_OkStat;
assign T1_M2_OkStat to "DTL-010:MC-MCU-002:OkStat-RB";
monitor T1_M2_OkStat;
int T1_M3_OkStat;
assign T1_M3_OkStat to "DTL-010:MC-MCU-003:OkStat-RB";
monitor T1_M3_OkStat;
int T2_M1_OkStat;
assign T2_M1_OkStat to "DTL-020:MC-MCU-001:OkStat-RB";
monitor T2_M1_OkStat;
int T2_M2_OkStat;
assign T2_M2_OkStat to "DTL-020:MC-MCU-002:OkStat-RB";
monitor T2_M2_OkStat;
int T2_M3_OkStat;
assign T2_M3_OkStat to "DTL-020:MC-MCU-003:OkStat-RB";
monitor T2_M3_OkStat;
int T3_M1_OkStat;
assign T3_M1_OkStat to "DTL-030:MC-MCU-001:OkStat-RB";
monitor T3_M1_OkStat;
int T3_M2_OkStat;
assign T3_M2_OkStat to "DTL-030:MC-MCU-002:OkStat-RB";
monitor T3_M2_OkStat;
int T3_M3_OkStat;
assign T3_M3_OkStat to "DTL-030:MC-MCU-003:OkStat-RB";
monitor T3_M3_OkStat;
int T4_M1_OkStat;
assign T4_M1_OkStat to "DTL-040:MC-MCU-001:OkStat-RB";
monitor T4_M1_OkStat;
int T4_M2_OkStat;
assign T4_M2_OkStat to "DTL-040:MC-MCU-002:OkStat-RB";
monitor T4_M2_OkStat;
int T4_M3_OkStat;
assign T4_M3_OkStat to "DTL-040:MC-MCU-003:OkStat-RB";
monitor T4_M3_OkStat;
int T5_M1_OkStat;
assign T5_M1_OkStat to "DTL-050:MC-MCU-001:OkStat-RB";
monitor T5_M1_OkStat;
int T5_M2_OkStat;
assign T5_M2_OkStat to "DTL-050:MC-MCU-002:OkStat-RB";
monitor T5_M2_OkStat;
int T5_M3_OkStat;
assign T5_M3_OkStat to "DTL-050:MC-MCU-003:OkStat-RB";
monitor T5_M3_OkStat;

/* Ok Status - Tanks */
int T1_OkStat;
assign T1_OkStat to "DTL-010:MC-MCU:OkStat-RB";
monitor T1_OkStat;
int T2_OkStat;
assign T2_OkStat to "DTL-020:MC-MCU:OkStat-RB";
monitor T2_OkStat;
int T3_OkStat;
assign T3_OkStat to "DTL-030:MC-MCU:OkStat-RB";
monitor T3_OkStat;
int T4_OkStat;
assign T4_OkStat to "DTL-040:MC-MCU:OkStat-RB";
monitor T4_OkStat;
int T5_OkStat;
assign T5_OkStat to "DTL-050:MC-MCU:OkStat-RB";
monitor T5_OkStat;

/* Ok Status - 24V */
int T1_24V_OkStat;
assing T1_24V_OkStat to "DTL-010:MC-MCU:GS24VPS_OKStat";
monitor T1_24V_OkStat;
int T2_24V_OkStat;
assing T2_24V_OkStat to "DTL-020:MC-MCU:GS24VPS_OKStat";
monitor T2_24V_OkStat;
int T3_24V_OkStat;
assing T3_24V_OkStat to "DTL-030:MC-MCU:GS24VPS_OKStat";
monitor T3_24V_OkStat;
int T4_24V_OkStat;
assing T4_24V_OkStat to "DTL-040:MC-MCU:GS24VPS_OKStat";
monitor T4_24V_OkStat;
int T5_24V_OkStat;
assing T5_24V_OkStat to "DTL-050:MC-MCU:GS24VPS_OKStat";
monitor T5_24V_OkStat;

/* Ok Status - 48V */
int T1_48V_OkStat;
assing T1_48V_OkStat to "DTL-010:MC-MCU:48VPS_OKStat";
monitor T1_48V_OkStat;
int T2_48V_OkStat;
assing T2_48V_OkStat to "DTL-020:MC-MCU:48VPS_OKStat";
monitor T2_48V_OkStat;
int T3_48V_OkStat;
assing T3_48V_OkStat to "DTL-030:MC-MCU:48VPS_OKStat";
monitor T3_48V_OkStat;
int T4_48V_OkStat;
assing T4_48V_OkStat to "DTL-040:MC-MCU:48VPS_OKStat";
monitor T4_48V_OkStat;
int T5_48V_OkStat;
assing T5_48V_OkStat to "DTL-050:MC-MCU:48VPS_OKStat";
monitor T5_48V_OkStat;

/* Switches */



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



/*
# State Machine Definition
*/

ss tuners_statemachine {

/* state INITIALIZATION	*/
	state initialization {
		entry {
			printf("\n\nPreliminary controls executed due to Application Startup - Intialization\n\n");
			StateMachineCode=0;
			pvPut(StateMachineCode);
		}

		when (pvConnectCount()==pvAssignCount()) {


		} state self_check
	}


/* state SELF_CHECK	*/
	state self_check {
		entry {
				printf("\n[SEQ STEERER] Enter in SELF CHECK status\n");
				StateMachineCode=10;
				pvPut(StateMachineCode);
		}


	}


/* state STARTUP	*/
state start_up {
  entry {
    printf("\n[SEQ STEERER] Enter in START UP status\n");
    StateMachineCode=30;
    pvPut(StateMachineCode);
  }


}


/* state IDLE   	*/
state idle {

	entry {
    printf("\n[SEQ STEERER] Enter in IDLE status\n");
    StateMachineCode=20;
    pvPut(StateMachineCode);
  }

}



/* state READY_FOR_OPERATION 	*/
state ready_for_operation {

	entry {
		printf("\n[SEQ STEERER] Enter in READY FOR OPERATION status\n");
		StateMachineCode=40;
		pvPut(StateMachineCode);
		}

}


/* state FAILURE	*/
state failure {

	entry {
			printf("\n[SEQ STEERER] Enter in FAILURE status\n");
			StateMachineCode=50;
			pvPut(StateMachineCode);
	}

}



/* state MAINTENANCE	*/
state maintenance {

	entry {
			printf("\n[SEQ STEERER] Enter in MAINTENANCE status\n");
			StateMachineCode=60;
			pvPut(StateMachineCode);
	}

}



/* end statemachine */
}
