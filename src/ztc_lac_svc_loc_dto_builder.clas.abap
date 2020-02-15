class ZTC_LAC_SVC_LOC_DTO_BUILDER definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods BUILD_FAIL
  for testing
    raising
      ZCX_LAC_CLOUD_DATA_NOT_FOUND .
  methods BUILD_OK
  for testing .
  methods CONSTRUCTOR_OK
  for testing .
protected section.
private section.

  data MO_LOCATOR_BUILDER type ref to ZIF_LAC_SVC_LOC_DTO_BUILDER .
  data MO_LOC_DB_DOUBLE type ref to ZIF_LAC_SVC_CLOUD_DB .

  methods SETUP .
ENDCLASS.



CLASS ZTC_LAC_SVC_LOC_DTO_BUILDER IMPLEMENTATION.


  METHOD build_fail.

    DATA lx_lac_cloud_data_not_found TYPE REF TO zcx_lac_cloud_data_not_found.

    CREATE OBJECT lx_lac_cloud_data_not_found.

*   configure CREATE
    cl_abap_testdouble=>configure_call( mo_loc_db_double
      )->raise_exception( lx_lac_cloud_data_not_found ).

    mo_loc_db_double->read_by_keys( space ).

    TRY .
*       @Test
        mo_locator_builder->build( space ).
        cl_aunit_assert=>fail( ).

      CATCH zcx_lac_cloud_data_not_found INTO lx_lac_cloud_data_not_found ##NO_HANDLER.
    ENDTRY.

    cl_aunit_assert=>assert_bound( lx_lac_cloud_data_not_found ).

  ENDMETHOD.


  METHOD build_ok.

    TRY .
        DATA(lo_locator) = mo_locator_builder->build( space ).

      CATCH zcx_lac_cloud_data_not_found.
        cl_aunit_assert=>fail( ).
    ENDTRY.

    cl_aunit_assert=>assert_bound( lo_locator ).

  ENDMETHOD.


  METHOD constructor_ok.

    CLEAR mo_locator_builder.

    CREATE OBJECT mo_locator_builder TYPE zcl_lac_svc_loc_dto_builder.

    cl_aunit_assert=>assert_bound( mo_locator_builder ).

  ENDMETHOD.


  METHOD setup.

    CONSTANTS lc_svc_cloud_db TYPE seoclsname VALUE 'ZIF_LAC_SVC_CLOUD_DB'.

    mo_loc_db_double ?= cl_abap_testdouble=>create( lc_svc_cloud_db ).

    CREATE OBJECT mo_locator_builder TYPE zcl_lac_svc_loc_dto_builder
      EXPORTING
        io_loc_db = mo_loc_db_double.

  ENDMETHOD.
ENDCLASS.
