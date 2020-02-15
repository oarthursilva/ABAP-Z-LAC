class ZTC_LAC_SVC_LOC_DTO definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods GET_SERVICE_TYPE_OK
  for testing .
  methods GET_VALID_FROM_OK
  for testing .
  methods GET_HOST_OK
  for testing .
  methods GET_OAUTH2_PROFILE_OK
  for testing .
  methods GET_OAUTH2_CONFIGURATION_OK
  for testing .
  methods GET_SERVICE_LOCATOR_STRUCT_OK
  for testing .
  methods GET_SVC_LOCATOR_STRUCT_EMPTY
  for testing .
  PROTECTED SECTION.
private section.

  data MO_LOCATOR_DTO type ref to ZCL_LAC_SVC_LOC_DTO .
  data MS_SERVICE_LOCATOR type ZLAC_SVC_CLOUD .

  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_SVC_LOC_DTO IMPLEMENTATION.


  METHOD constructor_ok.

    CLEAR mo_locator_dto.

    CREATE OBJECT mo_locator_dto.

    cl_aunit_assert=>assert_bound( mo_locator_dto ).

  ENDMETHOD.


  METHOD get_host_ok.

    DATA(lv_host_act) = mo_locator_dto->get_host( ).
    DATA(lv_host_exp) = 'SVC_HOST'.

    cl_aunit_assert=>assert_equals(
      act = lv_host_act
      exp = lv_host_exp
    ).

  ENDMETHOD.


  METHOD get_oauth2_configuration_ok.

    DATA(lv_oauth2_configuration_act) = mo_locator_dto->get_oauth2_configuration( ).
    DATA(lv_oauth2_configuration_exp) = 'OAUTH2_CONFIGURATION'.

    cl_aunit_assert=>assert_equals(
      act = lv_oauth2_configuration_act
      exp = lv_oauth2_configuration_exp
    ).

  ENDMETHOD.


  METHOD get_oauth2_profile_ok.

    DATA(lv_oauth2_profile_act) = mo_locator_dto->get_oauth2_profile( ).
    DATA(lv_oauth2_profile_exp) = 'OAUTH2_PROFILE'.

    cl_aunit_assert=>assert_equals(
      act = lv_oauth2_profile_act
      exp = lv_oauth2_profile_exp
    ).

  ENDMETHOD.


  METHOD get_service_locator_struct_ok.

    DATA(ls_locator_struct) = mo_locator_dto->get_service_locator_struct( ).

    cl_aunit_assert=>assert_equals(
      act = ls_locator_struct
      exp = ms_service_locator
    ).

  ENDMETHOD.


  METHOD get_service_type_ok.

    DATA(lv_service_type_act) = mo_locator_dto->get_service_type( ).
    DATA(lv_service_type_exp) = 'SVC_TYPE'.

    cl_aunit_assert=>assert_equals(
      act = lv_service_type_act
      exp = lv_service_type_exp
    ).

  ENDMETHOD.


  method get_svc_locator_struct_empty.

    CLEAR mo_locator_dto.

    CREATE OBJECT mo_locator_dto.

    cl_aunit_assert=>assert_initial(
      mo_locator_dto->get_service_locator_struct( )
    ).

  endmethod.


  METHOD get_valid_from_ok.

    DATA(lv_valid_from_act) = mo_locator_dto->get_valid_from( ).
    DATA(lv_valid_from_exp) = sy-datum.

    cl_aunit_assert=>assert_equals(
      act = lv_valid_from_act
      exp = lv_valid_from_exp
    ).

  ENDMETHOD.


  METHOD setup.

    ms_service_locator-svc_type             = 'SVC_TYPE'.
    ms_service_locator-svc_validfrom        = sy-datum.
    ms_service_locator-svc_host             = 'SVC_HOST'.
    ms_service_locator-oauth2_profile       = 'OAUTH2_PROFILE'.
    ms_service_locator-oauth2_configuration = 'OAUTH2_CONFIGURATION'.

    CREATE OBJECT mo_locator_dto
      EXPORTING
        is_service_locator = ms_service_locator.

  ENDMETHOD.
ENDCLASS.
