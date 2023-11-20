#This example stores these locals in json file in a separate key vault and pulls these values from it. Alternatively, could leave values in a .tfvars.
locals {
    // General Secret
    task_config = nonsensitive(jsondecode(data.azurerm_key_vault_secret.task-config.value))

    // Sensitive IP Addresses
    allowed_ip_addresses       = local.task_config.allowed_ip_address_ranges
    virtual_network_subnet_ids = local.task_config.virtual_network_subnet_ids
    vnet_address               = local.task_config.vnet_address
    subnet_address             = local.task_config.subnet_address

    tenant_id                  = local.task_config.tenant_id
    object_id                  = local.task_config.object_id

}
