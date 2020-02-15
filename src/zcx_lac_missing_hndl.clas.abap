class ZCX_LAC_MISSING_HNDL definition
  public
  inheriting from ZCX_LAC
  create public .

public section.

  constants:
    begin of ZCX_LAC_MISSING_HNDL,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '016',
      attr1 type scx_attrname value 'MV_EVENT_ID',
      attr2 type scx_attrname value 'MV_EVENT_TYPE',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ZCX_LAC_MISSING_HNDL .
  data MV_EVENT_TYPE type STRING .
  data MV_EVENT_ID type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_EVENT_TYPE type STRING optional
      !MV_EVENT_ID type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LAC_MISSING_HNDL IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_EVENT_TYPE = MV_EVENT_TYPE .
me->MV_EVENT_ID = MV_EVENT_ID .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_LAC_MISSING_HNDL .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
