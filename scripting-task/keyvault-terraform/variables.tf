# Use your own key vault details or leave this and don't store local json in KV.
variable "keyvault_name" {
  default     = "kvukstftest"
  description = "Keyvault name."
}

variable "keyvault_resource_group_name" {
  default     = "rg-uks-infra-test"
  description = "Keyvault resource group name."
}

#Resources for the task.
variable "kv_name" {
  default     = "kvweuofhtask"
  description = "Key Vault Name."
  type        = string
  validation {
    condition = length(var.kv_name) <= 24
    error_message = "Key Vault name must be no longer than 24 characters."
  }
}

variable "kv_record_name" {
  default     = "ofh-keyvault-task"
  description = "The keyvault A record name."
  type        = string
}

variable "private_dns_zone_name" {
  default = "jds-ofh-techtask.com"
  description = "Private DNS Zone name."
  type = string
}

variable "private_dns_link_name" {
  default = "ofh-vnet-link"
  description = "Private DNS Zone Vnet Link Name."
  type = string
}

variable "resource_group_name" {
  default     = "rg-weu-ofh-task"
  description = "Resource group name."
  type        = string
}

variable "resource_group_location" {
  default     = "westeurope"
  description = "Location for the resource group."
  type        = string
}

#Subnet that will be used for the private link to the KV instance.
variable "subnet_name" {
  default     = "snet-weu-ofh"
  description = "Subnet name, private linked to KV."
}

variable "tags_base" {
  default = {
      "Environment" = "Dev",
      "Owner"       = "JDS",
      "Purpose"     = "OFHTask"
    }
  description = "Base Azure tags applied to resource group."
  type        = map(string)
}

variable "vnet_name" {
  default     = "vnet-weu-ofh"
  description = "Virtual network name."
}
