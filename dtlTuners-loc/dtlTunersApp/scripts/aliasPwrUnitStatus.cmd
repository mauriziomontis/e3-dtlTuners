#==============================================================================
# aliasPwrUnitStatus.cmd
#- Arguments: SLAVE_ID, HW_DESC, BIT_IN, SECTION_NAME, POS_INDEX, SIGN_INDEX

#-d /**
#-d   \brief Alias Names for DTL Digital Status
#-d   \details Define the aliases for DTL digital bits devoted to Power status in order to align Records' Names to ESS Naming Convention.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SLAVE_ID Bus position
#-d   \param HW_DESC Hardware descriptor, i.e. EL1008
#-d   \param BIT_IN Digital input index, i.e. 3
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param POS_INDEX Device signal mapped with this digital interface, i.e. 001
#-d   \param SIGN_INDEX Signal index mapped with this digital interface, i.e. 1
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}aliasPwrUnitStatus.cmd", "SLAVE_ID=1, HW_DESC=EL1008, BIT_IN=1, SECTION_NAME=010, POS_INDEX=DTL-010O, SIGN_INDEX=1"
#-d   \endcode
#-d */

dbLoadRecords(ecmcGenericAlias.db,"NAME=${SM_PREFIX}ec${MASTER_ID}-s${SLAVE_ID}-${HW_DESC}-BI${BIT_IN}, ALIAS=${SECTION_NAME}ROW:CnPw-U-${POS_INDEX}:24VPS_OKStat${SIGN_INDEX}")

