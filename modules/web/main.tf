module "ec2" {
  source = "../ec2"

  nome_projeto        = var.nome_projeto
  vpc_id              = var.vpc_id
  subnet_id           = var.subnet_id
  ip_ssh_permitido    = var.ip_ssh_permitido
  porta_liberada      = 80
  tipo_instancia      = var.tipo_instancia
  associar_ip_publico = true

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y httpd
    systemctl enable httpd
    systemctl start httpd
    cat <<HTML > /var/www/html/index.html
    <html>
    <body>
    <h1>Atividade 1 - Terraform</h1>
    <p>Aluno: ${var.nome_aluno}</p>
    <p>Turma: ${var.turma}</p>
    </body>
    </html>
    HTML
  EOF
}
