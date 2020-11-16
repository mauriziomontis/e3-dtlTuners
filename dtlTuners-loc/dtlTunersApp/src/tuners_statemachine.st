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
int T1_M1_LinEnc_Position;
assign T1_M1_LinEnc_Position to "DTL-010:EMR-GT-001:Pos";
monitor T1_M1_LinEnc_Position;
int T1_M2_LinEnc_Position;
assign T1_M2_LinEnc_Position to "DTL-010:EMR-GT-002:Pos";
monitor T1_M2_LinEnc_Position;
int T1_M3_LinEnc_Position;
assign T1_M3_LinEnc_Position to "DTL-010:EMR-GT-003:Pos";
monitor T1_M3_LinEnc_Position;
int T2_M1_LinEnc_Position;
assign T2_M1_LinEnc_Position to "DTL-020:EMR-GT-001:Pos";
monitor T2_M1_LinEnc_Position;
int T2_M2_LinEnc_Position;
assign T2_M2_LinEnc_Position to "DTL-020:EMR-GT-002:Pos";
monitor T2_M2_LinEnc_Position;
int T2_M3_LinEnc_Position;
assign T2_M3_LinEnc_Position to "DTL-020:EMR-GT-003:Pos";
monitor T2_M3_LinEnc_Position;
int T3_M1_LinEnc_Position;
assign T3_M1_LinEnc_Position to "DTL-030:EMR-GT-001:Pos";
monitor T3_M1_LinEnc_Position;
int T3_M2_LinEnc_Position;
assign T3_M2_LinEnc_Position to "DTL-030:EMR-GT-002:Pos";
monitor T3_M2_LinEnc_Position;
int T3_M3_LinEnc_Position;
assign T3_M3_LinEnc_Position to "DTL-030:EMR-GT-003:Pos";
monitor T3_M3_LinEnc_Position;
int T4_M1_LinEnc_Position;
assign T4_M1_LinEnc_Position to "DTL-040:EMR-GT-001:Pos";
monitor T4_M1_LinEnc_Position;
int T4_M2_LinEnc_Position;
assign T4_M2_LinEnc_Position to "DTL-040:EMR-GT-002:Pos";
monitor T4_M2_LinEnc_Position;
int T4_M3_LinEnc_Position;
assign T4_M3_LinEnc_Position to "DTL-040:EMR-GT-003:Pos";
monitor T4_M3_LinEnc_Position;
int T5_M1_LinEnc_Position;
assign T5_M1_LinEnc_Position to "DTL-050:EMR-GT-001:Pos";
monitor T5_M1_LinEnc_Position;
int T5_M2_LinEnc_Position;
assign T5_M2_LinEnc_Position to "DTL-050:EMR-GT-002:Pos";
monitor T5_M2_LinEnc_Position;
int T5_M3_LinEnc_Position;
assign T5_M3_LinEnc_Position to "DTL-050:EMR-GT-003:Pos";
monitor T5_M3_LinEnc_Position;

/* Linear Encoders - Status*/
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

