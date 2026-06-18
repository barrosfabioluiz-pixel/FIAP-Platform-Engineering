variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

# Busca dinamica da Amazon Linux 2023 mais recente, evitando AMIs hardcoded que expiram.
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "instance_type" {
  description = "Tipo de instancia EC2 da frota. Usado tambem para descobrir as AZs que o ofertam."
  default     = "t3.micro"
}

variable "key_name" {
  default = "vockey"
}
variable "path_to_key" {
  default = "/home/vscode/.ssh/vockey.pem"
}
variable "instance_username" {
  default = "ec2-user"
}
