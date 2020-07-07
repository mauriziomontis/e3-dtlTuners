#==============================================================================
# aliasMotorAxis.cmd
#- Arguments: [DEV], ECMC_AXIS_NAME, ECMC_AXIS_EPICS_NAME

#-d /**
#-d   \brief Alias Names for DTL motor axis.
#-d   \details Define the aliases for DTL motor axis in order to align Records' Names to ESS Naming Convention
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param DEV (optional)  Device name
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param ECMC_AXIS_NAME Motor Name used in axis configuration file, i.e. AxisT1M1
#-d   \param ECMC_AXIS_EPICS_NAME EPICS name for axis according to Naming Convention, i.e. EMR-SM-001
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}aliasMotorAxis.cmd", "ECMC_AXIS_NAME=AxisT1M1, SECTION_NAME=DTL-010,  ECMC_AXIS_EPICS_NAME=EMR-SM-001"
#-d   \endcode
#-d */

# List of PV
# DTL-010:EMR-SM-001-PosAct
# 
# DTL-010:AxisT0M0-Err
#
#
#

dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-Err, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:Err") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-ErrId, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:Err-Id") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-ErrRst, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:Err-Rst") 


dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-Acc-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:Acc-RB") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-AccHom, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:AccHom")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-AllowCmdFromPLC-CmdEn, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:AllowCmdFromPLC-CmdEn")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-AllowCmdFromPLC-CmdEn-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:AllowCmdFromPLC-CmdEn-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-Array-Stat, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:Array-Stat")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-attarget, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:attarget")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-AxisType-Act, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:AxisType-Act")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-busy, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:busy")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgACCS-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgACCS-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgDHLM-En-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgDHLM-En-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgDHLM-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgDHLM-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgDLLM-En-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgDLLM-En-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgDLLM-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgDLLM-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgJVEL-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgJVEL-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgPMAX-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgPMAX-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgPMIN-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgPMIN-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgPOSLAG-En-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgPOSLAG-En-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgPOSLAG-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgPOSLAG-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgPOSLAG-Tim-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgPOSLAG-Tim-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgRDBD-En-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgRDBD-En-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgRDBD-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgRDBD-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgRDBD-Tim-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgRDBD-Tim-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgSPDB-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgSPDB-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgSREV-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgSREV-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgUREV-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgUREV-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgVELO-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgVELO-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-CfgVMAX-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:CfgVMAX-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-DbgStrToLOG, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:DbgStrToLOG")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-DIR_, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:DIR")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-enabled, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:enabled")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-EncAct, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:EncAct")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-EncSourceType-Cmd, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:EncSourceType-Cmd")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-EncSourceType-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:EncSourceType-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-execute, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:execute")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-homeswitch, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:homeswitch")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-HomPos, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:HomPos")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-HomPos-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:HomPos-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-HomProc, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:HomProc")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-HomProc-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:HomProc-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-inrealtime, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:inrealtime")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-instartup, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:instartup")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-lastilock, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:lastilock")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-limitbwd, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:limitbwd")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-limitfwd, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:limitfwd")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-moving, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:moving")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-MRES_, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:MRES")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-MsgTxt, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:MsgTxt")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-OFF_, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:OFF")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PLC-CmdEn, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PLC-CmdEn")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PLC-CmdEn-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PLC-CmdEn-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PLC-error, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PLC-error")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PLC-firstscan, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PLC-firstscan")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PLCExpr, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PLCExpr")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PLCExpr-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PLCExpr-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PosAct, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PosAct")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PosErr, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PosErr")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-PosSet, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:PosSet")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-seqstate, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:seqstate")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-Stat, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:Stat")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-Stat_, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:Stat_CK")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-TrajSourceType-Cmd, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:TrajSourceType-Cmd")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-TrajSourceType-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:TrajSourceType-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-Vel-RB, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:Vel-RB")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-VelAct, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:VelAct")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-VelFrmHom, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:VelFrmHom")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_AXIS_NAME}-VelToHom, ALIAS=${SECTION_NAME}:${ECMC_AXIS_EPICS_NAME}:VelToHom")

