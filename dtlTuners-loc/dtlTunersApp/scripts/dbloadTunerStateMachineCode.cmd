#==============================================================================
# dbloadTunerStateMachineCode.cmd
#- Arguments: SECTION_NAME

#-d /**
#-d   \brief Load Tuners Description Database
#-d   \details Load Tuners description records which indicate information in the GUI.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbloadTunerStateMachineCode.cmd", "SECTION_NAME=DTL-010"
#-d   \endcode
#-d */

dbLoadRecords(dtlTunerStateMachine.db,"PREFIX=${SECTION_NAME}")
