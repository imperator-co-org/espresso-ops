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

variable "vpc_id" {
  type        = string
  description = "ID of vpc"
}

variable "instance_name" {
  type        = string
  description = "The tag name of instance"
}

variable "instance_type" {
  type        = string
  description = "The type of instance"
  default     = "t3.db.micro"
}

variable "instance_storage" {
  type        = number
  description = "The storage of the database"
  default     = 10
}

variable "instance_engine" {
  type        = string
  description = "The rds instance engine"
}

variable "instance_engine_version" {
  type        = string
  description = "The rds instance engine version"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets to launch the instance"
}

variable "parameter_group_family" {
  type        = string
  description = "The rds paramenter group family"
}

variable "default_username" {
  type        = string
  description = "Database default user"
}

variable "default_password" {
  type        = string
  description = "Database default password"
  sensitive   = true
}

variable "default_database_name" {
  type        = string
  description = "Default database name"
}

variable "inbound_rules" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), null)
    security_groups = optional(list(string), null)
  }))
  default = []
}

variable "parameter_group_params" {
  type = list(object({
    name  = string
    value = string
  }))
}
