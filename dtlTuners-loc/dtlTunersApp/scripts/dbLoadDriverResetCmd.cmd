#==============================================================================
# dbLoadDriverResetCmd.cmd
#- Arguments: SECTION_NAME, POS_INDEX

#-d /**
#-d   \brief Load EPICS Database for Reset Driver 
#-d   \details Load  database in order to reset ecmc motor driver in case of (driver) fault.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param POS_INDEX Device position index, i.e. 010
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbLoadDriverResetCmd.cmd", "SECTION_NAME=DTL-010, POS_INDEX=010"
#-d   \endcode
#-d */

dbLoadRecords(dtlDriverResetCmd.db, "PREFIX=${SECTION_NAME}, DEVICE_POS=${POS_INDEX}" )


