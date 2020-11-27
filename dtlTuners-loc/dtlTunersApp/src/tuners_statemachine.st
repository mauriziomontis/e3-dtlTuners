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
%%#include <stdlib.h>
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
int T1_M1_LimSwitch_IN_OnCmd;
assign T1_M1_LimSwitch_IN_OnCmd to "DTL-010:EMR-GS-001:24VPS_OnCmd";
monitor T1_M1_LimSwitch_IN_OnCmd;
int T1_M1_LimSwitch_IN_OnCmd-RB;
assign T1_M1_LimSwitch_IN_OnCmd-RB to "DTL-010:EMR-GS-001:24VPS_OnCmd-RB";
monitor T1_M1_LimSwitch_IN_OnCmd-RB;
int T1_M1_LimSwitch_IN_Status;
assign T1_M1_LimSwitch_IN_Status to "DTL-010:EMR-GS-001:24VPS_OnStat";
monitor T1_M1_LimSwitch_IN_Status;
int T1_M1_LimSwitch_IN_TemperatureAlarm;
assign T1_M1_LimSwitch_IN_TemperatureAlarm to "DTL-010:EMR-GS-001:Tmp-Alrm";
monitor T1_M1_LimSwitch_IN_TemperatureAlarm;
int T1_M1_LimSwitch_IN_LoadAlarm;
assign T1_M1_LimSwitch_IN_LoadAlarm to "DTL-010:EMR-GS-001:Load-Alrm";
monitor T1_M1_LimSwitch_IN_LoadAlarm;
int T1_M1_LimSwitch_IN_OverCurrentAlarm;
assign T1_M1_LimSwitch_IN_OverCurrentAlarm to "DTL-010:EMR-GS-001:OvrI-Alrm";
monitor T1_M1_LimSwitch_IN_OverCurrentAlarm;
int T1_M1_LimSwitch_IN_ShortCircAlarm;
assign T1_M1_LimSwitch_IN_ShortCircAlarm to "DTL-010:EMR-GS-001:ShrtCirc-Alrm";
monitor T1_M1_LimSwitch_IN_ShortCircAlarm;
int T1_M1_LimSwitch_OUT_OnCmd;
assign T1_M1_LimSwitch_OUT_OnCmd to "DTL-010:EMR-GS-011:24VPS_OnCmd";
monitor T1_M1_LimSwitch_OUT_OnCmd;
int T1_M1_LimSwitch_OUT_OnCmd-RB;
assign T1_M1_LimSwitch_OUT_OnCmd-RB to "DTL-010:EMR-GS-011:24VPS_OnCmd-RB";
monitor T1_M1_LimSwitch_OUT_OnCmd-RB;
int T1_M1_LimSwitch_OUT_Status;
assign T1_M1_LimSwitch_OUT_Status to "DTL-010:EMR-GS-011:24VPS_OnStat";
monitor T1_M1_LimSwitch_OUT_Status;
int T1_M1_LimSwitch_OUT_TemperatureAlarm;
assign T1_M1_LimSwitch_OUT_TemperatureAlarm to "DTL-010:EMR-GS-011:Tmp-Alrm";
monitor T1_M1_LimSwitch_OUT_TemperatureAlarm;
int T1_M1_LimSwitch_OUT_LoadAlarm;
assign T1_M1_LimSwitch_OUT_LoadAlarm to "DTL-010:EMR-GS-011:Load-Alrm";
monitor T1_M1_LimSwitch_OUT_LoadAlarm;
int T1_M1_LimSwitch_OUT_OverCurrentAlarm;
assign T1_M1_LimSwitch_OUT_OverCurrentAlarm to "DTL-010:EMR-GS-011:OvrI-Alrm";
monitor T1_M1_LimSwitch_OUT_OverCurrentAlarm;
int T1_M1_LimSwitch_OUT_ShortCircAlarm;
assign T1_M1_LimSwitch_OUT_ShortCircAlarm to "DTL-010:EMR-GS-011:ShrtCirc-Alrm";
monitor T1_M1_LimSwitch_OUT_ShortCircAlarm;
int T1_M2_LimSwitch_IN_OnCmd;
assign T1_M2_LimSwitch_IN_OnCmd to "DTL-010:EMR-GS-002:24VPS_OnCmd";
monitor T1_M2_LimSwitch_IN_OnCmd;
int T1_M2_LimSwitch_IN_OnCmd-RB;
assign T1_M2_LimSwitch_IN_OnCmd-RB to "DTL-010:EMR-GS-002:24VPS_OnCmd-RB";
monitor T1_M2_LimSwitch_IN_OnCmd-RB;
int T1_M2_LimSwitch_IN_Status;
assign T1_M2_LimSwitch_IN_Status to "DTL-010:EMR-GS-002:24VPS_OnStat";
monitor T1_M2_LimSwitch_IN_Status;
int T1_M2_LimSwitch_IN_TemperatureAlarm;
assign T1_M2_LimSwitch_IN_TemperatureAlarm to "DTL-010:EMR-GS-002:Tmp-Alrm";
monitor T1_M2_LimSwitch_IN_TemperatureAlarm;
int T1_M2_LimSwitch_IN_LoadAlarm;
assign T1_M2_LimSwitch_IN_LoadAlarm to "DTL-010:EMR-GS-002:Load-Alrm";
monitor T1_M2_LimSwitch_IN_LoadAlarm;
int T1_M2_LimSwitch_IN_OverCurrentAlarm;
assign T1_M2_LimSwitch_IN_OverCurrentAlarm to "DTL-010:EMR-GS-002:OvrI-Alrm";
monitor T1_M2_LimSwitch_IN_OverCurrentAlarm;
int T1_M2_LimSwitch_IN_ShortCircAlarm;
assign T1_M2_LimSwitch_IN_ShortCircAlarm to "DTL-010:EMR-GS-002:ShrtCirc-Alrm";
monitor T1_M2_LimSwitch_IN_ShortCircAlarm;
int T1_M2_LimSwitch_OUT_OnCmd;
assign T1_M2_LimSwitch_OUT_OnCmd to "DTL-010:EMR-GS-012:24VPS_OnCmd";
monitor T1_M2_LimSwitch_OUT_OnCmd;
int T1_M2_LimSwitch_OUT_OnCmd-RB;
assign T1_M2_LimSwitch_OUT_OnCmd-RB to "DTL-010:EMR-GS-012:24VPS_OnCmd-RB";
monitor T1_M2_LimSwitch_OUT_OnCmd-RB;
int T1_M2_LimSwitch_OUT_Status;
assign T1_M2_LimSwitch_OUT_Status to "DTL-010:EMR-GS-012:24VPS_OnStat";
monitor T1_M2_LimSwitch_OUT_Status;
int T1_M2_LimSwitch_OUT_TemperatureAlarm;
assign T1_M2_LimSwitch_OUT_TemperatureAlarm to "DTL-010:EMR-GS-012:Tmp-Alrm";
monitor T1_M2_LimSwitch_OUT_TemperatureAlarm;
int T1_M2_LimSwitch_OUT_LoadAlarm;
assign T1_M2_LimSwitch_OUT_LoadAlarm to "DTL-010:EMR-GS-012:Load-Alrm";
monitor T1_M2_LimSwitch_OUT_LoadAlarm;
int T1_M2_LimSwitch_OUT_OverCurrentAlarm;
assign T1_M2_LimSwitch_OUT_OverCurrentAlarm to "DTL-010:EMR-GS-012:OvrI-Alrm";
monitor T1_M2_LimSwitch_OUT_OverCurrentAlarm;
int T1_M2_LimSwitch_OUT_ShortCircAlarm;
assign T1_M2_LimSwitch_OUT_ShortCircAlarm to "DTL-010:EMR-GS-012:ShrtCirc-Alrm";
monitor T1_M2_LimSwitch_OUT_ShortCircAlarm;
int T1_M3_LimSwitch_IN_OnCmd;
assign T1_M3_LimSwitch_IN_OnCmd to "DTL-010:EMR-GS-003:24VPS_OnCmd";
monitor T1_M3_LimSwitch_IN_OnCmd;
int T1_M3_LimSwitch_IN_OnCmd-RB;
assign T1_M3_LimSwitch_IN_OnCmd-RB to "DTL-010:EMR-GS-003:24VPS_OnCmd-RB";
monitor T1_M3_LimSwitch_IN_OnCmd-RB;
int T1_M3_LimSwitch_IN_Status;
assign T1_M3_LimSwitch_IN_Status to "DTL-010:EMR-GS-003:24VPS_OnStat";
monitor T1_M3_LimSwitch_IN_Status;
int T1_M3_LimSwitch_IN_TemperatureAlarm;
assign T1_M3_LimSwitch_IN_TemperatureAlarm to "DTL-010:EMR-GS-003:Tmp-Alrm";
monitor T1_M3_LimSwitch_IN_TemperatureAlarm;
int T1_M3_LimSwitch_IN_LoadAlarm;
assign T1_M3_LimSwitch_IN_LoadAlarm to "DTL-010:EMR-GS-003:Load-Alrm";
monitor T1_M3_LimSwitch_IN_LoadAlarm;
int T1_M3_LimSwitch_IN_OverCurrentAlarm;
assign T1_M3_LimSwitch_IN_OverCurrentAlarm to "DTL-010:EMR-GS-003:OvrI-Alrm";
monitor T1_M3_LimSwitch_IN_OverCurrentAlarm;
int T1_M3_LimSwitch_IN_ShortCircAlarm;
assign T1_M3_LimSwitch_IN_ShortCircAlarm to "DTL-010:EMR-GS-003:ShrtCirc-Alrm";
monitor T1_M3_LimSwitch_IN_ShortCircAlarm;
int T1_M3_LimSwitch_OUT_OnCmd;
assign T1_M3_LimSwitch_OUT_OnCmd to "DTL-010:EMR-GS-013:24VPS_OnCmd";
monitor T1_M3_LimSwitch_OUT_OnCmd;
int T1_M3_LimSwitch_OUT_OnCmd-RB;
assign T1_M3_LimSwitch_OUT_OnCmd-RB to "DTL-010:EMR-GS-013:24VPS_OnCmd-RB";
monitor T1_M3_LimSwitch_OUT_OnCmd-RB;
int T1_M3_LimSwitch_OUT_Status;
assign T1_M3_LimSwitch_OUT_Status to "DTL-010:EMR-GS-013:24VPS_OnStat";
monitor T1_M3_LimSwitch_OUT_Status;
int T1_M3_LimSwitch_OUT_TemperatureAlarm;
assign T1_M3_LimSwitch_OUT_TemperatureAlarm to "DTL-010:EMR-GS-013:Tmp-Alrm";
monitor T1_M3_LimSwitch_OUT_TemperatureAlarm;
int T1_M3_LimSwitch_OUT_LoadAlarm;
assign T1_M3_LimSwitch_OUT_LoadAlarm to "DTL-010:EMR-GS-013:Load-Alrm";
monitor T1_M3_LimSwitch_OUT_LoadAlarm;
int T1_M3_LimSwitch_OUT_OverCurrentAlarm;
assign T1_M3_LimSwitch_OUT_OverCurrentAlarm to "DTL-010:EMR-GS-013:OvrI-Alrm";
monitor T1_M3_LimSwitch_OUT_OverCurrentAlarm;
int T1_M3_LimSwitch_OUT_ShortCircAlarm;
assign T1_M3_LimSwitch_OUT_ShortCircAlarm to "DTL-010:EMR-GS-013:ShrtCirc-Alrm";
monitor T1_M3_LimSwitch_OUT_ShortCircAlarm;
int T2_M1_LimSwitch_IN_OnCmd;
assign T2_M1_LimSwitch_IN_OnCmd to "DTL-020:EMR-GS-001:24VPS_OnCmd";
monitor T2_M1_LimSwitch_IN_OnCmd;
int T2_M1_LimSwitch_IN_OnCmd-RB;
assign T2_M1_LimSwitch_IN_OnCmd-RB to "DTL-020:EMR-GS-001:24VPS_OnCmd-RB";
monitor T2_M1_LimSwitch_IN_OnCmd-RB;
int T2_M1_LimSwitch_IN_Status;
assign T2_M1_LimSwitch_IN_Status to "DTL-020:EMR-GS-001:24VPS_OnStat";
monitor T2_M1_LimSwitch_IN_Status;
int T2_M1_LimSwitch_IN_TemperatureAlarm;
assign T2_M1_LimSwitch_IN_TemperatureAlarm to "DTL-020:EMR-GS-001:Tmp-Alrm";
monitor T2_M1_LimSwitch_IN_TemperatureAlarm;
int T2_M1_LimSwitch_IN_LoadAlarm;
assign T2_M1_LimSwitch_IN_LoadAlarm to "DTL-020:EMR-GS-001:Load-Alrm";
monitor T2_M1_LimSwitch_IN_LoadAlarm;
int T2_M1_LimSwitch_IN_OverCurrentAlarm;
assign T2_M1_LimSwitch_IN_OverCurrentAlarm to "DTL-020:EMR-GS-001:OvrI-Alrm";
monitor T2_M1_LimSwitch_IN_OverCurrentAlarm;
int T2_M1_LimSwitch_IN_ShortCircAlarm;
assign T2_M1_LimSwitch_IN_ShortCircAlarm to "DTL-020:EMR-GS-001:ShrtCirc-Alrm";
monitor T2_M1_LimSwitch_IN_ShortCircAlarm;
int T2_M1_LimSwitch_OUT_OnCmd;
assign T2_M1_LimSwitch_OUT_OnCmd to "DTL-020:EMR-GS-011:24VPS_OnCmd";
monitor T2_M1_LimSwitch_OUT_OnCmd;
int T2_M1_LimSwitch_OUT_OnCmd-RB;
assign T2_M1_LimSwitch_OUT_OnCmd-RB to "DTL-020:EMR-GS-011:24VPS_OnCmd-RB";
monitor T2_M1_LimSwitch_OUT_OnCmd-RB;
int T2_M1_LimSwitch_OUT_Status;
assign T2_M1_LimSwitch_OUT_Status to "DTL-020:EMR-GS-011:24VPS_OnStat";
monitor T2_M1_LimSwitch_OUT_Status;
int T2_M1_LimSwitch_OUT_TemperatureAlarm;
assign T2_M1_LimSwitch_OUT_TemperatureAlarm to "DTL-020:EMR-GS-011:Tmp-Alrm";
monitor T2_M1_LimSwitch_OUT_TemperatureAlarm;
int T2_M1_LimSwitch_OUT_LoadAlarm;
assign T2_M1_LimSwitch_OUT_LoadAlarm to "DTL-020:EMR-GS-011:Load-Alrm";
monitor T2_M1_LimSwitch_OUT_LoadAlarm;
int T2_M1_LimSwitch_OUT_OverCurrentAlarm;
assign T2_M1_LimSwitch_OUT_OverCurrentAlarm to "DTL-020:EMR-GS-011:OvrI-Alrm";
monitor T2_M1_LimSwitch_OUT_OverCurrentAlarm;
int T2_M1_LimSwitch_OUT_ShortCircAlarm;
assign T2_M1_LimSwitch_OUT_ShortCircAlarm to "DTL-020:EMR-GS-011:ShrtCirc-Alrm";
monitor T2_M1_LimSwitch_OUT_ShortCircAlarm;
int T2_M2_LimSwitch_IN_OnCmd;
assign T2_M2_LimSwitch_IN_OnCmd to "DTL-020:EMR-GS-002:24VPS_OnCmd";
monitor T2_M2_LimSwitch_IN_OnCmd;
int T2_M2_LimSwitch_IN_OnCmd-RB;
assign T2_M2_LimSwitch_IN_OnCmd-RB to "DTL-020:EMR-GS-002:24VPS_OnCmd-RB";
monitor T2_M2_LimSwitch_IN_OnCmd-RB;
int T2_M2_LimSwitch_IN_Status;
assign T2_M2_LimSwitch_IN_Status to "DTL-020:EMR-GS-002:24VPS_OnStat";
monitor T2_M2_LimSwitch_IN_Status;
int T2_M2_LimSwitch_IN_TemperatureAlarm;
assign T2_M2_LimSwitch_IN_TemperatureAlarm to "DTL-020:EMR-GS-002:Tmp-Alrm";
monitor T2_M2_LimSwitch_IN_TemperatureAlarm;
int T2_M2_LimSwitch_IN_LoadAlarm;
assign T2_M2_LimSwitch_IN_LoadAlarm to "DTL-020:EMR-GS-002:Load-Alrm";
monitor T2_M2_LimSwitch_IN_LoadAlarm;
int T2_M2_LimSwitch_IN_OverCurrentAlarm;
assign T2_M2_LimSwitch_IN_OverCurrentAlarm to "DTL-020:EMR-GS-002:OvrI-Alrm";
monitor T2_M2_LimSwitch_IN_OverCurrentAlarm;
int T2_M2_LimSwitch_IN_ShortCircAlarm;
assign T2_M2_LimSwitch_IN_ShortCircAlarm to "DTL-020:EMR-GS-002:ShrtCirc-Alrm";
monitor T2_M2_LimSwitch_IN_ShortCircAlarm;
int T2_M2_LimSwitch_OUT_OnCmd;
assign T2_M2_LimSwitch_OUT_OnCmd to "DTL-020:EMR-GS-012:24VPS_OnCmd";
monitor T2_M2_LimSwitch_OUT_OnCmd;
int T2_M2_LimSwitch_OUT_OnCmd-RB;
assign T2_M2_LimSwitch_OUT_OnCmd-RB to "DTL-020:EMR-GS-012:24VPS_OnCmd-RB";
monitor T2_M2_LimSwitch_OUT_OnCmd-RB;
int T2_M2_LimSwitch_OUT_Status;
assign T2_M2_LimSwitch_OUT_Status to "DTL-020:EMR-GS-012:24VPS_OnStat";
monitor T2_M2_LimSwitch_OUT_Status;
int T2_M2_LimSwitch_OUT_TemperatureAlarm;
assign T2_M2_LimSwitch_OUT_TemperatureAlarm to "DTL-020:EMR-GS-012:Tmp-Alrm";
monitor T2_M2_LimSwitch_OUT_TemperatureAlarm;
int T2_M2_LimSwitch_OUT_LoadAlarm;
assign T2_M2_LimSwitch_OUT_LoadAlarm to "DTL-020:EMR-GS-012:Load-Alrm";
monitor T2_M2_LimSwitch_OUT_LoadAlarm;
int T2_M2_LimSwitch_OUT_OverCurrentAlarm;
assign T2_M2_LimSwitch_OUT_OverCurrentAlarm to "DTL-020:EMR-GS-012:OvrI-Alrm";
monitor T2_M2_LimSwitch_OUT_OverCurrentAlarm;
int T2_M2_LimSwitch_OUT_ShortCircAlarm;
assign T2_M2_LimSwitch_OUT_ShortCircAlarm to "DTL-020:EMR-GS-012:ShrtCirc-Alrm";
monitor T2_M2_LimSwitch_OUT_ShortCircAlarm;
int T2_M3_LimSwitch_IN_OnCmd;
assign T2_M3_LimSwitch_IN_OnCmd to "DTL-020:EMR-GS-003:24VPS_OnCmd";
monitor T2_M3_LimSwitch_IN_OnCmd;
int T2_M3_LimSwitch_IN_OnCmd-RB;
assign T2_M3_LimSwitch_IN_OnCmd-RB to "DTL-020:EMR-GS-003:24VPS_OnCmd-RB";
monitor T2_M3_LimSwitch_IN_OnCmd-RB;
int T2_M3_LimSwitch_IN_Status;
assign T2_M3_LimSwitch_IN_Status to "DTL-020:EMR-GS-003:24VPS_OnStat";
monitor T2_M3_LimSwitch_IN_Status;
int T2_M3_LimSwitch_IN_TemperatureAlarm;
assign T2_M3_LimSwitch_IN_TemperatureAlarm to "DTL-020:EMR-GS-003:Tmp-Alrm";
monitor T2_M3_LimSwitch_IN_TemperatureAlarm;
int T2_M3_LimSwitch_IN_LoadAlarm;
assign T2_M3_LimSwitch_IN_LoadAlarm to "DTL-020:EMR-GS-003:Load-Alrm";
monitor T2_M3_LimSwitch_IN_LoadAlarm;
int T2_M3_LimSwitch_IN_OverCurrentAlarm;
assign T2_M3_LimSwitch_IN_OverCurrentAlarm to "DTL-020:EMR-GS-003:OvrI-Alrm";
monitor T2_M3_LimSwitch_IN_OverCurrentAlarm;
int T2_M3_LimSwitch_IN_ShortCircAlarm;
assign T2_M3_LimSwitch_IN_ShortCircAlarm to "DTL-020:EMR-GS-003:ShrtCirc-Alrm";
monitor T2_M3_LimSwitch_IN_ShortCircAlarm;
int T2_M3_LimSwitch_OUT_OnCmd;
assign T2_M3_LimSwitch_OUT_OnCmd to "DTL-020:EMR-GS-013:24VPS_OnCmd";
monitor T2_M3_LimSwitch_OUT_OnCmd;
int T2_M3_LimSwitch_OUT_OnCmd-RB;
assign T2_M3_LimSwitch_OUT_OnCmd-RB to "DTL-020:EMR-GS-013:24VPS_OnCmd-RB";
monitor T2_M3_LimSwitch_OUT_OnCmd-RB;
int T2_M3_LimSwitch_OUT_Status;
assign T2_M3_LimSwitch_OUT_Status to "DTL-020:EMR-GS-013:24VPS_OnStat";
monitor T2_M3_LimSwitch_OUT_Status;
int T2_M3_LimSwitch_OUT_TemperatureAlarm;
assign T2_M3_LimSwitch_OUT_TemperatureAlarm to "DTL-020:EMR-GS-013:Tmp-Alrm";
monitor T2_M3_LimSwitch_OUT_TemperatureAlarm;
int T2_M3_LimSwitch_OUT_LoadAlarm;
assign T2_M3_LimSwitch_OUT_LoadAlarm to "DTL-020:EMR-GS-013:Load-Alrm";
monitor T2_M3_LimSwitch_OUT_LoadAlarm;
int T2_M3_LimSwitch_OUT_OverCurrentAlarm;
assign T2_M3_LimSwitch_OUT_OverCurrentAlarm to "DTL-020:EMR-GS-013:OvrI-Alrm";
monitor T2_M3_LimSwitch_OUT_OverCurrentAlarm;
int T2_M3_LimSwitch_OUT_ShortCircAlarm;
assign T2_M3_LimSwitch_OUT_ShortCircAlarm to "DTL-020:EMR-GS-013:ShrtCirc-Alrm";
monitor T2_M3_LimSwitch_OUT_ShortCircAlarm;
int T3_M1_LimSwitch_IN_OnCmd;
assign T3_M1_LimSwitch_IN_OnCmd to "DTL-030:EMR-GS-001:24VPS_OnCmd";
monitor T3_M1_LimSwitch_IN_OnCmd;
int T3_M1_LimSwitch_IN_OnCmd-RB;
assign T3_M1_LimSwitch_IN_OnCmd-RB to "DTL-030:EMR-GS-001:24VPS_OnCmd-RB";
monitor T3_M1_LimSwitch_IN_OnCmd-RB;
int T3_M1_LimSwitch_IN_Status;
assign T3_M1_LimSwitch_IN_Status to "DTL-030:EMR-GS-001:24VPS_OnStat";
monitor T3_M1_LimSwitch_IN_Status;
int T3_M1_LimSwitch_IN_TemperatureAlarm;
assign T3_M1_LimSwitch_IN_TemperatureAlarm to "DTL-030:EMR-GS-001:Tmp-Alrm";
monitor T3_M1_LimSwitch_IN_TemperatureAlarm;
int T3_M1_LimSwitch_IN_LoadAlarm;
assign T3_M1_LimSwitch_IN_LoadAlarm to "DTL-030:EMR-GS-001:Load-Alrm";
monitor T3_M1_LimSwitch_IN_LoadAlarm;
int T3_M1_LimSwitch_IN_OverCurrentAlarm;
assign T3_M1_LimSwitch_IN_OverCurrentAlarm to "DTL-030:EMR-GS-001:OvrI-Alrm";
monitor T3_M1_LimSwitch_IN_OverCurrentAlarm;
int T3_M1_LimSwitch_IN_ShortCircAlarm;
assign T3_M1_LimSwitch_IN_ShortCircAlarm to "DTL-030:EMR-GS-001:ShrtCirc-Alrm";
monitor T3_M1_LimSwitch_IN_ShortCircAlarm;
int T3_M1_LimSwitch_OUT_OnCmd;
assign T3_M1_LimSwitch_OUT_OnCmd to "DTL-030:EMR-GS-011:24VPS_OnCmd";
monitor T3_M1_LimSwitch_OUT_OnCmd;
int T3_M1_LimSwitch_OUT_OnCmd-RB;
assign T3_M1_LimSwitch_OUT_OnCmd-RB to "DTL-030:EMR-GS-011:24VPS_OnCmd-RB";
monitor T3_M1_LimSwitch_OUT_OnCmd-RB;
int T3_M1_LimSwitch_OUT_Status;
assign T3_M1_LimSwitch_OUT_Status to "DTL-030:EMR-GS-011:24VPS_OnStat";
monitor T3_M1_LimSwitch_OUT_Status;
int T3_M1_LimSwitch_OUT_TemperatureAlarm;
assign T3_M1_LimSwitch_OUT_TemperatureAlarm to "DTL-030:EMR-GS-011:Tmp-Alrm";
monitor T3_M1_LimSwitch_OUT_TemperatureAlarm;
int T3_M1_LimSwitch_OUT_LoadAlarm;
assign T3_M1_LimSwitch_OUT_LoadAlarm to "DTL-030:EMR-GS-011:Load-Alrm";
monitor T3_M1_LimSwitch_OUT_LoadAlarm;
int T3_M1_LimSwitch_OUT_OverCurrentAlarm;
assign T3_M1_LimSwitch_OUT_OverCurrentAlarm to "DTL-030:EMR-GS-011:OvrI-Alrm";
monitor T3_M1_LimSwitch_OUT_OverCurrentAlarm;
int T3_M1_LimSwitch_OUT_ShortCircAlarm;
assign T3_M1_LimSwitch_OUT_ShortCircAlarm to "DTL-030:EMR-GS-011:ShrtCirc-Alrm";
monitor T3_M1_LimSwitch_OUT_ShortCircAlarm;
int T3_M2_LimSwitch_IN_OnCmd;
assign T3_M2_LimSwitch_IN_OnCmd to "DTL-030:EMR-GS-002:24VPS_OnCmd";
monitor T3_M2_LimSwitch_IN_OnCmd;
int T3_M2_LimSwitch_IN_OnCmd-RB;
assign T3_M2_LimSwitch_IN_OnCmd-RB to "DTL-030:EMR-GS-002:24VPS_OnCmd-RB";
monitor T3_M2_LimSwitch_IN_OnCmd-RB;
int T3_M2_LimSwitch_IN_Status;
assign T3_M2_LimSwitch_IN_Status to "DTL-030:EMR-GS-002:24VPS_OnStat";
monitor T3_M2_LimSwitch_IN_Status;
int T3_M2_LimSwitch_IN_TemperatureAlarm;
assign T3_M2_LimSwitch_IN_TemperatureAlarm to "DTL-030:EMR-GS-002:Tmp-Alrm";
monitor T3_M2_LimSwitch_IN_TemperatureAlarm;
int T3_M2_LimSwitch_IN_LoadAlarm;
assign T3_M2_LimSwitch_IN_LoadAlarm to "DTL-030:EMR-GS-002:Load-Alrm";
monitor T3_M2_LimSwitch_IN_LoadAlarm;
int T3_M2_LimSwitch_IN_OverCurrentAlarm;
assign T3_M2_LimSwitch_IN_OverCurrentAlarm to "DTL-030:EMR-GS-002:OvrI-Alrm";
monitor T3_M2_LimSwitch_IN_OverCurrentAlarm;
int T3_M2_LimSwitch_IN_ShortCircAlarm;
assign T3_M2_LimSwitch_IN_ShortCircAlarm to "DTL-030:EMR-GS-002:ShrtCirc-Alrm";
monitor T3_M2_LimSwitch_IN_ShortCircAlarm;
int T3_M2_LimSwitch_OUT_OnCmd;
assign T3_M2_LimSwitch_OUT_OnCmd to "DTL-030:EMR-GS-012:24VPS_OnCmd";
monitor T3_M2_LimSwitch_OUT_OnCmd;
int T3_M2_LimSwitch_OUT_OnCmd-RB;
assign T3_M2_LimSwitch_OUT_OnCmd-RB to "DTL-030:EMR-GS-012:24VPS_OnCmd-RB";
monitor T3_M2_LimSwitch_OUT_OnCmd-RB;
int T3_M2_LimSwitch_OUT_Status;
assign T3_M2_LimSwitch_OUT_Status to "DTL-030:EMR-GS-012:24VPS_OnStat";
monitor T3_M2_LimSwitch_OUT_Status;
int T3_M2_LimSwitch_OUT_TemperatureAlarm;
assign T3_M2_LimSwitch_OUT_TemperatureAlarm to "DTL-030:EMR-GS-012:Tmp-Alrm";
monitor T3_M2_LimSwitch_OUT_TemperatureAlarm;
int T3_M2_LimSwitch_OUT_LoadAlarm;
assign T3_M2_LimSwitch_OUT_LoadAlarm to "DTL-030:EMR-GS-012:Load-Alrm";
monitor T3_M2_LimSwitch_OUT_LoadAlarm;
int T3_M2_LimSwitch_OUT_OverCurrentAlarm;
assign T3_M2_LimSwitch_OUT_OverCurrentAlarm to "DTL-030:EMR-GS-012:OvrI-Alrm";
monitor T3_M2_LimSwitch_OUT_OverCurrentAlarm;
int T3_M2_LimSwitch_OUT_ShortCircAlarm;
assign T3_M2_LimSwitch_OUT_ShortCircAlarm to "DTL-030:EMR-GS-012:ShrtCirc-Alrm";
monitor T3_M2_LimSwitch_OUT_ShortCircAlarm;
int T3_M3_LimSwitch_IN_OnCmd;
assign T3_M3_LimSwitch_IN_OnCmd to "DTL-030:EMR-GS-003:24VPS_OnCmd";
monitor T3_M3_LimSwitch_IN_OnCmd;
int T3_M3_LimSwitch_IN_OnCmd-RB;
assign T3_M3_LimSwitch_IN_OnCmd-RB to "DTL-030:EMR-GS-003:24VPS_OnCmd-RB";
monitor T3_M3_LimSwitch_IN_OnCmd-RB;
int T3_M3_LimSwitch_IN_Status;
assign T3_M3_LimSwitch_IN_Status to "DTL-030:EMR-GS-003:24VPS_OnStat";
monitor T3_M3_LimSwitch_IN_Status;
int T3_M3_LimSwitch_IN_TemperatureAlarm;
assign T3_M3_LimSwitch_IN_TemperatureAlarm to "DTL-030:EMR-GS-003:Tmp-Alrm";
monitor T3_M3_LimSwitch_IN_TemperatureAlarm;
int T3_M3_LimSwitch_IN_LoadAlarm;
assign T3_M3_LimSwitch_IN_LoadAlarm to "DTL-030:EMR-GS-003:Load-Alrm";
monitor T3_M3_LimSwitch_IN_LoadAlarm;
int T3_M3_LimSwitch_IN_OverCurrentAlarm;
assign T3_M3_LimSwitch_IN_OverCurrentAlarm to "DTL-030:EMR-GS-003:OvrI-Alrm";
monitor T3_M3_LimSwitch_IN_OverCurrentAlarm;
int T3_M3_LimSwitch_IN_ShortCircAlarm;
assign T3_M3_LimSwitch_IN_ShortCircAlarm to "DTL-030:EMR-GS-003:ShrtCirc-Alrm";
monitor T3_M3_LimSwitch_IN_ShortCircAlarm;
int T3_M3_LimSwitch_OUT_OnCmd;
assign T3_M3_LimSwitch_OUT_OnCmd to "DTL-030:EMR-GS-013:24VPS_OnCmd";
monitor T3_M3_LimSwitch_OUT_OnCmd;
int T3_M3_LimSwitch_OUT_OnCmd-RB;
assign T3_M3_LimSwitch_OUT_OnCmd-RB to "DTL-030:EMR-GS-013:24VPS_OnCmd-RB";
monitor T3_M3_LimSwitch_OUT_OnCmd-RB;
int T3_M3_LimSwitch_OUT_Status;
assign T3_M3_LimSwitch_OUT_Status to "DTL-030:EMR-GS-013:24VPS_OnStat";
monitor T3_M3_LimSwitch_OUT_Status;
int T3_M3_LimSwitch_OUT_TemperatureAlarm;
assign T3_M3_LimSwitch_OUT_TemperatureAlarm to "DTL-030:EMR-GS-013:Tmp-Alrm";
monitor T3_M3_LimSwitch_OUT_TemperatureAlarm;
int T3_M3_LimSwitch_OUT_LoadAlarm;
assign T3_M3_LimSwitch_OUT_LoadAlarm to "DTL-030:EMR-GS-013:Load-Alrm";
monitor T3_M3_LimSwitch_OUT_LoadAlarm;
int T3_M3_LimSwitch_OUT_OverCurrentAlarm;
assign T3_M3_LimSwitch_OUT_OverCurrentAlarm to "DTL-030:EMR-GS-013:OvrI-Alrm";
monitor T3_M3_LimSwitch_OUT_OverCurrentAlarm;
int T3_M3_LimSwitch_OUT_ShortCircAlarm;
assign T3_M3_LimSwitch_OUT_ShortCircAlarm to "DTL-030:EMR-GS-013:ShrtCirc-Alrm";
monitor T3_M3_LimSwitch_OUT_ShortCircAlarm;
int T4_M1_LimSwitch_IN_OnCmd;
assign T4_M1_LimSwitch_IN_OnCmd to "DTL-040:EMR-GS-001:24VPS_OnCmd";
monitor T4_M1_LimSwitch_IN_OnCmd;
int T4_M1_LimSwitch_IN_OnCmd-RB;
assign T4_M1_LimSwitch_IN_OnCmd-RB to "DTL-040:EMR-GS-001:24VPS_OnCmd-RB";
monitor T4_M1_LimSwitch_IN_OnCmd-RB;
int T4_M1_LimSwitch_IN_Status;
assign T4_M1_LimSwitch_IN_Status to "DTL-040:EMR-GS-001:24VPS_OnStat";
monitor T4_M1_LimSwitch_IN_Status;
int T4_M1_LimSwitch_IN_TemperatureAlarm;
assign T4_M1_LimSwitch_IN_TemperatureAlarm to "DTL-040:EMR-GS-001:Tmp-Alrm";
monitor T4_M1_LimSwitch_IN_TemperatureAlarm;
int T4_M1_LimSwitch_IN_LoadAlarm;
assign T4_M1_LimSwitch_IN_LoadAlarm to "DTL-040:EMR-GS-001:Load-Alrm";
monitor T4_M1_LimSwitch_IN_LoadAlarm;
int T4_M1_LimSwitch_IN_OverCurrentAlarm;
assign T4_M1_LimSwitch_IN_OverCurrentAlarm to "DTL-040:EMR-GS-001:OvrI-Alrm";
monitor T4_M1_LimSwitch_IN_OverCurrentAlarm;
int T4_M1_LimSwitch_IN_ShortCircAlarm;
assign T4_M1_LimSwitch_IN_ShortCircAlarm to "DTL-040:EMR-GS-001:ShrtCirc-Alrm";
monitor T4_M1_LimSwitch_IN_ShortCircAlarm;
int T4_M1_LimSwitch_OUT_OnCmd;
assign T4_M1_LimSwitch_OUT_OnCmd to "DTL-040:EMR-GS-011:24VPS_OnCmd";
monitor T4_M1_LimSwitch_OUT_OnCmd;
int T4_M1_LimSwitch_OUT_OnCmd-RB;
assign T4_M1_LimSwitch_OUT_OnCmd-RB to "DTL-040:EMR-GS-011:24VPS_OnCmd-RB";
monitor T4_M1_LimSwitch_OUT_OnCmd-RB;
int T4_M1_LimSwitch_OUT_Status;
assign T4_M1_LimSwitch_OUT_Status to "DTL-040:EMR-GS-011:24VPS_OnStat";
monitor T4_M1_LimSwitch_OUT_Status;
int T4_M1_LimSwitch_OUT_TemperatureAlarm;
assign T4_M1_LimSwitch_OUT_TemperatureAlarm to "DTL-040:EMR-GS-011:Tmp-Alrm";
monitor T4_M1_LimSwitch_OUT_TemperatureAlarm;
int T4_M1_LimSwitch_OUT_LoadAlarm;
assign T4_M1_LimSwitch_OUT_LoadAlarm to "DTL-040:EMR-GS-011:Load-Alrm";
monitor T4_M1_LimSwitch_OUT_LoadAlarm;
int T4_M1_LimSwitch_OUT_OverCurrentAlarm;
assign T4_M1_LimSwitch_OUT_OverCurrentAlarm to "DTL-040:EMR-GS-011:OvrI-Alrm";
monitor T4_M1_LimSwitch_OUT_OverCurrentAlarm;
int T4_M1_LimSwitch_OUT_ShortCircAlarm;
assign T4_M1_LimSwitch_OUT_ShortCircAlarm to "DTL-040:EMR-GS-011:ShrtCirc-Alrm";
monitor T4_M1_LimSwitch_OUT_ShortCircAlarm;
int T4_M2_LimSwitch_IN_OnCmd;
assign T4_M2_LimSwitch_IN_OnCmd to "DTL-040:EMR-GS-002:24VPS_OnCmd";
monitor T4_M2_LimSwitch_IN_OnCmd;
int T4_M2_LimSwitch_IN_OnCmd-RB;
assign T4_M2_LimSwitch_IN_OnCmd-RB to "DTL-040:EMR-GS-002:24VPS_OnCmd-RB";
monitor T4_M2_LimSwitch_IN_OnCmd-RB;
int T4_M2_LimSwitch_IN_Status;
assign T4_M2_LimSwitch_IN_Status to "DTL-040:EMR-GS-002:24VPS_OnStat";
monitor T4_M2_LimSwitch_IN_Status;
int T4_M2_LimSwitch_IN_TemperatureAlarm;
assign T4_M2_LimSwitch_IN_TemperatureAlarm to "DTL-040:EMR-GS-002:Tmp-Alrm";
monitor T4_M2_LimSwitch_IN_TemperatureAlarm;
int T4_M2_LimSwitch_IN_LoadAlarm;
assign T4_M2_LimSwitch_IN_LoadAlarm to "DTL-040:EMR-GS-002:Load-Alrm";
monitor T4_M2_LimSwitch_IN_LoadAlarm;
int T4_M2_LimSwitch_IN_OverCurrentAlarm;
assign T4_M2_LimSwitch_IN_OverCurrentAlarm to "DTL-040:EMR-GS-002:OvrI-Alrm";
monitor T4_M2_LimSwitch_IN_OverCurrentAlarm;
int T4_M2_LimSwitch_IN_ShortCircAlarm;
assign T4_M2_LimSwitch_IN_ShortCircAlarm to "DTL-040:EMR-GS-002:ShrtCirc-Alrm";
monitor T4_M2_LimSwitch_IN_ShortCircAlarm;
int T4_M2_LimSwitch_OUT_OnCmd;
assign T4_M2_LimSwitch_OUT_OnCmd to "DTL-040:EMR-GS-012:24VPS_OnCmd";
monitor T4_M2_LimSwitch_OUT_OnCmd;
int T4_M2_LimSwitch_OUT_OnCmd-RB;
assign T4_M2_LimSwitch_OUT_OnCmd-RB to "DTL-040:EMR-GS-012:24VPS_OnCmd-RB";
monitor T4_M2_LimSwitch_OUT_OnCmd-RB;
int T4_M2_LimSwitch_OUT_Status;
assign T4_M2_LimSwitch_OUT_Status to "DTL-040:EMR-GS-012:24VPS_OnStat";
monitor T4_M2_LimSwitch_OUT_Status;
int T4_M2_LimSwitch_OUT_TemperatureAlarm;
assign T4_M2_LimSwitch_OUT_TemperatureAlarm to "DTL-040:EMR-GS-012:Tmp-Alrm";
monitor T4_M2_LimSwitch_OUT_TemperatureAlarm;
int T4_M2_LimSwitch_OUT_LoadAlarm;
assign T4_M2_LimSwitch_OUT_LoadAlarm to "DTL-040:EMR-GS-012:Load-Alrm";
monitor T4_M2_LimSwitch_OUT_LoadAlarm;
int T4_M2_LimSwitch_OUT_OverCurrentAlarm;
assign T4_M2_LimSwitch_OUT_OverCurrentAlarm to "DTL-040:EMR-GS-012:OvrI-Alrm";
monitor T4_M2_LimSwitch_OUT_OverCurrentAlarm;
int T4_M2_LimSwitch_OUT_ShortCircAlarm;
assign T4_M2_LimSwitch_OUT_ShortCircAlarm to "DTL-040:EMR-GS-012:ShrtCirc-Alrm";
monitor T4_M2_LimSwitch_OUT_ShortCircAlarm;
int T4_M3_LimSwitch_IN_OnCmd;
assign T4_M3_LimSwitch_IN_OnCmd to "DTL-040:EMR-GS-003:24VPS_OnCmd";
monitor T4_M3_LimSwitch_IN_OnCmd;
int T4_M3_LimSwitch_IN_OnCmd-RB;
assign T4_M3_LimSwitch_IN_OnCmd-RB to "DTL-040:EMR-GS-003:24VPS_OnCmd-RB";
monitor T4_M3_LimSwitch_IN_OnCmd-RB;
int T4_M3_LimSwitch_IN_Status;
assign T4_M3_LimSwitch_IN_Status to "DTL-040:EMR-GS-003:24VPS_OnStat";
monitor T4_M3_LimSwitch_IN_Status;
int T4_M3_LimSwitch_IN_TemperatureAlarm;
assign T4_M3_LimSwitch_IN_TemperatureAlarm to "DTL-040:EMR-GS-003:Tmp-Alrm";
monitor T4_M3_LimSwitch_IN_TemperatureAlarm;
int T4_M3_LimSwitch_IN_LoadAlarm;
assign T4_M3_LimSwitch_IN_LoadAlarm to "DTL-040:EMR-GS-003:Load-Alrm";
monitor T4_M3_LimSwitch_IN_LoadAlarm;
int T4_M3_LimSwitch_IN_OverCurrentAlarm;
assign T4_M3_LimSwitch_IN_OverCurrentAlarm to "DTL-040:EMR-GS-003:OvrI-Alrm";
monitor T4_M3_LimSwitch_IN_OverCurrentAlarm;
int T4_M3_LimSwitch_IN_ShortCircAlarm;
assign T4_M3_LimSwitch_IN_ShortCircAlarm to "DTL-040:EMR-GS-003:ShrtCirc-Alrm";
monitor T4_M3_LimSwitch_IN_ShortCircAlarm;
int T4_M3_LimSwitch_OUT_OnCmd;
assign T4_M3_LimSwitch_OUT_OnCmd to "DTL-040:EMR-GS-013:24VPS_OnCmd";
monitor T4_M3_LimSwitch_OUT_OnCmd;
int T4_M3_LimSwitch_OUT_OnCmd-RB;
assign T4_M3_LimSwitch_OUT_OnCmd-RB to "DTL-040:EMR-GS-013:24VPS_OnCmd-RB";
monitor T4_M3_LimSwitch_OUT_OnCmd-RB;
int T4_M3_LimSwitch_OUT_Status;
assign T4_M3_LimSwitch_OUT_Status to "DTL-040:EMR-GS-013:24VPS_OnStat";
monitor T4_M3_LimSwitch_OUT_Status;
int T4_M3_LimSwitch_OUT_TemperatureAlarm;
assign T4_M3_LimSwitch_OUT_TemperatureAlarm to "DTL-040:EMR-GS-013:Tmp-Alrm";
monitor T4_M3_LimSwitch_OUT_TemperatureAlarm;
int T4_M3_LimSwitch_OUT_LoadAlarm;
assign T4_M3_LimSwitch_OUT_LoadAlarm to "DTL-040:EMR-GS-013:Load-Alrm";
monitor T4_M3_LimSwitch_OUT_LoadAlarm;
int T4_M3_LimSwitch_OUT_OverCurrentAlarm;
assign T4_M3_LimSwitch_OUT_OverCurrentAlarm to "DTL-040:EMR-GS-013:OvrI-Alrm";
monitor T4_M3_LimSwitch_OUT_OverCurrentAlarm;
int T4_M3_LimSwitch_OUT_ShortCircAlarm;
assign T4_M3_LimSwitch_OUT_ShortCircAlarm to "DTL-040:EMR-GS-013:ShrtCirc-Alrm";
monitor T4_M3_LimSwitch_OUT_ShortCircAlarm;
int T5_M1_LimSwitch_IN_OnCmd;
assign T5_M1_LimSwitch_IN_OnCmd to "DTL-050:EMR-GS-001:24VPS_OnCmd";
monitor T5_M1_LimSwitch_IN_OnCmd;
int T5_M1_LimSwitch_IN_OnCmd-RB;
assign T5_M1_LimSwitch_IN_OnCmd-RB to "DTL-050:EMR-GS-001:24VPS_OnCmd-RB";
monitor T5_M1_LimSwitch_IN_OnCmd-RB;
int T5_M1_LimSwitch_IN_Status;
assign T5_M1_LimSwitch_IN_Status to "DTL-050:EMR-GS-001:24VPS_OnStat";
monitor T5_M1_LimSwitch_IN_Status;
int T5_M1_LimSwitch_IN_TemperatureAlarm;
assign T5_M1_LimSwitch_IN_TemperatureAlarm to "DTL-050:EMR-GS-001:Tmp-Alrm";
monitor T5_M1_LimSwitch_IN_TemperatureAlarm;
int T5_M1_LimSwitch_IN_LoadAlarm;
assign T5_M1_LimSwitch_IN_LoadAlarm to "DTL-050:EMR-GS-001:Load-Alrm";
monitor T5_M1_LimSwitch_IN_LoadAlarm;
int T5_M1_LimSwitch_IN_OverCurrentAlarm;
assign T5_M1_LimSwitch_IN_OverCurrentAlarm to "DTL-050:EMR-GS-001:OvrI-Alrm";
monitor T5_M1_LimSwitch_IN_OverCurrentAlarm;
int T5_M1_LimSwitch_IN_ShortCircAlarm;
assign T5_M1_LimSwitch_IN_ShortCircAlarm to "DTL-050:EMR-GS-001:ShrtCirc-Alrm";
monitor T5_M1_LimSwitch_IN_ShortCircAlarm;
int T5_M1_LimSwitch_OUT_OnCmd;
assign T5_M1_LimSwitch_OUT_OnCmd to "DTL-050:EMR-GS-011:24VPS_OnCmd";
monitor T5_M1_LimSwitch_OUT_OnCmd;
int T5_M1_LimSwitch_OUT_OnCmd-RB;
assign T5_M1_LimSwitch_OUT_OnCmd-RB to "DTL-050:EMR-GS-011:24VPS_OnCmd-RB";
monitor T5_M1_LimSwitch_OUT_OnCmd-RB;
int T5_M1_LimSwitch_OUT_Status;
assign T5_M1_LimSwitch_OUT_Status to "DTL-050:EMR-GS-011:24VPS_OnStat";
monitor T5_M1_LimSwitch_OUT_Status;
int T5_M1_LimSwitch_OUT_TemperatureAlarm;
assign T5_M1_LimSwitch_OUT_TemperatureAlarm to "DTL-050:EMR-GS-011:Tmp-Alrm";
monitor T5_M1_LimSwitch_OUT_TemperatureAlarm;
int T5_M1_LimSwitch_OUT_LoadAlarm;
assign T5_M1_LimSwitch_OUT_LoadAlarm to "DTL-050:EMR-GS-011:Load-Alrm";
monitor T5_M1_LimSwitch_OUT_LoadAlarm;
int T5_M1_LimSwitch_OUT_OverCurrentAlarm;
assign T5_M1_LimSwitch_OUT_OverCurrentAlarm to "DTL-050:EMR-GS-011:OvrI-Alrm";
monitor T5_M1_LimSwitch_OUT_OverCurrentAlarm;
int T5_M1_LimSwitch_OUT_ShortCircAlarm;
assign T5_M1_LimSwitch_OUT_ShortCircAlarm to "DTL-050:EMR-GS-011:ShrtCirc-Alrm";
monitor T5_M1_LimSwitch_OUT_ShortCircAlarm;
int T5_M2_LimSwitch_IN_OnCmd;
assign T5_M2_LimSwitch_IN_OnCmd to "DTL-050:EMR-GS-002:24VPS_OnCmd";
monitor T5_M2_LimSwitch_IN_OnCmd;
int T5_M2_LimSwitch_IN_OnCmd-RB;
assign T5_M2_LimSwitch_IN_OnCmd-RB to "DTL-050:EMR-GS-002:24VPS_OnCmd-RB";
monitor T5_M2_LimSwitch_IN_OnCmd-RB;
int T5_M2_LimSwitch_IN_Status;
assign T5_M2_LimSwitch_IN_Status to "DTL-050:EMR-GS-002:24VPS_OnStat";
monitor T5_M2_LimSwitch_IN_Status;
int T5_M2_LimSwitch_IN_TemperatureAlarm;
assign T5_M2_LimSwitch_IN_TemperatureAlarm to "DTL-050:EMR-GS-002:Tmp-Alrm";
monitor T5_M2_LimSwitch_IN_TemperatureAlarm;
int T5_M2_LimSwitch_IN_LoadAlarm;
assign T5_M2_LimSwitch_IN_LoadAlarm to "DTL-050:EMR-GS-002:Load-Alrm";
monitor T5_M2_LimSwitch_IN_LoadAlarm;
int T5_M2_LimSwitch_IN_OverCurrentAlarm;
assign T5_M2_LimSwitch_IN_OverCurrentAlarm to "DTL-050:EMR-GS-002:OvrI-Alrm";
monitor T5_M2_LimSwitch_IN_OverCurrentAlarm;
int T5_M2_LimSwitch_IN_ShortCircAlarm;
assign T5_M2_LimSwitch_IN_ShortCircAlarm to "DTL-050:EMR-GS-002:ShrtCirc-Alrm";
monitor T5_M2_LimSwitch_IN_ShortCircAlarm;
int T5_M2_LimSwitch_OUT_OnCmd;
assign T5_M2_LimSwitch_OUT_OnCmd to "DTL-050:EMR-GS-012:24VPS_OnCmd";
monitor T5_M2_LimSwitch_OUT_OnCmd;
int T5_M2_LimSwitch_OUT_OnCmd-RB;
assign T5_M2_LimSwitch_OUT_OnCmd-RB to "DTL-050:EMR-GS-012:24VPS_OnCmd-RB";
monitor T5_M2_LimSwitch_OUT_OnCmd-RB;
int T5_M2_LimSwitch_OUT_Status;
assign T5_M2_LimSwitch_OUT_Status to "DTL-050:EMR-GS-012:24VPS_OnStat";
monitor T5_M2_LimSwitch_OUT_Status;
int T5_M2_LimSwitch_OUT_TemperatureAlarm;
assign T5_M2_LimSwitch_OUT_TemperatureAlarm to "DTL-050:EMR-GS-012:Tmp-Alrm";
monitor T5_M2_LimSwitch_OUT_TemperatureAlarm;
int T5_M2_LimSwitch_OUT_LoadAlarm;
assign T5_M2_LimSwitch_OUT_LoadAlarm to "DTL-050:EMR-GS-012:Load-Alrm";
monitor T5_M2_LimSwitch_OUT_LoadAlarm;
int T5_M2_LimSwitch_OUT_OverCurrentAlarm;
assign T5_M2_LimSwitch_OUT_OverCurrentAlarm to "DTL-050:EMR-GS-012:OvrI-Alrm";
monitor T5_M2_LimSwitch_OUT_OverCurrentAlarm;
int T5_M2_LimSwitch_OUT_ShortCircAlarm;
assign T5_M2_LimSwitch_OUT_ShortCircAlarm to "DTL-050:EMR-GS-012:ShrtCirc-Alrm";
monitor T5_M2_LimSwitch_OUT_ShortCircAlarm;
int T5_M3_LimSwitch_IN_OnCmd;
assign T5_M3_LimSwitch_IN_OnCmd to "DTL-050:EMR-GS-003:24VPS_OnCmd";
monitor T5_M3_LimSwitch_IN_OnCmd;
int T5_M3_LimSwitch_IN_OnCmd-RB;
assign T5_M3_LimSwitch_IN_OnCmd-RB to "DTL-050:EMR-GS-003:24VPS_OnCmd-RB";
monitor T5_M3_LimSwitch_IN_OnCmd-RB;
int T5_M3_LimSwitch_IN_Status;
assign T5_M3_LimSwitch_IN_Status to "DTL-050:EMR-GS-003:24VPS_OnStat";
monitor T5_M3_LimSwitch_IN_Status;
int T5_M3_LimSwitch_IN_TemperatureAlarm;
assign T5_M3_LimSwitch_IN_TemperatureAlarm to "DTL-050:EMR-GS-003:Tmp-Alrm";
monitor T5_M3_LimSwitch_IN_TemperatureAlarm;
int T5_M3_LimSwitch_IN_LoadAlarm;
assign T5_M3_LimSwitch_IN_LoadAlarm to "DTL-050:EMR-GS-003:Load-Alrm";
monitor T5_M3_LimSwitch_IN_LoadAlarm;
int T5_M3_LimSwitch_IN_OverCurrentAlarm;
assign T5_M3_LimSwitch_IN_OverCurrentAlarm to "DTL-050:EMR-GS-003:OvrI-Alrm";
monitor T5_M3_LimSwitch_IN_OverCurrentAlarm;
int T5_M3_LimSwitch_IN_ShortCircAlarm;
assign T5_M3_LimSwitch_IN_ShortCircAlarm to "DTL-050:EMR-GS-003:ShrtCirc-Alrm";
monitor T5_M3_LimSwitch_IN_ShortCircAlarm;
int T5_M3_LimSwitch_OUT_OnCmd;
assign T5_M3_LimSwitch_OUT_OnCmd to "DTL-050:EMR-GS-013:24VPS_OnCmd";
monitor T5_M3_LimSwitch_OUT_OnCmd;
int T5_M3_LimSwitch_OUT_OnCmd-RB;
assign T5_M3_LimSwitch_OUT_OnCmd-RB to "DTL-050:EMR-GS-013:24VPS_OnCmd-RB";
monitor T5_M3_LimSwitch_OUT_OnCmd-RB;
int T5_M3_LimSwitch_OUT_Status;
assign T5_M3_LimSwitch_OUT_Status to "DTL-050:EMR-GS-013:24VPS_OnStat";
monitor T5_M3_LimSwitch_OUT_Status;
int T5_M3_LimSwitch_OUT_TemperatureAlarm;
assign T5_M3_LimSwitch_OUT_TemperatureAlarm to "DTL-050:EMR-GS-013:Tmp-Alrm";
monitor T5_M3_LimSwitch_OUT_TemperatureAlarm;
int T5_M3_LimSwitch_OUT_LoadAlarm;
assign T5_M3_LimSwitch_OUT_LoadAlarm to "DTL-050:EMR-GS-013:Load-Alrm";
monitor T5_M3_LimSwitch_OUT_LoadAlarm;
int T5_M3_LimSwitch_OUT_OverCurrentAlarm;
assign T5_M3_LimSwitch_OUT_OverCurrentAlarm to "DTL-050:EMR-GS-013:OvrI-Alrm";
monitor T5_M3_LimSwitch_OUT_OverCurrentAlarm;
int T5_M3_LimSwitch_OUT_ShortCircAlarm;
assign T5_M3_LimSwitch_OUT_ShortCircAlarm to "DTL-050:EMR-GS-013:ShrtCirc-Alrm";
monitor T5_M3_LimSwitch_OUT_ShortCircAlarm;

