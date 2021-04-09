resource "azurerm_virtual_network" "vnet" {
  name                =   "vnet"
  location            = "${var.location}"
  resource_group_name = "${var.rg}"
  address_space       = "${var.cidr}"

}