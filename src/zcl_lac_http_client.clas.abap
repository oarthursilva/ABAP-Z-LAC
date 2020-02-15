class ZCL_LAC_HTTP_CLIENT definition
  public
  create public .

public section.

  interfaces ZIF_LAC_HTTP_CLIENT .

  methods CONSTRUCTOR
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
      !IO_HTTP_WRAP type ref to ZIF_LAC_HTTP_CLIENT_WRAP optional
      !IO_HTTP_RESPONSE_WRAP type ref to ZIF_LAC_HTTP_RESPONSE_WRAP optional .
  PROTECTED SECTION.
private section.

  data MO_HTTP_CLIENT type ref to IF_HTTP_CLIENT .
  data MO_HTTP_RESPONSE_WRAP type ref to ZIF_LAC_HTTP_RESPONSE_WRAP .
  data MO_HTTP_WRAP type ref to ZIF_LAC_HTTP_CLIENT_WRAP .
ENDCLASS.



CLASS ZCL_LAC_HTTP_CLIENT IMPLEMENTATION.


  METHOD constructor.

    mo_http_client = io_http_client.

    IF io_http_wrap IS BOUND.
      mo_http_wrap = io_http_wrap.
    ELSE.
      CREATE OBJECT mo_http_wrap TYPE zcl_lac_http_client_wrap.
    ENDIF.

    IF io_http_response_wrap IS BOUND.
      mo_http_response_wrap = io_http_response_wrap.
    ELSE.
      CREATE OBJECT mo_http_response_wrap TYPE zcl_lac_http_response_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_http_client~create_request.

    mo_http_wrap->set_method(
      io_http_client = io_http_client
      iv_method      = iv_method
    ).

    mo_http_wrap->set_propertytype_logon_popup(
      io_http_client = io_http_client
      iv_propertytype_logon_popup = 0
    ).

  ENDMETHOD.


  METHOD zif_lac_http_client~get_client.

    ro_http_client = mo_http_client.

  ENDMETHOD.


  METHOD zif_lac_http_client~receive_response.

    mo_http_wrap->receive( io_http_client ).

    rv_data_response = mo_http_response_wrap->get_data( io_http_client->response ).

  ENDMETHOD.


  METHOD zif_lac_http_client~send_request.

    mo_http_wrap->send( io_http_client ).

  ENDMETHOD.
ENDCLASS.
