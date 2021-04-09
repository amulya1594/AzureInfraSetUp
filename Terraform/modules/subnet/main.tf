resource "azurerm_subnet" "mgmt" {
  name                 = "subnet"
  resource_group_name  = "${var.rg}"
  virtual_network_name = "${var.vnet}"
  address_prefix       = "${var.subnet}"
}
