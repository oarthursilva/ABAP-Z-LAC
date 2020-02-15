class ZTC_LAC_HTTP_CLIENT definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods CREATE_REQUEST_OK
  for testing .
  methods GET_CLIENT_OK
  for testing .
  methods RECEIVE_RESPONSE_FAIL
  for testing
    raising
      ZCX_LAC_HTTP_RESPONSE_FAIL .
  methods RECEIVE_RESPONSE_OK
  for testing .
  methods SEND_REQUEST_FAIL
  for testing
    raising
      ZCX_LAC_HTTP_CLIENT_ERROR .
  methods SEND_REQUEST_OK
  for testing .
  PROTECTED SECTION.
private section.

  data MO_HTTP_CLIENT type ref to ZIF_LAC_HTTP_CLIENT .
  data MO_HTTP_CLIENT_DOUBLE type ref to IF_HTTP_CLIENT .
  data MO_HTTP_CLIENT_WRAP_DOUBLE type ref to ZIF_LAC_HTTP_CLIENT_WRAP .
  data MO_HTTP_RESPONSE_WRAP_DOUBLE type ref to ZIF_LAC_HTTP_RESPONSE_WRAP .

  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_HTTP_CLIENT IMPLEMENTATION.


  METHOD constructor_ok.

    DATA lo_http_client_double TYPE REF TO if_http_client ##NEEDED.

    CLEAR mo_http_client.

    CREATE OBJECT mo_http_client TYPE zcl_lac_http_client
      EXPORTING
        io_http_client = lo_http_client_double.

    cl_aunit_assert=>assert_bound( mo_http_client ).

  ENDMETHOD.


  METHOD create_request_ok.

    DATA lo_http_client TYPE REF TO if_http_client ##NEEDED.

*   configure SET_METHOD
    cl_abap_testdouble=>configure_call( mo_http_client_wrap_double
      )->times( 1 ).

    mo_http_client_wrap_double->set_method(
      io_http_client = lo_http_client
      iv_method      = space
    ).

*   configure SET_PROPERTYTYPE_LOGON_POPUP
    cl_abap_testdouble=>configure_call( mo_http_client_wrap_double
      )->and_expect( )->is_called_once( ).

    mo_http_client_wrap_double->set_propertytype_logon_popup(
      io_http_client              = lo_http_client
      iv_propertytype_logon_popup = 0
    ).

*   @Test
    mo_http_client->create_request( lo_http_client ).

    cl_abap_testdouble=>verify_expectations( mo_http_client_wrap_double ).

  ENDMETHOD.


  METHOD get_client_ok.

    DATA(lo_http_client) = mo_http_client->get_client( ).

    cl_aunit_assert=>assert_bound( lo_http_client ).

  ENDMETHOD.


  METHOD receive_response_fail.

    DATA: lo_http_client            TYPE REF TO if_http_client ##NEEDED,
          lx_lac_http_response_fail TYPE REF TO zcx_lac_http_response_fail.

    CREATE OBJECT lx_lac_http_response_fail.

*   configure SET_METHOD
    cl_abap_testdouble=>configure_call( mo_http_client_wrap_double
      )->raise_exception( lx_lac_http_response_fail ).

    mo_http_client_wrap_double->receive( lo_http_client ).

*   @Test
    TRY .
        mo_http_client->receive_response( lo_http_client ).
        cl_aunit_assert=>fail( ).

      CATCH zcx_lac_http_response_fail ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.


  METHOD receive_response_ok.

    DATA: lo_http_response     TYPE REF TO if_http_response ##NEEDED,
          lv_response_data_act TYPE xstring,
          lv_response_data_exp TYPE xstring VALUE '43876543345670'.

*   configure CREATE
    cl_abap_testdouble=>configure_call( mo_http_response_wrap_double
      )->returning( lv_response_data_exp ).

    mo_http_response_wrap_double->get_data( lo_http_response ).

    TRY .
*       @Test
        lv_response_data_act = mo_http_client->receive_response( mo_http_client_double ).
      CATCH zcx_lac_http_response_fail.
        cl_aunit_assert=>fail( ).
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      act = lv_response_data_act
      exp = lv_response_data_exp
    ).

  ENDMETHOD.


  METHOD send_request_fail.

    DATA: lo_http_client           TYPE REF TO if_http_client ##NEEDED,
          lx_lac_http_client_error TYPE REF TO zcx_lac_http_client_error.

    CREATE OBJECT lx_lac_http_client_error.

*   configure RECEIVE
    cl_abap_testdouble=>configure_call( mo_http_client_wrap_double
      )->raise_exception( lx_lac_http_client_error ).

    mo_http_client_wrap_double->send( lo_http_client ).

    TRY .
        mo_http_client->send_request( lo_http_client ).
        cl_aunit_assert=>fail( ).

      CATCH zcx_lac_http_client_error ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.


  METHOD send_request_ok.

    DATA lo_http_client TYPE REF TO if_http_client ##NEEDED.

    TRY .
        mo_http_client->send_request( lo_http_client ).

      CATCH zcx_lac_http_client_error.
        cl_aunit_assert=>fail( ).
    ENDTRY.

  ENDMETHOD.


  METHOD setup.

    CONSTANTS: lc_http_client        TYPE seoclsname VALUE 'IF_HTTP_CLIENT',
               lc_http_client_wrap   TYPE seoclsname VALUE 'ZIF_LAC_HTTP_CLIENT_WRAP',
               lc_http_response_wrap TYPE seoclsname VALUE 'ZIF_LAC_HTTP_RESPONSE_WRAP'.

    mo_http_client_double        ?= cl_abap_testdouble=>create( lc_http_client ).
    mo_http_client_wrap_double   ?= cl_abap_testdouble=>create( lc_http_client_wrap ).
    mo_http_response_wrap_double ?= cl_abap_testdouble=>create( lc_http_response_wrap ).

    CREATE OBJECT mo_http_client TYPE zcl_lac_http_client
      EXPORTING
        io_http_client        = mo_http_client_double
        io_http_wrap          = mo_http_client_wrap_double
        io_http_response_wrap = mo_http_response_wrap_double.

  ENDMETHOD.
ENDCLASS.
