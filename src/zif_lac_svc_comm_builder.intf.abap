interface ZIF_LAC_SVC_COMM_BUILDER
  public .


  methods BUILD
    importing
      !IO_LOCATOR_DTO type ref to ZCL_LAC_SVC_LOC_DTO
    returning
      value(RO_SERVICE_COMMUNICATOR) type ref to ZIF_LAC_SVC_COMM
    raising
      ZCX_LAC_BUILDER_FAIL .
endinterface.
