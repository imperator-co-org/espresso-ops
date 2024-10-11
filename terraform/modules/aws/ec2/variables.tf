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

variable "base_image_filter" {
  type        = string
  description = "The filter to query base image"
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
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
  default     = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "The subnet to launch the instance"
}

variable "use_eip" {
  type        = bool
  description = "Use EIP for the instance"
  default     = false
}

variable "root_disk_size" {
  type        = number
  description = "Root disk size"
  default     = 20
}

variable "create_data_disk" {
  type        = bool
  description = "Use additional data disk?"
  default     = false
}

variable "data_disk_size" {
  type        = number
  description = "Data disk size"
  default     = 20
}

variable "inbound_ip_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
