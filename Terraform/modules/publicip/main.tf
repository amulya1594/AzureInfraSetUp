resource "azurerm_public_ip" "publicip1" {
  name                = "hubPumblicIpdd1"
  resource_group_name = "${var.rg}"
  location            = "${var.location}"
  allocation_method   = "Static"
  domain_name_label   = "csvmdskkkkkddfere"
  sku                 = "Standard"

}