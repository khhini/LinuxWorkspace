variable "location" {
  type = string
}

variable "secrets" {
  type = map(object({
    name = string
    secret_data = string  
  }))
}

variable "secret_accessors" {
  type = list(string)
  default = []
}
