class ZCA_LAC_REPORT definition
  public
  abstract
  create public .

public section.

  interfaces ZIF_LAC_REPORT
      abstract methods FINALIZE
                       INITIALIZE .

  aliases FINALIZE
    for ZIF_LAC_REPORT~FINALIZE .
  aliases INITIALIZE
    for ZIF_LAC_REPORT~INITIALIZE .

  methods CONSTRUCTOR .
  PROTECTED SECTION.

    DATA mv_name TYPE string .

    METHODS get_name
      RETURNING
        VALUE(rv_name) TYPE string .
    METHODS set_name
      IMPORTING
        !iv_name TYPE string .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCA_LAC_REPORT IMPLEMENTATION.


  METHOD constructor.

    DATA lv_name TYPE string.

    lv_name = sy-cprog .

    set_name( lv_name ).

  ENDMETHOD.


  METHOD get_name.
    rv_name = mv_name.
  ENDMETHOD.


  METHOD set_name.
    mv_name = iv_name.
  ENDMETHOD.
ENDCLASS.
