
view: dedup_localytics_base {
  derived_table: {
    sql: with localytics_base as
          (
            select
              customer_id as external_profile_id
              , campaign_name
              , case when control_alert = 'Control' then 'holdout' else 'treatment' end as treatment_group
            from localytics.vw_campaign_events_raw
            where 1=1
              and app_name in ('Production - FOX NOW Android','Production - FOX NOW iOS')
              and event_name = 'Localytics Push Sent'
              and campaign_name in ('FOXNOW_ADH_P_iOS_InLife_All_Catchup_Drama_041021_NA', 'FOXNOW_ADH_P_Android_InLife_All_Catchup_Drama_041021_NA')
          )
          select external_profile_id, campaign_name, treatment_group from (
          select external_profile_id, campaign_name, treatment_group from localytics_base
          where treatment_group = 'treatment'
          union all
          select external_profile_id, campaign_name, treatment_group from localytics_base
          where treatment_group = 'control' and external_profile_id not in (select distinct external_profile_id from localytics_base where treatment_group = 'treatment')
          )
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

}
