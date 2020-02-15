interface ZIF_LAC_HTTP_CLIENT_BUILDER
  public .


  methods BUILD
    importing
      !IO_LOCATOR_DTO type ref to ZCL_LAC_SVC_LOC_DTO
    returning
      value(RO_HTTP_CLIENT) type ref to ZIF_LAC_HTTP_CLIENT
    raising
      ZCX_LAC_BUILDER_FAIL .
endinterface.
