class ZCL_LAC_SXML_FACTORY definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SXML_FACTORY .

  methods CONSTRUCTOR
    importing
      !IO_SXML_CREATE_WRAP type ref to ZIF_SXML_CREATE_WRAP optional .
protected section.
private section.

  data MO_SXML_CREATE_WRAP type ref to ZIF_SXML_CREATE_WRAP .
ENDCLASS.



CLASS ZCL_LAC_SXML_FACTORY IMPLEMENTATION.


  METHOD constructor.

    IF io_sxml_create_wrap IS BOUND.
      mo_sxml_create_wrap = io_sxml_create_wrap.
    ELSE.
      CREATE OBJECT mo_sxml_create_wrap TYPE zcl_sxml_create_wrap.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_sxml_factory~create.

    DATA lo_typedescr TYPE REF TO cl_abap_typedescr.

    lo_typedescr = cl_abap_typedescr=>describe_by_data( id_input ).

    IF lo_typedescr->type_kind = cl_abap_typedescr=>typekind_table
    OR lo_typedescr->type_kind = cl_abap_typedescr=>typekind_struct1.
      ro_handler = mo_sxml_create_wrap->create_table( id_input ).

    ELSEIF lo_typedescr->type_kind = cl_abap_typedescr=>typekind_xstring.
      ro_handler = mo_sxml_create_wrap->create_xstring( id_input ).

    ELSE.
      RAISE EXCEPTION TYPE zcx_lac_unsupported_media_type
        EXPORTING
          textid = zcx_lac_unsupported_media_type=>wrong_format.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
