#==============================================================================
# postInitStateMachine.cmd
#- Arguments: SECTION_NAME

#-d /**
#-d   \brief Execute DTL Tuner State Machine.
#-d   \details Configure and start SNL State Machine devoted to manage tuners system.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}postInitStateMachine.cmd", "SECTION_NAME=DTL-010"
#-d   \endcode
#-d */

afterInit(seq tuners_statemachine "SECTION_NAME=${SECTION_NAME}")
