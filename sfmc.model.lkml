connection: "cpeprod"

include: "lead_gens*.view.lkml"

explore: lead_gens {
  # join: lead_gens_weekly_dedup {
  #   type: left_outer
  #   sql_on: ${lead_gens_weekly_dedup.min_date_added_date} = ${lead_gens.date_added_date} ;;
  #   relationship: one_to_one
  # }
}

explore: lead_gens_weekly_dedup {}
