interface ZIF_LAC_GUI_WRAP
  public .


  methods CREATE_CONTAINER
    importing
      !IV_CONTAINER_NAME type C default 'MAIN_CONTAINER'
      !IV_CONTAINER_TYPE type STRING default 'CL_GUI_CUSTOM_CONTAINER'
    returning
      value(RO_CONTAINER) type ref to CL_GUI_CONTAINER
    raising
      ZCX_LAC_OBJ_CREATION .
  methods CREATE_SPLITTER
    importing
      !IO_PARENT type ref to CL_GUI_CONTAINER
      !IV_ROWS type I
      !IV_COLUMNS type I
    returning
      value(RO_SPLITTER) type ref to CL_GUI_SPLITTER_CONTAINER
    raising
      ZCX_LAC_OBJ_CREATION .
  methods GET_SPLITTER_CONTAINER
    importing
      !IO_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER
      !IV_ROW type I
      !IV_COLUMN type I default 1
    returning
      value(RO_CONTAINER) type ref to CL_GUI_CONTAINER .
  methods SET_SPLITTER_ROW_HEIGHT
    importing
      !IO_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER
      !IV_ID type I
      !IV_HEIGHT type I .
endinterface.
