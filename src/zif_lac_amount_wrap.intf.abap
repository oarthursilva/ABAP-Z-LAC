interface ZIF_LAC_AMOUNT_WRAP
  public .


  methods CURRENCY_AMOUNT_BAPI_TO_SAP
    importing
      !IV_CURRENCY type WAERS
      !IV_AMOUNT type BAPICURR_D
    returning
      value(RV_AMOUNT) type BAPICURR_D
    raising
      ZCX_LAC_BAPI_AMOUNT_INCORRECT .
endinterface.
