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

  methods ZIF_LAC_REPORT~FINALIZE
    redefinition .
  methods ZIF_LAC_REPORT~INITIALIZE
    redefinition .
protected section.
private section.

  data MO_REPORT type ref to ZCA_LAC_REPORT .

  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_REPORT IMPLEMENTATION.


  METHOD getter_setter_ok.

    cl_aunit_assert=>assert_equals(
      act = get_name( )
      exp = sy-cprog
    ).

  ENDMETHOD.


  METHOD setup.

    CREATE OBJECT mo_report TYPE ztd_lac_report.

  ENDMETHOD.


  METHOD zif_lac_report~finalize ##NEEDED.
  ENDMETHOD.


  METHOD zif_lac_report~initialize ##NEEDED.
  ENDMETHOD.
ENDCLASS.
