


module "azure-mysql" {
  source = "../Modules/mysql"

  resource_group_name                = "my-resource-group"
  location                           = "Central India"
  mysql_flexible_server_name         = "testdbserver01"
  mysql_sku_name                     = "Standard_B1ms"
  mysql_administrator_login          = "testadmin"
  mysql_administrator_login_password = "Password@123"
  mysql_flexible_database_name       = "mysqldb"
  mysql_charset                      = "utf8"
  mysql_collation                    = "utf8_general_ci"
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







































