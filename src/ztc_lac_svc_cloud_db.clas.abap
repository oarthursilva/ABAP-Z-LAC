class ZTC_LAC_SVC_CLOUD_DB definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods CONSTRUCTOR_OK
  for testing .
  methods READ_BY_KEYS_EMPTY
  for testing .
  methods READ_BY_KEYS_OK
  for testing .
  methods READ_EMPTY
  for testing .
  methods READ_OK
  for testing .
protected section.
private section.

  data MO_SERVICE_DB type ref to ZIF_LAC_SVC_CLOUD_DB .
  class-data MO_TEST_ENVIRONMENT type ref to IF_OSQL_TEST_ENVIRONMENT .

  class-methods CLASS_SETUP .
  class-methods CLASS_TEARDOWN .
  methods SETUP .
  methods TEARDOWN .
ENDCLASS.



CLASS ZTC_LAC_SVC_CLOUD_DB IMPLEMENTATION.


  METHOD class_setup.

    DATA: lt_tables TYPE TABLE OF ddstrucobjname.

    APPEND 'zlac_svc_cloud' TO lt_tables.

    mo_test_environment = cl_osql_test_environment=>create( lt_tables ).

  ENDMETHOD.


  METHOD class_teardown.

    mo_test_environment->destroy( ).

  ENDMETHOD.


  METHOD constructor_ok.

    CLEAR mo_service_db.

    CREATE OBJECT mo_service_db TYPE zcl_lac_svc_cloud_db.

    cl_aunit_assert=>assert_bound( mo_service_db ).

  ENDMETHOD.


  METHOD read_by_keys_empty.

    DATA lx_lac_cloud_data_not_found TYPE REF TO zcx_lac_cloud_data_not_found.

    TRY .
        mo_service_db->read_by_keys( ztf_lac_svc_cloud_db=>sc_type ).
        cl_aunit_assert=>fail( ).

      CATCH zcx_lac_cloud_data_not_found INTO lx_lac_cloud_data_not_found.
        cl_aunit_assert=>assert_bound( lx_lac_cloud_data_not_found ).
    ENDTRY.

  ENDMETHOD.


  METHOD read_by_keys_ok.

    DATA: ls_zlac_svc_exp TYPE zlac_svc_cloud,
          ls_zlac_svc_act TYPE zlac_svc_cloud,
          lt_zlac_svc     TYPE zlac_svc_cloud_tab.

    ls_zlac_svc_exp = ztf_lac_svc_cloud_db=>read_by_keys_in( ).
    APPEND ls_zlac_svc_exp TO lt_zlac_svc.

    mo_test_environment->insert_test_data( lt_zlac_svc ).

    TRY .
        ls_zlac_svc_act = mo_service_db->read_by_keys( ztf_lac_svc_cloud_db=>sc_type ).
        READ TABLE lt_zlac_svc INTO ls_zlac_svc_act INDEX 1.

      CATCH zcx_lac_cloud_data_not_found.
        cl_aunit_assert=>fail( 'data not found' ).
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      exp = ls_zlac_svc_exp
      act = ls_zlac_svc_act
    ).

  ENDMETHOD.


  METHOD read_empty.

    DATA: lx_lac_cloud_data_not_found TYPE REF TO zcx_lac_cloud_data_not_found,
          ls_lac_cloud_selection      TYPE zlac_svc_cloud_selection,
          ls_rsparams                 TYPE rsparams.

    ls_rsparams-sign = 'I'.
    ls_rsparams-option = 'EQ'.
    ls_rsparams-low = ztf_lac_svc_cloud_db=>sc_type.
    APPEND ls_rsparams TO ls_lac_cloud_selection-svc_type.

    TRY .
        mo_service_db->read( ls_lac_cloud_selection ).
        cl_aunit_assert=>fail( ).

      CATCH zcx_lac_cloud_data_not_found INTO lx_lac_cloud_data_not_found.
        cl_aunit_assert=>assert_bound( lx_lac_cloud_data_not_found ).
    ENDTRY.

  ENDMETHOD.


  METHOD read_ok.

    DATA: ls_zlac_svc_exp        TYPE zlac_svc_cloud,
          ls_zlac_svc_act        TYPE zlac_svc_cloud,
          lt_zlac_svc            TYPE zlac_svc_cloud_tab,
          ls_lac_cloud_selection TYPE zlac_svc_cloud_selection,
          ls_rsparams            TYPE rsparams.

    lt_zlac_svc = ztf_lac_svc_cloud_db=>read_in( ).
    READ TABLE lt_zlac_svc INTO ls_zlac_svc_exp INDEX 1.

    mo_test_environment->insert_test_data( lt_zlac_svc ).

    ls_rsparams-sign = 'I'.
    ls_rsparams-option = 'EQ'.
    ls_rsparams-low = ztf_lac_svc_cloud_db=>sc_type.
    APPEND ls_rsparams TO ls_lac_cloud_selection-svc_type.

    TRY .
        lt_zlac_svc = mo_service_db->read( ls_lac_cloud_selection ).
        READ TABLE lt_zlac_svc INTO ls_zlac_svc_act INDEX 1.

      CATCH zcx_lac_cloud_data_not_found.
        cl_aunit_assert=>fail( 'data not found' ).
    ENDTRY.

    cl_aunit_assert=>assert_equals(
      exp = ls_zlac_svc_exp
      act = ls_zlac_svc_act
    ).

  ENDMETHOD.


  METHOD setup.

    CREATE OBJECT mo_service_db TYPE zcl_lac_svc_cloud_db.

  ENDMETHOD.


  METHOD teardown.

    mo_test_environment->clear_doubles( ).

  ENDMETHOD.
ENDCLASS.
