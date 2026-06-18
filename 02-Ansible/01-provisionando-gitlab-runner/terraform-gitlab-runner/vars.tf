variable "aws_region" {
  default = "us-east-1"
}

variable "project" {
  default = "fiap-lab"
}

variable "key_name" {
  default = "vockey"
}

variable "path_to_key" {
  default = "/home/vscode/.ssh/vockey.pem"
}

variable "instance_username" {
  default = "ubuntu"
}
