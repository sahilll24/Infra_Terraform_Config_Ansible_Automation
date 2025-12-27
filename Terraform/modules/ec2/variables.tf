variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

# variable "iam_profile" {
#   type = string
# }
variable "iam_instance_profile" {
  type = string
}


variable "env" {
  type = string
}

