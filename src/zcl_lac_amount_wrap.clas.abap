class ZCL_LAC_AMOUNT_WRAP definition
  public
  create public .

public section.

  interfaces ZIF_LAC_AMOUNT_WRAP .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LAC_AMOUNT_WRAP IMPLEMENTATION.


  METHOD zif_lac_amount_wrap~currency_amount_bapi_to_sap.

    DATA lv_amount TYPE string.

    CALL FUNCTION 'CURRENCY_AMOUNT_BAPI_TO_SAP'
      EXPORTING
        currency              = iv_currency
        bapi_amount           = iv_amount
      IMPORTING
        sap_amount            = rv_amount
      EXCEPTIONS
        bapi_amount_incorrect = 1
        OTHERS                = 2.

    IF sy-subrc = 1.

      lv_amount = iv_amount.

      RAISE EXCEPTION TYPE zcx_lac_bapi_amount_incorrect
        EXPORTING
          textid    = zcx_lac_bapi_amount_incorrect=>wrong_format
          mv_amount = lv_amount.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
