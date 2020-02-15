class ZTC_LAC_SXML_FACTORY definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods CREATE_FAIL
  for testing .
  methods CREATE_TABLE_OK
  for testing
    raising
      ZCX_LAC_UNSUPPORTED_MEDIA_TYPE .
  methods CREATE_XSTRING_OK
  for testing
    raising
      ZCX_LAC_UNSUPPORTED_MEDIA_TYPE .
protected section.
private section.

  data MO_SXML_FACTORY type ref to ZIF_LAC_SXML_FACTORY .
  data MO_SXML_CREATE_WRAP_DOUBLE type ref to ZIF_SXML_CREATE_WRAP .

  methods SETUP .
  methods TEARDOWN .
ENDCLASS.



CLASS ZTC_LAC_SXML_FACTORY IMPLEMENTATION.


  METHOD constructor_ok.

    CLEAR mo_sxml_factory.

    CREATE OBJECT mo_sxml_factory TYPE zcl_lac_sxml_factory.

    cl_aunit_assert=>assert_bound( mo_sxml_factory ).

  ENDMETHOD.


  METHOD create_fail.

    DATA lx_lac_unsupported_media_type TYPE REF TO zcx_lac_unsupported_media_type.

    TRY .
      mo_sxml_factory->create( space ).
      cl_aunit_assert=>fail( ).

    CATCH zcx_lac_unsupported_media_type INTO lx_lac_unsupported_media_type.
      cl_aunit_assert=>assert_bound( lx_lac_unsupported_media_type ).

    ENDTRY.

  ENDMETHOD.


  METHOD create_table_ok.

    DATA: lt_data            TYPE TABLE OF c,
          lo_sxml_string_act TYPE REF TO if_sxml_reader,
          lo_sxml_string_exp TYPE REF TO if_sxml_reader.

    lo_sxml_string_exp ?= cl_abap_testdouble=>create( 'IF_SXML_READER' ).

    " configure the call
    cl_abap_testdouble=>configure_call( mo_sxml_create_wrap_double
      )->returning( lo_sxml_string_exp ).
    " bind the method call with parameters
    mo_sxml_create_wrap_double->create_table( lt_data ).

    lo_sxml_string_act = mo_sxml_factory->create( lt_data ).

    cl_aunit_assert=>assert_equals(
      act = lo_sxml_string_act
      exp = lo_sxml_string_exp
    ).

  ENDMETHOD.


  METHOD create_xstring_ok.

    DATA: lv_data            TYPE xstring VALUE '123456780987654321',
          lo_sxml_string_act TYPE REF TO if_sxml_reader,
          lo_sxml_string_exp TYPE REF TO if_sxml_reader.

    lo_sxml_string_exp ?= cl_abap_testdouble=>create( 'IF_SXML_READER' ).

    " configure the call
    cl_abap_testdouble=>configure_call( mo_sxml_create_wrap_double
      )->returning( lo_sxml_string_exp ).
    " bind the method call with parameters
    mo_sxml_create_wrap_double->create_xstring( lv_data ).

    lo_sxml_string_act = mo_sxml_factory->create( lv_data ).

    cl_aunit_assert=>assert_equals(
      act = lo_sxml_string_act
      exp = lo_sxml_string_exp
    ).

  ENDMETHOD.


  METHOD setup.

    mo_sxml_create_wrap_double ?= cl_abap_testdouble=>create( 'ZIF_SXML_CREATE_WRAP' ).

    CREATE OBJECT mo_sxml_factory TYPE zcl_lac_sxml_factory
      EXPORTING
        io_sxml_create_wrap = me->mo_sxml_create_wrap_double.

  ENDMETHOD.


  METHOD teardown.
    CLEAR me->mo_sxml_create_wrap_double.
  ENDMETHOD.
ENDCLASS.
