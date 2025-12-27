variable "vpc_id" {
  type = string
}

variable "env" {
  type = string
}

variable "allowed_ssh_cidr" {
  type = list(string)
}
