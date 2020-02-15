class ZCL_LAC_DATE_WRAP definition
  public
  final
  create public .

public section.

  interfaces ZIF_LAC_DATE_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_DATE_WRAP IMPLEMENTATION.


  METHOD zif_lac_date_wrap~convert_date_to_external.

    CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
      EXPORTING
        date_internal            = iv_date_internal
      IMPORTING
        date_external            = rv_date_external
      EXCEPTIONS
        date_internal_is_invalid = 1
        OTHERS                   = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_date_conversion_error
        EXPORTING
          textid           = zcx_lac_date_conversion_error=>to_external
          mv_internal_date = iv_date_internal.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_date_wrap~convert_date_to_internal.

    IF iv_date_external IS INITIAL.
      RAISE EXCEPTION TYPE zcx_lac_missing_parameter
        EXPORTING
          textid   = zcx_lac_missing_parameter=>obrligatory_parameter_missing
          mv_param = 'IV_DATE_INTERNAL'.
    ENDIF.

    CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
      EXPORTING
        date_internal            = iv_date_external
      IMPORTING
        date_external            = rv_date_internal
      EXCEPTIONS
        date_internal_is_invalid = 1
        OTHERS                   = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_lac_date_conversion_error
        EXPORTING
          textid           = zcx_lac_date_conversion_error=>to_internal
          mv_external_date = iv_date_external.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
