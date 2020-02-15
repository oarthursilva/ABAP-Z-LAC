class ZCL_LAC_SVC_COMM_BUILDER definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SVC_COMM_BUILDER .

  methods CONSTRUCTOR
    importing
      !IO_HTTP_BUILDER type ref to ZIF_LAC_HTTP_CLIENT_BUILDER optional
      !IO_OAUTH2_BUILDER type ref to ZIF_LAC_OAUTH2_CLIENT_BUILDER optional .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mo_http_builder TYPE REF TO zif_lac_http_client_builder .
    DATA mo_oauth2_builder TYPE REF TO zif_lac_oauth2_client_builder .
ENDCLASS.



CLASS ZCL_LAC_SVC_COMM_BUILDER IMPLEMENTATION.


  METHOD constructor.

    IF io_http_builder IS BOUND.
      mo_http_builder = io_http_builder.
    ELSE.
      CREATE OBJECT mo_http_builder TYPE zcl_lac_http_client_builder.
    ENDIF.

    IF io_oauth2_builder IS BOUND.
      mo_oauth2_builder = io_oauth2_builder.
    ELSE.
      CREATE OBJECT mo_oauth2_builder TYPE zcl_lac_oauth2_client_builder.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_svc_comm_builder~build.

    DATA: lo_oauth2_client          TYPE REF TO zif_lac_oauth2_client,
          lo_http_client            TYPE REF TO zif_lac_http_client.

    lo_oauth2_client = mo_oauth2_builder->build( io_locator_dto ).

    lo_http_client = mo_http_builder->build( io_locator_dto ).

    ro_service_communicator = NEW zcl_lac_svc_comm(
      io_oauth2_client = lo_oauth2_client
      io_http_client   = lo_http_client
    ).

  ENDMETHOD.
ENDCLASS.
