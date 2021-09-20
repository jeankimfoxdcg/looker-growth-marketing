
view: now_context_ip_mapping {
  derived_table: {
    sql: with mapping_raw as
          (
            select distinct
              anonymous_id
              , nvl(context_traits_last_known_profile_id, context_traits_dcg_profile_id, context_traits_last_anonymous_profile_id, user_id) as external_profile_id
              , source_platform
              , context_ip
              , source_network
            from dw.now_visitid
            where 1=1
              and event = 'video_content_started'
              and vcs_pod_id in ('1','1.0')
              and first_received_at::date between '2021-04-14' and '2021-04-15'
          )
          select a.anonymous_id, a.external_profile_id, a.source_platform, a.context_ip, a.source_network
          from mapping_raw a
          join (
                 select context_ip, count(distinct external_profile_id) as cnt_id
                 from mapping_raw
                 group by 1 having cnt_id > 4 order by 2 desc
               ) b on a.context_ip = b.context_ip
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: external_profile_id {
    type: string
    sql: ${TABLE}.external_profile_id ;;
  }

  dimension: source_platform {
    type: string
    sql: ${TABLE}.source_platform ;;
  }

  dimension: context_ip {
    type: string
    sql: ${TABLE}.context_ip ;;
  }

  dimension: source_network {
    type: string
    sql: ${TABLE}.source_network ;;
  }

}
