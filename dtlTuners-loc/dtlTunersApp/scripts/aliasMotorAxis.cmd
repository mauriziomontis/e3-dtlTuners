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
