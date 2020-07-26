interface ZIF_LAC_TIME_WRAP
  public .


  methods CONVERT_TIME_TO_INTERNAL
    importing
      !IV_TIME type CSEQUENCE
      !IB_24_ALLOWED type ABAP_BOOL default ABAP_FALSE
    returning
      value(RV_TIME) type T
    raising
      ZCX_LAC_TIME_CONVERSION_ERROR .
  methods CONVERT_TIME_TO_EXTERNAL
    importing
      !IV_TIME type T
      !IB_WITHOUT_SECONDS type ABAP_BOOL default ABAP_FALSE
    returning
      value(RV_TIME) type STRING
    raising
      ZCX_LAC_TIME_CONVERSION_ERROR .
endinterface.
