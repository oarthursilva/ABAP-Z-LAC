interface ZIF_SCMS_STRING_WRAP
  public .


  methods SCMS_XSTRING_TO_BINARY
    importing
      !IV_BUFFER type XSTRING
      !IV_APPEND_TO_TABLE type C default SPACE
    returning
      value(RS_BINARY_CONTENT) type ZLAC_FILE_BINARY_CONTENT .
  methods SCMS_BINARY_TO_STRING
    importing
      !IV_INPUT_LENGTH type I
      !IV_FIRST_LINE type I default 0
      !IV_LAST_LINE type I default 0
      !IV_MIMETYPE type C default SPACE
      !IV_ENCODING type ABAP_ENCODING optional
      !IT_BINARY_TAB type ZLAC_FILE_BINARY_CONTENT_TAB
    returning
      value(RS_STRING_CONTENT) type ZLAC_STRING_CONTENT
    raising
      ZCX_LAC_STRING_CONVERSION_FAIL .
endinterface.
