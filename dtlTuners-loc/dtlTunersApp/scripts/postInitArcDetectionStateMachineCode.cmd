#==============================================================================
# postInitArcDetectionStateMachineCode.cmd
#- Arguments:

#-d /**
#-d   \brief Execute DTL Arc Detection State Machine.
#-d   \details Configure and start SNL State Machine devoted to manage arc detection system.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}postInitArcDetectionStateMachineCode.cmd", "SECTION_NAME=DTL-010, TANK=010"
#-d   \endcode
#-d */


afterInit(seq arcDetection_tank{TANK} "SECTION_NAME=${SECTION_NAME}" )
