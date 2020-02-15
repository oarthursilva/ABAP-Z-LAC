interface ZIF_LAC_SVC_LOC_DTO
  public .


  methods GET_SERVICE_TYPE
    returning
      value(RV_SERVICE_TYPE) type ZLAC_SVC_TYPE .
  methods GET_VALID_FROM
    returning
      value(RV_SERVICE_VALID_FROM) type ZLAC_VALIDFROM .
  methods GET_HOST
    returning
      value(RV_SERVICE_HOST) type ZLAC_SVC_HOST .
  methods GET_OAUTH2_PROFILE
    returning
      value(RV_OAUTH2_PROFILE) type OA2C_PROFILE .
  methods GET_OAUTH2_CONFIGURATION
    returning
      value(RV_OAUTH2_CONFIGURATION) type OA2C_CONFIGURATION .
  methods GET_SERVICE_LOCATOR_STRUCT
    returning
      value(RS_SERVICE_LOCATOR) type ZLAC_SVC_CLOUD .
endinterface.
