variable "external_port" {
  type    = list(any)
  default = ["3000", "3001"]
}

variable "internal_port" {
  type    = number
  default = 3000
}

locals {
  container_count = length(var.external_port)
}
