variable "private_subnet_ids" {
  description = "List of Private Subnet IDs for RDS"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for RDS"
  type        = string
}
