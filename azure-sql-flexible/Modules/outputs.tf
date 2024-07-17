

output "mysql_server_fqdn" {
  value = azurerm_mysql_flexible_server.example.fqdn
}

output "mysql_database_id" {
  value = azurerm_mysql_flexible_database.example.id
}
