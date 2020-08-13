#==============================================================================
# dbLoadTunerPidControl.cmd
#- Arguments: SECTION_NAME, POS_INDEX, INPUT, OUTPUT, LOW_OP_RANGE, HIGH_OP_RANGE, LOW_DRIVER, HIGH_DRIVER, PRECISION, PROP_FACTOR, INT_FACTOR, DER_FACTOR, SCAN_TIME

#-d /**
#-d   \brief Load EPICS PID Control Database for DTL Tuners
#-d   \details Load  database in order to define a PID controller for a dedicated tuner.
#-d   \author Maurizio Montis (INFN-LNL)
#-d   \file
#-d   \param SECTION_NAME Section name, i.e. DTL-010
#-d   \param POS_INDEX Device position index, i.e. 010
#-d   \param INPUT PID controller input variable, i.e. DTL:RF:Err
#-d   \param OUTPUT controlled output variable, i.e. DTL-010:EMR-SM-010:Pos
#-d   \param LOW_OP_RANGE Low operator range for PID controller
#-d   \param HIGH_OP_RANGE High operator range for PID controller
#-d   \param LOW_DRIVER Low driver output value 
#-d   \param HIGH_DRIVER High driver output value 
#-d   \param PRECISION Number of digits used by the controller
#-d   \param PROP_FACTOR Proportional gain [KP]
#-d   \param INT_FACTOR Integrative contribution [KI]
#-d   \param DER_FACTOR Derivative contribution [KD]
#-d   \param SCAN_TIME Scanning period used by pid records, i.e. 1 second
#-d   \note Example call:
#-d   \code
#-d    ${SCRIPTEXEC} "${dtlTuner_DIR}dbLoadTunerPidControl.cmd", "SECTION_NAME=DTL-010, POS_INDEX=010, INPUT=DTL:RF:Err, OUTPUT=DTL-010:EMR-SM-010:Pos, LOW_OP_RANGE=0, HIGH_OP_RANGE=10, LOW_DRIVER=0, HIGH_DRIVER=100, PRECISION=3, PROP_FACTOR=1, INT_FACTOR=0.1, DER_FACTOR=0, SCAN_TIME=.1 second"
#-d   \endcode
#-d */

dbLoadRecords(dtlTunerPID.db, "PREFIX=${SECTION_NAME}, INDEX=${POS_INDEX}, INP=${INPUT}, OUT=${OUTPUT}, LOPR=${LOW_OP_RANGE}, HOPR=${HIGH_OP_RANGE}, DRVL=${LOW_DRIVER}, DRVH=${HIGH_DRIVER}, PREC=${PRECISION}, KP=${PROP_FACTOR=0.1}, KI=${INT_FACTOR=0}, KD=${DER_FACTOR=0}, SCAN=${SCAN_TIME=.1 second}" )


