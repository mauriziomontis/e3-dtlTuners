#==============================================================================
# dbloadTunerStateMachineCode.cmd
#- Arguments: 

#-d /**
#-d   \brief Load Tuners Description Database
#-d   \details Load Tuners description records which indicate information in the GUI.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbloadTunerStateMachineCode.cmd"
#-d   \endcode
#-d */

dbLoadRecords(dtlTunerStateMachine.db)
