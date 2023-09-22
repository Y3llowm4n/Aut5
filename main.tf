resource "azurerm_resource_group" "rg" {
  name     = "multi-vm"
  location = "East US"
}

# Create Linux virtual machines
resource "azurerm_linux_virtual_machine" "vm_lin" {
  for_each = var.vm_map

  name                            = each.value.name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1ls"
  admin_username                  = "adminuser"
  admin_password                  = each.value.admin_password
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}


resource "azurerm_virtual_machine_extension" "vm_ext_bash" {
  for_each             = var.vm_map
  name                 = "vme-bash"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm_lin[each.key].id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
    "fileUris": ["https://multivmdeploytest.blob.core.windows.net/multi-vm-cont-test/website.sh"], 
    "commandToExecute": "bash website.sh" 
  }
    SETTINGS
}
