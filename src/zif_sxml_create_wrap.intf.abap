interface ZIF_SXML_CREATE_WRAP
  public .


  methods CREATE_XSTRING
    importing
      !IV_DATA type XSTRING
    returning
      value(RO_READER) type ref to IF_SXML_READER .
  methods CREATE_TABLE
    importing
      !IT_TABLE type TABLE
    returning
      value(RO_READER) type ref to IF_SXML_READER .
endinterface.