int T1_M1_LimSwitch_IN_NC_LimStat;
assign T1_M1_LimSwitch_IN_NC_LimStat to "DTL-010:EMR-GS-001:NCLimStat";
monitor T1_M1_LimSwitch_IN_NC_LimStat;
int T1_M1_LimSwitch_IN_NO_LimStat;
assign T1_M1_LimSwitch_IN_NO_LimStat to "DTL-010:EMR-GS-001:NOLimStat";
monitor T1_M1_LimSwitch_IN_NO_LimStat;
int T1_M1_LimSwitch_OUT_NC_LimStat;
assign T1_M1_LimSwitch_OUT_NC_LimStat to "DTL-010:EMR-GS-011:NCLimStat";
monitor T1_M1_LimSwitch_OUT_NC_LimStat;
int T1_M1_LimSwitch_OUT_NO_LimStat;
assign T1_M1_LimSwitch_OUT_NO_LimStat to "DTL-010:EMR-GS-011:NOLimStat";
monitor T1_M1_LimSwitch_OUT_NO_LimStat;
int T1_M2_LimSwitch_IN_NC_LimStat;
assign T1_M2_LimSwitch_IN_NC_LimStat to "DTL-010:EMR-GS-002:NCLimStat";
monitor T1_M2_LimSwitch_IN_NC_LimStat;
int T1_M2_LimSwitch_IN_NO_LimStat;
assign T1_M2_LimSwitch_IN_NO_LimStat to "DTL-010:EMR-GS-002:NOLimStat";
monitor T1_M2_LimSwitch_IN_NO_LimStat;
int T1_M2_LimSwitch_OUT_NC_LimStat;
assign T1_M2_LimSwitch_OUT_NC_LimStat to "DTL-010:EMR-GS-012:NCLimStat";
monitor T1_M2_LimSwitch_OUT_NC_LimStat;
int T1_M2_LimSwitch_OUT_NO_LimStat;
assign T1_M2_LimSwitch_OUT_NO_LimStat to "DTL-010:EMR-GS-012:NOLimStat";
monitor T1_M2_LimSwitch_OUT_NO_LimStat;
int T1_M3_LimSwitch_IN_NC_LimStat;
assign T1_M3_LimSwitch_IN_NC_LimStat to "DTL-010:EMR-GS-003:NCLimStat";
monitor T1_M3_LimSwitch_IN_NC_LimStat;
int T1_M3_LimSwitch_IN_NO_LimStat;
assign T1_M3_LimSwitch_IN_NO_LimStat to "DTL-010:EMR-GS-003:NOLimStat";
monitor T1_M3_LimSwitch_IN_NO_LimStat;
int T1_M3_LimSwitch_OUT_NC_LimStat;
assign T1_M3_LimSwitch_OUT_NC_LimStat to "DTL-010:EMR-GS-013:NCLimStat";
monitor T1_M3_LimSwitch_OUT_NC_LimStat;
int T1_M3_LimSwitch_OUT_NO_LimStat;
assign T1_M3_LimSwitch_OUT_NO_LimStat to "DTL-010:EMR-GS-013:NOLimStat";
monitor T1_M3_LimSwitch_OUT_NO_LimStat;
int T2_M1_LimSwitch_IN_NC_LimStat;
assign T2_M1_LimSwitch_IN_NC_LimStat to "DTL-020:EMR-GS-001:NCLimStat";
monitor T2_M1_LimSwitch_IN_NC_LimStat;
int T2_M1_LimSwitch_IN_NO_LimStat;
assign T2_M1_LimSwitch_IN_NO_LimStat to "DTL-020:EMR-GS-001:NOLimStat";
monitor T2_M1_LimSwitch_IN_NO_LimStat;
int T2_M1_LimSwitch_OUT_NC_LimStat;
assign T2_M1_LimSwitch_OUT_NC_LimStat to "DTL-020:EMR-GS-011:NCLimStat";
monitor T2_M1_LimSwitch_OUT_NC_LimStat;
int T2_M1_LimSwitch_OUT_NO_LimStat;
assign T2_M1_LimSwitch_OUT_NO_LimStat to "DTL-020:EMR-GS-011:NOLimStat";
monitor T2_M1_LimSwitch_OUT_NO_LimStat;
int T2_M2_LimSwitch_IN_NC_LimStat;
assign T2_M2_LimSwitch_IN_NC_LimStat to "DTL-020:EMR-GS-002:NCLimStat";
monitor T2_M2_LimSwitch_IN_NC_LimStat;
int T2_M2_LimSwitch_IN_NO_LimStat;
assign T2_M2_LimSwitch_IN_NO_LimStat to "DTL-020:EMR-GS-002:NOLimStat";
monitor T2_M2_LimSwitch_IN_NO_LimStat;
int T2_M2_LimSwitch_OUT_NC_LimStat;
assign T2_M2_LimSwitch_OUT_NC_LimStat to "DTL-020:EMR-GS-012:NCLimStat";
monitor T2_M2_LimSwitch_OUT_NC_LimStat;
int T2_M2_LimSwitch_OUT_NO_LimStat;
assign T2_M2_LimSwitch_OUT_NO_LimStat to "DTL-020:EMR-GS-012:NOLimStat";
monitor T2_M2_LimSwitch_OUT_NO_LimStat;
int T2_M3_LimSwitch_IN_NC_LimStat;
assign T2_M3_LimSwitch_IN_NC_LimStat to "DTL-020:EMR-GS-003:NCLimStat";
monitor T2_M3_LimSwitch_IN_NC_LimStat;
int T2_M3_LimSwitch_IN_NO_LimStat;
assign T2_M3_LimSwitch_IN_NO_LimStat to "DTL-020:EMR-GS-003:NOLimStat";
monitor T2_M3_LimSwitch_IN_NO_LimStat;
int T2_M3_LimSwitch_OUT_NC_LimStat;
assign T2_M3_LimSwitch_OUT_NC_LimStat to "DTL-020:EMR-GS-013:NCLimStat";
monitor T2_M3_LimSwitch_OUT_NC_LimStat;
int T2_M3_LimSwitch_OUT_NO_LimStat;
assign T2_M3_LimSwitch_OUT_NO_LimStat to "DTL-020:EMR-GS-013:NOLimStat";
monitor T2_M3_LimSwitch_OUT_NO_LimStat;
int T3_M1_LimSwitch_IN_NC_LimStat;
assign T3_M1_LimSwitch_IN_NC_LimStat to "DTL-030:EMR-GS-001:NCLimStat";
monitor T3_M1_LimSwitch_IN_NC_LimStat;
int T3_M1_LimSwitch_IN_NO_LimStat;
assign T3_M1_LimSwitch_IN_NO_LimStat to "DTL-030:EMR-GS-001:NOLimStat";
monitor T3_M1_LimSwitch_IN_NO_LimStat;
int T3_M1_LimSwitch_OUT_NC_LimStat;
assign T3_M1_LimSwitch_OUT_NC_LimStat to "DTL-030:EMR-GS-011:NCLimStat";
monitor T3_M1_LimSwitch_OUT_NC_LimStat;
int T3_M1_LimSwitch_OUT_NO_LimStat;
assign T3_M1_LimSwitch_OUT_NO_LimStat to "DTL-030:EMR-GS-011:NOLimStat";
monitor T3_M1_LimSwitch_OUT_NO_LimStat;
int T3_M2_LimSwitch_IN_NC_LimStat;
assign T3_M2_LimSwitch_IN_NC_LimStat to "DTL-030:EMR-GS-002:NCLimStat";
monitor T3_M2_LimSwitch_IN_NC_LimStat;
int T3_M2_LimSwitch_IN_NO_LimStat;
assign T3_M2_LimSwitch_IN_NO_LimStat to "DTL-030:EMR-GS-002:NOLimStat";
monitor T3_M2_LimSwitch_IN_NO_LimStat;
int T3_M2_LimSwitch_OUT_NC_LimStat;
assign T3_M2_LimSwitch_OUT_NC_LimStat to "DTL-030:EMR-GS-012:NCLimStat";
monitor T3_M2_LimSwitch_OUT_NC_LimStat;
int T3_M2_LimSwitch_OUT_NO_LimStat;
assign T3_M2_LimSwitch_OUT_NO_LimStat to "DTL-030:EMR-GS-012:NOLimStat";
monitor T3_M2_LimSwitch_OUT_NO_LimStat;
int T3_M3_LimSwitch_IN_NC_LimStat;
assign T3_M3_LimSwitch_IN_NC_LimStat to "DTL-030:EMR-GS-003:NCLimStat";
monitor T3_M3_LimSwitch_IN_NC_LimStat;
int T3_M3_LimSwitch_IN_NO_LimStat;
assign T3_M3_LimSwitch_IN_NO_LimStat to "DTL-030:EMR-GS-003:NOLimStat";
monitor T3_M3_LimSwitch_IN_NO_LimStat;
int T3_M3_LimSwitch_OUT_NC_LimStat;
assign T3_M3_LimSwitch_OUT_NC_LimStat to "DTL-030:EMR-GS-013:NCLimStat";
monitor T3_M3_LimSwitch_OUT_NC_LimStat;
int T3_M3_LimSwitch_OUT_NO_LimStat;
assign T3_M3_LimSwitch_OUT_NO_LimStat to "DTL-030:EMR-GS-013:NOLimStat";
monitor T3_M3_LimSwitch_OUT_NO_LimStat;
int T4_M1_LimSwitch_IN_NC_LimStat;
assign T4_M1_LimSwitch_IN_NC_LimStat to "DTL-040:EMR-GS-001:NCLimStat";
monitor T4_M1_LimSwitch_IN_NC_LimStat;
int T4_M1_LimSwitch_IN_NO_LimStat;
assign T4_M1_LimSwitch_IN_NO_LimStat to "DTL-040:EMR-GS-001:NOLimStat";
monitor T4_M1_LimSwitch_IN_NO_LimStat;
int T4_M1_LimSwitch_OUT_NC_LimStat;
assign T4_M1_LimSwitch_OUT_NC_LimStat to "DTL-040:EMR-GS-011:NCLimStat";
monitor T4_M1_LimSwitch_OUT_NC_LimStat;
int T4_M1_LimSwitch_OUT_NO_LimStat;
assign T4_M1_LimSwitch_OUT_NO_LimStat to "DTL-040:EMR-GS-011:NOLimStat";
monitor T4_M1_LimSwitch_OUT_NO_LimStat;
int T4_M2_LimSwitch_IN_NC_LimStat;
assign T4_M2_LimSwitch_IN_NC_LimStat to "DTL-040:EMR-GS-002:NCLimStat";
monitor T4_M2_LimSwitch_IN_NC_LimStat;
int T4_M2_LimSwitch_IN_NO_LimStat;
assign T4_M2_LimSwitch_IN_NO_LimStat to "DTL-040:EMR-GS-002:NOLimStat";
monitor T4_M2_LimSwitch_IN_NO_LimStat;
int T4_M2_LimSwitch_OUT_NC_LimStat;
assign T4_M2_LimSwitch_OUT_NC_LimStat to "DTL-040:EMR-GS-012:NCLimStat";
monitor T4_M2_LimSwitch_OUT_NC_LimStat;
int T4_M2_LimSwitch_OUT_NO_LimStat;
assign T4_M2_LimSwitch_OUT_NO_LimStat to "DTL-040:EMR-GS-012:NOLimStat";
monitor T4_M2_LimSwitch_OUT_NO_LimStat;
int T4_M3_LimSwitch_IN_NC_LimStat;
assign T4_M3_LimSwitch_IN_NC_LimStat to "DTL-040:EMR-GS-003:NCLimStat";
monitor T4_M3_LimSwitch_IN_NC_LimStat;
int T4_M3_LimSwitch_IN_NO_LimStat;
assign T4_M3_LimSwitch_IN_NO_LimStat to "DTL-040:EMR-GS-003:NOLimStat";
monitor T4_M3_LimSwitch_IN_NO_LimStat;
int T4_M3_LimSwitch_OUT_NC_LimStat;
assign T4_M3_LimSwitch_OUT_NC_LimStat to "DTL-040:EMR-GS-013:NCLimStat";
monitor T4_M3_LimSwitch_OUT_NC_LimStat;
int T4_M3_LimSwitch_OUT_NO_LimStat;
assign T4_M3_LimSwitch_OUT_NO_LimStat to "DTL-040:EMR-GS-013:NOLimStat";
monitor T4_M3_LimSwitch_OUT_NO_LimStat;
int T5_M1_LimSwitch_IN_NC_LimStat;
assign T5_M1_LimSwitch_IN_NC_LimStat to "DTL-050:EMR-GS-001:NCLimStat";
monitor T5_M1_LimSwitch_IN_NC_LimStat;
int T5_M1_LimSwitch_IN_NO_LimStat;
assign T5_M1_LimSwitch_IN_NO_LimStat to "DTL-050:EMR-GS-001:NOLimStat";
monitor T5_M1_LimSwitch_IN_NO_LimStat;
int T5_M1_LimSwitch_OUT_NC_LimStat;
assign T5_M1_LimSwitch_OUT_NC_LimStat to "DTL-050:EMR-GS-011:NCLimStat";
monitor T5_M1_LimSwitch_OUT_NC_LimStat;
int T5_M1_LimSwitch_OUT_NO_LimStat;
assign T5_M1_LimSwitch_OUT_NO_LimStat to "DTL-050:EMR-GS-011:NOLimStat";
monitor T5_M1_LimSwitch_OUT_NO_LimStat;
int T5_M2_LimSwitch_IN_NC_LimStat;
assign T5_M2_LimSwitch_IN_NC_LimStat to "DTL-050:EMR-GS-002:NCLimStat";
monitor T5_M2_LimSwitch_IN_NC_LimStat;
int T5_M2_LimSwitch_IN_NO_LimStat;
assign T5_M2_LimSwitch_IN_NO_LimStat to "DTL-050:EMR-GS-002:NOLimStat";
monitor T5_M2_LimSwitch_IN_NO_LimStat;
int T5_M2_LimSwitch_OUT_NC_LimStat;
assign T5_M2_LimSwitch_OUT_NC_LimStat to "DTL-050:EMR-GS-012:NCLimStat";
monitor T5_M2_LimSwitch_OUT_NC_LimStat;
int T5_M2_LimSwitch_OUT_NO_LimStat;
assign T5_M2_LimSwitch_OUT_NO_LimStat to "DTL-050:EMR-GS-012:NOLimStat";
monitor T5_M2_LimSwitch_OUT_NO_LimStat;
int T5_M3_LimSwitch_IN_NC_LimStat;
assign T5_M3_LimSwitch_IN_NC_LimStat to "DTL-050:EMR-GS-003:NCLimStat";
monitor T5_M3_LimSwitch_IN_NC_LimStat;
int T5_M3_LimSwitch_IN_NO_LimStat;
assign T5_M3_LimSwitch_IN_NO_LimStat to "DTL-050:EMR-GS-003:NOLimStat";
monitor T5_M3_LimSwitch_IN_NO_LimStat;
int T5_M3_LimSwitch_OUT_NC_LimStat;
assign T5_M3_LimSwitch_OUT_NC_LimStat to "DTL-050:EMR-GS-013:NCLimStat";
monitor T5_M3_LimSwitch_OUT_NC_LimStat;
int T5_M3_LimSwitch_OUT_NO_LimStat;
assign T5_M3_LimSwitch_OUT_NO_LimStat to "DTL-050:EMR-GS-013:NOLimStat";
monitor T5_M3_LimSwitch_OUT_NO_LimStat;

