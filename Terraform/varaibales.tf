# variables.tf

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "route_table_name" {
  description = "Name of the Route Table"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "terraform-vpc"
}

variable "internet_gateway_name" {
  description = "The name of the Internet Gateway"
  type        = string
  default     = "IGW"
}
variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "terraform-subnet"

}
variable "subnet_block" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "route-table-name" {
  description = "The name of the route-table"
  type        = string
  default     = "terrfaorm-routeTable"
}