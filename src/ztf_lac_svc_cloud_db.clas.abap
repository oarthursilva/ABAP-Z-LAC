class ZTF_LAC_SVC_CLOUD_DB definition
  public
  final
  create public
  for testing .

public section.

  constants SC_TYPE type ZLAC_SVC_TYPE value 'type' ##NO_TEXT.
  constants SC_HOST type ZLAC_SVC_HOST value 'host' ##NO_TEXT.

  class-methods READ_IN
    returning
      value(RT_DATA) type ZLAC_SVC_CLOUD_TAB .
  class-methods READ_BY_KEYS_IN
    returning
      value(RS_DATA) type ZLAC_SVC_CLOUD .
protected section.
private section.
ENDCLASS.



CLASS ZTF_LAC_SVC_CLOUD_DB IMPLEMENTATION.


  METHOD read_by_keys_in.

    rs_data-mandt                = sy-mandt.
    rs_data-svc_type             = sc_type.
    rs_data-svc_validfrom        = sy-datum.
    rs_data-svc_host             = sc_host.
    rs_data-oauth2_profile       = space.
    rs_data-oauth2_configuration = space.

  ENDMETHOD.


  METHOD read_in.

    DATA ls_zlac_svc_cloud TYPE zlac_svc_cloud.

    ls_zlac_svc_cloud-mandt                = sy-mandt.
    ls_zlac_svc_cloud-svc_type             = sc_type.
    ls_zlac_svc_cloud-svc_validfrom        = sy-datum.
    ls_zlac_svc_cloud-svc_host             = sc_host.
    ls_zlac_svc_cloud-oauth2_profile       = space.
    ls_zlac_svc_cloud-oauth2_configuration = space.

    APPEND ls_zlac_svc_cloud TO rt_data.

  ENDMETHOD.
ENDCLASS.
