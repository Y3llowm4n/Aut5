resource "azurerm_public_ip" "pubip" {
  for_each = var.public_ip_configurations

  name                    = each.key
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  allocation_method       = each.value.allocation_method
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  sku                     = "Standard"
}

