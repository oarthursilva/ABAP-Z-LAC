class ZCL_LAC_OAUTH2_CLIENT_BUILDER definition
  public
  create public .

public section.

  interfaces ZIF_LAC_OAUTH2_CLIENT_BUILDER .

  methods CONSTRUCTOR
    importing
      !IO_OAUTH2_WRAP type ref to ZIF_LAC_OAUTH2_CLIENT_WRAP optional .
protected section.
private section.

  data MO_OAUTH2_WRAP type ref to ZIF_LAC_OAUTH2_CLIENT_WRAP .
ENDCLASS.



CLASS ZCL_LAC_OAUTH2_CLIENT_BUILDER IMPLEMENTATION.


  METHOD constructor.

    IF io_oauth2_wrap IS BOUND.
      mo_oauth2_wrap = io_oauth2_wrap.
    ELSE.
      CREATE OBJECT mo_oauth2_wrap TYPE zcl_lac_oauth2_client_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_oauth2_client_builder~build.

    DATA: lo_oauth2_client         TYPE REF TO if_oauth2_client,
          lx_lac_oa2c_create_error TYPE REF TO zcx_lac_oa2c_create_error.

    TRY .
        lo_oauth2_client = mo_oauth2_wrap->create(
          iv_profile       = io_locator_dto->get_oauth2_profile( )
          iv_configuration = io_locator_dto->get_oauth2_configuration( )
        ).
      CATCH zcx_lac_oa2c_create_error INTO lx_lac_oa2c_create_error.
        APPEND lx_lac_oa2c_create_error->build_bapiret( ) TO et_bapiret.
    ENDTRY.

    CREATE OBJECT ro_oauth2_client TYPE zcl_lac_oauth2_client
      EXPORTING
        io_oauth2_client = lo_oauth2_client.

  ENDMETHOD.
ENDCLASS.
