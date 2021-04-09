output "address_pool_ids" {
    value = "${azurerm_lb_backend_address_pool.bpepool.id}"
}
output "nat_pool_ids" {
    value = "${azurerm_lb_nat_pool.lbnatpool.id}"
}
output "health_probes" {
    value ="${azurerm_lb_probe.example.id}"
}
