
view: lead_gens {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
          FLP.date_added::DATE as date_added
          ,FLP.url
          ,FLP.emailaddress as email_addr
          FROM sfmc.foxnation_lead_prospect as FLP
          WHERE 1=1
          AND FLP.date_added::DATE >= '2019-04-05'
          AND FLP.url NOT ilike '%//dev%'
          AND FLP.emailaddress NOT IlIKE '%@fox%'

          UNION

          SELECT FLP.date_added::DATE as date_added
          ,FLP.url
          ,FLP.emailaddress as email_addr
          FROM sfmc.nation_lead_prospect_v2 as FLP
          WHERE 1=1
          AND FLP.date_added::DATE >= '2019-10-31'
          AND FLP.url NOT ilike '%//dev%'
          AND FLP.emailaddress NOT IlIKE '%@fox%'
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: date_added {
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: email_address {
    type: string
    sql: ${TABLE}.emailaddress ;;
  }

  measure: leads {
    type: count_distinct
    sql: ${TABLE}.emailaddress ;;
  }
}
