interface ZIF_LAC_SVC_CLOUD_DB
  public .


  methods READ
    importing
      !IS_SELECTION_FIELDS type ZLAC_SVC_CLOUD_SELECTION
    returning
      value(RT_CLOUD_SERVICE) type ZLAC_SVC_CLOUD_TAB
    raising
      ZCX_LAC_CLOUD_DATA_NOT_FOUND .
  methods READ_BY_KEYS
    importing
      !IV_SERVICE_TYPE type ZLAC_SVC_TYPE
      !IV_SERVICE_VALIDFROM type ZLAC_VALIDFROM optional
    returning
      value(RS_CLOUD_SERVICE) type ZLAC_SVC_CLOUD
    raising
      ZCX_LAC_CLOUD_DATA_NOT_FOUND .
endinterface.
