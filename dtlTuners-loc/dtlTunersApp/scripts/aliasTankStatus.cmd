#==============================================================================
# aliasTankStatus.cmd
#- Arguments: SLAVE_ID, HW_DESC, BIT, SECTION_NAME

#-d /**
#-d   \brief Alias Names for DTL motor tuners status .
#-d   \details Define the aliases for DTL motor status in order to align Records' Names to ESS Naming Convention.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SLAVE_ID Bus position
#-d   \param HW_DESC Hardware descriptor, i.e. EL2624
#-d   \param BIT Bit number, i.e. 1
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}aliasTankStatus.cmd", "SLAVE_ID=1, HW_DESC=EL2624, BIT=1, SECTION_NAME=DTL-010"
#-d   \endcode
#-d */

dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BO${BIT}, ALIAS=${SECTION_NAME}:MC-MCU:OkStat") 
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BO${BIT}-RB, ALIAS=${SECTION_NAME}:MC-MCU:OkStat-RB") 
