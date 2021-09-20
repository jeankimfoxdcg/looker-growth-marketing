view: now_campaign_context_map {
  derived_table: {
    sql: select a.external_profile_id, a.campaign_name, a.treatment_group, b.context_ip
         from ${dedup_localytics_base.SQL_TABLE_NAME} a
         join ${now_context_ip_mapping.SQL_TABLE_NAME} b on a.external_profile_id = b.external_profile_id
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: external_profile_id {
    type: string
    sql: ${TABLE}.external_profile_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: treatment_group {
    type: string
    sql: ${TABLE}.treatment_group ;;
  }

  dimension: context_ip {
    type: string
    sql: ${TABLE}.context_ip ;;
  }

}
