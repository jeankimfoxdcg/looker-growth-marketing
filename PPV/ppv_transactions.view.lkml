view: ppv_transactions {

  derived_table: {
    sql: SELECT
              O.order_create_date::DATE as order_date
              , o.order_id
              ,AD.external_profile_id
              ,CASE WHEN LEN(AD.external_profile_id) > 0 THEN 1 ELSE 0 END AS profiles
              ,AD.first_name
              ,AD.last_name
              ,AD.contact_email
              ,PD.pack_def_id
              ,PD.name
              ,TF.payment_amt
              ,TF.payment_method
              , case when pack_def_id in (2833,2933) then 'PPV1'
                     when pack_def_id in (3083,3133) then 'PPV2'
                     when pack_def_id in (3283,3333,3383) then 'PPV3'
                     when pack_def_id in (3581,3582,3583) then 'PPV4'
                     when pack_def_id in (3783,3882,3883,3933) then 'PPV5'
                     when pack_def_id in (7431,7432,7433,7633,7681,7682) then 'PPV6'
                     when pack_def_id in (8133,8233) then 'PPV7'
                     when pack_def_id in (8831,8832) then 'PPV9'
                end as PPV_number
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
              and tf.payment_amt > 0
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: order_date {
    type: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: external_profile_id {
    type: string
    sql: ${TABLE}.external_profile_id ;;
  }

  dimension: profiles {
    type: string
    sql: ${TABLE}.profiles ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: contact_email {
    type: string
    sql: ${TABLE}.contact_email ;;
  }
  dimension: pack_def_id {
    type: string
    sql: ${TABLE}.pack_def_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: payment_amt {
    type: number
    sql: ${TABLE}.payment_amt ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: ppv_number {
    type: string
    sql: ${TABLE}.ppv_number ;;
  }

  measure: purchasers {
    type: count_distinct
    sql: ${external_profile_id} ;;
  }

  measure: orders {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: num_fights {
    type: count_distinct
    sql: ${ppv_number} ;;
  }
}
