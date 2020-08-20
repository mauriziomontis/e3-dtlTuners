#==============================================================================
# aliasMotorLinearEnc.cmd
#- Arguments: SLAVE_ID, HW_DESC, BIT_POS, SECTION_NAME, DEVICE_POS

#-d /**
#-d   \brief Alias Names for DTL motor linear encoder.
#-d   \details Define the aliases for DTL motor linear encorder in order to align Records' Names to ESS Naming Convention.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SLAVE_ID Bus position
#-d   \param HW_DESC Hardware descriptor, i.e. EL3255
#-d   \param BIT_POS Bit index related to HW_DESC channel, i.e. 0
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param DEVICE_POS Device position (accordig to ESS Naming Convetion indexing)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}aliasMotorSwitchOutput.cmd", "SLAVE_ID=1, HW_DESC=EL3255, BIT_POS=1, SECTION_NAME=DTL-010, DEVICE_POS=1"
#-d   \endcode
#-d */

dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-AI${BIT_POS}, ALIAS=${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:Pos") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-AI${BIT_POS}-Stat, ALIAS=${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:Stat") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-AI${BIT_POS}-Err-Alrm, ALIAS=${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:Err-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-AI${BIT_POS}-UnderLim-Alrm, ALIAS=${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:LLim-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-AI${BIT_POS}-OverLim-Alrm, ALIAS=${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:HLim-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-operational, ALIAS=${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:HwOp") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-online, ALIAS=${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:ConnStat") 

