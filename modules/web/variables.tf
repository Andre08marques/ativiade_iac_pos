variable "nome_projeto" {
  type        = string
  description = "nome usado nas tags e no security group"
}

variable "vpc_id" {
  type        = string
  description = "vpc onde o security group sera criado"
}

variable "subnet_id" {
  type        = string
  description = "subnet onde a instancia sera lancada"
}

variable "ip_ssh_permitido" {
  type        = string
  description = "CIDR liberado na porta 22"
}

variable "tipo_instancia" {
  type        = string
  default     = "t3.micro"
  description = "tipo da instancia EC2"
}

variable "nome_aluno" {
  type        = string
  description = "nome exibido na pagina html"
}

variable "turma" {
  type        = string
  description = "turma exibida na pagina html"
}
