variable "cidr" {
  description = "Enter the CIDR range required for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "enable_dns_hostnames" {
  description = "Enable DNS Hostname"
  type        = bool
  default     = null
}
variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
  default     = null
}
variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type        = string
  default     = "shibnath_vpc"
}
variable "igw_tag" {
  description = "Mention Tag needs to be associated with internet gateway"
  type        = string
  default     = "shibnath_IGW"
}
variable "public_subnets_cidr" {
  description = "Cidr Blocks"
  type        = string
  default     = "10.0.0.0/24"
}
variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type        = bool
  default     = null
}
variable "public_subnet_tag" {
  description = "Tag for public subnet"
  type        = string
  default     = "shibnath_vpc_public_subnet"
}
variable "database_subnets_cidr" {
  description = "mention the CIDR block for database subnet"
  type = string
  default = "10.0.1.0/24"
}
variable "database_subnet_tag" {
  description = "Tag for Private Subnet"
  type        = string
  default     = "shibnath_vpc_private_subnet"
}
variable "public_route_table_tag" {
  description = "Tag name for public route table"
  type        = string
  default     = "shibnath_vpc_public_route_table"
}
variable "database_route_table_tag" {
  description = "Tage for database route table"
  type        = string
  default     = "shibnath_vpc_database_route_table"
}
