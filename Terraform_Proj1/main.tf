module "resource_group" {
  source = "./Resource-group"
  rg_name  = var.rg_name
  location = var.region
}

module "keyvault" {
  source        = "./Keyvault"
  keyvault_name = "kv-assignment2"
  location      = var.region

  resource_group_name = module.resource_group.resource_group_name
}

data "azurerm_key_vault" "source_kv" {
  name = "kv-assignment1"
  resource_group_name = "Manual_RG"
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = "admin-username"
  key_vault_id = data.azurerm_key_vault.source_kv.id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  key_vault_id = data.azurerm_key_vault.source_kv.id
}

module "vnet_subnet" {

  source    = "./vnet_subnet"
  vnet_name = "rk-assign1-vnet"
  address_space = [
    "10.0.0.0/16"
  ]
  subnet_name = "app-subnet"
  subnet_prefixes = [
    "10.0.1.0/24"
  ]
  location            = var.region
  resource_group_name = module.resource_group.resource_group_name
}

module "vm" {
  for_each = var.vms

  source              = "./VM"
  vm_name             = each.value.vm_name
  location            = var.region
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.vnet_subnet.subnet_id
  admin_username      = data.azurerm_key_vault_secret.admin_username.value
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
}
