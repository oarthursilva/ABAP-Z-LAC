class ZCL_LAC_POPUP definition
  public
  create protected .

public section.

  methods CONSTRUCTOR
    importing
      !IO_SALV_WRAP type ref to ZCL_LAC_SALV_WRAP optional .
protected section.

  methods CALL_SCREEN
    importing
      !IT_DATA type STANDARD TABLE
      !IV_TITLE type LVC_TITLE optional
    raising
      CX_SALV_ERROR .
private section.

  constants:
    BEGIN OF sc_popup_positions,
        lines_min    TYPE i VALUE 3,
        start_line   TYPE i VALUE 5,
        start_column TYPE i VALUE 70,
      END OF sc_popup_positions .
  data MO_POPUP_HANDLER type ref to ZIF_LAC_POPUP_HANDLER .
  data MO_SALV_WRAP type ref to ZIF_LAC_SALV_WRAP .

  methods HANDLER_ACTIVATION
    importing
      !IS_SALV_RETURN type ZLAC_SALV_RETURN .
  methods CREATE_SCREEN_POPUP
    importing
      !IT_DATA type STANDARD TABLE
      !IO_SALV type ref to CL_SALV_TABLE .
ENDCLASS.



CLASS ZCL_LAC_POPUP IMPLEMENTATION.


  METHOD call_screen.

    DATA ls_salv_data TYPE zlac_salv_return.

    ls_salv_data = mo_salv_wrap->create_salv_table(
      it_data = it_data
    ).

    create_screen_popup(
      io_salv = ls_salv_data-salv
      it_data = it_data
    ).

    mo_salv_wrap->set_optimize_columns(
      ls_salv_data-salv
    ).

    mo_salv_wrap->set_list_header(
      io_salv  = ls_salv_data-salv
      iv_title = iv_title
    ).

    handler_activation( ls_salv_data ).

    mo_salv_wrap->display( ls_salv_data-salv ).

  ENDMETHOD.


  METHOD constructor.

    IF io_salv_wrap IS BOUND.
      mo_salv_wrap = io_salv_wrap.
    ELSE.
      CREATE OBJECT mo_salv_wrap TYPE zcl_lac_salv_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD create_screen_popup.

    DATA: lv_lines_count TYPE i,
          lv_column_size TYPE i.

    lv_lines_count = lines( it_data ).

    IF lv_lines_count < sc_popup_positions-lines_min.
      lv_lines_count = sc_popup_positions-lines_min.
    ENDIF.

    mo_salv_wrap->set_screen_popup(
      io_salv         = io_salv
      iv_start_column = sc_popup_positions-start_column
      iv_end_column   = sc_popup_positions-start_column + lv_column_size
      iv_start_line   = sc_popup_positions-start_line
      iv_end_line     = sc_popup_positions-start_line   + lv_lines_count
    ).

  ENDMETHOD.


  METHOD handler_activation.

    DATA lo_grid_data TYPE REF TO zcl_lac_grid_data.

    CHECK mo_popup_handler IS BOUND.

    CREATE OBJECT lo_grid_data
      EXPORTING
        io_salv_table = is_salv_return-salv
        id_data       = is_salv_return-data.

    mo_popup_handler->activate( lo_grid_data ).

  ENDMETHOD.
ENDCLASS.
