#==============================================================================
# aliasMotorSwitchInput.cmd
#- Arguments: SLAVE_ID, HW_DESC, BIT_IN, BIT_OUT, SECTION_NAME, DEVICE_POS

#-d /**
#-d   \brief Alias Names for DTL motor limit switches (Inputs).
#-d   \details Define the aliases for DTL motor switch in order to align Records' Names to ESS Naming Convention. According to ESS Guidelines, limit switches are managed with 2 different Ethercat modules: 1 DI and 1 DO. This script verifies only the digital inputs related to the limit switches (high and low) coming back from the sensor. A different script (aliasMotorSwitchOutput.cmd) has been defined in order to manage digital outputs.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SLAVE_ID Bus position
#-d   \param HW_DESC Hardware descriptor, i.e. EL1008
#-d   \param BIT_IN Bit number associated to the full interted tuner's limit switch, i.e. 0
#-d   \param BIT_OUT Bit number associated to the full extracted tuner's limit switch, i.e. 1
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param DEVICE_POS Device position (accordig to ESS Naming Convetion indexing)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${ecmccfg_DIR}aliasMotorSwitchInput.cmd", "SLAVE_ID=1, HW_DESC=EL7037, BIT_IN=0, BIT_OUT=1, SECTION_NAME=DTL-010, DEVICE_POS=001"
#-d   \endcode
#-d */


dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BI${BIT_IN}, ALIAS=${SECTION_NAME}:EMR-GS-00${DEVICE_POS}:LimStat")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BI${BIT_OUT}, ALIAS=${SECTION_NAME}:EMR-GS-01${DEVICE_POS}:LimStat")

