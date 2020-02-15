class ZCL_LAC_SVC_LOC_DTO_BUILDER definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SVC_LOC_DTO_BUILDER .

  methods CONSTRUCTOR
    importing
      !IO_LOC_DB type ref to ZIF_LAC_SVC_CLOUD_DB optional
      !IO_LOC_DTO type ref to ZCL_LAC_SVC_LOC_DTO optional .
protected section.
private section.

  data MO_LOC_DB type ref to ZIF_LAC_SVC_CLOUD_DB .
ENDCLASS.



CLASS ZCL_LAC_SVC_LOC_DTO_BUILDER IMPLEMENTATION.


  METHOD constructor.

    IF io_loc_db IS BOUND.
      mo_loc_db = io_loc_db.
    ELSE.
      CREATE OBJECT mo_loc_db TYPE zcl_lac_svc_cloud_db.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_svc_loc_dto_builder~build.

    DATA ls_service_locator TYPE zlac_svc_cloud.

    TRY .
        ls_service_locator = mo_loc_db->read_by_keys( iv_service_type ).

      CATCH zcx_lac_cloud_data_not_found.
        RAISE EXCEPTION TYPE zcx_lac_cloud_data_not_found
          EXPORTING
            textid          = zcx_lac_cloud_data_not_found=>not_found
            mv_service_type = iv_service_type.
    ENDTRY.

    CREATE OBJECT ro_locator_dto
      EXPORTING
        is_service_locator = ls_service_locator.

  ENDMETHOD.
ENDCLASS.
