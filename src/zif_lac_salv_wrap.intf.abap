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
      !IO_CONTAINER type ref to CL_GUI_CONTAINER optional
      !IT_DATA type TABLE
    returning
      value(RS_SALV_RETURN) type ZLAC_SALV_RETURN
    raising
      CX_SALV_ERROR .
  methods DISPLAY
    importing
      !IO_SALV_WRAP type ref to CL_SALV_TABLE .
  methods FACTORY
    importing
      !ID_DATA type DATA
    returning
      value(RO_SALV) type ref to CL_SALV_TABLE
    raising
      CX_SALV_ERROR .
  methods SET_DEFAULT_FUNCTIONS
    importing
      !IO_SALV type ref to CL_SALV_TABLE .
  methods SET_OPTIMIZE_COLUMNS
    importing
      !IO_SALV type ref to CL_SALV_TABLE .
  methods SET_SCREEN_POPUP
    importing
      !IO_SALV type ref to CL_SALV_TABLE
      !IV_START_COLUMN type I
      !IV_END_COLUMN type I optional
      !IV_START_LINE type I
      !IV_END_LINE type I optional .
  methods SET_LIST_HEADER
    importing
      !IO_SALV type ref to CL_SALV_TABLE
      !IV_TITLE type LVC_TITLE .
endinterface.
