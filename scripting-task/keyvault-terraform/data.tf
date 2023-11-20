data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_resource_group_name
}

data "azurerm_key_vault_secret" "task-config" {
  name         = "config-secrets"
  key_vault_id = data.azurerm_key_vault.kv.id
}
