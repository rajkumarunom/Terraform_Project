output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "control_public_ip" {
value = module.vm["control"].vm_public_ip
}

output "web_public_ip" {
value = module.vm["web"].vm_public_ip
}
 
output "web_private_ip" {
value = module.vm["web"].private_ip
}