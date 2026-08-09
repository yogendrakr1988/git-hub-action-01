resource "azurerm_resource_group" "rg" {
for_each = var.rgs 
  name     = each.value.rg-name
  location = each.value.rg-location
}

resource "azurerm_management_lock" "rg_lock" {
  for_each = azurerm_resource_group.rg

  name       = "${each.value.name}-lock"
  scope      = each.value.id
  lock_level = "CanNotDelete"
  notes      = "Prevent accidental deletion of Resource Group"
}

