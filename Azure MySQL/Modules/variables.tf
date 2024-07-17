# variable "resource_group_name" {
#   description = "The name of the resource group."
#   default     = "sqldb-rg"
#   type        = string
# }

# variable "location" {
#   description = "The location where the resources will be created."
#   default     = "Central India"
#   type        = string
# }

# variable "environment" {
#   description = "The environment tag for the resources."
#   default     = "dev"
#   type        = string
# }

# variable "mysql_flexible_server_name" {
#   description = "The name of the MySQL Server."
#   default     = "mysqlserver"
#   type        = string
# }

# variable "mysql_sku_name" {
#   description = "The SKU name for the MySQL server."
#   default     = "B_Gen5_1"
#   type        = string
# }

# # variable "mysql_version" {
# #   description = "The version of MySQL."
# #   default     = "5.7"
# #   type        = string
# # }

# variable "mysql_administrator_login" {
#   description = "The administrator login name for the MySQL server."
#   default     = "mysqladmin"
#   type        = string
# }

# variable "mysql_administrator_login_password" {
#   description = "The password associated with the MySQL administrator login."
#   default     = "examplepassword"
#   type        = string
#   sensitive   = true
# }

# # variable "mysql_storage_mb" {
# #   description = "The storage capacity for the MySQL server in MB."
# #   default     = 51200
# #   type        = number
# # }

# # variable "mysql_backup_retention_days" {
# #   description = "The number of days to retain backups for."
# #   default     = 7
# #   type        = number
# # }

# variable "mysql_flexible_database_name" {
#   description = "The name of the MySQL database."
#   default     = "mysqldb"
#   type        = string
# }

# variable "mysql_charset" {
#   description = "The charset for the MySQL database."
#   default     = "utf8"
#   type        = string
# }

# variable "mysql_collation" {
#   description = "The collation for the MySQL database."
#   default     = "utf8_general_ci"
#   type        = string
# }

# # variable "ssl_enforcement_enabled" {
# #   description = "Whether SSL enforcement is enabled."
# #   type        = bool
# #   default     = true  
# # }

# variable "mysql_firewall_rules" {
#   description = "A list of firewall rules to apply to the MySQL server."
#   type = list(object({
#     name             = string
#     start_ip_address = string
#     end_ip_address   = string
#   }))
#   default = null
# }





variable "resource_group_name" {
  description = "The name of the resource group."
  default     = "my-resource-group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be created."
  default     = "Central India"
  type        = string
}

variable "mysql_flexible_server_name" {
  description = "The name of the MySQL Server."
  default     = "testdbserver01"
  type        = string
}

variable "mysql_sku_name" {
  description = "The SKU name for the MySQL server."
  default     = "B_Standard_B1s"
  type        = string
}

variable "mysql_administrator_login" {
  description = "The administrator login name for the MySQL server."
  default     = "testadmin"
  type        = string
}

variable "mysql_administrator_login_password" {
  description = "The password associated with the MySQL administrator login."
  default     = "Password@123"
  type        = string
  sensitive   = true
}

variable "mysql_flexible_database_name" {
  description = "The name of the MySQL database."
  default     = "mysqldb"
  type        = string
}

variable "mysql_charset" {
  description = "The charset for the MySQL database."
  default     = "utf8"
  type        = string
}

variable "mysql_collation" {
  description = "The collation for the MySQL database."
  default     = "utf8_general_ci"
  type        = string
}

variable "mysql_firewall_rules" {
  description = "A list of firewall rules to apply to the MySQL server."
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}
