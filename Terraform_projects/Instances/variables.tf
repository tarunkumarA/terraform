variable "region" {
  default     = "ca-central-1"
  description = "aws region"
}

variable "remote_state_bucket" {
    description = "Bucket name for layer 1 remote state"
}

variable "remote_state_key" {
    description = "Key name for layer 1 remote state"
}

