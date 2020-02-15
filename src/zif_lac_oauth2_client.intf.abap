interface ZIF_LAC_OAUTH2_CLIENT
  public .


  methods CREATE_CLIENT_CREDENTIALS
    importing
      !IO_HTTP_CLIENT type ref to IF_HTTP_CLIENT
      !IO_OAUTH2_CLIENT type ref to IF_OAUTH2_CLIENT .
  methods GET_CLIENT
    returning
      value(RO_OAUTH2_CLIENT) type ref to IF_OAUTH2_CLIENT .
endinterface.
