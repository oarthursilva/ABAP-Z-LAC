interface ZIF_LAC_SVC_LOC_DTO_BUILDER
  public .


  methods BUILD
    importing
      !IV_SERVICE_TYPE type ZLAC_SVC_TYPE
    returning
      value(RO_LOCATOR_DTO) type ref to ZCL_LAC_SVC_LOC_DTO
    raising
      ZCX_LAC_CLOUD_DATA_NOT_FOUND .
endinterface.