/* Motor - Reset Error */
double T1_M1_Axis_ErrorReset;
assign T1_M1_Axis_ErrorReset to "DTL-010:EMR-SM-001:Err-Rst";
monitor T1_M1_Axis_ErrorReset;
double T1_M2_Axis_ErrorReset;
assign T1_M2_Axis_ErrorReset to "DTL-010:EMR-SM-002:Err-Rst";
monitor T1_M2_Axis_ErrorReset;
double T1_M3_Axis_ErrorReset;
assign T1_M3_Axis_ErrorReset to "DTL-010:EMR-SM-003:Err-Rst";
monitor T1_M3_Axis_ErrorReset;
double T2_M1_Axis_ErrorReset;
assign T2_M1_Axis_ErrorReset to "DTL-020:EMR-SM-001:Err-Rst";
monitor T2_M1_Axis_ErrorReset;
double T2_M2_Axis_ErrorReset;
assign T2_M2_Axis_ErrorReset to "DTL-020:EMR-SM-002:Err-Rst";
monitor T2_M2_Axis_ErrorReset;
double T2_M3_Axis_ErrorReset;
assign T2_M3_Axis_ErrorReset to "DTL-020:EMR-SM-003:Err-Rst";
monitor T2_M3_Axis_ErrorReset;
double T3_M1_Axis_ErrorReset;
assign T3_M1_Axis_ErrorReset to "DTL-030:EMR-SM-001:Err-Rst";
monitor T3_M1_Axis_ErrorReset;
double T3_M2_Axis_ErrorReset;
assign T3_M2_Axis_ErrorReset to "DTL-030:EMR-SM-002:Err-Rst";
monitor T3_M2_Axis_ErrorReset;
double T3_M3_Axis_ErrorReset;
assign T3_M3_Axis_ErrorReset to "DTL-030:EMR-SM-003:Err-Rst";
monitor T3_M3_Axis_ErrorReset;
double T4_M1_Axis_ErrorReset;
assign T4_M1_Axis_ErrorReset to "DTL-040:EMR-SM-001:Err-Rst";
monitor T4_M1_Axis_ErrorReset;
double T4_M2_Axis_ErrorReset;
assign T4_M2_Axis_ErrorReset to "DTL-040:EMR-SM-002:Err-Rst";
monitor T4_M2_Axis_ErrorReset;
double T4_M3_Axis_ErrorReset;
assign T4_M3_Axis_ErrorReset to "DTL-040:EMR-SM-003:Err-Rst";
monitor T4_M3_Axis_ErrorReset;
double T5_M1_Axis_ErrorReset;
assign T5_M1_Axis_ErrorReset to "DTL-050:EMR-SM-001:Err-Rst";
monitor T5_M1_Axis_ErrorReset;
double T5_M2_Axis_ErrorReset;
assign T5_M2_Axis_ErrorReset to "DTL-050:EMR-SM-002:Err-Rst";
monitor T5_M2_Axis_ErrorReset;
double T5_M3_Axis_ErrorReset;
assign T5_M3_Axis_ErrorReset to "DTL-050:EMR-SM-003:Err-Rst";
monitor T5_M3_Axis_ErrorReset;

/* Motor - Error */
double T1_M1_Axis_Error;
assign T1_M1_Axis_Error to "DTL-010:EMR-SM-001:Err";
monitor T1_M1_Axis_Error;
double T1_M2_Axis_Error;
assign T1_M2_Axis_Error to "DTL-010:EMR-SM-002:Err";
monitor T1_M2_Axis_Error;
double T1_M3_Axis_Error;
assign T1_M3_Axis_Error to "DTL-010:EMR-SM-003:Err";
monitor T1_M3_Axis_Error;
double T2_M1_Axis_Error;
assign T2_M1_Axis_Error to "DTL-020:EMR-SM-001:Err";
monitor T2_M1_Axis_Error;
double T2_M2_Axis_Error;
assign T2_M2_Axis_Error to "DTL-020:EMR-SM-002:Err";
monitor T2_M2_Axis_Error;
double T2_M3_Axis_Error;
assign T2_M3_Axis_Error to "DTL-020:EMR-SM-003:Err";
monitor T2_M3_Axis_Error;
double T3_M1_Axis_Error;
assign T3_M1_Axis_Error to "DTL-030:EMR-SM-001:Err";
monitor T3_M1_Axis_Error;
double T3_M2_Axis_Error;
assign T3_M2_Axis_Error to "DTL-030:EMR-SM-002:Err";
monitor T3_M2_Axis_Error;
double T3_M3_Axis_Error;
assign T3_M3_Axis_Error to "DTL-030:EMR-SM-003:Err";
monitor T3_M3_Axis_Error;
double T4_M1_Axis_Error;
assign T4_M1_Axis_Error to "DTL-040:EMR-SM-001:Err";
monitor T4_M1_Axis_Error;
double T4_M2_Axis_Error;
assign T4_M2_Axis_Error to "DTL-040:EMR-SM-002:Err";
monitor T4_M2_Axis_Error;
double T4_M3_Axis_Error;
assign T4_M3_Axis_Error to "DTL-040:EMR-SM-003:Err";
monitor T4_M3_Axis_Error;
double T5_M1_Axis_Error;
assign T5_M1_Axis_Error to "DTL-050:EMR-SM-001:Err";
monitor T5_M1_Axis_Error;
double T5_M2_Axis_Error;
assign T5_M2_Axis_Error to "DTL-050:EMR-SM-002:Err";
monitor T5_M2_Axis_Error;
double T5_M3_Axis_Error;
assign T5_M3_Axis_Error to "DTL-050:EMR-SM-003:Err";
monitor T5_M3_Axis_Error;


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

		} state self_check

	}


/* state SELF_CHECK	*/
	state self_check {
		entry {
				printf("\n[SEQ STEERER] Enter in SELF CHECK status\n");
				StateMachineCode=10;
				pvPut(StateMachineCode);
		}

		when () {


		} state failure

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
