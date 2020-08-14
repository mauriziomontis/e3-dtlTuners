#==============================================================================
# dbLoadArcOkState.cmd
#- Arguments: SECTION_NAME, INPUT, OUTPUT, MAX_ARC_NUM

#-d /**
#-d   \brief Load EPICS Arc OK Status Database
#-d   \details Load  database in order to implement an arc detector "Ok State" bit for each DTL tank.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param INPUT Input variable, i.e. DTL:RF:ArcCount
#-d   \param OUTPUT Output variable, i.e. DTL-010:Exec
#-d   \param MAX_ARC_NUM Max arcs counted ardmited for mainatin ok status, i.e. 2
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbLoadArcOkState.cmd", "SECTION_NAME=DTL-010, INPUT=DTL:RF:ArcCount, OUTPUT=DTL-010:Exec, MAX_ARC_NUM=2"
#-d   \endcode
#-d */

dbLoadRecords(dtlArcOkState.db, "PREFIX=${SECTION_NAME}, INPUT=${INPUT}, OUTPUT=${OUTPUT}, LIMIT=${MAX_ARC_NUM}" )


