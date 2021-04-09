output "public_id" {
    value = "${azurerm_public_ip.publicip1.id}"
}
output "public_fqdn" {
    value = "${azurerm_public_ip.publicip1.fqdn}"
}
