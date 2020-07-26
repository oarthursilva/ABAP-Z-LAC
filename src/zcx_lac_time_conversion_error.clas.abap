class ZCX_LAC_TIME_CONVERSION_ERROR definition
  public
  inheriting from ZCX_LAC
  final
  create public .

public section.

  constants:
    begin of TO_EXTERNAL,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '017',
      attr1 type scx_attrname value 'MV_INTERNAL_DATE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of TO_EXTERNAL .
  constants:
    begin of TO_INTERNAL,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '018',
      attr1 type scx_attrname value 'MV_EXTERNAL_DATE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of TO_INTERNAL .
  data MV_EXTERNAL_TIME type STRING .
  data MV_INTERNAL_TIME type T .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_EXTERNAL_TIME type STRING optional
      !MV_INTERNAL_TIME type T optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LAC_TIME_CONVERSION_ERROR IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_EXTERNAL_TIME = MV_EXTERNAL_TIME .
me->MV_INTERNAL_TIME = MV_INTERNAL_TIME .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
