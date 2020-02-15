class ZCX_LAC_OBJ_MODIFY_ATTRIBUTE definition
  public
  inheriting from ZCX_LAC
  create public .

public section.

  constants:
    begin of MODIFY_OBJECT_ATTRIBUTE,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'MV_OBJECT',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of MODIFY_OBJECT_ATTRIBUTE .
  data MV_OBJECT type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_OBJECT type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LAC_OBJ_MODIFY_ATTRIBUTE IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_OBJECT = MV_OBJECT .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
