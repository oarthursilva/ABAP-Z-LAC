interface ZIF_LAC_JSON_PARSER
  public .


  methods PARSE
    importing
      !IS_DDIC type ANY
    returning
      value(RD_DDIC) type ref to DATA
    raising
      ZCX_LAC_JSON_PARSER .
endinterface.
