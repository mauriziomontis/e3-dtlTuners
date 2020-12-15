#==============================================================================
# dbloadArcDetectionResetMaintenance.cmd
#- Arguments:

#-d /**
#-d   \brief Load Arc Detection Maintenance Database
#-d   \details Load arcdetection maintenance records used by state machines.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuners_DIR}dbloadArcDetectionResetMaintenance.cmd"
#-d   \endcode
#-d */

dbLoadRecords(dbloadArcDetectionResetMaintenance.db)
