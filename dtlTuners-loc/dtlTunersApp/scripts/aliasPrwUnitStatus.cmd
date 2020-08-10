#==============================================================================
# aliasPrwUnitStatus.cmd
#- Arguments: SLAVE_ID, HW_DESC, BIT_24V, BIT_48V, SECTION_NAME

#-d /**
#-d   \brief Alias Names for DTL Digital Status
#-d   \details Define the aliases for DTL digital bits devoted to Power status in order to align Records' Names to ESS Naming Convention.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SLAVE_ID Bus position
#-d   \param HW_DESC Hardware descriptor, i.e. EL1809
#-d   \param BIT_24V Digital input index for 24V DC power, i.e. 3
#-d   \param BIT_48V Digital input index for 48V DC power, i.e. 4
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}aliasPrwUnitStatus.cmd", "SLAVE_ID=1, HW_DESC=EL1809, BIT_24V=3, BIT_48V=4, SECTION_NAME=DTL-010"
#-d   \endcode
#-d */

dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BI${BIT_24V}, ALIAS=${SECTION_NAME}:MC-MCU:GS24VPS_OKStat")
dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BI${BIT_48V}, ALIAS=${SECTION_NAME}:MC-MCU:48VPS_OKStat")

