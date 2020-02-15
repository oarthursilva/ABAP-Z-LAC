class ZCL_LAC_SVC_LOC_DTO definition
  public
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IS_SERVICE_LOCATOR type ZLAC_SVC_CLOUD optional .
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
  PROTECTED SECTION.
private section.

  data MS_SERVICE_LOCATOR type ZLAC_SVC_CLOUD .
ENDCLASS.



CLASS ZCL_LAC_SVC_LOC_DTO IMPLEMENTATION.


  METHOD constructor.

    IF is_service_locator IS NOT INITIAL.
      ms_service_locator = is_service_locator.
    ELSE.
      CLEAR ms_service_locator.
    ENDIF.

  ENDMETHOD.


  METHOD get_host.
    rv_service_host = ms_service_locator-svc_host.
  ENDMETHOD.


  METHOD get_oauth2_configuration.
    rv_oauth2_configuration = ms_service_locator-oauth2_configuration.
  ENDMETHOD.


  METHOD get_oauth2_profile.
    rv_oauth2_profile = ms_service_locator-oauth2_profile.
  ENDMETHOD.


  METHOD get_service_locator_struct.
    rs_service_locator = ms_service_locator.
  ENDMETHOD.


  METHOD get_service_type.
    rv_service_type = ms_service_locator-svc_type.
  ENDMETHOD.


  METHOD get_valid_from.
    rv_service_valid_from = ms_service_locator-svc_validfrom.
  ENDMETHOD.
ENDCLASS.
