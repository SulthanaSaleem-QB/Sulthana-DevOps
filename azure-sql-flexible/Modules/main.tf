provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefixes
  service_endpoints    = var.subnet_service_endpoints

  delegation {
    name = var.subnet_delegation_name
    service_delegation {
      name    = var.subnet_service_delegation_name
      actions = var.subnet_service_delegation_actions
    }
  }
}

resource "azurerm_private_dns_zone" "example" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = var.private_dns_zone_link_name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = azurerm_virtual_network.example.id
  resource_group_name   = azurerm_resource_group.example.name
}

resource "azurerm_mysql_flexible_server" "example" {
  name                   = var.mysql_server_name
  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  administrator_login    = var.mysql_admin_login
  administrator_password = var.mysql_admin_password
  backup_retention_days  = var.mysql_backup_retention_days
  delegated_subnet_id    = azurerm_subnet.example.id
  private_dns_zone_id    = azurerm_private_dns_zone.example.id
  sku_name               = var.mysql_sku_name
  zone                   = var.mysql_zone

  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]
}

resource "azurerm_mysql_flexible_database" "example" {
  name                = var.mysql_database_name
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_flexible_server.example.name
  charset             = var.mysql_database_charset
  collation           = var.mysql_database_collation
}

resource "azurerm_mysql_flexible_server_firewall_rule" "example" {
  name                = var.mysql_firewall_rule_name
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_flexible_server.example.name
  start_ip_address    = var.mysql_firewall_start_ip
  end_ip_address      = var.mysql_firewall_end_ip
}
