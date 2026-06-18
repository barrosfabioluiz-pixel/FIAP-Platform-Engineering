# Busca dinamica da AMI Ubuntu 22.04 mais recente publicada pela Canonical.
# Evita AMI hardcoded, que expira e quebra o lab entre regioes/turmas.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "random_shuffle" "random_subnet" {
  input        = [for s in data.aws_subnet.public : s.id]
  result_count = 1
}

resource "aws_instance" "example" {
  count                  = 1
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  iam_instance_profile   = "LabInstanceProfile"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.gitlab-runner-fleet.id]
  subnet_id              = random_shuffle.random_subnet.result[0]

  provisioner "file" {
    source      = "install-python.sh"
    destination = "/tmp/install-python.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-python.sh",
      "sudo /tmp/install-python.sh",
    ]
  }

  connection {
    user        = var.instance_username
    private_key = file(var.path_to_key)
    host        = self.public_ip
  }

  tags = {
    Name = format("gitlab-runner-fleet-%03d", count.index + 1)
  }
}
