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

variable "porta_liberada" {
  type        = number
  description = "porta de aplicacao liberada para 0.0.0.0/0"
}

variable "tipo_instancia" {
  type        = string
  default     = "t3.micro"
  description = "tipo da instancia EC2"
}

variable "associar_ip_publico" {
  type        = bool
  default     = true
  description = "associa IP publico automaticamente na instancia"
}

variable "user_data" {
  type        = string
  default     = null
  description = "script de inicializacao da instancia; opcional"
}

variable "key_name" {
  type        = string
  default     = null
  description = "nome da key pair EC2 usada para acesso SSH; opcional"
}

variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "tags adicionais mescladas na instancia (ex: usadas pelo inventario dinamico do Ansible)"
}
