
view: lead_gens_weekly_dedup {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
        select emailaddress, min(date_added)::date as min_add_date --into #looker_test
        from (
                  SELECT
                  FLP.date_added::DATE as date_added
                  ,FLP.emailaddress
                  FROM sfmc.foxnation_lead_prospect as FLP
                  WHERE 1=1
                  AND FLP.date_added::DATE >= '2019-04-05'
                  AND FLP.url NOT ilike '%//dev%'
                  AND FLP.emailaddress NOT IlIKE '%@fox%'

                  UNION

                  SELECT FLP.date_added::DATE as date_added
                  ,FLP.emailaddress
                  FROM sfmc.nation_lead_prospect_v2 as FLP
                  WHERE 1=1
                  AND FLP.date_added::DATE >= '2019-10-31'
                  AND FLP.url NOT ilike '%//dev%'
                  AND FLP.emailaddress NOT IlIKE '%@fox%'
                )
        group by 1
        ;;
  }

  # Define your dimensions and measures here, like this:
  dimension_group: min_date_added {
    type: time
    timeframes: [
      raw,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.min_add_date ;;
  }

  measure: leads {
    type: count_distinct
    sql: ${TABLE}.emailaddress ;;
  }

}
