class ZCL_LAC_GUI_WRAP definition
  public
  create public .

public section.

  interfaces ZIF_LAC_GUI_WRAP .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_GUI_WRAP IMPLEMENTATION.


  METHOD zif_lac_gui_wrap~create_container.

    TRY.
        CREATE OBJECT ro_container TYPE (iv_container_type)
          EXPORTING
            container_name = iv_container_name
          EXCEPTIONS
            OTHERS = 4.

        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_lac_obj_creation
            EXPORTING
              textid    = zcx_lac_obj_creation=>create_object_error
              mv_object = 'CONTAINER'.

        ENDIF.

      CATCH cx_sy_create_object_error.
        RAISE EXCEPTION TYPE zcx_lac_obj_creation
          EXPORTING
            textid    = zcx_lac_obj_creation=>create_object_error
            mv_object = 'CONTAINER'.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_gui_wrap~create_splitter.

    TRY .
        CREATE OBJECT ro_splitter
          EXPORTING
            parent  = io_parent
            rows    = iv_rows
            columns = iv_columns
          EXCEPTIONS
            OTHERS  = 4.

        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_lac_obj_creation
            EXPORTING
              textid    = zcx_lac_obj_creation=>create_object_error
              mv_object = 'SPLITTER CONTAINER'.
        ENDIF.

      CATCH cx_sy_create_object_error.
        RAISE EXCEPTION TYPE zcx_lac_obj_creation
          EXPORTING
            textid    = zcx_lac_obj_creation=>create_object_error
            mv_object = 'SPLITTER CONTAINER'.
    ENDTRY.

  ENDMETHOD.


  METHOD zif_lac_gui_wrap~get_splitter_container.

    ro_container = io_splitter->get_container(
      row    = iv_row
      column = iv_column
    ).

  ENDMETHOD.


  METHOD zif_lac_gui_wrap~set_splitter_row_height.

    io_splitter->set_row_height(
      id = iv_id
      height  = iv_height
    ).

    IF sy-subrc IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_lac_obj_modify_attribute
        EXPORTING
          textid    = zcx_lac_obj_modify_attribute=>modify_object_attribute
          mv_object = 'SPLITTER_CONTAINER'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
