view: ppv_pivot {

  derived_table: {
    sql: SELECT
              external_profile_id
              , count(distinct ppv_number) as fights
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

  measure: purchasers {
    type: count_distinct
    sql: ${TABLE}.external_profile_id ;;
  }

}
