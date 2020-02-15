class ZCX_LAC_DATE_CONVERSION_ERROR definition
  public
  inheriting from ZCX_LAC
  final
  create public .

public section.

  constants:
    begin of TO_EXTERNAL,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '003',
      attr1 type scx_attrname value 'MV_INTERNAL_DATE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of TO_EXTERNAL .
  constants:
    begin of TO_INTERNAL,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '004',
      attr1 type scx_attrname value 'MV_EXTERNAL_DATE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of TO_INTERNAL .
  data MV_EXTERNAL_DATE type STRING .
  data MV_INTERNAL_DATE type D .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MV_EXTERNAL_DATE type STRING optional
      !MV_INTERNAL_DATE type D optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LAC_DATE_CONVERSION_ERROR IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MV_EXTERNAL_DATE = MV_EXTERNAL_DATE .
me->MV_INTERNAL_DATE = MV_INTERNAL_DATE .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
