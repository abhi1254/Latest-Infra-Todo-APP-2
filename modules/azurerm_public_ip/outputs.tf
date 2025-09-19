output "public_ip_id" {
  description = "ID of the public IP"
  value       = azurerm_public_ip.public_ip.id
}

output "public_ip_name" {
  description = "Name of the public IP"
  value       = azurerm_public_ip.public_ip.name
}

output "public_ip_address" {
  description = "Public IP address"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "public_ip_fqdn" {
  description = "FQDN of the public IP"
  value       = azurerm_public_ip.public_ip.fqdn
}