/* Linear Encoders - Position*/
double Lin_Enc_Position_Res = 1;  // [millimiters]

double T1_M1_LinEnc_Position;
assign T1_M1_LinEnc_Position to "DTL-010:EMR-GT-001:Pos";
monitor T1_M1_LinEnc_Position;
double T1_M2_LinEnc_Position;
assign T1_M2_LinEnc_Position to "DTL-010:EMR-GT-002:Pos";
monitor T1_M2_LinEnc_Position;
double T1_M3_LinEnc_Position;
assign T1_M3_LinEnc_Position to "DTL-010:EMR-GT-003:Pos";
monitor T1_M3_LinEnc_Position;
double T2_M1_LinEnc_Position;
assign T2_M1_LinEnc_Position to "DTL-020:EMR-GT-001:Pos";
monitor T2_M1_LinEnc_Position;
double T2_M2_LinEnc_Position;
assign T2_M2_LinEnc_Position to "DTL-020:EMR-GT-002:Pos";
monitor T2_M2_LinEnc_Position;
double T2_M3_LinEnc_Position;
assign T2_M3_LinEnc_Position to "DTL-020:EMR-GT-003:Pos";
monitor T2_M3_LinEnc_Position;
double T3_M1_LinEnc_Position;
assign T3_M1_LinEnc_Position to "DTL-030:EMR-GT-001:Pos";
monitor T3_M1_LinEnc_Position;
double T3_M2_LinEnc_Position;
assign T3_M2_LinEnc_Position to "DTL-030:EMR-GT-002:Pos";
monitor T3_M2_LinEnc_Position;
double T3_M3_LinEnc_Position;
assign T3_M3_LinEnc_Position to "DTL-030:EMR-GT-003:Pos";
monitor T3_M3_LinEnc_Position;
double T4_M1_LinEnc_Position;
assign T4_M1_LinEnc_Position to "DTL-040:EMR-GT-001:Pos";
monitor T4_M1_LinEnc_Position;
double T4_M2_LinEnc_Position;
assign T4_M2_LinEnc_Position to "DTL-040:EMR-GT-002:Pos";
monitor T4_M2_LinEnc_Position;
double T4_M3_LinEnc_Position;
assign T4_M3_LinEnc_Position to "DTL-040:EMR-GT-003:Pos";
monitor T4_M3_LinEnc_Position;
double T5_M1_LinEnc_Position;
assign T5_M1_LinEnc_Position to "DTL-050:EMR-GT-001:Pos";
monitor T5_M1_LinEnc_Position;
double T5_M2_LinEnc_Position;
assign T5_M2_LinEnc_Position to "DTL-050:EMR-GT-002:Pos";
monitor T5_M2_LinEnc_Position;
double T5_M3_LinEnc_Position;
assign T5_M3_LinEnc_Position to "DTL-050:EMR-GT-003:Pos";
monitor T5_M3_LinEnc_Position;

