output "app_server_public_ip" {
  description = "IP publico da instancia da aplicacao getting-started-app"
  value       = module.app_server.public_ip
}

output "app_server_instance_id" {
  description = "ID da instancia da aplicacao getting-started-app"
  value       = module.app_server.instance_id
}

output "app_ssh_private_key_path" {
  description = "Caminho local da chave privada SSH gerada para esta instancia/workspace"
  value       = local_sensitive_file.app_private_key.filename
}
