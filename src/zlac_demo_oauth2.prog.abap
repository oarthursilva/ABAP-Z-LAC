*&---------------------------------------------------------------------*
*& Report ZLAC_DEMO_OAUTH2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zlac_demo_oauth2.

PARAMETERS p_svc_tp TYPE zlac_svc_type DEFAULT zcl_lac_svc_constants=>sc_scp_service.

  DATA: lo_scms_string_wrap TYPE REF TO zif_scms_string_wrap,
        lo_locator_builder  TYPE REF TO zif_lac_svc_loc_dto_builder,
        lo_locator          TYPE REF TO zcl_lac_svc_loc_dto,
        lo_comm_builder     TYPE REF TO zif_lac_svc_comm_builder,
        lo_comm             TYPE REF TO zif_lac_svc_comm.

  CREATE OBJECT lo_scms_string_wrap TYPE zcl_scms_string_wrap.

  CREATE OBJECT lo_locator_builder TYPE zcl_lac_svc_loc_dto_builder.
  lo_locator = lo_locator_builder->build( p_svc_tp ).

  CREATE OBJECT lo_comm_builder TYPE zcl_lac_svc_comm_builder.
  lo_comm = lo_comm_builder->build( lo_locator ).

* HTTP GET request
  lo_comm->request( zcl_lac_svc_constants=>sc_get ).

* HTTP response
  DATA(lv_xstring_content) = lo_comm->response( ).

  DATA(ls_binary_content) = lo_scms_string_wrap->scms_xstring_to_binary( lv_xstring_content ).
  DATA(ls_string_content) = lo_scms_string_wrap->scms_binary_to_string(
                              iv_input_length = ls_binary_content-output_length
                              it_binary_tab   = ls_binary_content-binary_tab ).
  WRITE ls_string_content-text.
