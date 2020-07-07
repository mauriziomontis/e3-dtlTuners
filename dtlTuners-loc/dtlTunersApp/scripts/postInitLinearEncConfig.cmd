#==============================================================================
# postInitLinearEncConfig.cmd
#- Arguments: SECTION_NAME, DEVICE_POS

#-d /**
#-d   \brief Configure Record fields for DTL motor linear encoder.
#-d   \details Set Linearization parameters defined in record fields (LINR, ESLO, EOFF) according to the mobile tuner design.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param DEVICE_POS Device position (accordig to ESS Naming Convetion indexing)
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}postInitLinearEncConfig.cmd", "SECTION_NAME=DTL-010, DEVICE_POS=1"
#-d   \endcode
#-d */


afterInit(dbpf "${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:Pos.EOFF" "105")
afterInit(dbpf "${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:Pos.ESLO" "-0.0032145")
afterInit(dbpf "${SECTION_NAME}:EMR-GT-00${DEVICE_POS}:Pos.LINR" "SLOPE")


