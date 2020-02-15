interface ZIF_LAC_SXML_FACTORY
  public .


  methods CREATE
    importing
      !ID_INPUT type ANY
    returning
      value(RO_HANDLER) type ref to IF_SXML_READER
    raising
      ZCX_LAC_UNSUPPORTED_MEDIA_TYPE .
endinterface.
