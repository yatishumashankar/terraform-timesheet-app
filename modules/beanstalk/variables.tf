variable "vpc_id" {
  description = "VPC ID for Beanstalk"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for Beanstalk"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for Beanstalk"
  type        = string
}