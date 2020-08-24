#==============================================================================
# postInitEnableAxis.cmd
#- Arguments: SECTION_NAME, DEVICE_POS, ENABLE_COND

#-d /**
#-d   \brief Configure Record fields for DTL motor axis.
#-d   \details Set enable condition for axis using SDIS and DISV record fields.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param DEVICE_POS Device position (accordig to ESS Naming Convetion indexing)
#-d   \param ENABLE_COND Enable condition value, i.e. 0
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}postInitEnableAxis.cmd", "SECTION_NAME=DTL-010, DEVICE_POS=1, ENABLE_COND=0"
#-d   \endcode
#-d */


afterInit(dbpf "${SECTION_NAME}:EMR-SM-00${DEVICE_POS}.SDIS" "DTL:EMR-SM:EnCmd")
afterInit(dbpf "${SECTION_NAME}:EMR-SM-00${DEVICE_POS}.DISV" "${ENABLE_COND}")


