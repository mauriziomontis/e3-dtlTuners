#==============================================================================
# postInitArcDetectionStateMachine.cmd
#- Arguments:

#-d /**
#-d   \brief Execute DTL Arc Detection State Machine.
#-d   \details Configure and start SNL State Machine devoted to manage arc detection system.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}postInitArcDetectionStateMachine.cmd"
#-d   \endcode
#-d */

afterInit(seq arcDetection_statemachine)
