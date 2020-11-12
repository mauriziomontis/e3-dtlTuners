#==============================================================================
# dbloadTunerResetMaintenance.cmd
#- Arguments:

#-d /**
#-d   \brief Load Tuners Maintenance Database
#-d   \details Load steerer maintenance records used by state machines.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlThermo_DIR}dbloadTunereResetMaintenance.cmd"
#-d   \endcode
#-d */

dbLoadRecords(dbTunerResetMaitenance.db)
