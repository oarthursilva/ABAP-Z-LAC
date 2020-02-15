interface ZIF_LAC_OAUTH2_CLIENT_WRAP
  public .


  methods CREATE
    importing
      !IV_PROFILE type OA2C_PROFILE
      !IV_CONFIGURATION type OA2C_CONFIGURATION optional
    returning
      value(RO_OAUTH2_CLIENT) type ref to IF_OAUTH2_CLIENT
    raising
      ZCX_LAC_OA2C_CREATE_ERROR .
  methods EXECUTE_CC_FLOW
    importing
      !IO_OAUTH2_CLIENT type ref to IF_OAUTH2_CLIENT
    raising
      CX_OA2C_RUNTIME .
  methods SET_TOKEN
    importing
      !IO_OAUTH2_CLIENT type ref to IF_OAUTH2_CLIENT
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
    raising
      CX_OA2C_RUNTIME .
endinterface.
