class ZCL_LAC_SVC_COMM definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SVC_COMM .

  methods CONSTRUCTOR
    importing
      !IO_HTTP_CLIENT type ref to ZIF_LAC_HTTP_CLIENT optional
      !IO_OAUTH2_CLIENT type ref to ZIF_LAC_OAUTH2_CLIENT optional .
protected section.
private section.

  data MO_HTTP_CLIENT type ref to ZIF_LAC_HTTP_CLIENT .
  data MO_OAUTH2_CLIENT type ref to ZIF_LAC_OAUTH2_CLIENT .
ENDCLASS.



CLASS ZCL_LAC_SVC_COMM IMPLEMENTATION.


  METHOD constructor.

    mo_http_client = io_http_client.

    mo_oauth2_client = io_oauth2_client.

  ENDMETHOD.


  METHOD zif_lac_svc_comm~request.

    DATA: lx_lac_http_client_error TYPE REF TO zcx_lac_http_client_error,
          lo_http_client           TYPE REF TO if_http_client,
          lo_oauth2_client         TYPE REF TO if_oauth2_client.

    lo_http_client   = mo_http_client->get_client( ).
    lo_oauth2_client = mo_oauth2_client->get_client( ).

    mo_http_client->create_request(
      io_http_client = lo_http_client
      iv_method      = iv_method
    ).

    mo_oauth2_client->create_client_credentials(
      io_http_client   = lo_http_client
      io_oauth2_client = lo_oauth2_client
    ).

    TRY .
        mo_http_client->send_request( lo_http_client ).

      CATCH zcx_lac_http_client_error INTO lx_lac_http_client_error.
        et_bapiret = lx_lac_http_client_error->build_bapiret_tab( ).
    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_svc_comm~response.

    DATA lo_http_client TYPE REF TO if_http_client.

    lo_http_client = mo_http_client->get_client( ).

    rv_response = mo_http_client->receive_response( lo_http_client ).

  ENDMETHOD.
ENDCLASS.
