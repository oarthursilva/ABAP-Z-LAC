class ZCL_SCMS_STRING_WRAP definition
  public
  final
  create public .

public section.

  interfaces ZIF_SCMS_STRING_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SCMS_STRING_WRAP IMPLEMENTATION.


  METHOD zif_scms_string_wrap~scms_binary_to_string.

    CALL FUNCTION 'SCMS_BINARY_TO_STRING'
      EXPORTING
        input_length  = iv_input_length
        first_line    = iv_first_line
        last_line     = iv_last_line
        mimetype      = iv_mimetype
        encoding      = iv_encoding
      IMPORTING
        text_buffer   = rs_string_content-text
        output_length = rs_string_content-output_length
      TABLES
        binary_tab    = it_binary_tab
      EXCEPTIONS
        failed        = 1
        OTHERS        = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_string_conversion_fail
        EXPORTING
          textid = zcx_lac_string_conversion_fail=>binary_to_string.
    ENDIF.

  ENDMETHOD.


  METHOD zif_scms_string_wrap~scms_xstring_to_binary.

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer          = iv_buffer
        append_to_table = iv_append_to_table
      IMPORTING
        output_length   = rs_binary_content-output_length
      TABLES
        binary_tab      = rs_binary_content-binary_tab.

  ENDMETHOD.
ENDCLASS.
