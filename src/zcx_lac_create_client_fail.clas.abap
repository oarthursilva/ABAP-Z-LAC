class ZCX_LAC_CREATE_CLIENT_FAIL definition
  public
  inheriting from ZCX_LAC_BUILDER_FAIL
  create public .

public section.

  constants:
    begin of NOT_REACHABLE,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '008',
      attr1 type scx_attrname value 'MV_URL',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_REACHABLE .
  data MV_URL type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_URL type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LAC_CREATE_CLIENT_FAIL IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_URL = MV_URL .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
