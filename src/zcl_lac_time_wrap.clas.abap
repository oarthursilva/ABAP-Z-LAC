class ZCL_LAC_TIME_WRAP definition
  public
  final
  create public .

public section.

  interfaces ZIF_LAC_TIME_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_TIME_WRAP IMPLEMENTATION.


  METHOD zif_lac_time_wrap~convert_time_to_external.

    TRY .
        cl_abap_timefm=>conv_time_int_to_ext(
          EXPORTING
            time_int            = iv_time
            without_seconds     = ib_without_seconds
            format_according_to = cl_abap_timefm=>environment
          IMPORTING
            time_ext            = rv_time
        ).

      CATCH cx_parameter_invalid_range.
        RAISE EXCEPTION TYPE zcx_lac_time_conversion_error
          EXPORTING
            mv_internal_time = iv_time
            textid           = zcx_lac_time_conversion_error=>to_external.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_time_wrap~convert_time_to_internal.

    TRY .
        cl_abap_timefm=>conv_time_ext_to_int(
          EXPORTING
            time_ext      = iv_time
            is_24_allowed = ib_24_allowed
          IMPORTING
          time_int      = rv_time
        ).

      CATCH cx_abap_timefm_invalid.
        RAISE EXCEPTION TYPE zcx_lac_time_conversion_error
          EXPORTING
            mv_external_time = iv_time
            textid           = zcx_lac_time_conversion_error=>to_internal.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
