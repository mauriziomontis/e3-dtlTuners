#==============================================================================
# dbLoadTunerEnableReset.cmd
#- Arguments: SECTION_NAME, POS_INDEX, INPUT, OUTPUT, LOW_OP_RANGE, HIGH_OP_RANGE, LOW_DRIVER, HIGH_DRIVER, PRECISION, PROP_FACTOR, INT_FACTOR, DER_FACTOR, SCAN_TIME

#-d /**
#-d   \brief Load EPICS Database for Enable System 
#-d   \details Load  database in order to reset enable tuner when general enable is disabled.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param POS_INDEX Device position index, i.e. 010
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbLoadTunerEnableReset.cmd", "SECTION_NAME=DTL-010, POS_INDEX=010"
#-d   \endcode
#-d */

dbLoadRecords(dtlTunerEnableReset.db, "PREFIX=${SECTION_NAME}, INDEX=${POS_INDEX}" )


