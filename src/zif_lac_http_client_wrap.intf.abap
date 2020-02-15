interface ZIF_LAC_HTTP_CLIENT_WRAP
  public .


  methods CLOSE
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
    raising
      ZCX_LAC_HTTP_CLIENT_ERROR .
  methods CREATE_BY_URL
    importing
      !IV_URL type STRING
      !IV_SSL_ID type SSFAPPLSSL default 'ANONYM'
    returning
      value(RO_CLIENT) type ref to IF_HTTP_CLIENT
    raising
      ZCX_LAC_CREATE_CLIENT_FAIL .
  methods RECEIVE
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
    raising
      ZCX_LAC_HTTP_RESPONSE_FAIL .
  methods SEND
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
    raising
      ZCX_LAC_HTTP_CLIENT_ERROR .
  methods SET_METHOD
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
      !IV_METHOD type STRING .
  methods SET_PROPERTYTYPE_LOGON_POPUP
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
      !IV_PROPERTYTYPE_LOGON_POPUP type I .
endinterface.
