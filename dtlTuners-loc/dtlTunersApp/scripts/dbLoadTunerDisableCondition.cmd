#==============================================================================
# dbLoadTunerDisableCondition.cmd
#- Arguments: SECTION_NAME, POS_INDEX

#-d /**
#-d   \brief Load EPICS Database for Diable Axis
#-d   \details Load  database in order to verify conditions for disabling motor record
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param POS_INDEX Device position index, i.e. 010
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbLoadTunerDisableCondition.cmd", "SECTION_NAME=DTL-010, POS_INDEX=010"
#-d   \endcode
#-d */

dbLoadRecords(dtlTunerDisableCondition.db, "PREFIX=${SECTION_NAME}, INDEX=${POS_INDEX}" )