/* Linear Encoders - Status*/
/*
int T1_M1_LinEnc_Stat;
assign T1_M1_LinEnc_Stat to "DTL-010:EMR-GT-001:Stat";
monitor T1_M1_LinEnc_Stat;
int T1_M2_LinEnc_Stat;
assign T1_M2_LinEnc_Stat to "DTL-010:EMR-GT-002:Stat";
monitor T1_M2_LinEnc_Stat;
int T1_M3_LinEnc_Stat;
assign T1_M3_LinEnc_Stat to "DTL-010:EMR-GT-003:Stat";
monitor T1_M3_LinEnc_Stat;
int T2_M1_LinEnc_Stat;
assign T2_M1_LinEnc_Stat to "DTL-020:EMR-GT-001:Stat";
monitor T2_M1_LinEnc_Stat;
int T2_M2_LinEnc_Stat;
assign T2_M2_LinEnc_Stat to "DTL-020:EMR-GT-002:Stat";
monitor T2_M2_LinEnc_Stat;
int T2_M3_LinEnc_Stat;
assign T2_M3_LinEnc_Stat to "DTL-020:EMR-GT-003:Stat";
monitor T2_M3_LinEnc_Stat;
int T3_M1_LinEnc_Stat;
assign T3_M1_LinEnc_Stat to "DTL-030:EMR-GT-001:Stat";
monitor T3_M1_LinEnc_Stat;
int T3_M2_LinEnc_Stat;
assign T3_M2_LinEnc_Stat to "DTL-030:EMR-GT-002:Stat";
monitor T3_M2_LinEnc_Stat;
int T3_M3_LinEnc_Stat;
assign T3_M3_LinEnc_Stat to "DTL-030:EMR-GT-003:Stat";
monitor T3_M3_LinEnc_Stat;
int T4_M1_LinEnc_Stat;
assign T4_M1_LinEnc_Stat to "DTL-040:EMR-GT-001:Stat";
monitor T4_M1_LinEnc_Stat;
int T4_M2_LinEnc_Stat;
assign T4_M2_LinEnc_Stat to "DTL-040:EMR-GT-002:Stat";
monitor T4_M2_LinEnc_Stat;
int T4_M3_LinEnc_Stat;
assign T4_M3_LinEnc_Stat to "DTL-040:EMR-GT-003:Stat";
monitor T4_M3_LinEnc_Stat;
int T5_M1_LinEnc_Stat;
assign T5_M1_LinEnc_Stat to "DTL-050:EMR-GT-001:Stat";
monitor T5_M1_LinEnc_Stat;
int T5_M2_LinEnc_Stat;
assign T5_M2_LinEnc_Stat to "DTL-050:EMR-GT-002:Stat";
monitor T5_M2_LinEnc_Stat;
int T5_M3_LinEnc_Stat;
assign T5_M3_LinEnc_Stat to "DTL-050:EMR-GT-003:Stat";
monitor T5_M3_LinEnc_Stat;
*/

/* Linear Encoders - Error Alarm*/
int T1_M1_LinEnc_ErrorAlrm;
assign T1_M1_LinEnc_ErrorAlrm to "DTL-010:EMR-GT-001:Err-Alrm";
monitor T1_M1_LinEnc_ErrorAlrm;
int T1_M2_LinEnc_ErrorAlrm;
assign T1_M2_LinEnc_ErrorAlrm to "DTL-010:EMR-GT-002:Err-Alrm";
monitor T1_M2_LinEnc_ErrorAlrm;
int T1_M3_LinEnc_ErrorAlrm;
assign T1_M3_LinEnc_ErrorAlrm to "DTL-010:EMR-GT-003:Err-Alrm";
monitor T1_M3_LinEnc_ErrorAlrm;
int T2_M1_LinEnc_ErrorAlrm;
assign T2_M1_LinEnc_ErrorAlrm to "DTL-020:EMR-GT-001:Err-Alrm";
monitor T2_M1_LinEnc_ErrorAlrm;
int T2_M2_LinEnc_ErrorAlrm;
assign T2_M2_LinEnc_ErrorAlrm to "DTL-020:EMR-GT-002:Err-Alrm";
monitor T2_M2_LinEnc_ErrorAlrm;
int T2_M3_LinEnc_ErrorAlrm;
assign T2_M3_LinEnc_ErrorAlrm to "DTL-020:EMR-GT-003:Err-Alrm";
monitor T2_M3_LinEnc_ErrorAlrm;
int T3_M1_LinEnc_ErrorAlrm;
assign T3_M1_LinEnc_ErrorAlrm to "DTL-030:EMR-GT-001:Err-Alrm";
monitor T3_M1_LinEnc_ErrorAlrm;
int T3_M2_LinEnc_ErrorAlrm;
assign T3_M2_LinEnc_ErrorAlrm to "DTL-030:EMR-GT-002:Err-Alrm";
monitor T3_M2_LinEnc_ErrorAlrm;
int T3_M3_LinEnc_ErrorAlrm;
assign T3_M3_LinEnc_ErrorAlrm to "DTL-030:EMR-GT-003:Err-Alrm";
monitor T3_M3_LinEnc_ErrorAlrm;
int T4_M1_LinEnc_ErrorAlrm;
assign T4_M1_LinEnc_ErrorAlrm to "DTL-040:EMR-GT-001:Err-Alrm";
monitor T4_M1_LinEnc_ErrorAlrm;
int T4_M2_LinEnc_ErrorAlrm;
assign T4_M2_LinEnc_ErrorAlrm to "DTL-040:EMR-GT-002:Err-Alrm";
monitor T4_M2_LinEnc_ErrorAlrm;
int T4_M3_LinEnc_ErrorAlrm;
assign T4_M3_LinEnc_ErrorAlrm to "DTL-040:EMR-GT-003:Err-Alrm";
monitor T4_M3_LinEnc_ErrorAlrm;
int T5_M1_LinEnc_ErrorAlrm;
assign T5_M1_LinEnc_ErrorAlrm to "DTL-050:EMR-GT-001:Err-Alrm";
monitor T5_M1_LinEnc_ErrorAlrm;
int T5_M2_LinEnc_ErrorAlrm;
assign T5_M2_LinEnc_ErrorAlrm to "DTL-050:EMR-GT-002:Err-Alrm";
monitor T5_M2_LinEnc_ErrorAlrm;
int T5_M3_LinEnc_ErrorAlrm;
assign T5_M3_LinEnc_ErrorAlrm to "DTL-050:EMR-GT-003:Err-Alrm";
monitor T5_M3_LinEnc_ErrorAlrm;

/* Linear Encoders - Limit Alarm*/
int T1_M1_LinEnc_LlimAlrm;
assign T1_M1_LinEnc_LlimAlrm to "DTL-010:EMR-GT-001:LLim-Alrm";
monitor T1_M1_LinEnc_LlimAlrm;
int T1_M2_LinEnc_LlimAlrm;
assign T1_M2_LinEnc_LlimAlrm to "DTL-010:EMR-GT-002:LLim-Alrm";
monitor T1_M2_LinEnc_LlimAlrm;
int T1_M3_LinEnc_LlimAlrm;
assign T1_M3_LinEnc_LlimAlrm to "DTL-010:EMR-GT-003:LLim-Alrm";
monitor T1_M3_LinEnc_LlimAlrm;
int T2_M1_LinEnc_LlimAlrm;
assign T2_M1_LinEnc_LlimAlrm to "DTL-020:EMR-GT-001:LLim-Alrm";
monitor T2_M1_LinEnc_LlimAlrm;
int T2_M2_LinEnc_LlimAlrm;
assign T2_M2_LinEnc_LlimAlrm to "DTL-020:EMR-GT-002:LLim-Alrm";
monitor T2_M2_LinEnc_LlimAlrm;
int T2_M3_LinEnc_LlimAlrm;
assign T2_M3_LinEnc_LlimAlrm to "DTL-020:EMR-GT-003:LLim-Alrm";
monitor T2_M3_LinEnc_LlimAlrm;
int T3_M1_LinEnc_LlimAlrm;
assign T3_M1_LinEnc_LlimAlrm to "DTL-030:EMR-GT-001:LLim-Alrm";
monitor T3_M1_LinEnc_LlimAlrm;
int T3_M2_LinEnc_LlimAlrm;
assign T3_M2_LinEnc_LlimAlrm to "DTL-030:EMR-GT-002:LLim-Alrm";
monitor T3_M2_LinEnc_LlimAlrm;
int T3_M3_LinEnc_LlimAlrm;
assign T3_M3_LinEnc_LlimAlrm to "DTL-030:EMR-GT-003:LLim-Alrm";
monitor T3_M3_LinEnc_LlimAlrm;
int T4_M1_LinEnc_LlimAlrm;
assign T4_M1_LinEnc_LlimAlrm to "DTL-040:EMR-GT-001:LLim-Alrm";
monitor T4_M1_LinEnc_LlimAlrm;
int T4_M2_LinEnc_LlimAlrm;
assign T4_M2_LinEnc_LlimAlrm to "DTL-040:EMR-GT-002:LLim-Alrm";
monitor T4_M2_LinEnc_LlimAlrm;
int T4_M3_LinEnc_LlimAlrm;
assign T4_M3_LinEnc_LlimAlrm to "DTL-040:EMR-GT-003:LLim-Alrm";
monitor T4_M3_LinEnc_LlimAlrm;
int T5_M1_LinEnc_LlimAlrm;
assign T5_M1_LinEnc_LlimAlrm to "DTL-050:EMR-GT-001:LLim-Alrm";
monitor T5_M1_LinEnc_LlimAlrm;
int T5_M2_LinEnc_LlimAlrm;
assign T5_M2_LinEnc_LlimAlrm to "DTL-050:EMR-GT-002:LLim-Alrm";
monitor T5_M2_LinEnc_LlimAlrm;
int T5_M3_LinEnc_LlimAlrm;
assign T5_M3_LinEnc_LlimAlrm to "DTL-050:EMR-GT-003:LLim-Alrm";
monitor T5_M3_LinEnc_LlimAlrm;
int T1_M1_LinEnc_HlimAlrm;
assign T1_M1_LinEnc_HlimAlrm to "DTL-010:EMR-GT-001:HLim-Alrm";
monitor T1_M1_LinEnc_HlimAlrm;
int T1_M2_LinEnc_HlimAlrm;
assign T1_M2_LinEnc_HlimAlrm to "DTL-010:EMR-GT-002:HLim-Alrm";
monitor T1_M2_LinEnc_HlimAlrm;
int T1_M3_LinEnc_HlimAlrm;
assign T1_M3_LinEnc_HlimAlrm to "DTL-010:EMR-GT-003:HLim-Alrm";
monitor T1_M3_LinEnc_HlimAlrm;
int T2_M1_LinEnc_HlimAlrm;
assign T2_M1_LinEnc_HlimAlrm to "DTL-020:EMR-GT-001:HLim-Alrm";
monitor T2_M1_LinEnc_HlimAlrm;
int T2_M2_LinEnc_HlimAlrm;
assign T2_M2_LinEnc_HlimAlrm to "DTL-020:EMR-GT-002:HLim-Alrm";
monitor T2_M2_LinEnc_HlimAlrm;
int T2_M3_LinEnc_HlimAlrm;
assign T2_M3_LinEnc_HlimAlrm to "DTL-020:EMR-GT-003:HLim-Alrm";
monitor T2_M3_LinEnc_HlimAlrm;
int T3_M1_LinEnc_HlimAlrm;
assign T3_M1_LinEnc_HlimAlrm to "DTL-030:EMR-GT-001:HLim-Alrm";
monitor T3_M1_LinEnc_HlimAlrm;
int T3_M2_LinEnc_HlimAlrm;
assign T3_M2_LinEnc_HlimAlrm to "DTL-030:EMR-GT-002:HLim-Alrm";
monitor T3_M2_LinEnc_HlimAlrm;
int T3_M3_LinEnc_HlimAlrm;
assign T3_M3_LinEnc_HlimAlrm to "DTL-030:EMR-GT-003:HLim-Alrm";
monitor T3_M3_LinEnc_HlimAlrm;
int T4_M1_LinEnc_HlimAlrm;
assign T4_M1_LinEnc_HlimAlrm to "DTL-040:EMR-GT-001:HLim-Alrm";
monitor T4_M1_LinEnc_HlimAlrm;
int T4_M2_LinEnc_HlimAlrm;
assign T4_M2_LinEnc_HlimAlrm to "DTL-040:EMR-GT-002:HLim-Alrm";
monitor T4_M2_LinEnc_HlimAlrm;
int T4_M3_LinEnc_HlimAlrm;
assign T4_M3_LinEnc_HlimAlrm to "DTL-040:EMR-GT-003:HLim-Alrm";
monitor T4_M3_LinEnc_HlimAlrm;
int T5_M1_LinEnc_HlimAlrm;
assign T5_M1_LinEnc_HlimAlrm to "DTL-050:EMR-GT-001:HLim-Alrm";
monitor T5_M1_LinEnc_HlimAlrm;
int T5_M2_LinEnc_HlimAlrm;
assign T5_M2_LinEnc_HlimAlrm to "DTL-050:EMR-GT-002:HLim-Alrm";
monitor T5_M2_LinEnc_HlimAlrm;
int T5_M3_LinEnc_HlimAlrm;
assign T5_M3_LinEnc_HlimAlrm to "DTL-050:EMR-GT-003:HLim-Alrm";
monitor T5_M3_LinEnc_HlimAlrm;

/* Linear Encoders - Online Status  */
int T1_M1_LinEnc_Online;
assign T1_M1_LinEnc_Online to "DTL-010:EMR-GT-001:ConnStat";
monitor T1_M1_LinEnc_Online;
int T1_M2_LinEnc_Online;
assign T1_M2_LinEnc_Online to "DTL-010:EMR-GT-002:ConnStat";
monitor T1_M2_LinEnc_Online;
int T1_M3_LinEnc_Online;
assign T1_M3_LinEnc_Online to "DTL-010:EMR-GT-003:ConnStat";
monitor T1_M3_LinEnc_Online;
int T2_M1_LinEnc_Online;
assign T2_M1_LinEnc_Online to "DTL-020:EMR-GT-001:ConnStat";
monitor T2_M1_LinEnc_Online;
int T2_M2_LinEnc_Online;
assign T2_M2_LinEnc_Online to "DTL-020:EMR-GT-002:ConnStat";
monitor T2_M2_LinEnc_Online;
int T2_M3_LinEnc_Online;
assign T2_M3_LinEnc_Online to "DTL-020:EMR-GT-003:ConnStat";
monitor T2_M3_LinEnc_Online;
int T3_M1_LinEnc_Online;
assign T3_M1_LinEnc_Online to "DTL-030:EMR-GT-001:ConnStat";
monitor T3_M1_LinEnc_Online;
int T3_M2_LinEnc_Online;
assign T3_M2_LinEnc_Online to "DTL-030:EMR-GT-002:ConnStat";
monitor T3_M2_LinEnc_Online;
int T3_M3_LinEnc_Online;
assign T3_M3_LinEnc_Online to "DTL-030:EMR-GT-003:ConnStat";
monitor T3_M3_LinEnc_Online;
int T4_M1_LinEnc_Online;
assign T4_M1_LinEnc_Online to "DTL-040:EMR-GT-001:ConnStat";
monitor T4_M1_LinEnc_Online;
int T4_M2_LinEnc_Online;
assign T4_M2_LinEnc_Online to "DTL-040:EMR-GT-002:ConnStat";
monitor T4_M2_LinEnc_Online;
int T4_M3_LinEnc_Online;
assign T4_M3_LinEnc_Online to "DTL-040:EMR-GT-003:ConnStat";
monitor T4_M3_LinEnc_Online;
int T5_M1_LinEnc_Online;
assign T5_M1_LinEnc_Online to "DTL-050:EMR-GT-001:ConnStat";
monitor T5_M1_LinEnc_Online;
int T5_M2_LinEnc_Online;
assign T5_M2_LinEnc_Online to "DTL-050:EMR-GT-002:ConnStat";
monitor T5_M2_LinEnc_Online;
int T5_M3_LinEnc_Online;
assign T5_M3_LinEnc_Online to "DTL-050:EMR-GT-003:ConnStat";
monitor T5_M3_LinEnc_Online;

/* Motor - Position */
double T1_M1_Axis_Position;
assign T1_M1_Axis_Position to "DTL-010:EMR-SM-001.VAL";
monitor T1_M1_Axis_Position;
double T1_M2_Axis_Position;
assign T1_M2_Axis_Position to "DTL-010:EMR-SM-002.VAL";
monitor T1_M2_Axis_Position;
double T1_M3_Axis_Position;
assign T1_M3_Axis_Position to "DTL-010:EMR-SM-003.VAL";
monitor T1_M3_Axis_Position;
double T2_M1_Axis_Position;
assign T2_M1_Axis_Position to "DTL-020:EMR-SM-001.VAL";
monitor T2_M1_Axis_Position;
double T2_M2_Axis_Position;
assign T2_M2_Axis_Position to "DTL-020:EMR-SM-002.VAL";
monitor T2_M2_Axis_Position;
double T2_M3_Axis_Position;
assign T2_M3_Axis_Position to "DTL-020:EMR-SM-003.VAL";
monitor T2_M3_Axis_Position;
double T3_M1_Axis_Position;
assign T3_M1_Axis_Position to "DTL-030:EMR-SM-001.VAL";
monitor T3_M1_Axis_Position;
double T3_M2_Axis_Position;
assign T3_M2_Axis_Position to "DTL-030:EMR-SM-002.VAL";
monitor T3_M2_Axis_Position;
double T3_M3_Axis_Position;
assign T3_M3_Axis_Position to "DTL-030:EMR-SM-003.VAL";
monitor T3_M3_Axis_Position;
double T4_M1_Axis_Position;
assign T4_M1_Axis_Position to "DTL-040:EMR-SM-001.VAL";
monitor T4_M1_Axis_Position;
double T4_M2_Axis_Position;
assign T4_M2_Axis_Position to "DTL-040:EMR-SM-002.VAL";
monitor T4_M2_Axis_Position;
double T4_M3_Axis_Position;
assign T4_M3_Axis_Position to "DTL-040:EMR-SM-003.VAL";
monitor T4_M3_Axis_Position;
double T5_M1_Axis_Position;
assign T5_M1_Axis_Position to "DTL-050:EMR-SM-001.VAL";
monitor T5_M1_Axis_Position;
double T5_M2_Axis_Position;
assign T5_M2_Axis_Position to "DTL-050:EMR-SM-002.VAL";
monitor T5_M2_Axis_Position;
double T5_M3_Axis_Position;
assign T5_M3_Axis_Position to "DTL-050:EMR-SM-003.VAL";
monitor T5_M3_Axis_Position;

/* Motor - Enable */
int T1_M1_Axis_Enable;
assign T1_M1_Axis_Enable to "DTL-010:EMR-SM-001.CNEN";
monitor T1_M1_Axis_Enable;
int T1_M2_Axis_Enable;
assign T1_M2_Axis_Enable to "DTL-010:EMR-SM-002.CNEN";
monitor T1_M2_Axis_Enable;
int T1_M3_Axis_Enable;
assign T1_M3_Axis_Enable to "DTL-010:EMR-SM-003.CNEN";
monitor T1_M3_Axis_Enable;
int T2_M1_Axis_Enable;
assign T2_M1_Axis_Enable to "DTL-020:EMR-SM-001.CNEN";
monitor T2_M1_Axis_Enable;
int T2_M2_Axis_Enable;
assign T2_M2_Axis_Enable to "DTL-020:EMR-SM-002.CNEN";
monitor T2_M2_Axis_Enable;
int T2_M3_Axis_Enable;
assign T2_M3_Axis_Enable to "DTL-020:EMR-SM-003.CNEN";
monitor T2_M3_Axis_Enable;
int T3_M1_Axis_Enable;
assign T3_M1_Axis_Enable to "DTL-030:EMR-SM-001.CNEN";
monitor T3_M1_Axis_Enable;
int T3_M2_Axis_Enable;
assign T3_M2_Axis_Enable to "DTL-030:EMR-SM-002.CNEN";
monitor T3_M2_Axis_Enable;
int T3_M3_Axis_Enable;
assign T3_M3_Axis_Enable to "DTL-030:EMR-SM-003.CNEN";
monitor T3_M3_Axis_Enable;
int T4_M1_Axis_Enable;
assign T4_M1_Axis_Enable to "DTL-040:EMR-SM-001.CNEN";
monitor T4_M1_Axis_Enable;
int T4_M2_Axis_Enable;
assign T4_M2_Axis_Enable to "DTL-040:EMR-SM-002.CNEN";
monitor T4_M2_Axis_Enable;
int T4_M3_Axis_Enable;
assign T4_M3_Axis_Enable to "DTL-040:EMR-SM-003.CNEN";
monitor T4_M3_Axis_Enable;
int T5_M1_Axis_Enable;
assign T5_M1_Axis_Enable to "DTL-050:EMR-SM-001.CNEN";
monitor T5_M1_Axis_Enable;
int T5_M2_Axis_Enable;
assign T5_M2_Axis_Enable to "DTL-050:EMR-SM-002.CNEN";
monitor T5_M2_Axis_Enable;
int T5_M3_Axis_Enable;
assign T5_M3_Axis_Enable to "DTL-050:EMR-SM-003.CNEN";
monitor T5_M3_Axis_Enable;

