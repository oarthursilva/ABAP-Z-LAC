class ZTC_LAC_HTTP_CLIENT_BUILDER definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods BUILD_OK
  for testing .
  methods BUILD_FAIL
  for testing
    raising
      ZCX_LAC_HTTP_CLIENT_ERROR .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mo_client_builder TYPE REF TO zif_lac_http_client_builder .
    DATA mo_client_wrap_double TYPE REF TO zif_lac_http_client_wrap .

    METHODS setup .
ENDCLASS.



CLASS ZTC_LAC_HTTP_CLIENT_BUILDER IMPLEMENTATION.


  METHOD build_fail.

    DATA: lo_locator_dto           TYPE REF TO zcl_lac_svc_loc_dto,
          lx_lac_http_client_error TYPE REF TO zcx_lac_http_client_error.

*   configure
    CREATE OBJECT lx_lac_http_client_error.
    cl_abap_testdouble=>configure_call( mo_client_wrap_double
      )->raise_exception( lx_lac_http_client_error ).

    mo_client_wrap_double->create_by_url( space ).

*   @Test
    CREATE OBJECT lo_locator_dto.

    TRY .
        CLEAR lx_lac_http_client_error.
        mo_client_builder->build( lo_locator_dto ).
        cl_aunit_assert=>fail( ).

      CATCH zcx_lac_builder_fail INTO DATA(lx_lac_builder_fail).
        DATA(lt_bapiret) = lx_lac_builder_fail->build_bapiret_tab( ).
        cl_aunit_assert=>assert_not_initial( lt_bapiret ).
    ENDTRY.

  ENDMETHOD.


  METHOD build_ok.

    DATA: lo_locator_dto TYPE REF TO zcl_lac_svc_loc_dto,
          lo_http_client TYPE REF TO zif_lac_http_client.

    CREATE OBJECT lo_locator_dto.

    TRY .
        lo_http_client = mo_client_builder->build( lo_locator_dto ).

      CATCH zcx_lac_builder_fail.
        cl_aunit_assert=>fail( ).
    ENDTRY.

    cl_aunit_assert=>assert_bound( lo_http_client ).

  ENDMETHOD.


  METHOD constructor_ok.

    CLEAR mo_client_builder.

    CREATE OBJECT mo_client_builder TYPE zcl_lac_http_client_builder.

    cl_aunit_assert=>assert_bound( mo_client_builder ).

  ENDMETHOD.


  METHOD setup.

    CONSTANTS lc_http_client_wrap TYPE seoclsname VALUE 'ZIF_LAC_HTTP_CLIENT_WRAP'.

    mo_client_wrap_double ?= cl_abap_testdouble=>create( lc_http_client_wrap ).

    CREATE OBJECT mo_client_builder TYPE zcl_lac_http_client_builder
      EXPORTING
        io_http_wrap = mo_client_wrap_double.

  ENDMETHOD.
ENDCLASS.
