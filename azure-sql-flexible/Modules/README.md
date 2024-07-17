
Copy code
# Terraform Module: Azure MySQL Flexible Server

This Terraform module creates an Azure MySQL Flexible Server along with a MySQL database and optional firewall rules.

## Module Usage

To use this module, create a new Terraform configuration file and include the module:

```hcl
provider "azurerm" {
  features {}
}

module "azure_sql_db_flexible" {
  source = "./terraform-azure-sql-db-flexible"

  resource_group_name                = "sample-resource-group"
  location                           = "Central India"
  virtual_network_name               = "my-vnet"
  address_space                      = ["10.0.0.0/16"]
  subnet_name                        = "my-subnet"
  subnet_address_prefixes            = ["10.0.2.0/24"]
  subnet_service_endpoints           = ["Microsoft.Storage"]
  subnet_delegation_name             = "test-delegation"
  subnet_service_delegation_name     = "Microsoft.DBforMySQL/flexibleServers"
  subnet_service_delegation_actions  = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
  private_dns_zone_name              = "test.mysql.database.azure.com"
  private_dns_zone_link_name         = "sampleVnetZone.com"
  mysql_server_name                  = "sample-mysql-server"
  mysql_admin_login                  = "mysqladmin"
  mysql_admin_password               = "Password@123"
  mysql_backup_retention_days        = 7
  mysql_sku_name                     = "B_Standard_B1s"
  mysql_zone                         = "2"
  mysql_database_name                = "sample-mysql-db"
  mysql_database_charset             = "utf8"
  mysql_database_collation           = "utf8_general_ci"
  mysql_firewall_rules = [
    {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    },
    {
      name             = "AllowMyIP"
      start_ip_address = "123.456.789.0"
      end_ip_address   = "123.456.789.0"
    }
  ]
}



## Inputs

| Name                                | Description                                              | Type          | Default          | Required |
|-------------------------------------|----------------------------------------------------------|---------------|------------------|----------|
| resource_group_name                 | The name of the resource group.                          | string        | n/a              | yes      |
| location                            | The location where the resources will be created.        | string        | n/a              | yes      |
| mysql_flexible_server_name          | The name of the MySQL Server.                            | string        | n/a              | yes      |
| mysql_sku_name                      | The SKU name for the MySQL server.                       | string        | "B_Gen5_1"       | yes      |
| mysql_administrator_login           | The administrator login name for the MySQL server.        | string        | "mysqladmin"     | yes      |
| mysql_administrator_login_password  | The password associated with the MySQL administrator login. | string     | n/a              | yes      |
| mysql_flexible_database_name        | The name of the MySQL database.                          | string        | n/a              | yes      |
| mysql_charset                       | The charset for the MySQL database.                      | string        | "utf8"           | yes      |
| mysql_collation                     | The collation for the MySQL database.                    | string        | "utf8_general_ci"| yes      |
| mysql_firewall_rules                | A list of firewall rules to apply to the MySQL server.   | list(object)  | []               | no       |

## Outputs

| Name                                | Description                                              |
|-------------------------------------|----------------------------------------------------------|
| mysql_server_name                   | The name of the MySQL server.                            |
| mysql_server_fully_qualified_domain_name | The fully qualified domain name of the MySQL server.  |
| mysql_database_name                 | The name of the MySQL database.                          |





