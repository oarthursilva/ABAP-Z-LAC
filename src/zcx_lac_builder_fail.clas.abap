class ZCX_LAC_BUILDER_FAIL definition
  public
  inheriting from ZCX_LAC
  create public .

public section.

  constants:
    begin of CANNOT_BUILD,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '015',
      attr1 type scx_attrname value 'CLASS_NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CANNOT_BUILD .
  data MV_CLASS_NAME type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_CLASS_NAME type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LAC_BUILDER_FAIL IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_CLASS_NAME = MV_CLASS_NAME .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
