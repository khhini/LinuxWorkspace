variable "policy_name_prefix" {
  type = string
}

variable "policy_description" {
  type = string
}

variable "waf_policies" {
  type = map(object({
    preconfigured_waf = string
    sensitifity = number
    opt_out_rule_ids = set(string)
    preview = bool
    priority = number
    action = string
    description = string
  }))
}

variable "other_rules" {
  type = map(object({
    expression = string
    sensitifity = number
    preview = bool
    priority = number
    action = string
    description = string
  }))
  default = {}
}
