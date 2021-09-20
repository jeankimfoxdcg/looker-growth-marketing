view: ppv_refunds {

  derived_table: {
    sql: SELECT
             o.order_id
          FROM
              evergent.account_dim as AD
              JOIN evergent.order_fact as O ON AD.account_dim_id = O.acct_dim_id
              LEFT JOIN evergent.transaction_fact as TF ON o.order_id = TF.order_id
              JOIN evergent.pack_def as PD ON O.pack_dim_id = PD.pack_def_id
          WHERE 1=1
              AND O.pack_dim_id IN ('2833',
                                    '2933',
                                    '3083',
                                    '3133',
                                    '3283',
                                    '3333',
                                    '3382',
                                    '3383',
                                    '3581',
                                    '3582',
                                    '3583',
                                    '3783',
                                    '3882',
                                    '3883',
                                    '3933',
                                    '7431',
                                    '7432',
                                    '7433',
                                    '7633',
                                    '7681',
                                    '7682',
                                    '8133',
                                    '8233',
                                    '8831',
                                    '8832')
              AND AD.etl_end_date > getdate()
              AND PD.etl_end_date > getdate()
              and tf.payment_amt < 0
      ;;
  }



  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

}
