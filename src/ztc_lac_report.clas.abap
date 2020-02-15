class ZTC_LAC_REPORT definition
  public
  inheriting from ZCA_LAC_REPORT
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods GETTER_SETTER_OK
  for testing .
  methods INITIALIZE_FAIL
  for testing .

  methods ZIF_LAC_REPORT~FINALIZE
    redefinition .
  methods ZIF_LAC_REPORT~INITIALIZE
    redefinition .
protected section.
private section.

  data MO_REPORT type ref to ZCA_LAC_REPORT .
  data MV_FAIL type ABAP_BOOL value ABAP_FALSE ##NO_TEXT.

  methods FINALIZE_FAIL .
  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_REPORT IMPLEMENTATION.


  METHOD finalize_fail.

    mv_fail = abap_true.

    TRY .
        finalize( ).
      CATCH zcx_lac INTO DATA(lx_lac).
        lx_lac->raise_message( ).
    ENDTRY.

  ENDMETHOD.


  METHOD getter_setter_ok.

    cl_aunit_assert=>assert_equals(
      act = get_name( )
      exp = sy-cprog
    ).

  ENDMETHOD.


  METHOD initialize_fail.

    mv_fail = abap_true.

    TRY .
        initialize( ).
      CATCH zcx_lac INTO DATA(lx_lac).
        lx_lac->raise_message( ).
    ENDTRY.

  ENDMETHOD.


  METHOD setup.

    CREATE OBJECT mo_report TYPE ztd_lac_report.

  ENDMETHOD.


  METHOD zif_lac_report~finalize.

    IF mv_fail = abap_true.
      RAISE EXCEPTION TYPE zcx_lac.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_report~initialize.

    IF mv_fail = abap_true.
      RAISE EXCEPTION TYPE zcx_lac.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
