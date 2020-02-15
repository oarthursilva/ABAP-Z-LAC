class ZCL_LAC_OAUTH2_CLIENT_WRAP definition
  public
  create public .

public section.

  interfaces ZIF_LAC_OAUTH2_CLIENT_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_OAUTH2_CLIENT_WRAP IMPLEMENTATION.


  METHOD zif_lac_oauth2_client_wrap~create.

    DATA: lx_oa2c_kernel_too_old TYPE REF TO cx_oa2c_kernel_too_old,
          lx_oa2c                TYPE REF TO cx_oa2c.

    TRY .
        cl_oauth2_client=>create(
          EXPORTING
            i_profile       = iv_profile
            i_configuration = iv_configuration
          RECEIVING
            ro_oauth2_client = ro_oauth2_client ).

      CATCH cx_oa2c INTO lx_oa2c.
        RAISE EXCEPTION TYPE zcx_lac_oa2c_create_error
          EXPORTING
            previous = lx_oa2c.

      CATCH cx_oa2c_kernel_too_old INTO lx_oa2c_kernel_too_old.

    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_oauth2_client_wrap~execute_cc_flow.

    TRY.
        io_oauth2_client->execute_cc_flow( ).

      CATCH cx_oa2c_runtime.
        RAISE EXCEPTION TYPE cx_oa2c_runtime
          EXPORTING
            textid = cx_oa2c_runtime=>cx_oa2c_runtime.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_oauth2_client_wrap~set_token.

    DATA lx_oa2c_runtime TYPE REF TO cx_oa2c_runtime.

    CHECK io_oauth2_client IS BOUND.

    TRY .
      io_oauth2_client->set_token( io_http_client ).

    CATCH cx_oa2c_runtime INTO lx_oa2c_runtime.
      RAISE EXCEPTION TYPE cx_oa2c_runtime
        EXPORTING
          textid = cx_oa2c_runtime=>cx_oa2c_runtime.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
