resource "azurerm_key_vault" "kv" {
  name                          = var.kv_name
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  enabled_for_disk_encryption   = true
  tenant_id                     = local.tenant_id
  soft_delete_retention_days    = 7
  purge_protection_enabled      = false
  sku_name                      = "standard"
  public_network_access_enabled = false

  # network_acls {
  #   bypass                     = "AzureServices"
  #   default_action             = "Deny"
  #   ip_rules                   = local.allowed_ip_addresses
  #   virtual_network_subnet_ids = local.virtual_network_subnet_ids
  # }
}

resource "azurerm_key_vault_access_policy" "service_connection" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = local.tenant_id
  object_id    = local.object_id

  key_permissions         = [ 
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
   ]
     secret_permissions   = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
  certificate_permissions = [
    "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "SetIssuers", "Update", "Backup", "Restore"
  ]
  storage_permissions     = [
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]
}

resource "azurerm_private_endpoint" "kv_private_endpoint" {
  name                = "kv-private-endpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "kv-privateserviceconnection"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names = ["vault"]
  }
}
