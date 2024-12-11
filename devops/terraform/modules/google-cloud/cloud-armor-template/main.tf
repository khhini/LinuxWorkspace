resource "google_compute_security_policy" "policy" {
  name = "${var.policy_name_prefix}-security-policy"
  description = var.policy_description
  type = "CLOUD_ARMOR"
}

resource "google_compute_security_policy_rule" "waf_policy_rules" {
  for_each = var.waf_policies

  security_policy = google_compute_security_policy.policy.name

  action = each.value.action
  priority = each.value.priority
  description = each.value.description
  preview = each.value.preview

  match {
    expr {
      expression = length(each.value.opt_out_rule_ids) > 0 ? "evaluatePreconfiguredWaf('${each.value.preconfigured_waf}', {'sensitivity': ${each.value.sensitifity}, 'opt_out_rule_ids': [${join(",", each.value.opt_out_rule_ids)}]})" : "evaluatePreconfiguredWaf('${each.value.preconfigured_waf}', {'sensitivity': ${each.value.sensitifity}})" 
    }
  }
}

resource "google_compute_security_policy_rule" "other_rules" {
   for_each = length(var.other_rules) > 0 ? var.other_rules : {}

   security_policy = google_compute_security_policy.policy.name

   action = each.value.action
   priority = each.value.priority
   description = each.value.description
   preview = each.value.preview

   match {
     expr {
       expression = each.value.expression
     }
   }
}
