class ZCL_SXML_CREATE_WRAP definition
  public
  create public .

public section.

  interfaces ZIF_SXML_CREATE_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SXML_CREATE_WRAP IMPLEMENTATION.


  METHOD zif_sxml_create_wrap~create_table.
    ro_reader = cl_sxml_table_reader=>create( it_table ).
  ENDMETHOD.


  METHOD zif_sxml_create_wrap~create_xstring.
    ro_reader = cl_sxml_string_reader=>create( iv_data ).
  ENDMETHOD.
ENDCLASS.
