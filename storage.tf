resource "azurerm_storage_account" "st_ass_lin_001" {
  name                     = "multivmdeploytest"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "ct_ass_lin_001" {
  name                  = "multi-vm-cont-test"
  storage_account_name  = azurerm_storage_account.st_ass_lin_001.name
  container_access_type = "container" # "blob" "private"
}

resource "azurerm_storage_blob" "bb_lin_001" {
  name                   = "website.sh"
  storage_account_name   = azurerm_storage_account.st_ass_lin_001.name
  storage_container_name = azurerm_storage_container.ct_ass_lin_001.name
  type                   = "Block"
  source                 = "website.sh"
}