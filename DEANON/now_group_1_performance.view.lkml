view: now_group_1_performance {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: select
            a.external_profile_id
            , a.treatment_group
            , sum(case when b.vcs_pod_id in ('1','1.0') then b.event_cnt end) as sum_ev
            , sum(b.video_seconds_viewed)/60.0 as sum_min
          from
            ${dedup_localytics_base.SQL_TABLE_NAME} a
            join dw.now_visitid b on a.external_profile_id = nvl(b.context_traits_last_known_profile_id, b.context_traits_dcg_profile_id, b.context_traits_last_anonymous_profile_id, b.user_id)
          where 1=1
            and b.first_received_at::date betweeb '2021-04-13' and '2021-04-15'
          group by 1,2
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: external_profile_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: treatment_group {
    type: string
    sql: ${TABLE}.treatment_group ;;
  }

  measure: starts {
    type: number
    sql: ${TABLE}.sum_ev  ;;
  }

  measure: minutes_viewed {
    type: number
    sql: ${TABLE}.sum_min  ;;
  }
}
