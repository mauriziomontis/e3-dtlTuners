#==============================================================================
# dbloadTunerTankOkStatus.cmd
#- Arguments:

#-d /**
#-d   \brief Load Tuners Tank OK Status Database
#-d   \details Load records used by state machines.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \note Example call:
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbloadTunereTankOkStatus.cmd"
#-d   \endcode
#-d */

dbLoadRecords(dtlTunerTankOkStatus.db, "PREFIX=${SECTION_NAME}")

