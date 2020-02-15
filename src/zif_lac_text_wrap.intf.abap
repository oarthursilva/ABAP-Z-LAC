interface ZIF_LAC_TEXT_WRAP
  public .


  methods TEXT_SPLIT
    importing
      !IV_LENGTH type INT4
      !IV_TEXT type ANY
    returning
      value(RS_SPLIT_RESULT) type ZLAC_SPLIT_RESULT .
endinterface.
