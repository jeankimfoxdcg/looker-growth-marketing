view: ppv_pivot {

  derived_table: {
    sql: SELECT
              external_profile_id
              , count(distinct ppv_number) as fights
              , max(case when  a.PPV_number = 'PPV1' then 1 else 0 end) as ppv1_flag
              , max(case when ppv_number = 'PPV2' then 1 else 0 end) as ppv2_flag
              , max(case when ppv_number = 'PPV3' then 1 else 0 end) as ppv3_flag
              , max(case when ppv_number = 'PPV4' then 1 else 0 end) as ppv4_flag
              , max(case when ppv_number = 'PPV5' then 1 else 0 end) as ppv5_flag
              , max(case when ppv_number = 'PPV6' then 1 else 0 end) as ppv6_flag
              , max(case when ppv_number = 'PPV7' then 1 else 0 end) as ppv7_flag
              --, max(case when ppv_number = 'PPV8' then 1 else 0 end) as ppv8_flag
              , max(case when ppv_number = 'PPV9' then 1 else 0 end) as ppv9_flag
            FROM
             ${ppv_transactions.SQL_TABLE_NAME} a
              left outer join ${ppv_refunds.SQL_TABLE_NAME} b on a.order_id = b.order_id
            WHERE 1=1
              and b.order_id is null
            group by 1
      ;;
  }

  # Define your dimensions and measures here, like this:


  dimension: external_profile_id {
    type: string
    sql: ${TABLE}.external_profile_id ;;
  }

  dimension: fights {
    type: number
    sql: ${TABLE}.fights ;;
  }

  dimension: purch_ppv1 {
    type: string
    sql: ${TABLE}.ppv1_flag ;;
  }

  dimension: purch_ppv2 {
    type: string
    sql: ${TABLE}.ppv2_flag ;;
  }

  dimension: purch_ppv3 {
    type: string
    sql: ${TABLE}.ppv3_flag ;;
  }

  dimension: purch_ppv4 {
    type: string
    sql: ${TABLE}.ppv4_flag ;;
  }

  dimension: purch_ppv5 {
    type: string
    sql: ${TABLE}.ppv5_flag ;;
  }

  dimension: purch_ppv6 {
    type: string
    sql: ${TABLE}.ppv6_flag ;;
  }

  dimension: purch_ppv7 {
    type: string
    sql: ${TABLE}.ppv7_flag ;;
  }

  dimension: purch_ppv9 {
    type: string
    sql: ${TABLE}.ppv9_flag ;;
  }


  measure: ppv1_flag {
    type: sum
    sql: ${TABLE}.ppv1_flag ;;
  }

  measure: ppv2_flag {
    type: sum
    sql: ${TABLE}.ppv2_flag ;;
  }

  measure: ppv3_flag {
    type: sum
    sql: ${TABLE}.ppv3_flag ;;
  }

  measure: ppv4_flag {
    type: sum
    sql: ${TABLE}.ppv4_flag ;;
  }

  measure: ppv5_flag {
    type: sum
    sql: ${TABLE}.ppv5_flag ;;
  }

  measure: ppv6_flag {
    type: sum
    sql: ${TABLE}.ppv6_flag ;;
  }

  measure: ppv7_flag {
    type: sum
    sql: ${TABLE}.ppv7_flag ;;
  }


  measure: ppv9_flag {
    type: sum
    sql: ${TABLE}.ppv9_flag ;;
  }

  measure: purchasers {
    type: count_distinct
    sql: ${TABLE}.external_profile_id ;;
  }

}
