variable "region" {
  type        = string
  description = "aws region"
}

variable "assume_role" {
  type = object({
    role_arn    = string
    external_id = string
  })
  description = "description"
}

variable "environment" {
  type        = string
  description = "choice environment"
}

variable "tags" {
  type = map(string)
}

variable "remote_backend" {
  type = object({
    bucket = string,
  })
}

variable "profile" {
  type        = string
  description = "profile for be used"
}

variable "azs" {
  type        = list(string)
  description = "availability zones"
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