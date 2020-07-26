class ZCL_LAC_GRID_DATA definition
  public
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IO_SALV_TABLE type ref to CL_SALV_TABLE optional
      !ID_DATA type DATA optional .
  methods GET_SALV_TABLE
    returning
      value(RO_SALV_TABLE) type ref to CL_SALV_TABLE .
  methods SET_SALV_TABLE
    importing
      !IO_SALV_TABLE type ref to CL_SALV_TABLE .
  methods GET_DATA
    returning
      value(RD_DATA) type ref to DATA .
  methods SET_DATA
    importing
      !ID_DATA type ref to DATA .
protected section.
PRIVATE SECTION.

  DATA mo_salv_table TYPE REF TO cl_salv_table .
  DATA md_data TYPE REF TO data .
ENDCLASS.



CLASS ZCL_LAC_GRID_DATA IMPLEMENTATION.


  method CONSTRUCTOR.

    IF io_salv_table IS BOUND.
      mo_salv_table = io_salv_table.
    ENDIF.

    IF id_data IS SUPPLIED.
      md_data = id_data.
    ENDIF.

  endmethod.


  METHOD get_data.
    rd_data = md_data.
  ENDMETHOD.


  METHOD get_salv_table.
    ro_salv_table = mo_salv_table.
  ENDMETHOD.


  METHOD set_data.
    md_data = id_data.
  ENDMETHOD.


  METHOD set_salv_table.
    mo_salv_table = io_salv_table.
  ENDMETHOD.
ENDCLASS.