/* Motor - Direction */
int T1_M1_Axis_Direction;
assign T1_M1_Axis_Direction to "DTL-010:EMR-SM-001.DIR";
monitor T1_M1_Axis_Direction;
int T1_M2_Axis_Direction;
assign T1_M2_Axis_Direction to "DTL-010:EMR-SM-002.DIR";
monitor T1_M2_Axis_Direction;
int T1_M3_Axis_Direction;
assign T1_M3_Axis_Direction to "DTL-010:EMR-SM-003.DIR";
monitor T1_M3_Axis_Direction;
int T2_M1_Axis_Direction;
assign T2_M1_Axis_Direction to "DTL-020:EMR-SM-001.DIR";
monitor T2_M1_Axis_Direction;
int T2_M2_Axis_Direction;
assign T2_M2_Axis_Direction to "DTL-020:EMR-SM-002.DIR";
monitor T2_M2_Axis_Direction;
int T2_M3_Axis_Direction;
assign T2_M3_Axis_Direction to "DTL-020:EMR-SM-003.DIR";
monitor T2_M3_Axis_Direction;
int T3_M1_Axis_Direction;
assign T3_M1_Axis_Direction to "DTL-030:EMR-SM-001.DIR";
monitor T3_M1_Axis_Direction;
int T3_M2_Axis_Direction;
assign T3_M2_Axis_Direction to "DTL-030:EMR-SM-002.DIR";
monitor T3_M2_Axis_Direction;
int T3_M3_Axis_Direction;
assign T3_M3_Axis_Direction to "DTL-030:EMR-SM-003.DIR";
monitor T3_M3_Axis_Direction;
int T4_M1_Axis_Direction;
assign T4_M1_Axis_Direction to "DTL-040:EMR-SM-001.DIR";
monitor T4_M1_Axis_Direction;
int T4_M2_Axis_Direction;
assign T4_M2_Axis_Direction to "DTL-040:EMR-SM-002.DIR";
monitor T4_M2_Axis_Direction;
int T4_M3_Axis_Direction;
assign T4_M3_Axis_Direction to "DTL-040:EMR-SM-003.DIR";
monitor T4_M3_Axis_Direction;
int T5_M1_Axis_Direction;
assign T5_M1_Axis_Direction to "DTL-050:EMR-SM-001.DIR";
monitor T5_M1_Axis_Direction;
int T5_M2_Axis_Direction;
assign T5_M2_Axis_Direction to "DTL-050:EMR-SM-002.DIR";
monitor T5_M2_Axis_Direction;
int T5_M3_Axis_Direction;
assign T5_M3_Axis_Direction to "DTL-050:EMR-SM-003.DIR";
monitor T5_M3_Axis_Direction;

/* Motor - Miss position */
int Error_Missing_Counter = 0;
int Max_Missing_Counter = 10;

int T1_M1_Axis_Missing;
assign T1_M1_Axis_Missing to "DTL-010:EMR-SM-001.MISS";
monitor T1_M1_Axis_Missing;
int T1_M2_Axis_Missing;
assign T1_M2_Axis_Missing to "DTL-010:EMR-SM-002.MISS";
monitor T1_M2_Axis_Missing;
int T1_M3_Axis_Missing;
assign T1_M3_Axis_Missing to "DTL-010:EMR-SM-003.MISS";
monitor T1_M3_Axis_Missing;
int T2_M1_Axis_Missing;
assign T2_M1_Axis_Missing to "DTL-020:EMR-SM-001.MISS";
monitor T2_M1_Axis_Missing;
int T2_M2_Axis_Missing;
assign T2_M2_Axis_Missing to "DTL-020:EMR-SM-002.MISS";
monitor T2_M2_Axis_Missing;
int T2_M3_Axis_Missing;
assign T2_M3_Axis_Missing to "DTL-020:EMR-SM-003.MISS";
monitor T2_M3_Axis_Missing;
int T3_M1_Axis_Missing;
assign T3_M1_Axis_Missing to "DTL-030:EMR-SM-001.MISS";
monitor T3_M1_Axis_Missing;
int T3_M2_Axis_Missing;
assign T3_M2_Axis_Missing to "DTL-030:EMR-SM-002.MISS";
monitor T3_M2_Axis_Missing;
int T3_M3_Axis_Missing;
assign T3_M3_Axis_Missing to "DTL-030:EMR-SM-003.MISS";
monitor T3_M3_Axis_Missing;
int T4_M1_Axis_Missing;
assign T4_M1_Axis_Missing to "DTL-040:EMR-SM-001.MISS";
monitor T4_M1_Axis_Missing;
int T4_M2_Axis_Missing;
assign T4_M2_Axis_Missing to "DTL-040:EMR-SM-002.MISS";
monitor T4_M2_Axis_Missing;
int T4_M3_Axis_Missing;
assign T4_M3_Axis_Missing to "DTL-040:EMR-SM-003.MISS";
monitor T4_M3_Axis_Missing;
int T5_M1_Axis_Missing;
assign T5_M1_Axis_Missing to "DTL-050:EMR-SM-001.MISS";
monitor T5_M1_Axis_Missing;
int T5_M2_Axis_Missing;
assign T5_M2_Axis_Missing to "DTL-050:EMR-SM-002.MISS";
monitor T5_M2_Axis_Missing;
int T5_M3_Axis_Missing;
assign T5_M3_Axis_Missing to "DTL-050:EMR-SM-003.MISS";
monitor T5_M3_Axis_Missing;

/* Motor - Stop */
int T1_M1_Axis_Stop;
assign T1_M1_Axis_Stop to "DTL-010:EMR-SM-001.STOP";
monitor T1_M1_Axis_Stop;
int T1_M2_Axis_Stop;
assign T1_M2_Axis_Stop to "DTL-010:EMR-SM-002.STOP";
monitor T1_M2_Axis_Stop;
int T1_M3_Axis_Stop;
assign T1_M3_Axis_Stop to "DTL-010:EMR-SM-003.STOP";
monitor T1_M3_Axis_Stop;
int T2_M1_Axis_Stop;
assign T2_M1_Axis_Stop to "DTL-020:EMR-SM-001.STOP";
monitor T2_M1_Axis_Stop;
int T2_M2_Axis_Stop;
assign T2_M2_Axis_Stop to "DTL-020:EMR-SM-002.STOP";
monitor T2_M2_Axis_Stop;
int T2_M3_Axis_Stop;
assign T2_M3_Axis_Stop to "DTL-020:EMR-SM-003.STOP";
monitor T2_M3_Axis_Stop;
int T3_M1_Axis_Stop;
assign T3_M1_Axis_Stop to "DTL-030:EMR-SM-001.STOP";
monitor T3_M1_Axis_Stop;
int T3_M2_Axis_Stop;
assign T3_M2_Axis_Stop to "DTL-030:EMR-SM-002.STOP";
monitor T3_M2_Axis_Stop;
int T3_M3_Axis_Stop;
assign T3_M3_Axis_Stop to "DTL-030:EMR-SM-003.STOP";
monitor T3_M3_Axis_Stop;
int T4_M1_Axis_Stop;
assign T4_M1_Axis_Stop to "DTL-040:EMR-SM-001.STOP";
monitor T4_M1_Axis_Stop;
int T4_M2_Axis_Stop;
assign T4_M2_Axis_Stop to "DTL-040:EMR-SM-002.STOP";
monitor T4_M2_Axis_Stop;
int T4_M3_Axis_Stop;
assign T4_M3_Axis_Stop to "DTL-040:EMR-SM-003.STOP";
monitor T4_M3_Axis_Stop;
int T5_M1_Axis_Stop;
assign T5_M1_Axis_Stop to "DTL-050:EMR-SM-001.STOP";
monitor T5_M1_Axis_Stop;
int T5_M2_Axis_Stop;
assign T5_M2_Axis_Stop to "DTL-050:EMR-SM-002.STOP";
monitor T5_M2_Axis_Stop;
int T5_M3_Axis_Stop;
assign T5_M3_Axis_Stop to "DTL-050:EMR-SM-003.STOP";
monitor T5_M3_Axis_Stop;

/* Motor - Reset Error */
int T1_M1_Axis_ErrorReset;
assign T1_M1_Axis_ErrorReset to "DTL-010:EMR-SM-001:Err-Rst";
monitor T1_M1_Axis_ErrorReset;
int T1_M2_Axis_ErrorReset;
assign T1_M2_Axis_ErrorReset to "DTL-010:EMR-SM-002:Err-Rst";
monitor T1_M2_Axis_ErrorReset;
int T1_M3_Axis_ErrorReset;
assign T1_M3_Axis_ErrorReset to "DTL-010:EMR-SM-003:Err-Rst";
monitor T1_M3_Axis_ErrorReset;
int T2_M1_Axis_ErrorReset;
assign T2_M1_Axis_ErrorReset to "DTL-020:EMR-SM-001:Err-Rst";
monitor T2_M1_Axis_ErrorReset;
int T2_M2_Axis_ErrorReset;
assign T2_M2_Axis_ErrorReset to "DTL-020:EMR-SM-002:Err-Rst";
monitor T2_M2_Axis_ErrorReset;
int T2_M3_Axis_ErrorReset;
assign T2_M3_Axis_ErrorReset to "DTL-020:EMR-SM-003:Err-Rst";
monitor T2_M3_Axis_ErrorReset;
int T3_M1_Axis_ErrorReset;
assign T3_M1_Axis_ErrorReset to "DTL-030:EMR-SM-001:Err-Rst";
monitor T3_M1_Axis_ErrorReset;
int T3_M2_Axis_ErrorReset;
assign T3_M2_Axis_ErrorReset to "DTL-030:EMR-SM-002:Err-Rst";
monitor T3_M2_Axis_ErrorReset;
int T3_M3_Axis_ErrorReset;
assign T3_M3_Axis_ErrorReset to "DTL-030:EMR-SM-003:Err-Rst";
monitor T3_M3_Axis_ErrorReset;
int T4_M1_Axis_ErrorReset;
assign T4_M1_Axis_ErrorReset to "DTL-040:EMR-SM-001:Err-Rst";
monitor T4_M1_Axis_ErrorReset;
int T4_M2_Axis_ErrorReset;
assign T4_M2_Axis_ErrorReset to "DTL-040:EMR-SM-002:Err-Rst";
monitor T4_M2_Axis_ErrorReset;
int T4_M3_Axis_ErrorReset;
assign T4_M3_Axis_ErrorReset to "DTL-040:EMR-SM-003:Err-Rst";
monitor T4_M3_Axis_ErrorReset;
int T5_M1_Axis_ErrorReset;
assign T5_M1_Axis_ErrorReset to "DTL-050:EMR-SM-001:Err-Rst";
monitor T5_M1_Axis_ErrorReset;
int T5_M2_Axis_ErrorReset;
assign T5_M2_Axis_ErrorReset to "DTL-050:EMR-SM-002:Err-Rst";
monitor T5_M2_Axis_ErrorReset;
int T5_M3_Axis_ErrorReset;
assign T5_M3_Axis_ErrorReset to "DTL-050:EMR-SM-003:Err-Rst";
monitor T5_M3_Axis_ErrorReset;

/* Motor - Error */
int T1_M1_Axis_Error;
assign T1_M1_Axis_Error to "DTL-010:EMR-SM-001:Err";
monitor T1_M1_Axis_Error;
int T1_M2_Axis_Error;
assign T1_M2_Axis_Error to "DTL-010:EMR-SM-002:Err";
monitor T1_M2_Axis_Error;
int T1_M3_Axis_Error;
assign T1_M3_Axis_Error to "DTL-010:EMR-SM-003:Err";
monitor T1_M3_Axis_Error;
int T2_M1_Axis_Error;
assign T2_M1_Axis_Error to "DTL-020:EMR-SM-001:Err";
monitor T2_M1_Axis_Error;
int T2_M2_Axis_Error;
assign T2_M2_Axis_Error to "DTL-020:EMR-SM-002:Err";
monitor T2_M2_Axis_Error;
int T2_M3_Axis_Error;
assign T2_M3_Axis_Error to "DTL-020:EMR-SM-003:Err";
monitor T2_M3_Axis_Error;
int T3_M1_Axis_Error;
assign T3_M1_Axis_Error to "DTL-030:EMR-SM-001:Err";
monitor T3_M1_Axis_Error;
int T3_M2_Axis_Error;
assign T3_M2_Axis_Error to "DTL-030:EMR-SM-002:Err";
monitor T3_M2_Axis_Error;
int T3_M3_Axis_Error;
assign T3_M3_Axis_Error to "DTL-030:EMR-SM-003:Err";
monitor T3_M3_Axis_Error;
int T4_M1_Axis_Error;
assign T4_M1_Axis_Error to "DTL-040:EMR-SM-001:Err";
monitor T4_M1_Axis_Error;
int T4_M2_Axis_Error;
assign T4_M2_Axis_Error to "DTL-040:EMR-SM-002:Err";
monitor T4_M2_Axis_Error;
int T4_M3_Axis_Error;
assign T4_M3_Axis_Error to "DTL-040:EMR-SM-003:Err";
monitor T4_M3_Axis_Error;
int T5_M1_Axis_Error;
assign T5_M1_Axis_Error to "DTL-050:EMR-SM-001:Err";
monitor T5_M1_Axis_Error;
int T5_M2_Axis_Error;
assign T5_M2_Axis_Error to "DTL-050:EMR-SM-002:Err";
monitor T5_M2_Axis_Error;
int T5_M3_Axis_Error;
assign T5_M3_Axis_Error to "DTL-050:EMR-SM-003:Err";
monitor T5_M3_Axis_Error;

/* Motor Driver Online */
int T1_M1_Driver_Online;
assign T1_M1_Driver_Online to "DTL-010:MC-MCU-001:online";
monitor T1_M1_Driver_Online;
int T1_M2_Driver_Online;
assign T1_M2_Driver_Online to "DTL-010:MC-MCU-002:online";
monitor T1_M2_Driver_Online;
int T1_M3_Driver_Online;
assign T1_M3_Driver_Online to "DTL-010:MC-MCU-003:online";
monitor T1_M3_Driver_Online;
int T2_M1_Driver_Online;
assign T2_M1_Driver_Online to "DTL-020:MC-MCU-001:online";
monitor T2_M1_Driver_Online;
int T2_M2_Driver_Online;
assign T2_M2_Driver_Online to "DTL-020:MC-MCU-002:online";
monitor T2_M2_Driver_Online;
int T2_M3_Driver_Online;
assign T2_M3_Driver_Online to "DTL-020:MC-MCU-003:online";
monitor T2_M3_Driver_Online;
int T3_M1_Driver_Online;
assign T3_M1_Driver_Online to "DTL-030:MC-MCU-001:online";
monitor T3_M1_Driver_Online;
int T3_M2_Driver_Online;
assign T3_M2_Driver_Online to "DTL-030:MC-MCU-002:online";
monitor T3_M2_Driver_Online;
int T3_M3_Driver_Online;
assign T3_M3_Driver_Online to "DTL-030:MC-MCU-003:online";
monitor T3_M3_Driver_Online;
int T4_M1_Driver_Online;
assign T4_M1_Driver_Online to "DTL-040:MC-MCU-001:online";
monitor T4_M1_Driver_Online;
int T4_M2_Driver_Online;
assign T4_M2_Driver_Online to "DTL-040:MC-MCU-002:online";
monitor T4_M2_Driver_Online;
int T4_M3_Driver_Online;
assign T4_M3_Driver_Online to "DTL-040:MC-MCU-003:online";
monitor T4_M3_Driver_Online;
int T5_M1_Driver_Online;
assign T5_M1_Driver_Online to "DTL-050:MC-MCU-001:online";
monitor T5_M1_Driver_Online;
int T5_M2_Driver_Online;
assign T5_M2_Driver_Online to "DTL-050:MC-MCU-002:online";
monitor T5_M2_Driver_Online;
int T5_M3_Driver_Online;
assign T5_M3_Driver_Online to "DTL-050:MC-MCU-003:online";
monitor T5_M3_Driver_Online;

/* Motor Driver Warning */
int T1_M1_Driver_WarningAlrm;
assign T1_M1_Driver_WarningAlrm to "DTL-010:MC-MCU-001:Drv-Wrn-Alrm";
monitor T1_M1_Driver_WarningAlrm;
int T1_M2_Driver_WarningAlrm;
assign T1_M2_Driver_WarningAlrm to "DTL-010:MC-MCU-002:Drv-Wrn-Alrm";
monitor T1_M2_Driver_WarningAlrm;
int T1_M3_Driver_WarningAlrm;
assign T1_M3_Driver_WarningAlrm to "DTL-010:MC-MCU-003:Drv-Wrn-Alrm";
monitor T1_M3_Driver_WarningAlrm;
int T2_M1_Driver_WarningAlrm;
assign T2_M1_Driver_WarningAlrm to "DTL-020:MC-MCU-001:Drv-Wrn-Alrm";
monitor T2_M1_Driver_WarningAlrm;
int T2_M2_Driver_WarningAlrm;
assign T2_M2_Driver_WarningAlrm to "DTL-020:MC-MCU-002:Drv-Wrn-Alrm";
monitor T2_M2_Driver_WarningAlrm;
int T2_M3_Driver_WarningAlrm;
assign T2_M3_Driver_WarningAlrm to "DTL-020:MC-MCU-003:Drv-Wrn-Alrm";
monitor T2_M3_Driver_WarningAlrm;
int T3_M1_Driver_WarningAlrm;
assign T3_M1_Driver_WarningAlrm to "DTL-030:MC-MCU-001:Drv-Wrn-Alrm";
monitor T3_M1_Driver_WarningAlrm;
int T3_M2_Driver_WarningAlrm;
assign T3_M2_Driver_WarningAlrm to "DTL-030:MC-MCU-002:Drv-Wrn-Alrm";
monitor T3_M2_Driver_WarningAlrm;
int T3_M3_Driver_WarningAlrm;
assign T3_M3_Driver_WarningAlrm to "DTL-030:MC-MCU-003:Drv-Wrn-Alrm";
monitor T3_M3_Driver_WarningAlrm;
int T4_M1_Driver_WarningAlrm;
assign T4_M1_Driver_WarningAlrm to "DTL-040:MC-MCU-001:Drv-Wrn-Alrm";
monitor T4_M1_Driver_WarningAlrm;
int T4_M2_Driver_WarningAlrm;
assign T4_M2_Driver_WarningAlrm to "DTL-040:MC-MCU-002:Drv-Wrn-Alrm";
monitor T4_M2_Driver_WarningAlrm;
int T4_M3_Driver_WarningAlrm;
assign T4_M3_Driver_WarningAlrm to "DTL-040:MC-MCU-003:Drv-Wrn-Alrm";
monitor T4_M3_Driver_WarningAlrm;
int T5_M1_Driver_WarningAlrm;
assign T5_M1_Driver_WarningAlrm to "DTL-050:MC-MCU-001:Drv-Wrn-Alrm";
monitor T5_M1_Driver_WarningAlrm;
int T5_M2_Driver_WarningAlrm;
assign T5_M2_Driver_WarningAlrm to "DTL-050:MC-MCU-002:Drv-Wrn-Alrm";
monitor T5_M2_Driver_WarningAlrm;
int T5_M3_Driver_WarningAlrm;
assign T5_M3_Driver_WarningAlrm to "DTL-050:MC-MCU-003:Drv-Wrn-Alrm";
monitor T5_M3_Driver_WarningAlrm;

/* Motor Driver Error Alarm */
int T1_M1_Driver_ErrorAlrm;
assign T1_M1_Driver_ErrorAlrm to "DTL-010:MC-MCU-001:Drv-Err-Alrm";
monitor T1_M1_Driver_ErrorAlrm;
int T1_M2_Driver_ErrorAlrm;
assign T1_M2_Driver_ErrorAlrm to "DTL-010:MC-MCU-002:Drv-Err-Alrm";
monitor T1_M2_Driver_ErrorAlrm;
int T1_M3_Driver_ErrorAlrm;
assign T1_M3_Driver_ErrorAlrm to "DTL-010:MC-MCU-003:Drv-Err-Alrm";
monitor T1_M3_Driver_ErrorAlrm;
int T2_M1_Driver_ErrorAlrm;
assign T2_M1_Driver_ErrorAlrm to "DTL-020:MC-MCU-001:Drv-Err-Alrm";
monitor T2_M1_Driver_ErrorAlrm;
int T2_M2_Driver_ErrorAlrm;
assign T2_M2_Driver_ErrorAlrm to "DTL-020:MC-MCU-002:Drv-Err-Alrm";
monitor T2_M2_Driver_ErrorAlrm;
int T2_M3_Driver_ErrorAlrm;
assign T2_M3_Driver_ErrorAlrm to "DTL-020:MC-MCU-003:Drv-Err-Alrm";
monitor T2_M3_Driver_ErrorAlrm;
int T3_M1_Driver_ErrorAlrm;
assign T3_M1_Driver_ErrorAlrm to "DTL-030:MC-MCU-001:Drv-Err-Alrm";
monitor T3_M1_Driver_ErrorAlrm;
int T3_M2_Driver_ErrorAlrm;
assign T3_M2_Driver_ErrorAlrm to "DTL-030:MC-MCU-002:Drv-Err-Alrm";
monitor T3_M2_Driver_ErrorAlrm;
int T3_M3_Driver_ErrorAlrm;
assign T3_M3_Driver_ErrorAlrm to "DTL-030:MC-MCU-003:Drv-Err-Alrm";
monitor T3_M3_Driver_ErrorAlrm;
int T4_M1_Driver_ErrorAlrm;
assign T4_M1_Driver_ErrorAlrm to "DTL-040:MC-MCU-001:Drv-Err-Alrm";
monitor T4_M1_Driver_ErrorAlrm;
int T4_M2_Driver_ErrorAlrm;
assign T4_M2_Driver_ErrorAlrm to "DTL-040:MC-MCU-002:Drv-Err-Alrm";
monitor T4_M2_Driver_ErrorAlrm;
int T4_M3_Driver_ErrorAlrm;
assign T4_M3_Driver_ErrorAlrm to "DTL-040:MC-MCU-003:Drv-Err-Alrm";
monitor T4_M3_Driver_ErrorAlrm;
int T5_M1_Driver_ErrorAlrm;
assign T5_M1_Driver_ErrorAlrm to "DTL-050:MC-MCU-001:Drv-Err-Alrm";
monitor T5_M1_Driver_ErrorAlrm;
int T5_M2_Driver_ErrorAlrm;
assign T5_M2_Driver_ErrorAlrm to "DTL-050:MC-MCU-002:Drv-Err-Alrm";
monitor T5_M2_Driver_ErrorAlrm;
int T5_M3_Driver_ErrorAlrm;
assign T5_M3_Driver_ErrorAlrm to "DTL-050:MC-MCU-003:Drv-Err-Alrm";
monitor T5_M3_Driver_ErrorAlrm;

