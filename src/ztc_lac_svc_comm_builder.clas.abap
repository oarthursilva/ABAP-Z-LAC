class ZTC_LAC_SVC_COMM_BUILDER definition
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
  methods BUILD_DATA_NOT_FOUND_FAIL
  for testing
    raising
      ZCX_LAC_CREATE_CLIENT_FAIL .
protected section.
private section.

  data MO_COMM_BUILDER type ref to ZIF_LAC_SVC_COMM_BUILDER .
  data MO_HTTP_BUILDER_DOUBLE type ref to ZIF_LAC_HTTP_CLIENT_BUILDER .
  data MO_OAUTH2_BUILDER_DOUBLE type ref to ZIF_LAC_OAUTH2_CLIENT_BUILDER .

  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_SVC_COMM_BUILDER IMPLEMENTATION.


  METHOD build_data_not_found_fail.

    DATA: lx_lac_create_client_fail TYPE REF TO zcx_lac_create_client_fail,
          lo_locator_dto            TYPE REF TO zcl_lac_svc_loc_dto.

    CREATE OBJECT lx_lac_create_client_fail.
    CREATE OBJECT lo_locator_dto.

*   configure BUILD
    cl_abap_testdouble=>configure_call( mo_http_builder_double
      )->raise_exception( lx_lac_create_client_fail ).

    mo_http_builder_double->build( lo_locator_dto ).

    TRY .
*       @Test
        mo_comm_builder->build( lo_locator_dto ).
        cl_aunit_assert=>fail( ).

      CATCH zcx_lac_builder_fail ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.


  METHOD build_ok.

    DATA lo_locator_dto TYPE REF TO zcl_lac_svc_loc_dto.

    CREATE OBJECT lo_locator_dto.

    TRY .
*       @Test
        mo_comm_builder->build( lo_locator_dto ).

      CATCH zcx_lac_builder_fail.
        cl_aunit_assert=>fail( ).
    ENDTRY.

  ENDMETHOD.


  METHOD constructor_ok.

    CLEAR mo_comm_builder.

    CREATE OBJECT mo_comm_builder TYPE zcl_lac_svc_comm_builder.

    cl_aunit_assert=>assert_bound( mo_comm_builder ).

  ENDMETHOD.


  METHOD setup.

    CONSTANTS: lc_http_client_builder   TYPE seoclsname VALUE 'ZIF_LAC_HTTP_CLIENT_BUILDER',
               lc_oauth2_client_builder TYPE seoclsname VALUE 'ZIF_LAC_OAUTH2_CLIENT_BUILDER'.

    mo_http_builder_double   ?= cl_abap_testdouble=>create( lc_http_client_builder ).
    mo_oauth2_builder_double ?= cl_abap_testdouble=>create( lc_oauth2_client_builder ).

    CREATE OBJECT mo_comm_builder TYPE zcl_lac_svc_comm_builder
      EXPORTING
        io_http_builder   = mo_http_builder_double
        io_oauth2_builder = mo_oauth2_builder_double.

  ENDMETHOD.
ENDCLASS.
