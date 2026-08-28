module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  azs         = var.azs

  vpc = {
    cidr           = var.vpc.cidr
    public_subnets = var.vpc.public_subnets
  }
}

# chave SSH usada pelo Ansible
resource "tls_private_key" "app" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "app" {
  key_name   = "${var.project_name}-${terraform.workspace}"
  public_key = tls_private_key.app.public_key_openssh
}

# chave privada salva localmente, usada pelo inventario dinamico do Ansible
resource "local_sensitive_file" "app_private_key" {
  content         = tls_private_key.app.private_key_pem
  filename        = "${path.module}/ssh/${var.project_name}-${terraform.workspace}.pem"
  file_permission = "0400"
}

# instancia da getting-started-app; Docker e o container ficam por conta do Ansible
module "app_server" {
  source = "./modules/ec2"

  nome_projeto        = "${var.project_name}-${terraform.workspace}"
  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.vpc.subnet_ids[0]
  ip_ssh_permitido    = var.ip_ssh_permitido
  porta_liberada      = 3000
  tipo_instancia      = "t3.micro"
  associar_ip_publico = true
  key_name            = aws_key_pair.app.key_name

  extra_tags = {
    Environment = terraform.workspace
    Project     = var.project_name
  }
}