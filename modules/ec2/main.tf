data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "este" {
  name        = "secgrp-${var.nome_projeto}"
  description = "Libera SSH restrito e a porta de aplicacao do modulo ec2"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH apenas do IP autorizado"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ip_ssh_permitido]
  }

  ingress {
    description = "Porta de aplicacao"
    from_port   = var.porta_liberada
    to_port     = var.porta_liberada
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "secgrp-${var.nome_projeto}"
    Curso = "pos-devops-iac"
  }
}

resource "aws_instance" "este" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.tipo_instancia
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.este.id]
  associate_public_ip_address = var.associar_ip_publico
  user_data                   = var.user_data
  key_name                    = var.key_name

  tags = merge(
    {
      Name  = "instancia-${var.nome_projeto}"
      Curso = "pos-devops-iac"
    },
    var.extra_tags
  )
}
