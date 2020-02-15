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

    cl_salv_table=>factory(
      EXPORTING
        r_container  = io_container
      IMPORTING
        r_salv_table = ro_salv_table
      CHANGING
        t_table      = <table>
    ).

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~display.

    io_salv_wrap->display( ).

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~set_default_functions.

    DATA lo_functions TYPE REF TO cl_salv_functions_list.

    lo_functions = io_salv->get_functions( ).
    lo_functions->set_default( ).

  ENDMETHOD.


  METHOD zif_lac_salv_wrap~set_optimize_columns.

    DATA lo_columns TYPE REF TO cl_salv_columns_table.

    lo_columns = io_salv->get_columns( ).
    lo_columns->set_optimize( ).

  ENDMETHOD.
ENDCLASS.
