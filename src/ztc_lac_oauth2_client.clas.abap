class ZTC_LAC_OAUTH2_CLIENT definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods CREATE_CLIENT_CREDENTIALS_OK
  for testing .
  methods CREATE_CLIENT_CREDENTIALS_FAIL
  for testing
    raising
      CX_OA2C_RUNTIME .
  methods GET_CLIENT_OK
  for testing .
  PROTECTED SECTION.
private section.

  data MO_OAUTH2_CLIENT type ref to ZIF_LAC_OAUTH2_CLIENT .
  data MO_OAUTH2_CLIENT_WRAP_DOUBLE type ref to ZIF_LAC_OAUTH2_CLIENT_WRAP .
  data MO_OAUTH2_DOUBLE type ref to IF_OAUTH2_CLIENT .

  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_OAUTH2_CLIENT IMPLEMENTATION.


  METHOD constructor_ok.

    CLEAR mo_oauth2_client.

    CREATE OBJECT mo_oauth2_client TYPE zcl_lac_oauth2_client
      EXPORTING
        io_oauth2_client = mo_oauth2_double.

    cl_aunit_assert=>assert_bound( mo_oauth2_client ).

  ENDMETHOD.


  METHOD create_client_credentials_fail.

    DATA: lx_oa2c_runtime  TYPE REF TO cx_oa2c_runtime,
          lo_http_client   TYPE REF TO if_http_client ##NEEDED,
          lo_oauth2_client TYPE REF TO if_oauth2_client ##NEEDED.

    CREATE OBJECT lx_oa2c_runtime.

*   configure SET_TOKEN
    cl_abap_testdouble=>configure_call( mo_oauth2_client_wrap_double
      )->raise_exception( lx_oa2c_runtime ).

    mo_oauth2_client_wrap_double->set_token(
      io_http_client   = lo_http_client
      io_oauth2_client = lo_oauth2_client ).

*   @Test
    mo_oauth2_client->create_client_credentials(
      io_http_client   = lo_http_client
      io_oauth2_client = lo_oauth2_client
     ).

  ENDMETHOD.


  METHOD create_client_credentials_ok.

    DATA: lo_http_client   TYPE REF TO if_http_client ##NEEDED,
          lo_oauth2_client TYPE REF TO if_oauth2_client ##NEEDED.

*   @Test
    mo_oauth2_client->create_client_credentials(
      io_http_client   = lo_http_client
      io_oauth2_client = lo_oauth2_client
     ).

  ENDMETHOD.


  METHOD get_client_ok.

    DATA lo_oauth2_client TYPE REF TO if_oauth2_client.

    lo_oauth2_client = mo_oauth2_client->get_client( ).

    cl_aunit_assert=>assert_bound( lo_oauth2_client ).

  ENDMETHOD.


  METHOD setup.

    CONSTANTS: lc_oauth2_client      TYPE seoclsname VALUE 'IF_OAUTH2_CLIENT',
               lc_oauth2_client_wrap TYPE seoclsname VALUE 'ZIF_LAC_OAUTH2_CLIENT_WRAP'.

    mo_oauth2_double             ?= cl_abap_testdouble=>create( lc_oauth2_client ).
    mo_oauth2_client_wrap_double ?= cl_abap_testdouble=>create( lc_oauth2_client_wrap ).

    CREATE OBJECT mo_oauth2_client TYPE zcl_lac_oauth2_client
      EXPORTING
        io_oauth2_client = mo_oauth2_double
        io_oauth2_wrap   = mo_oauth2_client_wrap_double.

  ENDMETHOD.
ENDCLASS.
