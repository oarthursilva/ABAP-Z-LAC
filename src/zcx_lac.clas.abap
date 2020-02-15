class ZCX_LAC definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    BEGIN OF sc_msgty,
        error   TYPE symsgty VALUE 'E',
        success TYPE symsgty VALUE 'S',
      END OF sc_msgty .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional .
  methods BUILD_BAPIRET
    returning
      value(RS_BAPIRET) type BAPIRET2 .
  methods BUILD_BAPIRET_TAB
    returning
      value(RT_BAPIRET) type BAPIRET2_TAB .
  methods RAISE_MESSAGE
    importing
      !IV_MSGTY type SYMSGTY default 'E' .
protected section.
private section.

  aliases T100KEY
    for IF_T100_MESSAGE~T100KEY .
ENDCLASS.



CLASS ZCX_LAC IMPLEMENTATION.


  METHOD build_bapiret.

    CHECK t100key IS NOT INITIAL.

    cl_message_helper=>set_msg_vars_for_if_t100_msg( me ).

    MESSAGE ID t100key-msgid
          TYPE sc_msgty-error
        NUMBER t100key-msgno
          WITH t100key-attr1
               t100key-attr2
               t100key-attr3
               t100key-attr4
          INTO rs_bapiret-message.

    rs_bapiret-id         = t100key-msgid.
    rs_bapiret-type       = sy-msgty.
    rs_bapiret-message_v1 = t100key-attr1.
    rs_bapiret-message_v2 = t100key-attr2.
    rs_bapiret-message_v3 = t100key-attr3.
    rs_bapiret-message_v4 = t100key-attr4.

  ENDMETHOD.


  METHOD build_bapiret_tab.

    DATA:
      lx_lac     TYPE REF TO zcx_lac,
      ls_bapiret TYPE bapiret2.

    ls_bapiret = build_bapiret( ).
    APPEND ls_bapiret TO rt_bapiret.

    IF previous IS NOT INITIAL.
      lx_lac ?= previous.
      APPEND LINES OF lx_lac->build_bapiret_tab( ) TO rt_bapiret.
    ENDIF.

  ENDMETHOD.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.


  METHOD raise_message.

    CHECK t100key IS NOT INITIAL.

    cl_message_helper=>set_msg_vars_for_if_t100_msg( me ).

    MESSAGE ID t100key-msgid
          TYPE sc_msgty-success
        NUMBER t100key-msgno
          WITH sy-msgv1
               sy-msgv2
               sy-msgv3
               sy-msgv4
  DISPLAY LIKE iv_msgty.

  ENDMETHOD.
ENDCLASS.
