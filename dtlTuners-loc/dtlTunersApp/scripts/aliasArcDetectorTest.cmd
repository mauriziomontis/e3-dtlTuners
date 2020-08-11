#==============================================================================
# aliasArcDetectorTest.cmd
#- Arguments: SLAVE_ID, HW_DESC, BIT_IN, BIT_OUT, SECTION_NAME, DEVICE_POS

#-d /**
#-d   \brief Alias Names for DTL motor limit switches (Outputs) .
#-d   \details Define the aliases for DTL arc detector test command in order to align Records' Names to ESS Naming Convention. According to ESS Guidelines.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SLAVE_ID Bus position
#-d   \param HW_DESC Hardware descriptor, i.e. EL2124
#-d   \param BIT_IN Bit number associated to the full interted tuner's limit switch, i.e. 0
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param DEVICE_POS Device position (accordig to ESS Naming Convetion indexing)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}aliasArcDetectorTest.cmd", "SLAVE_ID=1, HW_DESC=EL2124, BIT_IN=0, SECTION_NAME=DTL-010, DEVICE_POS=001"
#-d   \endcode
#-d */

dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BO${BIT_IN}, ALIAS=${SECTION_NAME}:RFS-ADTT-00${DEVICE_POS}:OnCmd") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BO${BIT_IN}, ALIAS=${SECTION_NAME}:RFS-ADTT-00${DEVICE_POS}:OnCmd-RB") 
