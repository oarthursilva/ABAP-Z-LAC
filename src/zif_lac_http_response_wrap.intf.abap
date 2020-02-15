interface ZIF_LAC_HTTP_RESPONSE_WRAP
  public .


  methods GET_CONTENT_TYPE
    importing
      !IO_HTTP_RESPONSE type ref to IF_HTTP_RESPONSE
    returning
      value(RV_CONTENT_TYPE) type STRING .
  methods GET_DATA
    importing
      !IO_HTTP_RESPONSE type ref to IF_HTTP_RESPONSE
    returning
      value(RV_DATA) type XSTRING .
  methods GET_HEADER_FIELDS
    importing
      !IO_HTTP_RESPONSE type ref to IF_HTTP_RESPONSE
    returning
      value(RT_FIELDS) type TIHTTPNVP .
  methods GET_STATUS
    importing
      !IO_HTTP_RESPONSE type ref to IF_HTTP_RESPONSE
    returning
      value(RS_HTTP_RECEIVE_STATUS) type ZLAC_HTTP_RECEIVE_STATUS .
endinterface.
