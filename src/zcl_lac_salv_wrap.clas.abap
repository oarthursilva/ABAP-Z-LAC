class ZCL_LAC_SALV_WRAP definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SALV_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_SALV_WRAP IMPLEMENTATION.


  METHOD zif_lac_salv_wrap~add_function.

    DATA lo_functions TYPE REF TO cl_salv_functions_list.

    lo_functions = io_salv->get_functions( ).
    lo_functions->add_function(
        name     = iv_name
        icon     = iv_icon
        text     = iv_text
        tooltip  = iv_tooltip
        position = iv_position
    ).

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~create_salv_table.

    FIELD-SYMBOLS <table> TYPE ANY TABLE.
    DATA lr_data TYPE REF TO data.

    CREATE DATA lr_data LIKE it_data.
    ASSIGN lr_data->* TO <table>.

    IF io_container IS BOUND.
      cl_salv_table=>factory(
        EXPORTING
          r_container  = io_container
        IMPORTING
          r_salv_table = rs_salv_return-salv
        CHANGING
          t_table      = <table>
      ).

    ELSE.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = rs_salv_return-salv
        CHANGING
          t_table      = <table>
      ).
    ENDIF.

    rs_salv_return-data = lr_data.

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~display.

    io_salv_wrap->display( ).

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~factory.

    DATA: ld_table TYPE REF TO data.

    FIELD-SYMBOLS: <fs_table>    TYPE ANY TABLE,
                   <fs_table_in> TYPE ANY TABLE.

    ASSIGN id_data->* TO <fs_table_in>.

    CREATE DATA ld_table LIKE <fs_table_in>.
    ASSIGN ld_table->* TO <fs_table>.

    <fs_table> = <fs_table_in>.

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = ro_salv
          CHANGING
            t_table      = <fs_table>
         ).
      CATCH cx_salv_msg.
        RAISE EXCEPTION TYPE cx_salv_error.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~set_default_functions.

    DATA lo_functions TYPE REF TO cl_salv_functions_list.

    lo_functions = io_salv->get_functions( ).
    lo_functions->set_default( ).

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~set_list_header.

    DATA lo_display_settings TYPE REF TO cl_salv_display_settings.

    CHECK iv_title IS NOT INITIAL.

    lo_display_settings = io_salv->get_display_settings( ).
    lo_display_settings->set_list_header( iv_title ).

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~set_optimize_columns.

    DATA lo_columns TYPE REF TO cl_salv_columns_table.

    lo_columns = io_salv->get_columns( ).
    lo_columns->set_optimize( ).

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~set_screen_popup.

    io_salv->set_screen_popup(
      start_column = iv_start_column
      end_column   = iv_end_column
      start_line   = iv_start_line
      end_line     = iv_end_line
    ).

  ENDMETHOD.
ENDCLASS.
