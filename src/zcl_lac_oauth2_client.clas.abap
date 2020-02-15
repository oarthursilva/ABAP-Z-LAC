class ZCL_LAC_OAUTH2_CLIENT definition
  public
  create public .

public section.

  interfaces ZIF_LAC_OAUTH2_CLIENT .

  methods CONSTRUCTOR
    importing
      !IO_OAUTH2_CLIENT type ref to IF_OAUTH2_CLIENT
      !IO_OAUTH2_WRAP type ref to ZIF_LAC_OAUTH2_CLIENT_WRAP optional .
protected section.
PRIVATE SECTION.

  DATA mo_oauth2_wrap TYPE REF TO zif_lac_oauth2_client_wrap ##NEEDED.
  DATA mo_oauth2_client TYPE REF TO if_oauth2_client .
ENDCLASS.



CLASS ZCL_LAC_OAUTH2_CLIENT IMPLEMENTATION.


  METHOD constructor.
    mo_oauth2_client = io_oauth2_client.

    IF io_oauth2_wrap IS BOUND.
      mo_oauth2_wrap = io_oauth2_wrap.
    ELSE.
      CREATE OBJECT mo_oauth2_wrap TYPE zcl_lac_oauth2_client_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_oauth2_client~create_client_credentials.

    TRY .
        mo_oauth2_wrap->set_token( io_http_client   = io_http_client
                                   io_oauth2_client = io_oauth2_client ).

      CATCH cx_oa2c.
        TRY .
            mo_oauth2_wrap->execute_cc_flow( io_oauth2_client ).

            mo_oauth2_wrap->set_token( io_http_client   = io_http_client
                                       io_oauth2_client = io_oauth2_client ).
          CATCH cx_oa2c_runtime ##NO_HANDLER.
        ENDTRY.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_oauth2_client~get_client.
    ro_oauth2_client = mo_oauth2_client.
  ENDMETHOD.
ENDCLASS.
