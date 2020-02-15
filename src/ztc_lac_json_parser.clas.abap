class ZTC_LAC_JSON_PARSER definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods PARSE_EMPTY_DATA_OK
  for testing .
  methods PARSE_FAIL
  for testing .
  methods PARSE_OK
  for testing .
protected section.
private section.

  data MO_JSON_PARSER type ref to ZIF_LAC_JSON_PARSER .
  data MO_READER_DOUBLE type ref to IF_SXML_READER .

  methods CONFIGURE_READ_CURRENT_NODE
    importing
      !IO_SXML_NODE type ref to IF_SXML_NODE .
  methods CONFIGURE_READ_NEXT_NODE
    importing
      !IO_SXML_NODE type ref to IF_SXML_NODE .
  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_JSON_PARSER IMPLEMENTATION.


  METHOD CONFIGURE_READ_CURRENT_NODE.

*   configure READ_CURRENT_NODE
    cl_abap_testdouble=>configure_call( mo_reader_double
      )->returning( io_sxml_node ).

    mo_reader_double->read_current_node( ).

  ENDMETHOD.


  METHOD configure_read_next_node.

*   configure READ_NEXT_NODE
    cl_abap_testdouble=>configure_call( mo_reader_double
      )->returning( io_sxml_node ).

    mo_reader_double->read_next_node( ).

  ENDMETHOD.


  METHOD constructor_ok.

    CLEAR mo_json_parser.

    CREATE OBJECT mo_json_parser TYPE zcl_lac_json_parser
      EXPORTING
        io_reader = mo_reader_double.

    cl_aunit_assert=>assert_bound( mo_json_parser ).

  ENDMETHOD.


  METHOD parse_empty_data_ok.

    DATA: ld_ddic TYPE REF TO data.

    FIELD-SYMBOLS <fs_data> TYPE c.

*   @Test
    ld_ddic = mo_json_parser->parse( space ).

    ASSIGN ld_ddic->* TO <fs_data>.

    cl_aunit_assert=>assert_initial( <fs_data> ).

  ENDMETHOD.


  METHOD parse_fail.

    DATA lx_parse_error TYPE REF TO cx_sxml_parse_error.

    CREATE OBJECT lx_parse_error.

*   configure PARSE
    cl_abap_testdouble=>configure_call( mo_reader_double
      )->raise_exception( lx_parse_error ).

    mo_reader_double->read_next_node( ).

*   @Test
    TRY .
        mo_json_parser->parse( space ).
        cl_aunit_assert=>fail( ).

      CATCH zcx_lac_json_parser INTO DATA(lx_lac_json_parser).
        DATA(lt_bapiret) = lx_lac_json_parser->build_bapiret_tab( ).
        cl_aunit_assert=>assert_not_initial( lt_bapiret ).
    ENDTRY.

  ENDMETHOD.


  METHOD parse_ok.

    CONSTANTS lc_sxml_node TYPE seoclsname VALUE 'IF_SXML_NODE'.

    DATA: lo_sxml_node TYPE REF TO if_sxml_node,
          ld_ddic      TYPE REF TO data.

    lo_sxml_node ?= cl_abap_testdouble=>create( lc_sxml_node ).

    FIELD-SYMBOLS <fs_data> TYPE c.

*   configure READ_NEXT_NODE
    configure_read_next_node( lo_sxml_node ).

*   configure READ_CURRENT_NODE
    configure_read_current_node( lo_sxml_node ).

*   configure READ_NEXT_NODE
    CLEAR lo_sxml_node.
    configure_read_next_node( lo_sxml_node ).

*   @Test
    ld_ddic = mo_json_parser->parse( space ).

    ASSIGN ld_ddic->* TO <fs_data>.

    cl_aunit_assert=>assert_initial( <fs_data> ).

  ENDMETHOD.


  METHOD setup.

    CONSTANTS lc_sxml_reader TYPE seoclsname VALUE 'IF_SXML_READER'.

    mo_reader_double ?= cl_abap_testdouble=>create( lc_sxml_reader ).

    CREATE OBJECT mo_json_parser TYPE zcl_lac_json_parser
      EXPORTING
        io_reader = mo_reader_double.

  ENDMETHOD.
ENDCLASS.
