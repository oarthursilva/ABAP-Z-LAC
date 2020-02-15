class ZCL_LAC_HTTP_CLIENT_WRAP definition
  public
  create public .

public section.

  interfaces ZIF_LAC_HTTP_CLIENT_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_HTTP_CLIENT_WRAP IMPLEMENTATION.


  METHOD zif_lac_http_client_wrap~close.

    io_http_client->close(
      EXCEPTIONS
        http_invalid_state = 1
        OTHERS             = 2
    ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_http_client_error
        EXPORTING
          textid = zcx_lac_http_client_error=>http_invalidate_state.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_http_client_wrap~create_by_url.

    cl_http_client=>create_by_url(
      EXPORTING
        url                = iv_url
        ssl_id             = iv_ssl_id
      IMPORTING
        client             = ro_client
      EXCEPTIONS
        argument_not_found = 1
        plugin_not_active  = 2
        internal_error     = 3
        OTHERS             = 4 ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_create_client_fail
        EXPORTING
          textid = zcx_lac_create_client_fail=>not_reachable
          mv_url = iv_url.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_http_client_wrap~receive.

    io_http_client->receive(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        OTHERS                     = 4 ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_http_response_fail
        EXPORTING
          textid = zcx_lac_http_response_fail=>client_not_created.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_http_client_wrap~send.

    io_http_client->send(
      EXCEPTIONS
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        OTHERS                     = 5 ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_http_client_error
        EXPORTING
          textid = zcx_lac_http_client_error=>send_communication_failure.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_http_client_wrap~set_method.

    io_http_client->request->set_method( iv_method ).

  ENDMETHOD.


  METHOD zif_lac_http_client_wrap~set_propertytype_logon_popup.

    io_http_client->propertytype_logon_popup = iv_propertytype_logon_popup.

  ENDMETHOD.
ENDCLASS.