/* Motor Driver Stall Alarm */
int T1_M1_Driver_StallAlrm;
assign T1_M1_Driver_StallAlrm to "DTL-010:MC-MCU-001:Drv-Stl-Alrm";
monitor T1_M1_Driver_StallAlrm;
int T1_M2_Driver_StallAlrm;
assign T1_M2_Driver_StallAlrm to "DTL-010:MC-MCU-002:Drv-Stl-Alrm";
monitor T1_M2_Driver_StallAlrm;
int T1_M3_Driver_StallAlrm;
assign T1_M3_Driver_StallAlrm to "DTL-010:MC-MCU-003:Drv-Stl-Alrm";
monitor T1_M3_Driver_StallAlrm;
int T2_M1_Driver_StallAlrm;
assign T2_M1_Driver_StallAlrm to "DTL-020:MC-MCU-001:Drv-Stl-Alrm";
monitor T2_M1_Driver_StallAlrm;
int T2_M2_Driver_StallAlrm;
assign T2_M2_Driver_StallAlrm to "DTL-020:MC-MCU-002:Drv-Stl-Alrm";
monitor T2_M2_Driver_StallAlrm;
int T2_M3_Driver_StallAlrm;
assign T2_M3_Driver_StallAlrm to "DTL-020:MC-MCU-003:Drv-Stl-Alrm";
monitor T2_M3_Driver_StallAlrm;
int T3_M1_Driver_StallAlrm;
assign T3_M1_Driver_StallAlrm to "DTL-030:MC-MCU-001:Drv-Stl-Alrm";
monitor T3_M1_Driver_StallAlrm;
int T3_M2_Driver_StallAlrm;
assign T3_M2_Driver_StallAlrm to "DTL-030:MC-MCU-002:Drv-Stl-Alrm";
monitor T3_M2_Driver_StallAlrm;
int T3_M3_Driver_StallAlrm;
assign T3_M3_Driver_StallAlrm to "DTL-030:MC-MCU-003:Drv-Stl-Alrm";
monitor T3_M3_Driver_StallAlrm;
int T4_M1_Driver_StallAlrm;
assign T4_M1_Driver_StallAlrm to "DTL-040:MC-MCU-001:Drv-Stl-Alrm";
monitor T4_M1_Driver_StallAlrm;
int T4_M2_Driver_StallAlrm;
assign T4_M2_Driver_StallAlrm to "DTL-040:MC-MCU-002:Drv-Stl-Alrm";
monitor T4_M2_Driver_StallAlrm;
int T4_M3_Driver_StallAlrm;
assign T4_M3_Driver_StallAlrm to "DTL-040:MC-MCU-003:Drv-Stl-Alrm";
monitor T4_M3_Driver_StallAlrm;
int T5_M1_Driver_StallAlrm;
assign T5_M1_Driver_StallAlrm to "DTL-050:MC-MCU-001:Drv-Stl-Alrm";
monitor T5_M1_Driver_StallAlrm;
int T5_M2_Driver_StallAlrm;
assign T5_M2_Driver_StallAlrm to "DTL-050:MC-MCU-002:Drv-Stl-Alrm";
monitor T5_M2_Driver_StallAlrm;
int T5_M3_Driver_StallAlrm;
assign T5_M3_Driver_StallAlrm to "DTL-050:MC-MCU-003:Drv-Stl-Alrm";
monitor T5_M3_Driver_StallAlrm;

/* Motor Driver Synchronization Alarm */
int T1_M1_Driver_SyncAlrm;
assign T1_M1_Driver_SyncAlrm to "DTL-010:MC-MCU-001:Drv-SyncErr-Alrm";
monitor T1_M1_Driver_SyncAlrm;
int T1_M2_Driver_SyncAlrm;
assign T1_M2_Driver_SyncAlrm to "DTL-010:MC-MCU-002:Drv-SyncErr-Alrm";
monitor T1_M2_Driver_SyncAlrm;
int T1_M3_Driver_SyncAlrm;
assign T1_M3_Driver_SyncAlrm to "DTL-010:MC-MCU-003:Drv-SyncErr-Alrm";
monitor T1_M3_Driver_SyncAlrm;
int T2_M1_Driver_SyncAlrm;
assign T2_M1_Driver_SyncAlrm to "DTL-020:MC-MCU-001:Drv-SyncErr-Alrm";
monitor T2_M1_Driver_SyncAlrm;
int T2_M2_Driver_SyncAlrm;
assign T2_M2_Driver_SyncAlrm to "DTL-020:MC-MCU-002:Drv-SyncErr-Alrm";
monitor T2_M2_Driver_SyncAlrm;
int T2_M3_Driver_SyncAlrm;
assign T2_M3_Driver_SyncAlrm to "DTL-020:MC-MCU-003:Drv-SyncErr-Alrm";
monitor T2_M3_Driver_SyncAlrm;
int T3_M1_Driver_SyncAlrm;
assign T3_M1_Driver_SyncAlrm to "DTL-030:MC-MCU-001:Drv-SyncErr-Alrm";
monitor T3_M1_Driver_SyncAlrm;
int T3_M2_Driver_SyncAlrm;
assign T3_M2_Driver_SyncAlrm to "DTL-030:MC-MCU-002:Drv-SyncErr-Alrm";
monitor T3_M2_Driver_SyncAlrm;
int T3_M3_Driver_SyncAlrm;
assign T3_M3_Driver_SyncAlrm to "DTL-030:MC-MCU-003:Drv-SyncErr-Alrm";
monitor T3_M3_Driver_SyncAlrm;
int T4_M1_Driver_SyncAlrm;
assign T4_M1_Driver_SyncAlrm to "DTL-040:MC-MCU-001:Drv-SyncErr-Alrm";
monitor T4_M1_Driver_SyncAlrm;
int T4_M2_Driver_SyncAlrm;
assign T4_M2_Driver_SyncAlrm to "DTL-040:MC-MCU-002:Drv-SyncErr-Alrm";
monitor T4_M2_Driver_SyncAlrm;
int T4_M3_Driver_SyncAlrm;
assign T4_M3_Driver_SyncAlrm to "DTL-040:MC-MCU-003:Drv-SyncErr-Alrm";
monitor T4_M3_Driver_SyncAlrm;
int T5_M1_Driver_SyncAlrm;
assign T5_M1_Driver_SyncAlrm to "DTL-050:MC-MCU-001:Drv-SyncErr-Alrm";
monitor T5_M1_Driver_SyncAlrm;
int T5_M2_Driver_SyncAlrm;
assign T5_M2_Driver_SyncAlrm to "DTL-050:MC-MCU-002:Drv-SyncErr-Alrm";
monitor T5_M2_Driver_SyncAlrm;
int T5_M3_Driver_SyncAlrm;
assign T5_M3_Driver_SyncAlrm to "DTL-050:MC-MCU-003:Drv-SyncErr-Alrm";
monitor T5_M3_Driver_SyncAlrm;


/* Manual/Auto Control  */
int AutoControlCmd;
assign AutoControlCmd to "DTL:MC-MCU:AutoCmd";
monitor AutoControlCmd;

