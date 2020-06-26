#==============================================================================
# aliasMotorDriver.cmd
#- Arguments: SLAVE_ID, HW_DESC, SECTION_NAME, DEVICE_POS

#-d /**
#-d   \brief Alias Names for DTL motor driver.
#-d   \details Define the aliases for DTL motor driver in order to align Records' Names to ESS Naming Convention
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SLAVE_ID Bus position
#-d   \param HW_DESC Hardware descriptor, i.e. EL7037
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param DEVICE_POS Device position (accordig to ESS Naming Convetion indexing)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}aliasMotorDriver.cmd", "SLAVE_ID=1, HW_DESC=EL7037, SECTION_NAME=DTL-010, DEVICE_POS=001"
#-d   \endcode
#-d */


dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-AutoRst, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-AutoRst") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-Rst, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-Rst") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-AutoRst_SP, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-AutoRst_SP") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-Cmd, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-Cmd") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-Cmd, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-Cmd") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-Spd, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-Spd") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Cmd, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Cmd") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-PosCmd, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-PosCmd") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Stat_, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Stat_") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-Stat, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-Stat") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Stat, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Stat") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Stat, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Stat") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-online, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:online") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-operational, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:operational") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-alstate-init, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:alstate-init") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-alstate-preop, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:alstate-preop") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-alstate-safeop, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:alstate-safeop") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-alstate-op, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:alstate-op") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-Wrn-Alrm, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-Wrn-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-Err-Alrm, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-Err-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-Stl-Alrm, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-Stl-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-SyncErr-Alrm, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-SyncErr-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-ExtLatch-OK, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-ExtLatch-OK") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-OpnCrct-Alrm, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-OpnCrct-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Wrn-Alrm, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Wrn-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-SyncErr-Alrm, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-SyncErr-Alrm") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-entrycounter, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:entrycounter") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-One, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:One") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Zero, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Zero") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-HWType, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:HWType") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-Cmd-RB, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-Cmd-RB") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Drv-Spd-RB, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Drv-Spd-RB") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-PosAct, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-PosAct") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Latch-PosAct, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Latch-PosAct") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-Cmd-RB, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-Cmd-RB") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-Enc-PosCmd-RB, ALIAS=${SECTION_NAME}:MC-MCU-${DEVICE_POS}:Enc-PosCmd-RB") 
