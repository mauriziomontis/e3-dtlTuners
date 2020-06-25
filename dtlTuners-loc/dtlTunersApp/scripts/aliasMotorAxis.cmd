#==============================================================================
# aliasMotorAxis.cmd
#- Arguments: [DEV], ECMC_MOTOR_NAME, ECMC_IN_SWITCH, ECMC_OUT_SWITCH

#-d /**
#-d   \brief Alias Names for DTL motor axis.
#-d   \details Define the aliases for DTL motor axis in order to align Records' Names to ESS Naming Convention
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param DEV (optional)  Device name
#-d   \param ECMC_MOTOR_NAME Motor Name used in axis configuration file, i.e. EMR-SM-001"
#-d   \param ECMC_IN_SWITCH Limit switch name - Tuner inserted, i.e. EMR-GS-001"
#-d   \param ECMC_OUT_SWITCH Limit switch name - Tuner extracted, i.e. EMR-GS-011"
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${ecmccfg_DIR}aliasMotorAxis.cmd", "ECMC_MOTOR_NAME=EMR-SM-001"
#-d   \endcode
#-d */

dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_MOTOR_NAME}.RBV, ALIAS=${DEV}:${ECMC_MOTOR_NAME}:PosAct") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_MOTOR_NAME}.OFF, ALIAS=${DEV}:${ECMC_MOTOR_NAME}:PosOff") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_MOTOR_NAME}.VAL, ALIAS=${DEV}:${ECMC_MOTOR_NAME}:PosSet") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_MOTOR_NAME}.HLS, ALIAS=${DEV}:${ECMC_IN_SWITCH}:Stat") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${DEV}:${ECMC_MOTOR_NAME}.LLS, ALIAS=${DEV}:${ECMC_OUT_SWITCH}:Stat") 
