#==============================================================================
# postInitTunersStateMachine.cmd
#- Arguments:

#-d /**
#-d   \brief Execute DTL Tuner State Machine.
#-d   \details Configure and start SNL State Machine devoted to manage tuners system.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}postInitTunersStateMachine.cmd"
#-d   \endcode
#-d */

afterInit(seq tuners_statemachine)
