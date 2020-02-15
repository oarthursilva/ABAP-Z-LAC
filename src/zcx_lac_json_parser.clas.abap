class ZCX_LAC_JSON_PARSER definition
  public
  inheriting from ZCX_LAC_DC
  final
  create public .

public section.

  constants:
    begin of INVALID_SOURCE,
      msgid type symsgid value 'ZLAC',
      msgno type symsgno value '007',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of INVALID_SOURCE .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !SC_MSGTY_ERROR type SYMSGTY default 'E' .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LAC_JSON_PARSER IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
SC_MSGTY_ERROR = SC_MSGTY_ERROR
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
