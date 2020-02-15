class ZCL_LAC_HTTP_CLIENT_BUILDER definition
  public
  create public .

public section.

  interfaces ZIF_LAC_HTTP_CLIENT_BUILDER .

  methods CONSTRUCTOR
    importing
      !IO_HTTP_WRAP type ref to ZIF_LAC_HTTP_CLIENT_WRAP optional .
protected section.
private section.

  data MO_HTTP_WRAP type ref to ZIF_LAC_HTTP_CLIENT_WRAP .
ENDCLASS.



CLASS ZCL_LAC_HTTP_CLIENT_BUILDER IMPLEMENTATION.


  METHOD constructor.

    IF io_http_wrap IS BOUND.
      mo_http_wrap = io_http_wrap.
    ELSE.
      CREATE OBJECT mo_http_wrap TYPE zcl_lac_http_client_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_http_client_builder~build.

    DATA: lx_lac_http_client_error TYPE REF TO zcx_lac_http_client_error,
          lo_http_client           TYPE REF TO if_http_client.

    TRY .
        lo_http_client = mo_http_wrap->create_by_url( io_locator_dto->get_host( ) ).

      CATCH zcx_lac_http_client_error INTO lx_lac_http_client_error.
        RAISE EXCEPTION TYPE zcx_lac_builder_fail
          EXPORTING
            textid          = zcx_lac_builder_fail=>cannot_build
            mv_service_type = io_locator_dto->get_service_type( ).
    ENDTRY.

    CREATE OBJECT ro_http_client TYPE zcl_lac_http_client
      EXPORTING
        io_http_client = lo_http_client.

  ENDMETHOD.
ENDCLASS.
