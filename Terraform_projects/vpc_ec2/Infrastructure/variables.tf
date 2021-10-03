variable region {
  default     = "ca-central-1"
  description = "AWS region"
}

variable "vpc_cidr" {
    default     = "10.0.0.0/16"
    description = "vpc_cidrblock"
}

variable "public_subnet_1_cidr" {
    description = "public subnet 1"
}

variable "public_subnet_2_cidr" {
    description = "public subnet 2"
}

variable "public_subnet_3_cidr" {
    description = "public subnet 3"
}

variable "private_subnet_1_cidr" {
    description = "private subnet 1"
}

variable "private_subnet_2_cidr" {
    description = "private subnet 2"
}

variable "private_subnet_3_cidr" {
    description = "private subnet 3"
}