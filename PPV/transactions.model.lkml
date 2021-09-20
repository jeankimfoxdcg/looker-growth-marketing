connection: "cpeprod"

include: "ppv*.view.lkml"

explore: ppv_transactions {
  join: ppv_refunds {
    relationship: one_to_one
    type: left_outer
    sql_on: ${ppv_transactions.order_id} = ${ppv_refunds.order_id} ;;
    sql_where:  ${ppv_refunds.order_id} is null;;
  }
}
