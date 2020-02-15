class ZTC_LAC_SVC_COMM definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods REQUEST_OK
  for testing
    raising
      ZCX_LAC_HTTP_CLIENT_ERROR .
  methods RESPONSE_OK
  for testing
    raising
      ZCX_LAC_HTTP_RESPONSE_FAIL .
  methods REQUEST_FAIL
  for testing
    raising
      ZCX_LAC_HTTP_CLIENT_ERROR .
  methods RESPONSE_FAIL
  for testing
    raising
      ZCX_LAC_HTTP_RESPONSE_FAIL .
protected section.
private section.

  data MO_HTTP_CLIENT_DOUBLE type ref to ZIF_LAC_HTTP_CLIENT .
  data MO_HTTP_DOUBLE type ref to IF_HTTP_CLIENT .
  data MO_OAUTH2_CLIENT_DOUBLE type ref to ZIF_LAC_OAUTH2_CLIENT .
  data MO_SERVICE_COMM type ref to ZIF_LAC_SVC_COMM .

  methods SETUP .
  methods TEARDOWN .
ENDCLASS.



CLASS ZTC_LAC_SVC_COMM IMPLEMENTATION.


  METHOD constructor_ok.

    CLEAR mo_service_comm.

    CREATE OBJECT mo_service_comm TYPE zcl_lac_svc_comm.

    cl_aunit_assert=>assert_bound( mo_service_comm ).

  ENDMETHOD.


  METHOD request_fail.

    DATA: lx_lac_http_client_error TYPE REF TO zcx_lac_http_client_error,
          lt_bapiret               TYPE bapiret2_tab.

    CREATE OBJECT lx_lac_http_client_error.

    CLEAR mo_http_double.

*   configure SEND_REQUEST
    cl_abap_testdouble=>configure_call( mo_http_client_double
      )->raise_exception( lx_lac_http_client_error ).

    mo_http_client_double->send_request( mo_http_double ).

*   @Test
    lt_bapiret = mo_service_comm->request( ).

    cl_aunit_assert=>assert_not_initial( lt_bapiret ).

  ENDMETHOD.


  METHOD request_ok.

    DATA lo_oauth_client TYPE REF TO if_oauth2_client.

*   configure GET_HTTP_CLIENT
    cl_abap_testdouble=>configure_call( mo_http_client_double
      )->returning( mo_http_double )->times( 1 ).

    mo_http_client_double->get_client( ).

*   configure GET_OAUTH2_CLIENT
    cl_abap_testdouble=>configure_call( mo_oauth2_client_double
      )->returning( lo_oauth_client )->times( 1 ).

    mo_oauth2_client_double->get_client( ).

*   configure CREATE_REQUEST
    cl_abap_testdouble=>configure_call( mo_http_client_double
      )->times( 1 ).

    mo_http_client_double->create_request(
      io_http_client = mo_http_double
      iv_method      = zcl_lac_svc_constants=>sc_get
    ).

*   configure CREATE_CLIENT_CREDENTIALS
    cl_abap_testdouble=>configure_call( mo_oauth2_client_double
      )->times( 1 ).

    mo_oauth2_client_double->create_client_credentials(
      io_http_client   = mo_http_double
      io_oauth2_client = lo_oauth_client ).

*   configure SEND_REQUEST
    cl_abap_testdouble=>configure_call( mo_http_client_double
      )->times( 1 ).

    mo_http_client_double->send_request( mo_http_double ).

*   @Test
    mo_service_comm->request( ).

    cl_abap_testdouble=>verify_expectations( mo_http_client_double ).
    cl_abap_testdouble=>verify_expectations( mo_oauth2_client_double ).

  ENDMETHOD.


  METHOD response_fail.

    DATA lx_lac_http_response_fail TYPE REF TO zcx_lac_http_response_fail.

    CLEAR mo_http_double.
    CREATE OBJECT lx_lac_http_response_fail.

    cl_abap_testdouble=>configure_call( mo_http_client_double
      )->raise_exception( lx_lac_http_response_fail ).

    mo_http_client_double->receive_response( mo_http_double ).

    TRY .
      mo_service_comm->response( ).
      cl_aunit_assert=>fail( ).

    CATCH zcx_lac_http_response_fail ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.


  METHOD response_ok.

    DATA lv_response           TYPE string.
    CONSTANTS lv_response_mock TYPE string VALUE '1234567890'.

*   configure GET_CLIENT
    cl_abap_testdouble=>configure_call( mo_http_client_double
      )->returning( mo_http_double ).

    mo_http_client_double->get_client( ).

*   configure RECEIVE_RESPONSE
    cl_abap_testdouble=>configure_call( mo_http_client_double
      )->returning( lv_response_mock ).

    mo_http_client_double->receive_response( mo_http_double ).

*   @Test
    lv_response = mo_service_comm->response( ).

    cl_aunit_assert=>assert_equals(
      act = lv_response
      exp = lv_response_mock ).

  ENDMETHOD.


  METHOD setup.

    CONSTANTS: lc_obj_http_client   TYPE seoclsname VALUE 'ZIF_LAC_HTTP_CLIENT',
               lc_obj_http          TYPE seoclsname VALUE 'IF_HTTP_CLIENT',
               lc_obj_oauth2_client TYPE seoclsname VALUE 'ZIF_LAC_OAUTH2_CLIENT'.

    mo_http_client_double   ?= cl_abap_testdouble=>create( lc_obj_http_client ).
    mo_http_double          ?= cl_abap_testdouble=>create( lc_obj_http ).
    mo_oauth2_client_double ?= cl_abap_testdouble=>create( lc_obj_oauth2_client ).

    CREATE OBJECT mo_service_comm TYPE zcl_lac_svc_comm
      EXPORTING
        io_http_client   = mo_http_client_double
        io_oauth2_client = mo_oauth2_client_double.

  ENDMETHOD.


  METHOD teardown.
    CLEAR: mo_http_client_double,
           mo_oauth2_client_double,
           mo_http_double.
  ENDMETHOD.
ENDCLASS.
