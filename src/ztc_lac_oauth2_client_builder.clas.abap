class ZTC_LAC_OAUTH2_CLIENT_BUILDER definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods BUILD_OK
  for testing .
  methods BUILD_FAIL
  for testing
    raising
      ZCX_LAC_OA2C_CREATE_ERROR .
protected section.
private section.

  data MO_CLIENT_BUILDER type ref to ZIF_LAC_OAUTH2_CLIENT_BUILDER .
  data MO_OAUTH2_CLIENT_WRAP_DOUBLE type ref to ZIF_LAC_OAUTH2_CLIENT_WRAP .
  data MO_LOCATOR_DTO_DOUBLE type ref to ZTD_LAC_SVC_LOC_DTO .

  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_OAUTH2_CLIENT_BUILDER IMPLEMENTATION.


  METHOD build_fail.

    DATA: lx_lac_oa2c_create_error TYPE REF TO zcx_lac_oa2c_create_error,
          lt_bapiret               TYPE bapiret2_tab.

    CREATE OBJECT lx_lac_oa2c_create_error.

*   configure CREATE
    cl_abap_testdouble=>configure_call( mo_oauth2_client_wrap_double
      )->raise_exception( lx_lac_oa2c_create_error ).

    mo_oauth2_client_wrap_double->create(
      iv_profile       = space
      iv_configuration = space
    ).

*   @Test
    mo_client_builder->build(
      EXPORTING
        io_locator_dto = mo_locator_dto_double
      IMPORTING
        et_bapiret = lt_bapiret ).

    cl_aunit_assert=>assert_not_initial( lt_bapiret ).

  ENDMETHOD.


  METHOD build_ok.

    DATA mo_oauth2_client TYPE REF TO zif_lac_oauth2_client.

    TRY .
*       @Test
        mo_oauth2_client = mo_client_builder->build( mo_locator_dto_double ).

      CATCH zcx_lac_oa2c_create_error.
        cl_aunit_assert=>fail( ).
    ENDTRY.

    cl_aunit_assert=>assert_bound( mo_oauth2_client ).

  ENDMETHOD.


  METHOD constructor_ok.

    CLEAR mo_client_builder.

    CREATE OBJECT mo_client_builder TYPE zcl_lac_oauth2_client_builder.

    cl_aunit_assert=>assert_bound( mo_client_builder ).

  ENDMETHOD.


  METHOD setup.

    CONSTANTS lc_oauth2_client_wrap TYPE seoclsname VALUE 'ZIF_LAC_OAUTH2_CLIENT_WRAP'.

    mo_oauth2_client_wrap_double ?= cl_abap_testdouble=>create( lc_oauth2_client_wrap ).

    CREATE OBJECT mo_locator_dto_double.

    CREATE OBJECT mo_client_builder TYPE zcl_lac_oauth2_client_builder
      EXPORTING
        io_oauth2_wrap = mo_oauth2_client_wrap_double.

  ENDMETHOD.
ENDCLASS.
