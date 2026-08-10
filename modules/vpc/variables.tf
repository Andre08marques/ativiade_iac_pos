variable "environment" {
  type = string
}

variable "vpc" {
  type = object({
    cidr           = string
    public_subnets = list(string)
  })
  default = {
    cidr           = "10.10.0.0/16"
    public_subnets = []
  }
}

variable "azs" {
  type    = list(string)
  default = []
}
