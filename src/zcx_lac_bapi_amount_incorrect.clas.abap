class ZCX_LAC_BAPI_AMOUNT_INCORRECT definition
  public
  inheriting from ZCX_LAC
  create public .

public section.

  constants:
    begin of WRONG_FORMAT,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '002',
      attr1 type scx_attrname value 'MV_AMOUNT',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of WRONG_FORMAT .
  data MV_AMOUNT type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_AMOUNT type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LAC_BAPI_AMOUNT_INCORRECT IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_AMOUNT = MV_AMOUNT .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
