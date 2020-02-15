class ZCL_LAC_SVC_CLOUD_DB definition
  public
  create public .

public section.

  interfaces ZIF_LAC_SVC_CLOUD_DB .
protected section.
private section.
ENDCLASS.



CLASS ZCL_LAC_SVC_CLOUD_DB IMPLEMENTATION.


  METHOD zif_lac_svc_cloud_db~read.

    DATA: lr_svc_type       TYPE RANGE OF zlac_svc_type,
          lr_svc_validfrom  TYPE RANGE OF zlac_validfrom,
          lr_svc_url        TYPE RANGE OF zlac_svc_host,
          lr_oauth2_profile TYPE RANGE OF oa2c_profile.

    MOVE-CORRESPONDING: is_selection_fields-svc_type       TO lr_svc_type,
                        is_selection_fields-svc_validfrom  TO lr_svc_validfrom.

    SELECT * FROM zlac_svc_cloud INTO TABLE rt_cloud_service
      WHERE svc_type      IN lr_svc_type
        AND svc_validfrom IN lr_svc_validfrom
        AND oauth2_profile IN lr_oauth2_profile.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_cloud_data_not_found
        EXPORTING
          textid = zcx_lac_cloud_data_not_found=>not_found.
    ENDIF.

  ENDMETHOD.


  METHOD zif_lac_svc_cloud_db~read_by_keys.

    SELECT SINGLE * FROM zlac_svc_cloud INTO rs_cloud_service
      WHERE svc_type      = iv_service_type.
*        AND svc_validfrom = iv_service_validfrom.

    IF sy-dbcnt = 0.
      RAISE EXCEPTION TYPE zcx_lac_cloud_data_not_found
        EXPORTING
          textid = zcx_lac_cloud_data_not_found=>not_found.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
