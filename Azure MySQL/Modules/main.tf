# # Provider configuration block (must be in the root module)
# provider "azurerm" {
#   features {}
# }


# # #To create resource group
# resource "azurerm_resource_group" "resourcegroup" {
#   name     = var.resource_group_name
#   location = var.location
# }

# # # #To create MySQL Server
# # resource "azurerm_mysql_server" "mysql_server" {
# #   name                = var.mysql_server_name
# #   location            = var.location
# #   resource_group_name = azurerm_resource_group.resourcegroup.name

# #   administrator_login          = var.mysql_administrator_login
# #   administrator_login_password = var.mysql_administrator_login_password
# #   sku_name                     = var.mysql_sku_name
# #   version                      = var.mysql_version
# #   storage_mb                   = var.mysql_storage_mb
# #   backup_retention_days        = var.mysql_backup_retention_days
# #   ssl_enforcement_enabled      = var.ssl_enforcement_enabled 

# #   tags = {
# #     Name        = var.mysql_server_name
# #   }
# # }

# # # #To create MySQL Database
# # resource "azurerm_mysql_database" "mysql_database" {
# #   name                = var.mysql_database_name
# #   resource_group_name = azurerm_resource_group.resourcegroup.name
# #   server_name         = azurerm_mysql_server.mysql_server.name
# #   charset             = var.mysql_charset
# #   collation           = var.mysql_collation
# # }

# resource "azurerm_mysql_flexible_server" "example" {
#   name                   = var.mysql_flexible_server.example.name
#   resource_group_name    = azurerm_resource_group.resourcegroup.name
#   location               = azurerm_resource_group.resourcegroup.location
#   administrator_login    = var.mysql_administrator_login
#   administrator_password = var.mysql_administrator_login_password
#   sku_name               = var.mysql_sku_name
# }

# resource "azurerm_mysql_flexible_database" "example" {
#   name                = var.mysql_flexible_database.example.name
#   resource_group_name = azurerm_resource_group.resourcegroup.name
#   server_name         = azurerm_mysql_flexible_server.example.name
#   charset             = var.mysql_charset
#   collation           = var.mysql_collation
# }

# # Create MySQL Firewall Rule (if applicable)
# resource "azurerm_mysql_flexible_server_firewall_rule" "mysql_firewall_rule" {
#   count               = var.mysql_firewall_rules != null ? length(var.mysql_firewall_rules) : 0
#   name                = var.mysql_firewall_rules[count.index].name
#   resource_group_name = azurerm_resource_group.resourcegroup.name
#   server_name         = azurerm_mysql_flexible_server.example.name
#   start_ip_address    = var.mysql_firewall_rules[count.index].start_ip_address
#   end_ip_address      = var.mysql_firewall_rules[count.index].end_ip_address
# }



provider "azurerm" {
  features {}
}

# To create resource group
resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_mysql_flexible_server" "example" {
  name                   = var.mysql_flexible_server_name
  resource_group_name    = azurerm_resource_group.resourcegroup.name
  location               = azurerm_resource_group.resourcegroup.location
  administrator_login    = var.mysql_administrator_login
  administrator_password = var.mysql_administrator_login_password
  sku_name               = var.mysql_sku_name
}

resource "azurerm_mysql_flexible_database" "example" {
  name                = var.mysql_flexible_database_name
  resource_group_name = azurerm_resource_group.resourcegroup.name
  server_name         = azurerm_mysql_flexible_server.example.name
  charset             = var.mysql_charset
  collation           = var.mysql_collation
}

# Create MySQL Firewall Rule (if applicable)
resource "azurerm_mysql_flexible_server_firewall_rule" "mysql_firewall_rule" {
  count               = var.mysql_firewall_rules != null ? length(var.mysql_firewall_rules) : 0
  name                = var.mysql_firewall_rules[count.index].name
  resource_group_name = azurerm_resource_group.resourcegroup.name
  server_name         = azurerm_mysql_flexible_server.example.name
  start_ip_address    = var.mysql_firewall_rules[count.index].start_ip_address
  end_ip_address      = var.mysql_firewall_rules[count.index].end_ip_address
}
