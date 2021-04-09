output "vnet" {
    value = "${azurerm_virtual_network.vnet.name}"
}
output "vnet_id" {
    value = "${azurerm_virtual_network.vnet.id}"
}
output "cidr" {
    value = "${azurerm_virtual_network.vnet.address_space}"
}
output "vnet_name" {
    value = "${azurerm_virtual_network.vnet.name}"
}