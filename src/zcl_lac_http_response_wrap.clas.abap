class ZCL_LAC_HTTP_RESPONSE_WRAP definition
  public
  create public .

public section.

  interfaces ZIF_LAC_HTTP_RESPONSE_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_HTTP_RESPONSE_WRAP IMPLEMENTATION.


  METHOD zif_lac_http_response_wrap~get_content_type.

    rv_content_type = io_http_response->get_content_type( ).

  ENDMETHOD.


  METHOD zif_lac_http_response_wrap~get_data.

    rv_data = io_http_response->get_data( ).

  ENDMETHOD.


  METHOD zif_lac_http_response_wrap~get_header_fields.

    io_http_response->get_header_fields(
      CHANGING
        fields = rt_fields ).

  ENDMETHOD.


  METHOD zif_lac_http_response_wrap~get_status.

    io_http_response->get_status(
      IMPORTING
        code   = rs_http_receive_status-code
        reason = rs_http_receive_status-reason ).

  ENDMETHOD.
ENDCLASS.
