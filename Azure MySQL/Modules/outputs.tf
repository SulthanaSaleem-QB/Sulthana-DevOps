# output "mysql_server_name" {
#   description = "The name of the MySQL server."
#   value       = azurerm_mysql_flexible_server.example.name
# }

# output "mysql_server_fully_qualified_domain_name" {
#   description = "The fully qualified domain name of the MySQL server."
#   value       = azurerm_mysql_flexible_server.example.fqdn
# }

# output "mysql_database_name" {
#   description = "The name of the MySQL database."
#   value       = azurerm_mysql_flexible_database.example.name
# }





output "mysql_server_name" {
  description = "The name of the MySQL server."
  value       = azurerm_mysql_flexible_server.example.name
}

output "mysql_server_fully_qualified_domain_name" {
  description = "The fully qualified domain name of the MySQL server."
  value       = azurerm_mysql_flexible_server.example.fqdn
}

output "mysql_database_name" {
  description = "The name of the MySQL database."
  value       = azurerm_mysql_flexible_database.example.name
}
