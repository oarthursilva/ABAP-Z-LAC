interface ZIF_LAC_REPORT
  public .


  methods INITIALIZE
    raising
      ZCX_LAC .
  methods FINALIZE
    exceptions
      ZCX_LAC .
endinterface.
