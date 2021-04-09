output "subnet" {
    value= "${azurerm_subnet.mgmt.address_prefix}"
}
output "subnet_id" {
    value= "${azurerm_subnet.mgmt.id}"
}