int AutoControl_ActualStatus;
assign AutoControl_ActualStatus to "DTL:MC-MCU:AutoCmd-RB";
monitor AutoControl_ActualStatus;



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
			printf("[SEQ TUNERS] All PVs connected\n");
			printf("[SEQ TUNERS] Starting Self Check Process\n");

			/* System pre-configuration */
			T1_M1_LimSwitch_IN_OnCmd=1;
			pvPut(T1_M1_LimSwitch_IN_OnCmd);
			T1_M2_LimSwitch_IN_OnCmd=1;
			pvPut(T1_M2_LimSwitch_IN_OnCmd);
			T1_M3_LimSwitch_IN_OnCmd=1;
			pvPut(T1_M3_LimSwitch_IN_OnCmd);
			T1_M1_LimSwitch_OUT_OnCmd=1;
			pvPut(T1_M1_LimSwitch_OUT_OnCmd);
			T1_M2_LimSwitch_OUT_OnCmd=1;
			pvPut(T1_M2_LimSwitch_OUT_OnCmd);
			T1_M3_LimSwitch_OUT_OnCmd=1;
			pvPut(T1_M3_LimSwitch_OUT_OnCmd);
			T2_M1_LimSwitch_IN_OnCmd=1;
			pvPut(T2_M1_LimSwitch_IN_OnCmd);
			T2_M2_LimSwitch_IN_OnCmd=1;
			pvPut(T2_M2_LimSwitch_IN_OnCmd);
			T2_M3_LimSwitch_IN_OnCmd=1;
			pvPut(T2_M3_LimSwitch_IN_OnCmd);
			T2_M1_LimSwitch_OUT_OnCmd=1;
			pvPut(T2_M1_LimSwitch_OUT_OnCmd);
			T2_M2_LimSwitch_OUT_OnCmd=1;
			pvPut(T2_M2_LimSwitch_OUT_OnCmd);
			T2_M3_LimSwitch_OUT_OnCmd=1;
			pvPut(T2_M3_LimSwitch_OUT_OnCmd);
			T3_M1_LimSwitch_IN_OnCmd=1;
			pvPut(T3_M1_LimSwitch_IN_OnCmd);
			T3_M2_LimSwitch_IN_OnCmd=1;
			pvPut(T3_M2_LimSwitch_IN_OnCmd);
			T3_M3_LimSwitch_IN_OnCmd=1;
			pvPut(T3_M3_LimSwitch_IN_OnCmd);
			T3_M1_LimSwitch_OUT_OnCmd=1;
			pvPut(T3_M1_LimSwitch_OUT_OnCmd);
			T3_M2_LimSwitch_OUT_OnCmd=1;
			pvPut(T3_M2_LimSwitch_OUT_OnCmd);
			T3_M3_LimSwitch_OUT_OnCmd=1;
			pvPut(T3_M3_LimSwitch_OUT_OnCmd);
			T4_M1_LimSwitch_IN_OnCmd=1;
			pvPut(T4_M1_LimSwitch_IN_OnCmd);
			T4_M2_LimSwitch_IN_OnCmd=1;
			pvPut(T4_M2_LimSwitch_IN_OnCmd);
			T4_M3_LimSwitch_IN_OnCmd=1;
			pvPut(T4_M3_LimSwitch_IN_OnCmd);
			T4_M1_LimSwitch_OUT_OnCmd=1;
			pvPut(T4_M1_LimSwitch_OUT_OnCmd);
			T4_M2_LimSwitch_OUT_OnCmd=1;
			pvPut(T4_M2_LimSwitch_OUT_OnCmd);
			T4_M3_LimSwitch_OUT_OnCmd=1;
			pvPut(T4_M3_LimSwitch_OUT_OnCmd);
			T5_M1_LimSwitch_IN_OnCmd=1;
			pvPut(T5_M1_LimSwitch_IN_OnCmd);
			T5_M2_LimSwitch_IN_OnCmd=1;
			pvPut(T5_M2_LimSwitch_IN_OnCmd);
			T5_M3_LimSwitch_IN_OnCmd=1;
			pvPut(T5_M3_LimSwitch_IN_OnCmd);
			T5_M1_LimSwitch_OUT_OnCmd=1;
			pvPut(T5_M1_LimSwitch_OUT_OnCmd);
			T5_M2_LimSwitch_OUT_OnCmd=1;
			pvPut(T5_M2_LimSwitch_OUT_OnCmd);
			T5_M3_LimSwitch_OUT_OnCmd=1;
			pvPut(T5_M3_LimSwitch_OUT_OnCmd);

			/* Reset Error Motor */
			T1_M1_Axis_ErrorReset=1;
			pvPut(T1_M1_Axis_ErrorReset);
			T1_M2_Axis_ErrorReset=1;
			pvPut(T1_M2_Axis_ErrorReset);
			T1_M3_Axis_ErrorReset=1;
			pvPut(T1_M3_Axis_ErrorReset);
			T2_M1_Axis_ErrorReset=1;
			pvPut(T2_M1_Axis_ErrorReset);
			T2_M2_Axis_ErrorReset=1;
			pvPut(T2_M2_Axis_ErrorReset);
			T2_M3_Axis_ErrorReset=1;
			pvPut(T2_M3_Axis_ErrorReset);
			T3_M1_Axis_ErrorReset=1;
			pvPut(T3_M1_Axis_ErrorReset);
			T3_M2_Axis_ErrorReset=1;
			pvPut(T3_M2_Axis_ErrorReset);
			T3_M3_Axis_ErrorReset=1;
			pvPut(T3_M3_Axis_ErrorReset);
			T4_M1_Axis_ErrorReset=1;
			pvPut(T4_M1_Axis_ErrorReset);
			T4_M2_Axis_ErrorReset=1;
			pvPut(T4_M2_Axis_ErrorReset);
			T4_M3_Axis_ErrorReset=1;
			pvPut(T4_M3_Axis_ErrorReset);
			T5_M1_Axis_ErrorReset=1;
			pvPut(T5_M1_Axis_ErrorReset);
			T5_M2_Axis_ErrorReset=1;
			pvPut(T5_M2_Axis_ErrorReset);
			T5_M3_Axis_ErrorReset=1;
			pvPut(T5_M3_Axis_ErrorReset);

      /* Set Correct Motor Direction */
      T1_M1_Axis__Direction=0;
			pvPut(T1_M1_Axis__Direction);
			T1_M2_Axis__Direction=0;
			pvPut(T1_M2_Axis__Direction);
			T1_M3_Axis__Direction=0;
			pvPut(T1_M3_Axis__Direction);
			T2_M1_Axis__Direction=0;
			pvPut(T2_M1_Axis__Direction);
			T2_M2_Axis__Direction=0;
			pvPut(T2_M2_Axis__Direction);
			T2_M3_Axis__Direction=0;
			pvPut(T2_M3_Axis__Direction);
			T3_M1_Axis__Direction=0;
			pvPut(T3_M1_Axis__Direction);
			T3_M2_Axis__Direction=0;
			pvPut(T3_M2_Axis__Direction);
			T3_M3_Axis__Direction=0;
			pvPut(T3_M3_Axis__Direction);
			T4_M1_Axis__Direction=0;
			pvPut(T4_M1_Axis__Direction);
			T4_M2_Axis__Direction=0;
			pvPut(T4_M2_Axis__Direction);
			T4_M3_Axis__Direction=0;
			pvPut(T4_M3_Axis__Direction);
			T5_M1_Axis__Direction=0;
			pvPut(T5_M1_Axis__Direction);
			T5_M2_Axis__Direction=0;
			pvPut(T5_M2_Axis__Direction);
			T5_M3_Axis__Direction=0;
			pvPut(T5_M3_Axis__Direction);

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
		when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T1_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T1_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: temperature module problem in one or more lines \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

		} state failure

    /* Error in limit switches: Load */
		when ( (T1_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T1_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T1_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M3_LimSwitch_OUT_LoadAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: load problem in one or more lines \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

		} state failure

    /* Error in limit switches: Over Current */
		when ( (T1_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T1_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T1_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: over current problem in one or more lines \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in limit switches: Short Circuit */
		when ( (T1_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T1_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T1_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: short circuit problem in one or more lines \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in limit switches: NC or NO line closed for each tuner system */
		when ( ( (T1_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T1_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T1_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M3_LimSwitch_IN_NO_LimStat == 1 ) )  ) {
      printf("[SEQ TUNERS] Error in limit switches: one or more lines not proper connected (NC or NO) \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: module is offline */
		when ( (T1_M1_LinEnc_Online == 0) || (T1_M2_LinEnc_Online == 0) || (T1_M3_LinEnc_Online == 0) || (T2_M1_LinEnc_Online == 0) || (T2_M2_LinEnc_Online == 0) || (T2_M3_LinEnc_Online == 0) || (T3_M1_LinEnc_Online == 0) || (T3_M2_LinEnc_Online == 0) || (T3_M3_LinEnc_Online == 0) || (T4_M1_LinEnc_Online == 0) || (T4_M2_LinEnc_Online == 0) || (T4_M3_LinEnc_Online == 0) || (T5_M1_LinEnc_Online == 0) || (T5_M2_LinEnc_Online == 0) || (T5_M3_LinEnc_Online == 0) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more modules are not online \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: error alarm */
		when ( (T1_M1_LinEnc_ErrorAlrm == 1) || (T1_M2_LinEnc_ErrorAlrm == 1) || (T1_M3_LinEnc_ErrorAlrm == 1) || (T2_M1_LinEnc_ErrorAlrm == 1) || (T2_M2_LinEnc_ErrorAlrm == 1) || (T2_M3_LinEnc_ErrorAlrm == 1) || (T3_M1_LinEnc_ErrorAlrm == 1) || (T3_M2_LinEnc_ErrorAlrm == 1) || (T3_M3_LinEnc_ErrorAlrm == 1) || (T4_M1_LinEnc_ErrorAlrm == 1) || (T4_M2_LinEnc_ErrorAlrm == 1) || (T4_M3_LinEnc_ErrorAlrm == 1) || (T5_M1_LinEnc_ErrorAlrm == 1) || (T5_M2_LinEnc_ErrorAlrm == 1) || (T5_M3_LinEnc_ErrorAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more modules are in error \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: low limit alarm */
		when ( (T1_M1_LinEnc_LLim-Alrm == 1) || (T1_M2_LinEnc_LLim-Alrm == 1) || (T1_M3_LinEnc_LLim-Alrm == 1) || (T2_M1_LinEnc_LLim-Alrm == 1) || (T2_M2_LinEnc_LLim-Alrm == 1) || (T2_M3_LinEnc_LLim-Alrm == 1) || (T3_M1_LinEnc_LLim-Alrm == 1) || (T3_M2_LinEnc_LLim-Alrm == 1) || (T3_M3_LinEnc_LLim-Alrm == 1) || (T4_M1_LinEnc_LLim-Alrm == 1) || (T4_M2_LinEnc_LLim-Alrm == 1) || (T4_M3_LinEnc_LLim-Alrm == 1) || (T5_M1_LinEnc_LLim-Alrm == 1) || (T5_M2_LinEnc_LLim-Alrm == 1) || (T5_M3_LinEnc_LLim-Alrm == 1) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more lines are below HW low limit \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in linear encoders: high limit alarm */
		when ( (T1_M1_LinEnc_HLim-Alrm == 1) || (T1_M2_LinEnc_HLim-Alrm == 1) || (T1_M3_LinEnc_HLim-Alrm == 1) || (T2_M1_LinEnc_HLim-Alrm == 1) || (T2_M2_LinEnc_HLim-Alrm == 1) || (T2_M3_LinEnc_HLim-Alrm == 1) || (T3_M1_LinEnc_HLim-Alrm == 1) || (T3_M2_LinEnc_HLim-Alrm == 1) || (T3_M3_LinEnc_HLim-Alrm == 1) || (T4_M1_LinEnc_HLim-Alrm == 1) || (T4_M2_LinEnc_HLim-Alrm == 1) || (T4_M3_LinEnc_HLim-Alrm == 1) || (T5_M1_LinEnc_HLim-Alrm == 1) || (T5_M2_LinEnc_HLim-Alrm == 1) || (T5_M3_LinEnc_HLim-Alrm == 1) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more lines are above HW high limit \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motors */
		when ( (T1_M1_Axis_Error == 1) || (T1_M2_Axis_Error == 1) || (T1_M3_Axis_Error == 1) || (T2_M1_Axis_Error == 1) || (T2_M2_Axis_Error == 1) || (T2_M3_Axis_Error == 1) || (T3_M1_Axis_Error == 1) || (T3_M2_Axis_Error == 1) || (T3_M3_Axis_Error == 1) || (T4_M1_Axis_Error == 1) || (T4_M2_Axis_Error == 1) || (T4_M3_Axis_Error == 1) || (T5_M1_Axis_Error == 1) || (T5_M2_Axis_Error == 1) || (T5_M3_Axis_Error == 1) ) {
      printf("[SEQ TUNERS] Error in tuners axes: one or more motors are in error \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module not online */
		when ( (T1_M1_Driver_Online == 0) || (T1_M2_Driver_Online == 0) || (T1_M3_Driver_Online == 0) || (T2_M1_Driver_Online == 0) || (T2_M2_Driver_Online == 0) || (T2_M3_Driver_Online == 0) || (T3_M1_Driver_Online == 0) || (T3_M2_Driver_Online == 0) || (T3_M3_Driver_Online == 0) || (T4_M1_Driver_Online == 0) || (T4_M2_Driver_Online == 0) || (T4_M3_Driver_Online == 0) || (T5_M1_Driver_Online == 0) || (T5_M2_Driver_Online == 0) || (T5_M3_Driver_Online == 0) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are not online \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module warning alarm */
		when ( (T1_M1_Driver_WarningAlrm == 1) || (T1_M2_Driver_WarningAlrm == 1) || (T1_M3_Driver_WarningAlrm == 1) || (T2_M1_Driver_WarningAlrm == 1) || (T2_M2_Driver_WarningAlrm == 1) || (T2_M3_Driver_WarningAlrm == 1) || (T3_M1_Driver_WarningAlrm == 1) || (T3_M2_Driver_WarningAlrm == 1) || (T3_M3_Driver_WarningAlrm == 1) || (T4_M1_Driver_WarningAlrm == 1) || (T4_M2_Driver_WarningAlrm == 1) || (T4_M3_Driver_WarningAlrm == 1) || (T5_M1_Driver_WarningAlrm == 1) || (T5_M2_Driver_WarningAlrm == 1) || (T5_M3_Driver_WarningAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in warning status \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module error alarm */
		when ( (T1_M1_Driver_ErrorAlrm == 1) || (T1_M2_Driver_ErrorAlrm == 1) || (T1_M3_Driver_ErrorAlrm == 1) || (T2_M1_Driver_ErrorAlrm == 1) || (T2_M2_Driver_ErrorAlrm == 1) || (T2_M3_Driver_ErrorAlrm == 1) || (T3_M1_Driver_ErrorAlrm == 1) || (T3_M2_Driver_ErrorAlrm == 1) || (T3_M3_Driver_ErrorAlrm == 1) || (T4_M1_Driver_ErrorAlrm == 1) || (T4_M2_Driver_ErrorAlrm == 1) || (T4_M3_Driver_ErrorAlrm == 1) || (T5_M1_Driver_ErrorAlrm == 1) || (T5_M2_Driver_ErrorAlrm == 1) || (T5_M3_Driver_ErrorAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in error status \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module stall alarm */
		when ( (T1_M1_Driver_StallAlrm == 1) || (T1_M2_Driver_StallAlrm == 1) || (T1_M3_Driver_StallAlrm == 1) || (T2_M1_Driver_StallAlrm == 1) || (T2_M2_Driver_StallAlrm == 1) || (T2_M3_Driver_StallAlrm == 1) || (T3_M1_Driver_StallAlrm == 1) || (T3_M2_Driver_StallAlrm == 1) || (T3_M3_Driver_StallAlrm == 1) || (T4_M1_Driver_StallAlrm == 1) || (T4_M2_Driver_StallAlrm == 1) || (T4_M3_Driver_StallAlrm == 1) || (T5_M1_Driver_StallAlrm == 1) || (T5_M2_Driver_StallAlrm == 1) || (T5_M3_Driver_StallAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in stall status \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure

    /* Error in motor driver: module synchronization alarm */
    when ( (T1_M1_Driver_SyncAlrm == 1) || (T1_M2_Driver_SyncAlrm == 1) || (T1_M3_Driver_SyncAlrm == 1) || (T2_M1_Driver_SyncAlrm == 1) || (T2_M2_Driver_SyncAlrm == 1) || (T2_M3_Driver_SyncAlrm == 1) || (T3_M1_Driver_SyncAlrm == 1) || (T3_M2_Driver_SyncAlrm == 1) || (T3_M3_Driver_SyncAlrm == 1) || (T4_M1_Driver_SyncAlrm == 1) || (T4_M2_Driver_SyncAlrm == 1) || (T4_M3_Driver_SyncAlrm == 1) || (T5_M1_Driver_SyncAlrm == 1) || (T5_M2_Driver_SyncAlrm == 1) || (T5_M3_Driver_SyncAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in synchronization error status \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

    } state failure


    /* no error in any line */
    when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T2_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T2_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T2_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T3_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T3_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T3_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T4_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T4_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T4_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T5_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T5_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T5_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T1_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T1_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T2_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T2_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T2_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T3_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T3_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T3_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T4_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T4_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T4_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T5_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T5_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T5_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T2_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T2_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T2_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T3_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T3_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T3_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T4_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T4_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T4_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T5_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T5_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T5_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T2_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T2_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T2_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T3_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T3_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T3_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T4_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T4_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T4_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T5_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T5_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T5_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T2_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T2_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T2_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T3_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T3_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T3_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T4_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T4_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T4_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T5_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T5_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T5_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T2_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T2_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T2_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T3_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T3_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T3_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T4_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T4_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T4_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T5_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T5_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T5_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T1_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T1_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T2_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T2_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T2_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T3_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T3_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T3_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T4_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T4_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T4_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T5_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T5_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T5_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T1_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T1_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T1_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T2_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T2_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T2_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T3_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T3_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T3_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T4_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T4_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T4_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T5_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T5_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T5_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) &&  ( (T1_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T1_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T2_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T2_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T2_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T2_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T2_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T2_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T3_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T3_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T3_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T3_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T3_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T3_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T4_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T4_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T4_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T4_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T4_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T4_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T5_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T5_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T5_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T5_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T5_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T5_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && (T1_M1_LinEnc_ErrorAlrm == 0) && (T1_M2_LinEnc_ErrorAlrm == 0) && (T1_M3_LinEnc_ErrorAlrm == 0) && (T2_M1_LinEnc_ErrorAlrm == 0) && (T2_M2_LinEnc_ErrorAlrm == 0) && (T2_M3_LinEnc_ErrorAlrm == 0) && (T3_M1_LinEnc_ErrorAlrm == 0) && (T3_M2_LinEnc_ErrorAlrm == 0) && (T3_M3_LinEnc_ErrorAlrm == 0) && (T4_M1_LinEnc_ErrorAlrm == 0) && (T4_M2_LinEnc_ErrorAlrm == 0) && (T4_M3_LinEnc_ErrorAlrm == 0) && (T5_M1_LinEnc_ErrorAlrm == 0) && (T5_M2_LinEnc_ErrorAlrm == 0) && (T5_M3_LinEnc_ErrorAlrm == 0) && (T1_M1_Axis_Error == 0) && (T1_M2_Axis_Error == 0) && (T1_M3_Axis_Error == 0) && (T2_M1_Axis_Error == 0) && (T2_M2_Axis_Error == 0) && (T2_M3_Axis_Error == 0) && (T3_M1_Axis_Error == 0) && (T3_M2_Axis_Error == 0) && (T3_M3_Axis_Error == 0) && (T4_M1_Axis_Error == 0) && (T4_M2_Axis_Error == 0) && (T4_M3_Axis_Error == 0) && (T5_M1_Axis_Error == 0) && (T5_M2_Axis_Error == 0) && (T5_M3_Axis_Error == 0) && (T1_M1_Driver_WarningAlrm == 0) && (T1_M2_Driver_WarningAlrm == 0) && (T1_M3_Driver_WarningAlrm == 0) && (T2_M1_Driver_WarningAlrm == 0) && (T2_M2_Driver_WarningAlrm == 0) && (T2_M3_Driver_WarningAlrm == 0) && (T3_M1_Driver_WarningAlrm == 0) && (T3_M2_Driver_WarningAlrm == 0) && (T3_M3_Driver_WarningAlrm == 0) && (T4_M1_Driver_WarningAlrm == 0) && (T4_M2_Driver_WarningAlrm == 0) && (T4_M3_Driver_WarningAlrm == 0) && (T5_M1_Driver_WarningAlrm == 0) && (T5_M2_Driver_WarningAlrm == 0) && (T5_M3_Driver_WarningAlrm == 0) && (T1_M1_Driver_ErrorAlrm == 0) && (T1_M2_Driver_ErrorAlrm == 0) && (T1_M3_Driver_ErrorAlrm == 0) && (T2_M1_Driver_ErrorAlrm == 0) && (T2_M2_Driver_ErrorAlrm == 0) && (T2_M3_Driver_ErrorAlrm == 0) && (T3_M1_Driver_ErrorAlrm == 0) && (T3_M2_Driver_ErrorAlrm == 0) && (T3_M3_Driver_ErrorAlrm == 0) && (T4_M1_Driver_ErrorAlrm == 0) && (T4_M2_Driver_ErrorAlrm == 0) && (T4_M3_Driver_ErrorAlrm == 0) && (T5_M1_Driver_ErrorAlrm == 0) && (T5_M2_Driver_ErrorAlrm == 0) && (T5_M3_Driver_ErrorAlrm == 0) && (T1_M1_Driver_StallAlrm == 0) && (T1_M2_Driver_StallAlrm == 0) && (T1_M3_Driver_StallAlrm == 0) && (T2_M1_Driver_StallAlrm == 0) && (T2_M2_Driver_StallAlrm == 0) && (T2_M3_Driver_StallAlrm == 0) && (T3_M1_Driver_StallAlrm == 0) && (T3_M2_Driver_StallAlrm == 0) && (T3_M3_Driver_StallAlrm == 0) && (T4_M1_Driver_StallAlrm == 0) && (T4_M2_Driver_StallAlrm == 0) && (T4_M3_Driver_StallAlrm == 0) && (T5_M1_Driver_StallAlrm == 0) && (T5_M2_Driver_StallAlrm == 0) && (T5_M3_Driver_StallAlrm == 0) && (T1_M1_Driver_SyncAlrm == 0) && (T1_M2_Driver_SyncAlrm == 0) && (T1_M3_Driver_SyncAlrm == 0) && (T2_M1_Driver_SyncAlrm == 0) && (T2_M2_Driver_SyncAlrm == 0) && (T2_M3_Driver_SyncAlrm == 0) && (T3_M1_Driver_SyncAlrm == 0) && (T3_M2_Driver_SyncAlrm == 0) && (T3_M3_Driver_SyncAlrm == 0) && (T4_M1_Driver_SyncAlrm == 0) && (T4_M2_Driver_SyncAlrm == 0) && (T4_M3_Driver_SyncAlrm == 0) && (T5_M1_Driver_SyncAlrm == 0) && (T5_M2_Driver_SyncAlrm == 0) && (T5_M3_Driver_SyncAlrm == 0)  ) {

      printf("[SEQ TUNERS] Self Check Passed. \n");
      printf("[SEQ TUNERS] System set homing position (tuners extracted) \n");
      /* Enable tuners drivers */
			T1_M1_Axis_Enable=1;
			pvPut(T1_M1_Axis_Enable);
			T1_M2_Axis_Enable=1;
			pvPut(T1_M2_Axis_Enable);
			T1_M3_Axis_Enable=1;
			pvPut(T1_M3_Axis_Enable);
			T2_M1_Axis_Enable=1;
			pvPut(T2_M1_Axis_Enable);
			T2_M2_Axis_Enable=1;
			pvPut(T2_M2_Axis_Enable);
			T2_M3_Axis_Enable=1;
			pvPut(T2_M3_Axis_Enable);
			T3_M1_Axis_Enable=1;
			pvPut(T3_M1_Axis_Enable);
			T3_M2_Axis_Enable=1;
			pvPut(T3_M2_Axis_Enable);
			T3_M3_Axis_Enable=1;
			pvPut(T3_M3_Axis_Enable);
			T4_M1_Axis_Enable=1;
			pvPut(T4_M1_Axis_Enable);
			T4_M2_Axis_Enable=1;
			pvPut(T4_M2_Axis_Enable);
			T4_M3_Axis_Enable=1;
			pvPut(T4_M3_Axis_Enable);
			T5_M1_Axis_Enable=1;
			pvPut(T5_M1_Axis_Enable);
			T5_M2_Axis_Enable=1;
			pvPut(T5_M2_Axis_Enable);
			T5_M3_Axis_Enable=1;
			pvPut(T5_M3_Axis_Enable);

    } state start_up

  }


/* state STARTUP	*/
state start_up {
  entry {
    printf("\n[SEQ TUNERS] Enter in START UP status\n");
    StateMachineCode=30;
    pvPut(StateMachineCode);

    /* Tuners in home position (0 mm) */
    T1_M1_Axis_Position=0;
    pvPut(T1_M1_Axis_Position);
    T1_M2_Axis_Position=0;
    pvPut(T1_M2_Axis_Position);
    T1_M3_Axis_Position=0;
    pvPut(T1_M3_Axis_Position);
    T2_M1_Axis_Position=0;
    pvPut(T2_M1_Axis_Position);
    T2_M2_Axis_Position=0;
    pvPut(T2_M2_Axis_Position);
    T2_M3_Axis_Position=0;
    pvPut(T2_M3_Axis_Position);
    T3_M1_Axis_Position=0;
    pvPut(T3_M1_Axis_Position);
    T3_M2_Axis_Position=0;
    pvPut(T3_M2_Axis_Position);
    T3_M3_Axis_Position=0;
    pvPut(T3_M3_Axis_Position);
    T4_M1_Axis_Position=0;
    pvPut(T4_M1_Axis_Position);
    T4_M2_Axis_Position=0;
    pvPut(T4_M2_Axis_Position);
    T4_M3_Axis_Position=0;
    pvPut(T4_M3_Axis_Position);
    T5_M1_Axis_Position=0;
    pvPut(T5_M1_Axis_Position);
    T5_M2_Axis_Position=0;
    pvPut(T5_M2_Axis_Position);
    T5_M3_Axis_Position=0;
    pvPut(T5_M3_Axis_Position);
  }

  /* Error in limit switches: Temperature */
  when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T1_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T1_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) ) {
    printf("[SEQ TUNERS] Error in limit switches: temperature module problem in one or more lines \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Load */
  when ( (T1_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T1_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T1_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M3_LimSwitch_OUT_LoadAlarm == 1 ) ) {
    printf("[SEQ TUNERS] Error in limit switches: load problem in one or more lines \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Over Current */
  when ( (T1_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T1_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T1_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) ) {
    printf("[SEQ TUNERS] Error in limit switches: over current problem in one or more lines \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Short Circuit */
  when ( (T1_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T1_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T1_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) ) {
    printf("[SEQ TUNERS] Error in limit switches: short circuit problem in one or more lines \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: NC or NO line closed for each tuner system */
  when ( ( (T1_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T1_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T1_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M3_LimSwitch_IN_NO_LimStat == 1 ) )  ) {
    printf("[SEQ TUNERS] Error in limit switches: one or more lines not proper connected (NC or NO) \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: module is offline */
  when ( (T1_M1_LinEnc_Online == 0) || (T1_M2_LinEnc_Online == 0) || (T1_M3_LinEnc_Online == 0) || (T2_M1_LinEnc_Online == 0) || (T2_M2_LinEnc_Online == 0) || (T2_M3_LinEnc_Online == 0) || (T3_M1_LinEnc_Online == 0) || (T3_M2_LinEnc_Online == 0) || (T3_M3_LinEnc_Online == 0) || (T4_M1_LinEnc_Online == 0) || (T4_M2_LinEnc_Online == 0) || (T4_M3_LinEnc_Online == 0) || (T5_M1_LinEnc_Online == 0) || (T5_M2_LinEnc_Online == 0) || (T5_M3_LinEnc_Online == 0) ) {
    printf("[SEQ TUNERS] Error in linear encoders: one or more modules are not online \n");
    printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: error alarm */
  when ( (T1_M1_LinEnc_ErrorAlrm == 1) || (T1_M2_LinEnc_ErrorAlrm == 1) || (T1_M3_LinEnc_ErrorAlrm == 1) || (T2_M1_LinEnc_ErrorAlrm == 1) || (T2_M2_LinEnc_ErrorAlrm == 1) || (T2_M3_LinEnc_ErrorAlrm == 1) || (T3_M1_LinEnc_ErrorAlrm == 1) || (T3_M2_LinEnc_ErrorAlrm == 1) || (T3_M3_LinEnc_ErrorAlrm == 1) || (T4_M1_LinEnc_ErrorAlrm == 1) || (T4_M2_LinEnc_ErrorAlrm == 1) || (T4_M3_LinEnc_ErrorAlrm == 1) || (T5_M1_LinEnc_ErrorAlrm == 1) || (T5_M2_LinEnc_ErrorAlrm == 1) || (T5_M3_LinEnc_ErrorAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in linear encoders: one or more modules are in error \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: low limit alarm */
  when ( (T1_M1_LinEnc_LLim-Alrm == 1) || (T1_M2_LinEnc_LLim-Alrm == 1) || (T1_M3_LinEnc_LLim-Alrm == 1) || (T2_M1_LinEnc_LLim-Alrm == 1) || (T2_M2_LinEnc_LLim-Alrm == 1) || (T2_M3_LinEnc_LLim-Alrm == 1) || (T3_M1_LinEnc_LLim-Alrm == 1) || (T3_M2_LinEnc_LLim-Alrm == 1) || (T3_M3_LinEnc_LLim-Alrm == 1) || (T4_M1_LinEnc_LLim-Alrm == 1) || (T4_M2_LinEnc_LLim-Alrm == 1) || (T4_M3_LinEnc_LLim-Alrm == 1) || (T5_M1_LinEnc_LLim-Alrm == 1) || (T5_M2_LinEnc_LLim-Alrm == 1) || (T5_M3_LinEnc_LLim-Alrm == 1) ) {
    printf("[SEQ TUNERS] Error in linear encoders: one or more lines are below HW low limit \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: high limit alarm */
  when ( (T1_M1_LinEnc_HLim-Alrm == 1) || (T1_M2_LinEnc_HLim-Alrm == 1) || (T1_M3_LinEnc_HLim-Alrm == 1) || (T2_M1_LinEnc_HLim-Alrm == 1) || (T2_M2_LinEnc_HLim-Alrm == 1) || (T2_M3_LinEnc_HLim-Alrm == 1) || (T3_M1_LinEnc_HLim-Alrm == 1) || (T3_M2_LinEnc_HLim-Alrm == 1) || (T3_M3_LinEnc_HLim-Alrm == 1) || (T4_M1_LinEnc_HLim-Alrm == 1) || (T4_M2_LinEnc_HLim-Alrm == 1) || (T4_M3_LinEnc_HLim-Alrm == 1) || (T5_M1_LinEnc_HLim-Alrm == 1) || (T5_M2_LinEnc_HLim-Alrm == 1) || (T5_M3_LinEnc_HLim-Alrm == 1) ) {
    printf("[SEQ TUNERS] Error in linear encoders: one or more lines are above HW high limit \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motors */
  when ( (T1_M1_Axis_Error == 1) || (T1_M2_Axis_Error == 1) || (T1_M3_Axis_Error == 1) || (T2_M1_Axis_Error == 1) || (T2_M2_Axis_Error == 1) || (T2_M3_Axis_Error == 1) || (T3_M1_Axis_Error == 1) || (T3_M2_Axis_Error == 1) || (T3_M3_Axis_Error == 1) || (T4_M1_Axis_Error == 1) || (T4_M2_Axis_Error == 1) || (T4_M3_Axis_Error == 1) || (T5_M1_Axis_Error == 1) || (T5_M2_Axis_Error == 1) || (T5_M3_Axis_Error == 1) ) {
    printf("[SEQ TUNERS] Error in tuners axes: one or more motors are in error \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module not online */
  when ( (T1_M1_Driver_Online == 0) || (T1_M2_Driver_Online == 0) || (T1_M3_Driver_Online == 0) || (T2_M1_Driver_Online == 0) || (T2_M2_Driver_Online == 0) || (T2_M3_Driver_Online == 0) || (T3_M1_Driver_Online == 0) || (T3_M2_Driver_Online == 0) || (T3_M3_Driver_Online == 0) || (T4_M1_Driver_Online == 0) || (T4_M2_Driver_Online == 0) || (T4_M3_Driver_Online == 0) || (T5_M1_Driver_Online == 0) || (T5_M2_Driver_Online == 0) || (T5_M3_Driver_Online == 0) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are not online \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module warning alarm */
  when ( (T1_M1_Driver_WarningAlrm == 1) || (T1_M2_Driver_WarningAlrm == 1) || (T1_M3_Driver_WarningAlrm == 1) || (T2_M1_Driver_WarningAlrm == 1) || (T2_M2_Driver_WarningAlrm == 1) || (T2_M3_Driver_WarningAlrm == 1) || (T3_M1_Driver_WarningAlrm == 1) || (T3_M2_Driver_WarningAlrm == 1) || (T3_M3_Driver_WarningAlrm == 1) || (T4_M1_Driver_WarningAlrm == 1) || (T4_M2_Driver_WarningAlrm == 1) || (T4_M3_Driver_WarningAlrm == 1) || (T5_M1_Driver_WarningAlrm == 1) || (T5_M2_Driver_WarningAlrm == 1) || (T5_M3_Driver_WarningAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in warning status \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module error alarm */
  when ( (T1_M1_Driver_ErrorAlrm == 1) || (T1_M2_Driver_ErrorAlrm == 1) || (T1_M3_Driver_ErrorAlrm == 1) || (T2_M1_Driver_ErrorAlrm == 1) || (T2_M2_Driver_ErrorAlrm == 1) || (T2_M3_Driver_ErrorAlrm == 1) || (T3_M1_Driver_ErrorAlrm == 1) || (T3_M2_Driver_ErrorAlrm == 1) || (T3_M3_Driver_ErrorAlrm == 1) || (T4_M1_Driver_ErrorAlrm == 1) || (T4_M2_Driver_ErrorAlrm == 1) || (T4_M3_Driver_ErrorAlrm == 1) || (T5_M1_Driver_ErrorAlrm == 1) || (T5_M2_Driver_ErrorAlrm == 1) || (T5_M3_Driver_ErrorAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in error status \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module stall alarm */
  when ( (T1_M1_Driver_StallAlrm == 1) || (T1_M2_Driver_StallAlrm == 1) || (T1_M3_Driver_StallAlrm == 1) || (T2_M1_Driver_StallAlrm == 1) || (T2_M2_Driver_StallAlrm == 1) || (T2_M3_Driver_StallAlrm == 1) || (T3_M1_Driver_StallAlrm == 1) || (T3_M2_Driver_StallAlrm == 1) || (T3_M3_Driver_StallAlrm == 1) || (T4_M1_Driver_StallAlrm == 1) || (T4_M2_Driver_StallAlrm == 1) || (T4_M3_Driver_StallAlrm == 1) || (T5_M1_Driver_StallAlrm == 1) || (T5_M2_Driver_StallAlrm == 1) || (T5_M3_Driver_StallAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in stall status \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module synchronization alarm */
  when ( (T1_M1_Driver_SyncAlrm == 1) || (T1_M2_Driver_SyncAlrm == 1) || (T1_M3_Driver_SyncAlrm == 1) || (T2_M1_Driver_SyncAlrm == 1) || (T2_M2_Driver_SyncAlrm == 1) || (T2_M3_Driver_SyncAlrm == 1) || (T3_M1_Driver_SyncAlrm == 1) || (T3_M2_Driver_SyncAlrm == 1) || (T3_M3_Driver_SyncAlrm == 1) || (T4_M1_Driver_SyncAlrm == 1) || (T4_M2_Driver_SyncAlrm == 1) || (T4_M3_Driver_SyncAlrm == 1) || (T5_M1_Driver_SyncAlrm == 1) || (T5_M2_Driver_SyncAlrm == 1) || (T5_M3_Driver_SyncAlrm == 1) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in synchronization error status \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor axis: devices have MISS error with number of times > Max number accepted*/
  when ( ( (T1_M1_Axis_Missing=1) || (T1_M2_Axis_Missing=1) || (T1_M3_Axis_Missing=1) || (T2_M1_Axis_Missing=1) || (T2_M2_Axis_Missing=1) || (T2_M3_Axis_Missing=1) || (T3_M1_Axis_Missing=1) || (T3_M2_Axis_Missing=1) || (T3_M3_Axis_Missing=1) || (T4_M1_Axis_Missing=1) || (T4_M2_Axis_Missing=1) || (T4_M3_Axis_Missing=1) || (T5_M1_Axis_Missing=1) || (T5_M2_Axis_Missing=1) || (T5_M3_Axis_Missing=1) ) && (Error_Missing_Counter>Max_Missing_Counter) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in missing error status \n");
    printf("[SEQ TUNERS] System not ok for many times: go to FAILURE \n");

  } state failure

  /* Error in motor axis: devices have MISS error with number of times <= Max number accepted*/
  when ( ( (T1_M1_Axis_Missing=1) || (T1_M2_Axis_Missing=1) || (T1_M3_Axis_Missing=1) || (T2_M1_Axis_Missing=1) || (T2_M2_Axis_Missing=1) || (T2_M3_Axis_Missing=1) || (T3_M1_Axis_Missing=1) || (T3_M2_Axis_Missing=1) || (T3_M3_Axis_Missing=1) || (T4_M1_Axis_Missing=1) || (T4_M2_Axis_Missing=1) || (T4_M3_Axis_Missing=1) || (T5_M1_Axis_Missing=1) || (T5_M2_Axis_Missing=1) || (T5_M3_Axis_Missing=1) ) && (Error_Missing_Counter<=Max_Missing_Counter) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in missing error status \n");
    printf("[SEQ TUNERS] System not ok: Try to reset axis and restart procedure \n");
    /* Reset Error Motors */
    printf("[SEQ TUNERS] - Reset Errors \n");
    T1_M1_Axis_ErrorReset=1;
    pvPut(T1_M1_Axis_ErrorReset);
    T1_M2_Axis_ErrorReset=1;
    pvPut(T1_M2_Axis_ErrorReset);
    T1_M3_Axis_ErrorReset=1;
    pvPut(T1_M3_Axis_ErrorReset);
    T2_M1_Axis_ErrorReset=1;
    pvPut(T2_M1_Axis_ErrorReset);
    T2_M2_Axis_ErrorReset=1;
    pvPut(T2_M2_Axis_ErrorReset);
    T2_M3_Axis_ErrorReset=1;
    pvPut(T2_M3_Axis_ErrorReset);
    T3_M1_Axis_ErrorReset=1;
    pvPut(T3_M1_Axis_ErrorReset);
    T3_M2_Axis_ErrorReset=1;
    pvPut(T3_M2_Axis_ErrorReset);
    T3_M3_Axis_ErrorReset=1;
    pvPut(T3_M3_Axis_ErrorReset);
    T4_M1_Axis_ErrorReset=1;
    pvPut(T4_M1_Axis_ErrorReset);
    T4_M2_Axis_ErrorReset=1;
    pvPut(T4_M2_Axis_ErrorReset);
    T4_M3_Axis_ErrorReset=1;
    pvPut(T4_M3_Axis_ErrorReset);
    T5_M1_Axis_ErrorReset=1;
    pvPut(T5_M1_Axis_ErrorReset);
    T5_M2_Axis_ErrorReset=1;
    pvPut(T5_M2_Axis_ErrorReset);
    T5_M3_Axis_ErrorReset=1;
    pvPut(T5_M3_Axis_ErrorReset);
    /* Stop Motors */
    printf("[SEQ TUNERS] - Stop Motors \n");
    T1_M1_Axis_Stop=1;
    pvPut(T1_M1_Axis_Stop);
    T1_M2_Axis_Stop=1;
    pvPut(T1_M2_Axis_Stop);
    T1_M3_Axis_Stop=1;
    pvPut(T1_M3_Axis_Stop);
    T2_M1_Axis_Stop=1;
    pvPut(T2_M1_Axis_Stop);
    T2_M2_Axis_Stop=1;
    pvPut(T2_M2_Axis_Stop);
    T2_M3_Axis_Stop=1;
    pvPut(T2_M3_Axis_Stop);
    T3_M1_Axis_Stop=1;
    pvPut(T3_M1_Axis_Stop);
    T3_M2_Axis_Stop=1;
    pvPut(T3_M2_Axis_Stop);
    T3_M3_Axis_Stop=1;
    pvPut(T3_M3_Axis_Stop);
    T4_M1_Axis_Stop=1;
    pvPut(T4_M1_Axis_Stop);
    T4_M2_Axis_Stop=1;
    pvPut(T4_M2_Axis_Stop);
    T4_M3_Axis_Stop=1;
    pvPut(T4_M3_Axis_Stop);
    T5_M1_Axis_Stop=1;
    pvPut(T5_M1_Axis_Stop);
    T5_M2_Axis_Stop=1;
    pvPut(T5_M2_Axis_Stop);
    T5_M3_Axis_Stop=1;
    pvPut(T5_M3_Axis_Stop);
    /* Wait 2 seconds before next operation */
    delay(2);
    /* Enable Axis */
    printf("[SEQ TUNERS] - Re-enable Motors \n");
    T1_M1_Axis_Enable=1;
    pvPut(T1_M1_Axis_Enable);
    T1_M2_Axis_Enable=1;
    pvPut(T1_M2_Axis_Enable);
    T1_M3_Axis_Enable=1;
    pvPut(T1_M3_Axis_Enable);
    T2_M1_Axis_Enable=1;
    pvPut(T2_M1_Axis_Enable);
    T2_M2_Axis_Enable=1;
    pvPut(T2_M2_Axis_Enable);
    T2_M3_Axis_Enable=1;
    pvPut(T2_M3_Axis_Enable);
    T3_M1_Axis_Enable=1;
    pvPut(T3_M1_Axis_Enable);
    T3_M2_Axis_Enable=1;
    pvPut(T3_M2_Axis_Enable);
    T3_M3_Axis_Enable=1;
    pvPut(T3_M3_Axis_Enable);
    T4_M1_Axis_Enable=1;
    pvPut(T4_M1_Axis_Enable);
    T4_M2_Axis_Enable=1;
    pvPut(T4_M2_Axis_Enable);
    T4_M3_Axis_Enable=1;
    pvPut(T4_M3_Axis_Enable);
    T5_M1_Axis_Enable=1;
    pvPut(T5_M1_Axis_Enable);
    T5_M2_Axis_Enable=1;
    pvPut(T5_M2_Axis_Enable);
    T5_M3_Axis_Enable=1;
    pvPut(T5_M3_Axis_Enable);

    ++Error_Missing_Counter;
  } state start_up


  /* Error in motor position: devices are not in home position */
  when( ( (T1_M1_LinEnc_Position - T1_M1_Axis_Position) > Lin_Enc_Position_Res ) || ( (T1_M2_LinEnc_Position - T1_M2_Axis_Position) > Lin_Enc_Position_Res ) || ( (T1_M3_LinEnc_Position - T1_M3_Axis_Position) > Lin_Enc_Position_Res ) || (T2_M1_LinEnc_Position - T2_M1_Axis_Position) > Lin_Enc_Position_Res ) || ( (T2_M2_LinEnc_Position - T2_M2_Axis_Position) > Lin_Enc_Position_Res ) || ( (T2_M3_LinEnc_Position - T2_M3_Axis_Position) > Lin_Enc_Position_Res ) || (T3_M1_LinEnc_Position - T3_M1_Axis_Position) > Lin_Enc_Position_Res ) || ( (T3_M2_LinEnc_Position - T3_M2_Axis_Position) > Lin_Enc_Position_Res ) || ( (T3_M3_LinEnc_Position - T3_M3_Axis_Position) > Lin_Enc_Position_Res ) || (T4_M1_LinEnc_Position - T4_M1_Axis_Position) > Lin_Enc_Position_Res ) || ( (T4_M2_LinEnc_Position - T4_M2_Axis_Position) > Lin_Enc_Position_Res ) || ( (T4_M3_LinEnc_Position - T4_M3_Axis_Position) > Lin_Enc_Position_Res ) || (T5_M1_LinEnc_Position - T5_M1_Axis_Position) > Lin_Enc_Position_Res ) || ( (T5_M2_LinEnc_Position - T5_M2_Axis_Position) > Lin_Enc_Position_Res ) || ( (T5_M3_LinEnc_Position - T5_M3_Axis_Position) > Lin_Enc_Position_Res ) ) {
    printf("[SEQ TUNERS] Error in motor axis: one or more axis are not in home position \n");
    printf("[SEQ TUNERS] System not ok: retry to set home position\n");

  } state start_up


  /* no error in any line */
  when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T2_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T2_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T2_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T3_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T3_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T3_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T4_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T4_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T4_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T5_M1_LimSwitch_IN_TemperatureAlarm == 0 ) && (T5_M2_LimSwitch_IN_TemperatureAlarm == 0 ) && (T5_M3_LimSwitch_IN_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T1_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T1_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T2_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T2_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T2_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T3_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T3_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T3_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T4_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T4_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T4_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T5_M1_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T5_M2_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T5_M3_LimSwitch_OUT_TemperatureAlarm == 0 ) && (T1_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T2_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T2_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T2_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T3_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T3_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T3_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T4_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T4_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T4_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T5_M1_LimSwitch_IN_LoadAlarm == 0 ) && (T5_M2_LimSwitch_IN_LoadAlarm == 0 ) && (T5_M3_LimSwitch_IN_LoadAlarm == 0 ) && (T1_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T2_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T2_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T2_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T3_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T3_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T3_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T4_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T4_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T4_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T5_M1_LimSwitch_OUT_LoadAlarm == 0 ) && (T5_M2_LimSwitch_OUT_LoadAlarm == 0 ) && (T5_M3_LimSwitch_OUT_LoadAlarm == 0 ) && (T1_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T2_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T2_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T2_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T3_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T3_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T3_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T4_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T4_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T4_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T5_M1_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T5_M2_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T5_M3_LimSwitch_IN_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T2_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T2_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T2_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T3_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T3_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T3_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T4_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T4_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T4_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T5_M1_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T5_M2_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T5_M3_LimSwitch_OUT_OverCurrentAlarm == 0 ) && (T1_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T1_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T1_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T2_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T2_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T2_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T3_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T3_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T3_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T4_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T4_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T4_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T5_M1_LimSwitch_IN_ShortCircAlarm == 0 ) && (T5_M2_LimSwitch_IN_ShortCircAlarm == 0 ) && (T5_M3_LimSwitch_IN_ShortCircAlarm == 0 ) && (T1_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T1_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T1_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T2_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T2_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T2_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T3_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T3_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T3_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T4_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T4_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T4_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T5_M1_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T5_M2_LimSwitch_OUT_ShortCircAlarm == 0 ) && (T5_M3_LimSwitch_OUT_ShortCircAlarm == 0 ) && ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) &&  ( (T1_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T1_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T1_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T2_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T2_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T2_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T2_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T2_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T2_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T3_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T3_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T3_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T3_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T3_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T3_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T4_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T4_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T4_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T4_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T4_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T4_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T5_M1_LimSwitch_IN_NC_LimStat == 1 ) || (T5_M1_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T5_M2_LimSwitch_IN_NC_LimStat == 1 ) || (T5_M2_LimSwitch_IN_NO_LimStat == 1 ) ) && ( (T5_M3_LimSwitch_IN_NC_LimStat == 1 ) || (T5_M3_LimSwitch_IN_NO_LimStat == 1 ) ) && (T1_M1_LinEnc_ErrorAlrm == 0) && (T1_M2_LinEnc_ErrorAlrm == 0) && (T1_M3_LinEnc_ErrorAlrm == 0) && (T2_M1_LinEnc_ErrorAlrm == 0) && (T2_M2_LinEnc_ErrorAlrm == 0) && (T2_M3_LinEnc_ErrorAlrm == 0) && (T3_M1_LinEnc_ErrorAlrm == 0) && (T3_M2_LinEnc_ErrorAlrm == 0) && (T3_M3_LinEnc_ErrorAlrm == 0) && (T4_M1_LinEnc_ErrorAlrm == 0) && (T4_M2_LinEnc_ErrorAlrm == 0) && (T4_M3_LinEnc_ErrorAlrm == 0) && (T5_M1_LinEnc_ErrorAlrm == 0) && (T5_M2_LinEnc_ErrorAlrm == 0) && (T5_M3_LinEnc_ErrorAlrm == 0) && (T1_M1_Axis_Error == 0) && (T1_M2_Axis_Error == 0) && (T1_M3_Axis_Error == 0) && (T2_M1_Axis_Error == 0) && (T2_M2_Axis_Error == 0) && (T2_M3_Axis_Error == 0) && (T3_M1_Axis_Error == 0) && (T3_M2_Axis_Error == 0) && (T3_M3_Axis_Error == 0) && (T4_M1_Axis_Error == 0) && (T4_M2_Axis_Error == 0) && (T4_M3_Axis_Error == 0) && (T5_M1_Axis_Error == 0) && (T5_M2_Axis_Error == 0) && (T5_M3_Axis_Error == 0) && (T1_M1_Driver_WarningAlrm == 0) && (T1_M2_Driver_WarningAlrm == 0) && (T1_M3_Driver_WarningAlrm == 0) && (T2_M1_Driver_WarningAlrm == 0) && (T2_M2_Driver_WarningAlrm == 0) && (T2_M3_Driver_WarningAlrm == 0) && (T3_M1_Driver_WarningAlrm == 0) && (T3_M2_Driver_WarningAlrm == 0) && (T3_M3_Driver_WarningAlrm == 0) && (T4_M1_Driver_WarningAlrm == 0) && (T4_M2_Driver_WarningAlrm == 0) && (T4_M3_Driver_WarningAlrm == 0) && (T5_M1_Driver_WarningAlrm == 0) && (T5_M2_Driver_WarningAlrm == 0) && (T5_M3_Driver_WarningAlrm == 0) && (T1_M1_Driver_ErrorAlrm == 0) && (T1_M2_Driver_ErrorAlrm == 0) && (T1_M3_Driver_ErrorAlrm == 0) && (T2_M1_Driver_ErrorAlrm == 0) && (T2_M2_Driver_ErrorAlrm == 0) && (T2_M3_Driver_ErrorAlrm == 0) && (T3_M1_Driver_ErrorAlrm == 0) && (T3_M2_Driver_ErrorAlrm == 0) && (T3_M3_Driver_ErrorAlrm == 0) && (T4_M1_Driver_ErrorAlrm == 0) && (T4_M2_Driver_ErrorAlrm == 0) && (T4_M3_Driver_ErrorAlrm == 0) && (T5_M1_Driver_ErrorAlrm == 0) && (T5_M2_Driver_ErrorAlrm == 0) && (T5_M3_Driver_ErrorAlrm == 0) && (T1_M1_Driver_StallAlrm == 0) && (T1_M2_Driver_StallAlrm == 0) && (T1_M3_Driver_StallAlrm == 0) && (T2_M1_Driver_StallAlrm == 0) && (T2_M2_Driver_StallAlrm == 0) && (T2_M3_Driver_StallAlrm == 0) && (T3_M1_Driver_StallAlrm == 0) && (T3_M2_Driver_StallAlrm == 0) && (T3_M3_Driver_StallAlrm == 0) && (T4_M1_Driver_StallAlrm == 0) && (T4_M2_Driver_StallAlrm == 0) && (T4_M3_Driver_StallAlrm == 0) && (T5_M1_Driver_StallAlrm == 0) && (T5_M2_Driver_StallAlrm == 0) && (T5_M3_Driver_StallAlrm == 0) && (T1_M1_Driver_SyncAlrm == 0) && (T1_M2_Driver_SyncAlrm == 0) && (T1_M3_Driver_SyncAlrm == 0) && (T2_M1_Driver_SyncAlrm == 0) && (T2_M2_Driver_SyncAlrm == 0) && (T2_M3_Driver_SyncAlrm == 0) && (T3_M1_Driver_SyncAlrm == 0) && (T3_M2_Driver_SyncAlrm == 0) && (T3_M3_Driver_SyncAlrm == 0) && (T4_M1_Driver_SyncAlrm == 0) && (T4_M2_Driver_SyncAlrm == 0) && (T4_M3_Driver_SyncAlrm == 0) && (T5_M1_Driver_SyncAlrm == 0) && (T5_M2_Driver_SyncAlrm == 0) && (T5_M3_Driver_SyncAlrm == 0)  ) {
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
  }

  /* Error in limit switches: Temperature */
  when ( (T1_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T2_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T3_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T4_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M1_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M2_LimSwitch_IN_TemperatureAlarm == 1 ) || (T5_M3_LimSwitch_IN_TemperatureAlarm == 1 ) || (T1_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T1_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T1_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T2_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T3_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T4_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M1_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M2_LimSwitch_OUT_TemperatureAlarm == 1 ) || (T5_M3_LimSwitch_OUT_TemperatureAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: temperature module problem in one or more lines \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Load */
  when ( (T1_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T2_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T3_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T4_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M1_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M2_LimSwitch_IN_LoadAlarm == 1 ) || (T5_M3_LimSwitch_IN_LoadAlarm == 1 ) || (T1_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T1_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T1_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T2_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T3_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T4_M3_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M1_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M2_LimSwitch_OUT_LoadAlarm == 1 ) || (T5_M3_LimSwitch_OUT_LoadAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: load problem in one or more lines \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Over Current */
  when ( (T1_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T2_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T3_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T4_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M1_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M2_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T5_M3_LimSwitch_IN_OverCurrentAlarm == 1 ) || (T1_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T1_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T1_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T2_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T3_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T4_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M1_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M2_LimSwitch_OUT_OverCurrentAlarm == 1 ) || (T5_M3_LimSwitch_OUT_OverCurrentAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: over current problem in one or more lines \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: Short Circuit */
  when ( (T1_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T2_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T3_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T4_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M1_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M2_LimSwitch_IN_ShortCircAlarm == 1 ) || (T5_M3_LimSwitch_IN_ShortCircAlarm == 1 ) || (T1_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T1_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T1_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T2_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T3_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T4_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M1_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M2_LimSwitch_OUT_ShortCircAlarm == 1 ) || (T5_M3_LimSwitch_OUT_ShortCircAlarm == 1 ) ) {
      printf("[SEQ TUNERS] Error in limit switches: short circuit problem in one or more lines \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in limit switches: NC or NO line closed for each tuner system */
  when ( ( (T1_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T1_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T2_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T2_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T3_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T3_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T4_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T4_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M1_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M1_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M2_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M2_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T5_M3_LimSwitch_IN_NC_LimStat == 0 ) && (T5_M3_LimSwitch_IN_NO_LimStat == 0 ) ) || ( (T1_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T1_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T1_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T1_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T2_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T2_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T3_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T3_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T4_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T4_M3_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M1_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M1_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M2_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M2_LimSwitch_IN_NO_LimStat == 1 ) ) || ( (T5_M3_LimSwitch_IN_NC_LimStat == 1 ) && (T5_M3_LimSwitch_IN_NO_LimStat == 1 ) )  ) {
      printf("[SEQ TUNERS] Error in limit switches: one or more lines not proper connected (NC or NO) \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: module is offline */
  when ( (T1_M1_LinEnc_Online == 0) || (T1_M2_LinEnc_Online == 0) || (T1_M3_LinEnc_Online == 0) || (T2_M1_LinEnc_Online == 0) || (T2_M2_LinEnc_Online == 0) || (T2_M3_LinEnc_Online == 0) || (T3_M1_LinEnc_Online == 0) || (T3_M2_LinEnc_Online == 0) || (T3_M3_LinEnc_Online == 0) || (T4_M1_LinEnc_Online == 0) || (T4_M2_LinEnc_Online == 0) || (T4_M3_LinEnc_Online == 0) || (T5_M1_LinEnc_Online == 0) || (T5_M2_LinEnc_Online == 0) || (T5_M3_LinEnc_Online == 0) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more modules are not online \n");
      printf("[SEQ TUNERS] System not passed self check: go to FAILURE \n");

  } state failure

  /* Error in linear encoders: error alarm */
  when ( (T1_M1_LinEnc_ErrorAlrm == 1) || (T1_M2_LinEnc_ErrorAlrm == 1) || (T1_M3_LinEnc_ErrorAlrm == 1) || (T2_M1_LinEnc_ErrorAlrm == 1) || (T2_M2_LinEnc_ErrorAlrm == 1) || (T2_M3_LinEnc_ErrorAlrm == 1) || (T3_M1_LinEnc_ErrorAlrm == 1) || (T3_M2_LinEnc_ErrorAlrm == 1) || (T3_M3_LinEnc_ErrorAlrm == 1) || (T4_M1_LinEnc_ErrorAlrm == 1) || (T4_M2_LinEnc_ErrorAlrm == 1) || (T4_M3_LinEnc_ErrorAlrm == 1) || (T5_M1_LinEnc_ErrorAlrm == 1) || (T5_M2_LinEnc_ErrorAlrm == 1) || (T5_M3_LinEnc_ErrorAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in linear encoders: one or more modules are in error \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motors */
  when ( (T1_M1_Axis_Error == 1) || (T1_M2_Axis_Error == 1) || (T1_M3_Axis_Error == 1) || (T2_M1_Axis_Error == 1) || (T2_M2_Axis_Error == 1) || (T2_M3_Axis_Error == 1) || (T3_M1_Axis_Error == 1) || (T3_M2_Axis_Error == 1) || (T3_M3_Axis_Error == 1) || (T4_M1_Axis_Error == 1) || (T4_M2_Axis_Error == 1) || (T4_M3_Axis_Error == 1) || (T5_M1_Axis_Error == 1) || (T5_M2_Axis_Error == 1) || (T5_M3_Axis_Error == 1) ) {
    printf("[SEQ TUNERS] Error in tuners axes: one or more motors are in error \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module not online */
  when ( (T1_M1_Driver_Online == 0) || (T1_M2_Driver_Online == 0) || (T1_M3_Driver_Online == 0) || (T2_M1_Driver_Online == 0) || (T2_M2_Driver_Online == 0) || (T2_M3_Driver_Online == 0) || (T3_M1_Driver_Online == 0) || (T3_M2_Driver_Online == 0) || (T3_M3_Driver_Online == 0) || (T4_M1_Driver_Online == 0) || (T4_M2_Driver_Online == 0) || (T4_M3_Driver_Online == 0) || (T5_M1_Driver_Online == 0) || (T5_M2_Driver_Online == 0) || (T5_M3_Driver_Online == 0) ) {
    printf("[SEQ TUNERS] Error in motor drives: one or more drivers are not online \n");
    printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module warning alarm */
  when ( (T1_M1_Driver_WarningAlrm == 1) || (T1_M2_Driver_WarningAlrm == 1) || (T1_M3_Driver_WarningAlrm == 1) || (T2_M1_Driver_WarningAlrm == 1) || (T2_M2_Driver_WarningAlrm == 1) || (T2_M3_Driver_WarningAlrm == 1) || (T3_M1_Driver_WarningAlrm == 1) || (T3_M2_Driver_WarningAlrm == 1) || (T3_M3_Driver_WarningAlrm == 1) || (T4_M1_Driver_WarningAlrm == 1) || (T4_M2_Driver_WarningAlrm == 1) || (T4_M3_Driver_WarningAlrm == 1) || (T5_M1_Driver_WarningAlrm == 1) || (T5_M2_Driver_WarningAlrm == 1) || (T5_M3_Driver_WarningAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in warning status \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module error alarm */
  when ( (T1_M1_Driver_ErrorAlrm == 1) || (T1_M2_Driver_ErrorAlrm == 1) || (T1_M3_Driver_ErrorAlrm == 1) || (T2_M1_Driver_ErrorAlrm == 1) || (T2_M2_Driver_ErrorAlrm == 1) || (T2_M3_Driver_ErrorAlrm == 1) || (T3_M1_Driver_ErrorAlrm == 1) || (T3_M2_Driver_ErrorAlrm == 1) || (T3_M3_Driver_ErrorAlrm == 1) || (T4_M1_Driver_ErrorAlrm == 1) || (T4_M2_Driver_ErrorAlrm == 1) || (T4_M3_Driver_ErrorAlrm == 1) || (T5_M1_Driver_ErrorAlrm == 1) || (T5_M2_Driver_ErrorAlrm == 1) || (T5_M3_Driver_ErrorAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in error status \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module stall alarm */
  when ( (T1_M1_Driver_StallAlrm == 1) || (T1_M2_Driver_StallAlrm == 1) || (T1_M3_Driver_StallAlrm == 1) || (T2_M1_Driver_StallAlrm == 1) || (T2_M2_Driver_StallAlrm == 1) || (T2_M3_Driver_StallAlrm == 1) || (T3_M1_Driver_StallAlrm == 1) || (T3_M2_Driver_StallAlrm == 1) || (T3_M3_Driver_StallAlrm == 1) || (T4_M1_Driver_StallAlrm == 1) || (T4_M2_Driver_StallAlrm == 1) || (T4_M3_Driver_StallAlrm == 1) || (T5_M1_Driver_StallAlrm == 1) || (T5_M2_Driver_StallAlrm == 1) || (T5_M3_Driver_StallAlrm == 1) ) {
      printf("[SEQ TUNERS] Error in motor drives: one or more drivers are in stall status \n");
      printf("[SEQ TUNERS] System not ok: go to FAILURE \n");

  } state failure

  /* Error in motor driver: module synchronization alarm */
  when ( (T1_M1_Driver_SyncAlrm == 1) || (T1_M2_Driver_SyncAlrm == 1) || (T1_M3_Driver_SyncAlrm == 1) || (T2_M1_Driver_SyncAlrm == 1) || (T2_M2_Driver_SyncAlrm == 1) || (T2_M3_Driver_SyncAlrm == 1) || (T3_M1_Driver_SyncAlrm == 1) || (T3_M2_Driver_SyncAlrm == 1) || (T3_M3_Driver_SyncAlrm == 1) || (T4_M1_Driver_SyncAlrm == 1) || (T4_M2_Driver_SyncAlrm == 1) || (T4_M3_Driver_SyncAlrm == 1) || (T5_M1_Driver_SyncAlrm == 1) || (T5_M2_Driver_SyncAlrm == 1) || (T5_M3_Driver_SyncAlrm == 1) ) {
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

  

}


/* state FAILURE	*/
state failure {

	entry {
			printf("\n[SEQ TUNERS] Enter in FAILURE status\n");
			StateMachineCode=50;
			pvPut(StateMachineCode);
	}

}



/* state MAINTENANCE	*/
state maintenance {

	entry {
			printf("\n[SEQ TUNERS] Enter in MAINTENANCE status\n");
			StateMachineCode=60;
			pvPut(StateMachineCode);
	}

  /* ADD reset Error_Missing_Counter */

}



/* end statemachine */
}
