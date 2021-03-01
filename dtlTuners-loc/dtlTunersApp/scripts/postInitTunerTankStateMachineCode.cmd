#==============================================================================
postInitTunerTankStateMachine.cmd
#- Arguments: SECTION_NAME, TANK

#-d /**
#-d   \brief Load Tuners Description Database
#-d   \details Load Tuners description records which indicate information in the GUI.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param TANK Section name, i.e. 010
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}postInitTunerTankStateMachine.cmd", "SECTION_NAME=DTL-010, TANK=010"
#-d   \endcode
#-d */

afterInit(seq tuners_tank{TANK} "SECTION_NAME=${SECTION_NAME}" )
