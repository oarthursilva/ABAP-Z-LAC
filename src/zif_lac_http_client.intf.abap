interface ZIF_LAC_HTTP_CLIENT
  public .


  methods RECEIVE_RESPONSE
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
    returning
      value(RV_DATA_RESPONSE) type XSTRING
    raising
      ZCX_LAC_HTTP_COMMUNICATION .
  methods CREATE_REQUEST
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
      !IV_METHOD type STRING default ZCL_LAC_SVC_CONSTANTS=>SC_GET .
  methods GET_CLIENT
    returning
      value(RO_HTTP_CLIENT) type ref to IF_HTTP_CLIENT .
  methods SEND_REQUEST
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
    raising
      ZCX_LAC_HTTP_COMMUNICATION .
endinterface.
