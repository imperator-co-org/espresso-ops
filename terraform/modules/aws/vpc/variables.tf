variable "project" {
  type        = string
  description = "The project to deploy to"
}

variable "env" {
  type        = string
  description = "The name of current env"
}

variable "region" {
  type        = string
  description = "The region to deploy resource"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "List of public subnets"
}

variable "private_subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "List of private subnets"
  default     = []
}
