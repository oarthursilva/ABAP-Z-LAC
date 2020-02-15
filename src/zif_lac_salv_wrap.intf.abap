interface ZIF_LAC_SALV_WRAP
  public .


  methods ADD_FUNCTION
    importing
      !IO_SALV type ref to CL_SALV_TABLE
      !IV_NAME type SALV_DE_FUNCTION
      !IV_ICON type STRING
      !IV_TEXT type STRING
      !IV_TOOLTIP type STRING
      !IV_POSITION type SALV_DE_FUNCTION_POS
    raising
      CX_SALV_ERROR .
  methods CREATE_SALV_TABLE
    importing
      !IO_CONTAINER type ref to CL_GUI_CONTAINER
      !IT_DATA type TABLE
    returning
      value(RO_SALV_TABLE) type ref to CL_SALV_TABLE
    raising
      CX_SALV_ERROR .
  methods DISPLAY
    importing
      !IO_SALV_WRAP type ref to CL_SALV_TABLE .
  methods SET_DEFAULT_FUNCTIONS
    importing
      !IO_SALV type ref to CL_SALV_TABLE .
  methods SET_OPTIMIZE_COLUMNS
    importing
      !IO_SALV type ref to CL_SALV_TABLE .
endinterface.
