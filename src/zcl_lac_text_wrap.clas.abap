class ZCL_LAC_TEXT_WRAP definition
  public
  final
  create public .

public section.

  interfaces ZIF_LAC_TEXT_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_TEXT_WRAP IMPLEMENTATION.


  METHOD zif_lac_text_wrap~text_split.

    CALL FUNCTION 'TEXT_SPLIT'
      EXPORTING
        length = iv_length
        text   = iv_text
      IMPORTING
        line   = rs_split_result-line
        rest   = rs_split_result-rest
      EXCEPTIONS
        OTHERS = 4.

  ENDMETHOD.
ENDCLASS.
