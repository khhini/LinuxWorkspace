 variable "name" {
  description = "Name of External Application Load Balancer"
  type = string
}

variable "type" {
  description = "Type Of External Application Load Balancer"
  type = string
  default = "global"
}


variable "region" {
  description = "Region for Regional External Application Load Balancer"
  type = string
  default = "asia-southeast2"
}


variable "backends" {
  description = "List of Load Balancer Backends"
  type = map(object({
    name = string
    service_type = string
    service_name = string
    region = string
  }))

  default = {}
}
