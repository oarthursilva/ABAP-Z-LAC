interface ZIF_LAC_DATE_WRAP
  public .


  methods CONVERT_DATE_TO_EXTERNAL
    importing
      !IV_DATE_INTERNAL type D
    returning
      value(RV_DATE_EXTERNAL) type STRING
    raising
      ZCX_LAC_DATE_CONVERSION_ERROR .
  methods CONVERT_DATE_TO_INTERNAL
    importing
      !IV_DATE_EXTERNAL type ANY
      !IV_ACCEPT_INITIAL_DATE type EDTFLAG optional
    returning
      value(RV_DATE_INTERNAL) type D
    raising
      ZCX_LAC_DATE_CONVERSION_ERROR
      ZCX_LAC_MISSING_PARAMETER .
endinterface.
