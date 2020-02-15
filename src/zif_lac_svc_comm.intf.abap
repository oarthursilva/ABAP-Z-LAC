interface ZIF_LAC_SVC_COMM
  public .


  methods REQUEST
    importing
      !IV_METHOD type STRING default ZCL_LAC_SVC_CONSTANTS=>SC_GET
    returning
      value(ET_BAPIRET) type BAPIRET2_TAB .
  methods RESPONSE
    returning
      value(RV_RESPONSE) type XSTRING
    raising
      ZCX_LAC_HTTP_RESPONSE_FAIL .
endinterface.
