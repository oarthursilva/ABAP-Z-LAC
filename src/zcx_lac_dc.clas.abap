class ZCX_LAC_DC definition
  public
  inheriting from CX_DYNAMIC_CHECK
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  data SC_MSGTY_ERROR type SYMSGTY value 'E' ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !SC_MSGTY_ERROR type SYMSGTY default 'E' .
  methods BUILD_ERROR_MESSAGE
    importing
      !IV_MESSAGE type STRING
    returning
      value(RS_BAPIRET) type BAPIRET2 .
  methods BUILD_BAPIRET
    returning
      value(RS_BAPIRET) type BAPIRET2 .
  methods BUILD_BAPIRET_TAB
    returning
      value(RT_BAPIRET2) type BAPIRET2_TAB .
protected section.
private section.

  aliases T100KEY
    for IF_T100_MESSAGE~T100KEY .
ENDCLASS.



CLASS ZCX_LAC_DC IMPLEMENTATION.


  METHOD build_bapiret.

    CHECK t100key IS NOT INITIAL.

    cl_message_helper=>set_msg_vars_for_if_t100_msg( me ).

    MESSAGE ID t100key-msgid
          TYPE sc_msgty_error
        NUMBER sy-msgno
          WITH sy-msgv1
               sy-msgv2
               sy-msgv3
               sy-msgv4
          INTO rs_bapiret-message.

    rs_bapiret-id         = sy-msgid.
    rs_bapiret-type       = sy-msgty.
    rs_bapiret-message_v1 = sy-msgv1.
    rs_bapiret-message_v1 = sy-msgv2.
    rs_bapiret-message_v1 = sy-msgv3.
    rs_bapiret-message_v1 = sy-msgv4.

  ENDMETHOD.


  METHOD build_bapiret_tab.

    DATA: lx_lac_dc   TYPE REF TO cx_dynamic_check,
          ls_bapiret2 TYPE bapiret2.

    ls_bapiret2 = build_bapiret( ).
    APPEND ls_bapiret2 TO rt_bapiret2.

    IF previous IS NOT INITIAL.
      lx_lac_dc ?= previous.
      APPEND build_error_message( lx_lac_dc->get_text( ) ) TO rt_bapiret2.
    ENDIF.

  ENDMETHOD.


  METHOD build_error_message.

    rs_bapiret-id         = sy-msgid.
    rs_bapiret-type       = sc_msgty_error.
    rs_bapiret-message    = iv_message.
    rs_bapiret-message_v1 = sy-msgv1.
    rs_bapiret-message_v1 = sy-msgv2.
    rs_bapiret-message_v1 = sy-msgv3.
    rs_bapiret-message_v1 = sy-msgv4.

  ENDMETHOD.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->SC_MSGTY_ERROR = SC_MSGTY_ERROR .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
