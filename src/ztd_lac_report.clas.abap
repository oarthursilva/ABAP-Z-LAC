class ZTD_LAC_REPORT definition
  public
  inheriting from ZCA_LAC_REPORT
  final
  create public
  for testing .

public section.

  methods ZIF_LAC_REPORT~INITIALIZE
    redefinition .
  methods ZIF_LAC_REPORT~FINALIZE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZTD_LAC_REPORT IMPLEMENTATION.


  METHOD zif_lac_report~finalize ##NEEDED.
  ENDMETHOD.


  METHOD zif_lac_report~initialize ##NEEDED.
  ENDMETHOD.
ENDCLASS.
