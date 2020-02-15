class ZCL_LAC_JSON_PARSER definition
  public
  create public .

public section.

  interfaces ZIF_LAC_JSON_PARSER .

  methods CONSTRUCTOR
    importing
      !IO_READER type ref to IF_SXML_READER .
protected section.
PRIVATE SECTION.

  DATA:
    mt_nodes_queue TYPE STANDARD TABLE OF REF TO if_sxml_attribute .
  DATA mo_reader TYPE REF TO if_sxml_reader .

  METHODS assign_component
    IMPORTING
      !io_node TYPE REF TO if_sxml_node
      !id_ddic TYPE REF TO data .
  METHODS dequeue_element .
  METHODS enqueue_element
    IMPORTING
      !io_node TYPE REF TO if_sxml_node .
ENDCLASS.



CLASS ZCL_LAC_JSON_PARSER IMPLEMENTATION.


  METHOD ASSIGN_COMPONENT.

    DATA: lo_element_name  TYPE REF TO if_sxml_attribute,
          lo_element_value TYPE REF TO if_sxml_value_node,
          lv_element_name  TYPE string,
          lv_element_value TYPE string.

    FIELD-SYMBOLS: <fs_target_structure> TYPE any,
                   <fs_target_field>     TYPE any.

    READ TABLE mt_nodes_queue INDEX 1 INTO lo_element_name.
    lv_element_name = lo_element_name->get_value( ).

    lo_element_value ?= io_node.
    lv_element_value = lo_element_value->get_value( ).

    ASSIGN id_ddic->* TO <fs_target_structure>.
    ASSIGN COMPONENT lv_element_name OF STRUCTURE <fs_target_structure> TO <fs_target_field>.
    IF <fs_target_field> IS ASSIGNED.
      <fs_target_field> = lv_element_value.
    ENDIF.

  ENDMETHOD.


  METHOD constructor.
    mo_reader = io_reader.
  ENDMETHOD.


  METHOD DEQUEUE_ELEMENT.

    DELETE mt_nodes_queue INDEX 1.

  ENDMETHOD.


  METHOD ENQUEUE_ELEMENT.

    DATA lo_open_element TYPE REF TO if_sxml_open_element.

    lo_open_element ?= io_node.

    APPEND LINES OF lo_open_element->get_attributes( ) TO mt_nodes_queue.

  ENDMETHOD.


  METHOD zif_lac_json_parser~parse.

    DATA: lx_sxml_parse_error TYPE REF TO cx_sxml_parse_error,
          lo_sxml_node        TYPE REF TO if_sxml_node.

    CREATE DATA rd_ddic LIKE is_ddic.

    TRY .
        WHILE mo_reader->read_next_node( ) IS NOT INITIAL.

          lo_sxml_node = mo_reader->read_current_node( ).

          CASE lo_sxml_node->type.
            WHEN if_sxml_node=>co_nt_element_open.
              enqueue_element( lo_sxml_node ).

            WHEN if_sxml_node=>co_nt_element_close.
              dequeue_element( ).

            WHEN if_sxml_node=>co_nt_value.
              assign_component( io_node = lo_sxml_node
                                id_ddic = rd_ddic ).
          ENDCASE.
        ENDWHILE.

      CATCH cx_sxml_parse_error INTO lx_sxml_parse_error.
        RAISE EXCEPTION TYPE zcx_lac_json_parser
          EXPORTING
            textid   = zcx_lac_json_parser=>invalid_source
            previous = lx_sxml_parse_error.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
