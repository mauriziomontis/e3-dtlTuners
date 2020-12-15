#==============================================================================
# dbloadArcDetectionStateMachineCode.cmd
#- Arguments:

#-d /**
#-d   \brief Load Arc Detection Description Database
#-d   \details Load Arc Detection description records which indicate information in the GUI.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbloadArcDetectionStateMachineCode.cmd"
#-d   \endcode
#-d */

dbLoadRecords(dtlArcDetectionStateMachine.db)
