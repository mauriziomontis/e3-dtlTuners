#==============================================================================
# aliasMotorDriver.cmd
#- Arguments: MASTER_ID, SLAVE_ID, HW_DESC, SECTION_NAME, DEVICE_POS

#-d /**
#-d   \brief Alias Names for DTL motor driver.
#-d   \details Define the aliases for DTL motor driver in order to align Records' Names to ESS Naming Convention
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param MASTER_ID Ethercat master index
#-d   \param SLAVE_ID Bus position
#-d   \param HW_DESC Hardware descriptor, i.e. EL7037
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param DEVICE_POS Device position (accordig to ESS Naming Convetion indexing)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${ecmccfg_DIR}aliasMotorDriver.cmd", "MASTER_ID=0, SLAVE_ID=1, HW_DESC=EL7037, SECTION_NAME=DTL-010, DEVICE_POS=001"
#-d   \endcode
#-d */


dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-AutoRst, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-AutoRst") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-Rst, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-Rst") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-AutoRst_SP, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-AutoRst_SP") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-Cmd, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-Cmd") 



