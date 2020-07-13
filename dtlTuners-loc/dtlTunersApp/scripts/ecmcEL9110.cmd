#-d /**
#-d   \brief hardware script for EL9110
#-d   \details Power supply terminal with refresh of E-Bus
#-d   \author Maurizio Montis | INFN-LNL
#-d   \file
#-d */

#- ###########################################################
#- ############ Information:
#-  Description: Power supply terminal with refresh of E-Bus
#-
#- ###########################################################

epicsEnvSet("ECMC_EC_HWTYPE"             "EL9110")
epicsEnvSet("ECMC_EC_VENDOR_ID"          "0x2")
epicsEnvSet("ECMC_EC_PRODUCT_ID"         "0x23963052")

ecmcConfigOrDie "Cfg.EcSlaveVerify(0,${ECMC_EC_SLAVE_NUM},${ECMC_EC_VENDOR_ID},${ECMC_EC_PRODUCT_ID})"

ecmcConfigOrDie "Cfg.EcAddEntryComplete(${ECMC_EC_SLAVE_NUM},${ECMC_EC_VENDOR_ID},${ECMC_EC_PRODUCT_ID},2,0,0x1a00,0x6000,0x1,1,EBUS_UNDERVOLTAGE)"
ecmcConfigOrDie "Cfg.EcAddEntryComplete(${ECMC_EC_SLAVE_NUM},${ECMC_EC_VENDOR_ID},${ECMC_EC_PRODUCT_ID},2,0,0x1a01,0x6000,0x1,1,POWER_UNDERVOLTAGE)"
