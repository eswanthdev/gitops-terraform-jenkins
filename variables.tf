variable "key_name" {
  description = "Private key name to use with instance"
  default     = "ansible-key121"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t3.small"
}

variable "ami" {
  description = "Base AMI to launch the instances"

  # Bitnami NGINX AMI
  default = "ami-07539a31f72d244e7"
}
